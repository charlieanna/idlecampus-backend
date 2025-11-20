class LogStreamingJob < ApplicationJob
  queue_as :lab_execution
  
  def perform(user_id, container_name, connection_identifier)
    @user_id = user_id
    @container_name = container_name
    @connection_identifier = connection_identifier
    
    begin
      # Validate container name follows security pattern
      unless container_name.start_with?('codesprout_lab_')
        raise "Invalid container name - must be a CodeSprout lab container"
      end
      
      # Stream logs from the container
      stream_logs
      
      Rails.logger.info "Log streaming started for container #{container_name} (user: #{user_id})"
      
    rescue StandardError => e
      broadcast_error(e.message)
      Rails.logger.error "Log streaming failed for user #{user_id}: #{e.message}"
      raise e
    end
  end
  
  private
  
  def stream_logs
    # Use IO.popen to stream logs in real-time
    IO.popen("docker logs -f --tail 100 #{@container_name} 2>&1") do |io|
      io.each_line do |line|
        broadcast_log_line(line.chomp)
      end
    end
  rescue Errno::ENOENT
    broadcast_error("Container not found: #{@container_name}")
  rescue IOError => e
    # Stream closed - this is normal when container stops
    broadcast_message({
      type: 'log_stream_ended',
      container_name: @container_name,
      timestamp: Time.current.iso8601
    })
  end
  
  def broadcast_log_line(line)
    broadcast_message({
      type: 'log',
      container_name: @container_name,
      line: line,
      timestamp: Time.current.iso8601
    })
  end
  
  def broadcast_error(message)
    broadcast_message({
      type: 'error',
      container_name: @container_name,
      error: message,
      timestamp: Time.current.iso8601
    })
  end
  
  def broadcast_message(message)
    ActionCable.server.broadcast(
      "lab_execution_#{@user_id}",
      message
    )
  end
end