class KubernetesLabRunner
  # Kubernetes-specific lab command executor
  # Executes kubectl commands against the configured cluster
  include ActiveModel::Model
  
  ALLOWED_COMMANDS = %w[
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
    /kubectl\s+delete\s+namespace/, # Don't allow deleting namespaces
    /kubectl\s+delete\s+--all/, # Don't allow delete all
  ].freeze
  
  attr_accessor :user_id, :session_id
  
  def initialize(user_id:, session_id: nil)
    @user_id = user_id
    @session_id = session_id || generate_session_id
  end
  
  def execute_command(command, context = {})
    return { success: false, output: "bash: #{command.split.first}: command not found or invalid syntax" } unless validate_command(command)

    # Check if kubectl is available
    unless kubectl_available?
      return {
        success: false,
        output: 'kubectl is not installed. Install kubectl to practice Kubernetes commands.'
      }
    end

    # Check if cluster is accessible
    unless cluster_accessible?
      return {
        success: false,
        output: <<~MSG.strip
          No Kubernetes cluster found!
          
          To enable Kubernetes:
          1. Open Docker Desktop
          2. Go to Settings → Kubernetes
          3. Check "Enable Kubernetes"
          4. Click "Apply & Restart"
          5. Wait 2 minutes for it to start
          
          Then refresh this page and try again!
        MSG
      }
    end

    # Execute kubectl commands
    begin
      Rails.logger.info "Executing Kubernetes command: #{command}"
      
      # Use Open3 with timeout to prevent hanging
      require 'open3'
      require 'timeout'
      
      stdout_lines = []
      stderr_lines = []
      exit_status = nil
      
      Timeout.timeout(5) do
        Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
          stdin.close
          
          # Read output from both stdout and stderr
          begin
            stdout_lines << stdout.read
            stderr_lines << stderr.read
          rescue => e
            Rails.logger.error "Error reading kubectl output: #{e.message}"
          end
          
          exit_status = wait_thr.value
        end
      end
      
      all_output = (stdout_lines + stderr_lines).join.strip
      
      result = {
        success: exit_status&.success? || false,
        output: all_output.presence || 'No output captured',
        exit_code: exit_status&.exitstatus || 1
      }
      
      Rails.logger.info "Kubernetes command result: success=#{result[:success]}, output_length=#{result[:output].length}"
      
      # Log the execution
      log_execution(command, result, context)
      
      result
    rescue Timeout::Error
      Rails.logger.error "Kubernetes command timeout: #{command}"
      { 
        success: false, 
        output: 'Command timed out. The cluster may be slow to respond.' 
      }
    rescue => e
      Rails.logger.error "Kubernetes execution failed: #{e.message}\n#{e.backtrace.first(5).join("\n")}"
      { success: false, output: "Error: #{e.message}" }
    end
  end
  
  private
  
  def generate_session_id
    "k8s_#{Time.current.to_i}_#{SecureRandom.hex(4)}"
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
  
  def kubectl_available?
    system('which kubectl >/dev/null 2>&1')
  end
  
  def cluster_accessible?
    # Quick check if kubectl can connect to cluster
    system('kubectl cluster-info >/dev/null 2>&1')
  end
  
  def log_execution(command, result, context)
    Rails.logger.info "Kubernetes Command Executed: #{command} | Success: #{result[:success]} | User: #{user_id}"
  end
end