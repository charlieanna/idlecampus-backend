class LabExecutionChannel < ApplicationCable::Channel
  def subscribed
    # Verify user authentication
    reject unless current_user
    
    # Subscribe to user-specific lab execution stream
    stream_from "lab_execution_#{current_user.id}"
    
    logger.info "User #{current_user.id} subscribed to lab execution channel"
  end

  def unsubscribed
    # Cleanup when channel is unsubscribed
    logger.info "User #{current_user&.id} unsubscribed from lab execution channel"
  end

  def execute_command(data)
    return reject_command('User not authenticated') unless current_user
    
    command = data['command']
    session_id = data['session_id']
    options = data['options'] || {}
    
    return reject_command('Command is required') unless command.present?
    
    begin
      # Validate command before execution
      validate_command_safety(command)
      
      # Create lab runner instance
      lab_runner = LabRunnerService.new(
        user_id: current_user.id,
        lab_session_id: session_id
      )
      
      # Execute command asynchronously
      LabExecutionJob.perform_async(
        current_user.id,
        session_id,
        command,
        options,
        connection.connection_identifier
      )
      
      # Acknowledge command received
      transmit({
        type: 'command_acknowledged',
        command: command,
        session_id: session_id,
        timestamp: Time.current.iso8601
      })
      
    rescue StandardError => e
      reject_command(e.message)
    end
  end

  def start_session(data)
    return reject_command('User not authenticated') unless current_user
    
    lab_type = data['lab_type'] || 'general'
    
    begin
      lab_runner = LabRunnerService.new(user_id: current_user.id)
      session_info = lab_runner.start_lab_session(lab_type)
      
      transmit({
        type: 'session_started',
        session_info: session_info,
        timestamp: Time.current.iso8601
      })
      
      logger.info "Started lab session #{session_info[:session_id]} for user #{current_user.id}"
      
    rescue StandardError => e
      transmit({
        type: 'error',
        message: "Failed to start session: #{e.message}",
        timestamp: Time.current.iso8601
      })
    end
  end

  def stop_session(data)
    return reject_command('User not authenticated') unless current_user
    
    session_id = data['session_id']
    return reject_command('Session ID is required') unless session_id.present?
    
    begin
      lab_runner = LabRunnerService.new(
        user_id: current_user.id,
        lab_session_id: session_id
      )
      
      result = lab_runner.stop_lab_session
      
      transmit({
        type: 'session_stopped',
        result: result,
        timestamp: Time.current.iso8601
      })
      
      logger.info "Stopped lab session #{session_id} for user #{current_user.id}"
      
    rescue StandardError => e
      transmit({
        type: 'error',
        message: "Failed to stop session: #{e.message}",
        timestamp: Time.current.iso8601
      })
    end
  end

  def list_sessions(data = {})
    return reject_command('User not authenticated') unless current_user
    
    begin
      lab_runner = LabRunnerService.new(user_id: current_user.id)
      sessions = lab_runner.list_active_sessions
      
      transmit({
        type: 'sessions_list',
        sessions: sessions,
        timestamp: Time.current.iso8601
      })
      
    rescue StandardError => e
      transmit({
        type: 'error',
        message: "Failed to list sessions: #{e.message}",
        timestamp: Time.current.iso8601
      })
    end
  end

  def stream_logs(data)
    return reject_command('User not authenticated') unless current_user
    
    container_name = data['container_name']
    return reject_command('Container name is required') unless container_name.present?
    
    begin
      lab_runner = LabRunnerService.new(user_id: current_user.id)
      
      # Start log streaming in background
      LogStreamingJob.perform_async(
        current_user.id,
        container_name,
        connection.connection_identifier
      )
      
      transmit({
        type: 'log_streaming_started',
        container_name: container_name,
        timestamp: Time.current.iso8601
      })
      
    rescue StandardError => e
      transmit({
        type: 'error',
        message: "Failed to start log streaming: #{e.message}",
        timestamp: Time.current.iso8601
      })
    end
  end

  private

  def current_user
    @current_user ||= find_verified_user
  end

  def find_verified_user
    # This method should be implemented based on your authentication system
    # For example, using session or token-based authentication
    User.find_by(id: connection.current_user&.id)
  end

  def validate_command_safety(command)
    # Basic command validation
    dangerous_patterns = [
      /rm\s+-rf\s+\//, # Don't allow deletion of root
      />\s*\/dev/, # Don't allow device access
      /sudo/, # No sudo
      /su\s/, # No user switching
      /passwd/, # No password changes
      /mount/, # No mounting
      /umount/, # No unmounting
    ]

    dangerous_patterns.each do |pattern|
      if command.match?(pattern)
        raise "Command contains dangerous pattern and is not allowed"
      end
    end
  end

  def reject_command(message)
    transmit({
      type: 'error',
      message: message,
      timestamp: Time.current.iso8601
    })
    
    logger.warn "Rejected command for user #{current_user&.id}: #{message}"
  end
end