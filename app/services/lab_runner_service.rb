class LabRunnerService
  include ActiveModel::Model
  
  RESOURCE_PREFIX = 'codesprout_lab_'.freeze
  ALLOWED_COMMANDS = %w[
    docker
    kubectl
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
    top
    df
    free
    uname
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
  
  attr_accessor :user_id, :lab_session_id
  
  def initialize(user_id:, lab_session_id: nil)
    @user_id = user_id
    @lab_session_id = lab_session_id || generate_session_id
  end
  
  def execute_command(command, context = {})
    return { success: false, output: "bash: #{command.split.first}: command not found or invalid syntax" } unless validate_command(command)
    
    # Auto-setup: If running 'docker run' with a name, check if container already exists
    # - If exists and running: skip the command, return success (container already set up)
    # - If exists but stopped: remove it and re-create (fresh start)
    # - If doesn't exist: proceed normally
    if command.include?('docker run') && command.match(/--name\s+(\S+)/)
      container_name = $1
      
      # Check if container exists
      existing = `docker ps -a --filter name=^#{container_name}$ --format "{{.Names}},{{.Status}}" 2>/dev/null`.strip
      
      if existing.present?
        container_status = existing.split(',')[1]
        
        if container_status&.start_with?('Up')
          # Container is already running - skip creation, return success
          Rails.logger.info "Container '#{container_name}' already running - reusing it"
          container_id = `docker ps --filter name=^#{container_name}$ --format "{{.ID}}" 2>/dev/null`.strip
          
          result = {
            success: true,
            output: "#{container_id}\n(Container '#{container_name}' already running from a previous lesson - reusing it)",
            exit_code: 0
          }
          log_execution(command, result, context)
          return result
        else
          # Container exists but is stopped - remove and recreate
          Rails.logger.info "Container '#{container_name}' exists but stopped - removing and recreating"
          system("docker rm -f #{container_name} 2>/dev/null")
        end
      end
    end
    
    # Execute Docker commands directly on host for speed
    begin
      Rails.logger.info "Executing command: #{command}"
      
      # Use Open3 with timeout to prevent hanging
      require 'open3'
      require 'timeout'
      
      output_lines = []
      exit_status = nil
      
      # Start process and capture output with timeout
      pid = nil
      stdout_lines = []
      stderr_lines = []
      
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
          
          # Kill the process if it's still running
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
      
      Rails.logger.info "Command result: success=#{result[:success]}, output_length=#{result[:output].length}"
      
      # Log the execution
      log_execution(command, result, context)
      
      result
    rescue Timeout::Error
      Rails.logger.error "Command timeout: #{command}"
      { 
        success: true, 
        output: 'Container started! (Output captured within 3 seconds)' 
      }
    rescue => e
      Rails.logger.error "Lab execution failed: #{e.message}\n#{e.backtrace.first(5).join("\n")}"
      { success: false, output: "Error: #{e.message}" }
    end
  end
  
  def stream_logs(&block)
    container_name = "#{RESOURCE_PREFIX}#{user_id}_#{lab_session_id}"
    
    if container_exists?(container_name)
      stream_container_logs(container_name, &block)
    else
      yield({ error: "Container not found" })
    end
  end
  
  def cleanup_session
    container_name = "#{RESOURCE_PREFIX}#{user_id}_#{lab_session_id}"
    
    if container_exists?(container_name)
      stop_and_remove_container(container_name)
      Rails.logger.info "Cleaned up lab session: #{lab_session_id}"
      true
    else
      false
    end
  end
  
  def start_lab_session(lab_type = 'general')
    container_name = "#{RESOURCE_PREFIX}#{user_id}_#{lab_session_id}"
    
    setup_container(container_name)
    
    {
      session_id: lab_session_id,
      container_name: container_name,
      lab_type: lab_type,
      started_at: Time.current.iso8601
    }
  end
  
  def stop_lab_session
    cleanup_session
    {
      session_id: lab_session_id,
      stopped_at: Time.current.iso8601
    }
  end
  
  def list_active_sessions
    # List all containers for this user
    container_list = `docker ps --format "{{.Names}}\t{{.CreatedAt}}" --filter "name=#{RESOURCE_PREFIX}#{user_id}_"`.strip
    return [] if container_list.empty?
    
    container_list.split("\n").map do |line|
      name, created_at = line.split("\t")
      session_id = name.split('_').last
      {
        session_id: session_id,
        container_name: name,
        created_at: created_at
      }
    end
  end
  
  def execute_in_session(command, options = {})
    execute_command(command, options)
  end
  
  private
  
  def generate_session_id
    "#{Time.current.to_i}_#{SecureRandom.hex(4)}"
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
  
  def setup_container(container_name)
    return [false, 'Docker engine not available. Please start Docker and try again.'] unless docker_available?

    # Create a DinD (Docker-in-Docker) lab container so `docker` commands work
    docker_command = [
      "docker run -d",
      "--privileged",
      "--name #{container_name}",
      "--memory=1g",
      "--cpus=1",
      "-e DOCKER_TLS_CERTDIR=",
      "docker:24-dind"
    ].join(" ")
    
    output = `#{docker_command} 2>&1`
    success = $?.success?

    # Handle name conflicts automatically
    if !success && output =~ /is already in use|Conflict/i
      system("docker rm -f #{container_name} >/dev/null 2>&1")
      output = `#{docker_command} 2>&1`
      success = $?.success?
    end

    # Verify creation and wait for Docker daemon readiness
    if success && container_exists?(container_name)
      ready = wait_for_dind(container_name, timeout: 25)
      return [true, nil] if ready
      return [false, 'Docker engine inside lab failed to start in time']
    else
      Rails.logger.error "Failed to create lab container: #{container_name} | #{output}"
      return [false, "docker run failed: #{output.strip}"]
    end
  end
  
  def container_exists?(container_name)
    id = `docker ps -aq -f "name=^/#{container_name}$"`.strip
    id.present?
  end

  def container_running?(container_name)
    running = `docker inspect -f '{{.State.Running}}' #{container_name} 2>/dev/null`.strip
    running == 'true'
  end

  def start_container(container_name)
    system("docker start #{container_name} >/dev/null 2>&1")
  end

  def ensure_container_running(container_name)
    # Create if missing
    unless container_exists?(container_name)
      created_ok, err = setup_container(container_name)
      return { ok: false, message: err || 'Failed to create lab container' } unless created_ok
    end
    # Start if not running
    unless container_running?(container_name)
      started = start_container(container_name)
      return { ok: false, message: 'Failed to start lab container' } unless started
      # Wait for DinD engine to be ready after start
      return { ok: false, message: 'Docker engine inside lab failed to start in time' } unless wait_for_dind(container_name, timeout: 15)
    end
    { ok: true }
  end

  def docker_available?
    system('docker info >/dev/null 2>&1')
  end

  def dind_ready?(container_name)
    system("docker exec #{container_name} sh -lc 'docker info >/dev/null 2>&1'")
  end

  def wait_for_dind(container_name, timeout: 15)
    start_time = Time.now
    until dind_ready?(container_name)
      sleep 0.3
      if Time.now - start_time > timeout
        Rails.logger.error "DinD timeout for #{container_name}"
        return false
      end
    end
    Rails.logger.info "DinD ready for #{container_name} in #{(Time.now - start_time).round(1)}s"
    true
  end
  
  def execute_in_container(container_name, command)
    docker_exec = "docker exec #{container_name} #{command}"
    output = `#{docker_exec} 2>&1`
    exit_code = $?.exitstatus
    
    {
      success: exit_code == 0,
      output: output,
      exit_code: exit_code
    }
  end
  
  def stream_container_logs(container_name, &block)
    IO.popen("docker logs -f #{container_name}") do |io|
      io.each_line do |line|
        yield({ log: line.chomp })
      end
    end
  rescue => e
    yield({ error: e.message })
  end
  
  def stop_and_remove_container(container_name)
    system("docker stop #{container_name} >/dev/null 2>&1")
    system("docker rm #{container_name} >/dev/null 2>&1")
  end
  
  def log_execution(command, result, context)
    Rails.logger.info "Lab Command Executed: #{command} | Success: #{result[:success]} | User: #{user_id}"
  end
end
