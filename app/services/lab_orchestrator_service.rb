require 'docker'

class LabOrchestratorService
  """
  Docker-in-Docker lab environment orchestrator
  Creates, manages, and cleans up isolated lab containers
  """
  
  # Resource limits per lab container
  RESOURCE_LIMITS = {
    memory: 1.gigabyte,           # 1GB RAM
    memory_swap: 2.gigabytes,     # 2GB total with swap
    cpu_shares: 512,              # 50% of one CPU
    cpu_quota: 50000,             # 50% CPU quota (100000 = 100%)
    pids_limit: 512,              # Max processes
    ulimits: [
      { name: 'nofile', soft: 1024, hard: 2048 }  # File descriptors
    ]
  }.freeze
  
  # Container lifecycle limits
  MAX_IDLE_MINUTES = 45
  HARD_TIMEOUT_HOURS = 2
  MAX_SESSIONS_PER_USER = 2
  
  def initialize
    Docker.url = ENV['DOCKER_HOST'] || 'unix:///var/run/docker.sock'
    @docker = Docker
  end
  
  def create_lab_environment(user:, lab:)
    """
    Create isolated Docker environment for lab
    
    Returns:
      {
        container_id: string,
        session: LabSession,
        websocket_endpoint: string
      }
    """
    
    # Check user session limit
    active_count = LabSession.where(user: user, status: ['active', 'paused']).count
    if active_count >= MAX_SESSIONS_PER_USER
      raise "User has #{active_count} active sessions (max: #{MAX_SESSIONS_PER_USER})"
    end
    
    # Create container
    container = create_container(user, lab)
    container.start!
    
    # Create session record
    session = LabSession.create!(
      user: user,
      hands_on_lab: lab,
      container_id: container.id,
      status: 'active',
      current_step: 0,
      steps_completed: 0,
      time_spent_seconds: 0
    )
    
    # Initialize environment
    setup_lab_environment(container, lab)
    
    # Log event
    StructuredLogger.log_lab_event(
      user_id: user.id,
      lab_id: lab.id,
      session_id: session.id,
      event: 'container_created',
      details: { container_id: container.id }
    )
    
    {
      container_id: container.id,
      session: session,
      websocket_endpoint: generate_websocket_endpoint(session.id)
    }
  end
  
  def execute_command(container_id:, command:, timeout: 30)
    """Execute command in container and return output"""
    
    container = @docker::Container.get(container_id)
    
    # Execute with timeout
    stdout, stderr, exit_code = container.exec(
      command.split,
      wait: timeout
    )
    
    {
      stdout: stdout.join,
      stderr: stderr.join,
      exit_code: exit_code,
      success: exit_code == 0
    }
  rescue Docker::Error::TimeoutError
    {
      stdout: '',
      stderr: 'Command timed out',
      exit_code: 124,
      success: false,
      timeout: true
    }
  rescue => e
    {
      stdout: '',
      stderr: e.message,
      exit_code: 1,
      success: false,
      error: e.message
    }
  end
  
  def validate_lab_state(container_id:, validation_rules:)
    """
    Validate container state against rules
    
    Validation types:
    - container_running: check if named container is running
    - pod_created: check if k8s pod exists
    - file_exists: check if file present
    - service_accessible: check if service responds
    - command_output: check command output matches
    """
    
    container = @docker::Container.get(container_id)
    results = {}
    
    validation_rules.each do |name, rule|
      results[name] = case rule[:type]
                      when 'container_running'
                        validate_container_running(container, rule[:container_name])
                      when 'pod_created'
                        validate_pod_exists(container, rule[:pod_name])
                      when 'file_exists'
                        validate_file_exists(container, rule[:path])
                      when 'service_accessible'
                        validate_service_accessible(container, rule[:url])
                      when 'command_output'
                        validate_command_output(container, rule[:command], rule[:expected])
                      else
                        { passed: true, message: 'Unknown validation type' }
                      end
    end
    
    {
      all_passed: results.values.all? { |r| r[:passed] },
      results: results
    }
  end
  
  def cleanup_container(container_id:)
    """Stop and remove container"""
    
    container = @docker::Container.get(container_id)
    container.stop(timeout: 10)
    container.remove(force: true)
    
    StructuredLogger.log_event(
      category: 'lab',
      action: 'container_cleaned',
      context: { container_id: container_id }
    )
  rescue Docker::Error::NotFoundError
    # Already gone
    Rails.logger.info("Container #{container_id} already removed")
  rescue => e
    StructuredLogger.log_error(
      error: e,
      context: { container_id: container_id, action: 'cleanup' }
    )
  end
  
  def cleanup_expired_sessions
    """Background job: cleanup expired lab sessions"""
    
    # Find sessions that have exceeded limits
    expired = LabSession
      .where(status: ['active', 'paused'])
      .where('last_activity_at < ?', MAX_IDLE_MINUTES.minutes.ago)
      .or(LabSession.where('started_at < ?', HARD_TIMEOUT_HOURS.hours.ago))
    
    expired.each do |session|
      begin
        # Mark as expired
        session.update!(
          status: 'expired',
          expired_at: Time.current
        )
        
        # Cleanup container if exists
        if session.container_id
          cleanup_container(container_id: session.container_id)
        end
        
        Rails.logger.info("Cleaned up expired session #{session.id}")
      rescue => e
        Rails.logger.error("Failed to cleanup session #{session.id}: #{e.message}")
      end
    end
    
    {
      cleaned: expired.count,
      timestamp: Time.current
    }
  end
  
  private
  
  def create_container(user, lab)
    """Create Docker container for lab"""
    
    image = lab.environment_image || 'docker:20-dind'
    
    # Pull image if not present
    ensure_image_available(image)
    
    # Create container
    @docker::Container.create(
      'Image' => image,
      'name' => generate_container_name(user, lab),
      'Hostname' => "lab-#{lab.id}",
      'Tty' => true,
      'OpenStdin' => true,
      'Env' => generate_environment_vars(user, lab),
      'Labels' => {
        'lab.user_id' => user.id.to_s,
        'lab.lab_id' => lab.id.to_s,
        'lab.created_at' => Time.current.to_i.to_s,
        'lab.type' => lab.lab_type
      },
      'HostConfig' => {
        'Memory' => RESOURCE_LIMITS[:memory],
        'MemorySwap' => RESOURCE_LIMITS[:memory_swap],
        'CpuShares' => RESOURCE_LIMITS[:cpu_shares],
        'CpuQuota' => RESOURCE_LIMITS[:cpu_quota],
        'PidsLimit' => RESOURCE_LIMITS[:pids_limit],
        'Ulimits' => RESOURCE_LIMITS[:ulimits],
        'AutoRemove' => false, # Manual cleanup for tracking
        'NetworkMode' => 'bridge',
        'ReadonlyRootfs' => false,
        'Privileged' => lab.lab_type == 'docker', # Only for Docker labs
        'CapDrop' => ['ALL'],
        'CapAdd' => determine_required_capabilities(lab)
      }
    )
  end
  
  def ensure_image_available(image)
    """Pull image if not present"""
    
    begin
      @docker::Image.get(image)
    rescue Docker::Error::NotFoundError
      Rails.logger.info("Pulling image: #{image}")
      @docker::Image.create('fromImage' => image)
    end
  end
  
  def generate_container_name(user, lab)
    """Generate unique container name"""
    "lab-u#{user.id}-l#{lab.id}-#{Time.current.to_i}"
  end
  
  def generate_environment_vars(user, lab)
    """Generate environment variables for container"""
    [
      "USER_ID=#{user.id}",
      "LAB_ID=#{lab.id}",
      "LAB_TYPE=#{lab.lab_type}",
      "LAB_DIFFICULTY=#{lab.difficulty}",
      "PS1=[lab] \\w $ " # Friendly prompt
    ]
  end
  
  def determine_required_capabilities(lab)
    """Determine required Linux capabilities"""
    
    base_caps = ['CHOWN', 'DAC_OVERRIDE', 'FOWNER', 'SETGID', 'SETUID']
    
    if lab.lab_type == 'docker'
      base_caps + ['SYS_ADMIN', 'NET_ADMIN'] # For Docker-in-Docker
    elsif lab.lab_type == 'kubernetes'
      base_caps + ['NET_ADMIN', 'NET_RAW'] # For networking
    else
      base_caps
    end
  end
  
  def setup_lab_environment(container, lab)
    """Initialize lab environment with files/scripts"""
    
    # Run setup commands if defined
    if lab.respond_to?(:setup_commands) && lab.setup_commands.is_a?(Array)
      lab.setup_commands.each do |cmd|
        execute_command(container_id: container.id, command: cmd, timeout: 60)
      end
    end
    
    # Create workspace directory
    execute_command(
      container_id: container.id,
      command: 'mkdir -p /workspace && cd /workspace',
      timeout: 5
    )
  end
  
  def generate_websocket_endpoint(session_id)
    """Generate WebSocket endpoint for terminal"""
    "ws://#{ENV['WS_HOST'] || 'localhost:3001'}/labs/#{session_id}/terminal"
  end
  
  # ============================================
  # Validation Helpers
  # ============================================
  
  def validate_container_running(container, container_name)
    """Check if a container is running inside the lab container"""
    
    result = execute_command(
      container_id: container.id,
      command: "docker ps --filter name=#{container_name} --format '{{.Names}}'",
      timeout: 10
    )
    
    running = result[:stdout].include?(container_name)
    
    {
      passed: running,
      message: running ? "Container #{container_name} is running" : "Container #{container_name} not found"
    }
  end
  
  def validate_pod_exists(container, pod_name)
    """Check if Kubernetes pod exists"""
    
    result = execute_command(
      container_id: container.id,
      command: "kubectl get pod #{pod_name} -o name",
      timeout: 10
    )
    
    exists = result[:success] && result[:stdout].include?(pod_name)
    
    {
      passed: exists,
      message: exists ? "Pod #{pod_name} exists" : "Pod #{pod_name} not found"
    }
  end
  
  def validate_file_exists(container, path)
    """Check if file exists"""
    
    result = execute_command(
      container_id: container.id,
      command: "test -f #{path} && echo exists",
      timeout: 5
    )
    
    exists = result[:stdout].include?('exists')
    
    {
      passed: exists,
      message: exists ? "File #{path} exists" : "File #{path} not found"
    }
  end
  
  def validate_service_accessible(container, url)
    """Check if service is accessible"""
    
    result = execute_command(
      container_id: container.id,
      command: "curl -s -o /dev/null -w '%{http_code}' #{url}",
      timeout: 10
    )
    
    accessible = result[:stdout].to_i == 200
    
    {
      passed: accessible,
      message: accessible ? "Service at #{url} is accessible" : "Service at #{url} not accessible"
    }
  end
  
  def validate_command_output(container, command, expected)
    """Validate command output matches expected"""
    
    result = execute_command(
      container_id: container.id,
      command: command,
      timeout: 10
    )
    
    matches = result[:stdout].include?(expected)
    
    {
      passed: matches,
      message: matches ? 'Output matches expected' : "Expected '#{expected}' in output"
    }
  end
end
