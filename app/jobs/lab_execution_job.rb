class LabExecutionJob < ApplicationJob
  queue_as :lab_execution
  
  def perform(user_id, session_id, command, options, connection_identifier)
    @user_id = user_id
    @session_id = session_id
    @command = command
    @options = options.with_indifferent_access
    @connection_identifier = connection_identifier
    
    begin
      # Create lab runner
      lab_runner = LabRunnerService.new(
        user_id: user_id,
        session_id: session_id,
        lab_context: {
          job: 'background',
          job_id: job_id
        }
      )
      
      # Notify execution started
      broadcast_message({
        type: 'execution_started',
        command: command,
        session_id: session_id,
        timestamp: Time.current.iso8601
      })
      
      # Execute command
      if session_id.present?
        result = lab_runner.execute_in_session(command, options)
      else
        result = lab_runner.execute_command(command, options)
      end
      
      # Broadcast execution result
      broadcast_message({
        type: 'execution_completed',
        command: command,
        result: {
          stdout: result[:stdout],
          stderr: result[:stderr],
          exit_status: result[:exit_status],
          execution_time: result[:execution_time],
          timeout: result[:timeout] || false
        },
        session_id: session_id,
        timestamp: Time.current.iso8601
      })
      
      # Log successful execution
      Rails.logger.info "Successfully executed command for user #{user_id}: #{command}"
      
    rescue StandardError => e
      # Broadcast error
      broadcast_message({
        type: 'execution_error',
        command: command,
        error: e.message,
        session_id: session_id,
        timestamp: Time.current.iso8601
      })
      
      # Log error
      Rails.logger.error "Lab execution failed for user #{user_id}: #{e.message}"
      Rails.logger.error e.backtrace.join("\n") if e.backtrace
      
      # Re-raise for job retry mechanism
      raise e
    end
  end
  
  private
  
  def broadcast_message(message)
    ActionCable.server.broadcast(
      "lab_execution_#{@user_id}",
      message
    )
  end
end