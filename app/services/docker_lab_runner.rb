class DockerLabRunner
  # Docker-specific lab command executor
  # Executes docker commands directly on the host Docker daemon
  include ActiveModel::Model
  
  ALLOWED_COMMANDS = %w[
    docker
    ls
    cat
    echo
    pwd
    cd
    mkdir
    touch
    rm
    cp
    mv
    grep
    find
    ps
  ].freeze
  
  DANGEROUS_PATTERNS = [
    /rm\s+-rf\s+\//, # Don't allow deleting root
    /sudo/, # No sudo access
    /passwd/, # No password changes
    /shutdown/, # No system shutdown
    /reboot/, # No system reboot
    /kill\s+-9/, # No force kills
    />\s*\/etc/, # No writing to system configs
    /curl.*\|.*sh/, # No piped shell execution
    /wget.*\|.*sh/, # No piped shell execution
  ].freeze
  
  attr_accessor :user_id, :session_id
  
  def initialize(user_id:, session_id: nil)
    @user_id = user_id
    @session_id = session_id || generate_session_id
  end
  
  def execute_command(command, context = {})
    return { success: false, output: "bash: #{command.split.first}: command not found or invalid syntax" } unless validate_command(command)

    # Check if Docker is available
    unless docker_available?
      return {
        success: false,
        output: 'Docker is not running. Please start Docker Desktop and try again.'
      }
    end

    # Execute Docker commands directly on host for speed
    begin
      Rails.logger.info "Executing Docker command: #{command}"
      
      # Use Open3 with timeout to prevent hanging
      require 'open3'
      require 'timeout'
      
      stdout_lines = []
      stderr_lines = []
      exit_status = nil
      
      Timeout.timeout(3) do
        Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
          pid = wait_thr.pid
          stdin.close
          
          # Read initial output (up to 2 seconds worth) from both stdout and stderr
          start_read = Time.now
          loop do
            break if Time.now - start_read > 2
            
            # Check both stdout and stderr
            ready = IO.select([stdout, stderr], nil, nil, 0.1)
            if ready
              ready[0].each do |io|
                begin
                  chunk = io.read_nonblock(4096)
                  if io == stdout
                    stdout_lines << chunk
                  else
                    stderr_lines << chunk
                  end
                rescue IO::WaitReadable
                  # Nothing to read yet
                rescue EOFError
                  # Stream closed
                end
              end
            end
          end
          
          # Kill the process if it's still running (for long-running containers)
          if wait_thr.alive?
            Process.kill('TERM', pid) rescue nil
            sleep 0.2
            Process.kill('KILL', pid) rescue nil if wait_thr.alive?
          end
          
          begin
            exit_status = wait_thr.value
          rescue
            exit_status = nil
          end
        end
      end
      
      all_output = (stdout_lines + stderr_lines).join.strip
      
      result = {
        success: exit_status&.success? || false,
        output: all_output.presence || 'No output captured',
        exit_code: exit_status&.exitstatus || 1
      }
      
      Rails.logger.info "Docker command result: success=#{result[:success]}, output_length=#{result[:output].length}"
      
      # Log the execution
      log_execution(command, result, context)
      
      result
    rescue Timeout::Error
      Rails.logger.error "Docker command timeout: #{command}"
      { 
        success: true, 
        output: 'Container started! (Output captured within 3 seconds)' 
      }
    rescue => e
      Rails.logger.error "Docker execution failed: #{e.message}\n#{e.backtrace.first(5).join("\n")}"
      { success: false, output: "Error: #{e.message}" }
    end
  end
  
  private
  
  def generate_session_id
    "docker_#{Time.current.to_i}_#{SecureRandom.hex(4)}"
  end
  
  def validate_command(command)
    # Check if command starts with an allowed command
    command_start = command.split.first
    return false unless ALLOWED_COMMANDS.include?(command_start)
    
    # Check for dangerous patterns
    DANGEROUS_PATTERNS.each do |pattern|
      return false if command.match?(pattern)
    end
    
    true
  end
  
  def docker_available?
    system('docker info >/dev/null 2>&1')
  end
  
  def log_execution(command, result, context)
    Rails.logger.info "Docker Command Executed: #{command} | Success: #{result[:success]} | User: #{user_id}"
  end
end