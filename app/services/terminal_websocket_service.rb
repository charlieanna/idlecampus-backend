require 'json'

class TerminalWebsocketService
  """
  WebSocket service for interactive terminal sessions in labs
  Provides real-time command execution and output streaming
  """
  
  def initialize(session_id)
    @session_id = session_id
    @session = LabSession.find(session_id)
    @lab = @session.hands_on_lab
    @orchestrator = LabOrchestratorService.new
  end
  
  def handle_connection(websocket)
    """Handle WebSocket connection lifecycle"""
    
    # Send welcome message
    send_message(websocket, {
      type: 'connected',
      session_id: @session_id,
      lab_title: @lab.title,
      prompt: get_prompt
    })
    
    # Message loop
    websocket.each_message do |msg|
      handle_message(websocket, msg)
    end
    
  rescue => e
    Rails.logger.error("WebSocket error: #{e.message}")
    send_message(websocket, {
      type: 'error',
      message: e.message
    })
  ensure
    websocket.close if websocket
  end
  
  def handle_message(websocket, raw_message)
    """Handle incoming WebSocket message"""
    
    message = JSON.parse(raw_message)
    
    case message['type']
    when 'command'
      handle_command(websocket, message['command'])
    when 'resize'
      handle_resize(message['rows'], message['cols'])
    when 'heartbeat'
      send_message(websocket, { type: 'pong' })
    else
      send_message(websocket, { type: 'error', message: 'Unknown message type' })
    end
    
  rescue JSON::ParserError => e
    send_message(websocket, { type: 'error', message: 'Invalid JSON' })
  end
  
  def handle_command(websocket, command)
    """Execute command in container and stream output"""
    
    # Update last activity
    @session.update!(last_activity_at: Time.current)
    
    # Sanitize command
    sanitized_command = sanitize_command(command)
    
    # Check if command is allowed
    unless command_allowed?(sanitized_command)
      send_message(websocket, {
        type: 'output',
        data: "Command not allowed: #{sanitized_command}\n",
        error: true
      })
      return
    end
    
    # Execute command
    result = @orchestrator.execute_command(
      container_id: @session.container_id,
      command: sanitized_command,
      timeout: 30
    )
    
    # Send output
    send_message(websocket, {
      type: 'output',
      data: result[:stdout],
      error: !result[:success]
    })
    
    if result[:stderr].present?
      send_message(websocket, {
        type: 'output',
        data: result[:stderr],
        error: true
      })
    end
    
    # Send prompt
    send_message(websocket, {
      type: 'prompt',
      data: get_prompt
    })
    
    # Track command execution
    @session.record_command(sanitized_command, result)
    
    # Check if step validation should run
    check_step_validation(websocket, sanitized_command)
  end
  
  def handle_resize(rows, cols)
    """Handle terminal resize"""
    # Store terminal dimensions (for future PTY integration)
    @terminal_size = { rows: rows, cols: cols }
  end
  
  private
  
  def send_message(websocket, data)
    """Send JSON message to websocket"""
    websocket.send(data.to_json)
  end
  
  def get_prompt
    """Get terminal prompt"""
    "[lab-#{@session.current_step + 1}] $ "
  end
  
  def sanitize_command(command)
    """Sanitize user input"""
    
    # Remove dangerous patterns
    command.to_s
      .gsub(/[;&|`$()]/, '') # Remove shell meta-characters
      .strip
  end
  
  def command_allowed?(command)
    """Check if command is allowed in lab context"""
    
    # Blacklist dangerous commands
    blacklist = [
      'rm -rf /',
      'dd if=/dev/zero',
      'fork bomb',
      ':(){ :|:& };:',
      'shutdown',
      'reboot',
      'halt'
    ]
    
    blacklist.none? { |dangerous| command.downcase.include?(dangerous) }
  end
  
  def check_step_validation(websocket, command)
    """Check if command completes current step"""
    
    steps = @lab.steps.is_a?(Array) ? @lab.steps : []
    current_step = steps[@session.current_step]
    
    return unless current_step
    
    expected_command = current_step['expected_command']
    
    # Check if command matches (flexible matching)
    if command_matches?(command, expected_command)
      send_message(websocket, {
        type: 'step_complete',
        step_number: @session.current_step,
        message: current_step['title'] + ' completed!'
      })
      
      # Advance step
      @session.record_step_completion(@session.current_step)
      @session.update!(current_step: @session.current_step + 1)
      
      # Track event
      LearningEventTracker.lab_step_completed(
        user: @session.user,
        lab: @lab,
        session: @session,
        step_number: @session.current_step - 1
      )
    end
  end
  
  def command_matches?(user_command, expected_command)
    """Check if user command matches expected (flexible)"""
    
    user_normalized = user_command.to_s.strip.squeeze(' ').downcase
    expected_normalized = expected_command.to_s.strip.squeeze(' ').downcase
    
    # Exact match
    return true if user_normalized == expected_normalized
    
    # Contains expected command
    user_normalized.include?(expected_normalized)
  end
end

