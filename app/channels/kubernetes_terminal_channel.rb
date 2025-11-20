class KubernetesTerminalChannel < ApplicationCable::Channel
  def subscribed
    reject unless current_user
    stream_from "kubernetes_terminal_#{current_user.id}"
    Rails.logger.info "User #{current_user.id} subscribed to Kubernetes terminal channel"
  end

  def unsubscribed
    Rails.logger.info "User #{current_user&.id} unsubscribed from Kubernetes terminal channel"
  end

  def execute_command(data)
    return reject_command('User not authenticated') unless current_user

    command = data['command']
    lesson_id = data['lesson_id']
    session_id = data['session_id']

    return reject_command('Command is required') unless command.present?

    begin
      # Validate command safety
      validate_command_safety(command)

      # Execute command via KubernetesLabRunner
      lab_runner = KubernetesLabRunner.new(
        user_id: current_user.id,
        session_id: session_id
      )

      result = lab_runner.execute_command(command)

      # Send result back to client
      transmit({
        type: 'command_result',
        success: result[:success],
        output: result[:output],
        exit_code: result[:exit_code],
        command: command,
        timestamp: Time.current.iso8601
      })

      # Track command execution for progress
      if result[:success] && lesson_id.present?
        session = LearningSession.find_or_create_active(current_user)
        
        # Record command in session
        session.update_state('last_command', command)
        session.update_state('last_command_timestamp', Time.current.iso8601)

        # Update mastery if this matches an expected command
        if lesson_id.present?
          mastery = current_user.command_masteries.find_or_create_by(canonical_command: lesson_id)
          mastery.update!(last_used_at: Time.current)
        end
      end

    rescue StandardError => e
      reject_command(e.message)
    end
  end

  def heartbeat(data)
    transmit({
      type: 'pong',
      timestamp: Time.current.iso8601
    })
  end

  private

  def reject_command(message)
    transmit({
      type: 'error',
      message: message,
      timestamp: Time.current.iso8601
    })
  end

  def validate_command_safety(command)
    # Basic validation - ensure command starts with kubectl or safe commands
    allowed_starts = ['kubectl', 'ls', 'cat', 'pwd', 'echo', 'cd', 'mkdir', 'touch', 'grep']
    command_base = command.split.first

    unless allowed_starts.include?(command_base)
      raise "Command '#{command_base}' is not allowed"
    end

    # Check for dangerous patterns
    dangerous_patterns = [
      /rm\s+-rf\s+\//, # Don't allow deleting root
      /sudo/,          # No sudo access
      />\s*\/etc/,     # No writing to system configs
      /\|\s*sh/,       # No piped shell execution
      /curl.*\|.*sh/,  # No curl piped to shell
    ]

    dangerous_patterns.each do |pattern|
      if command.match?(pattern)
        raise "Command contains potentially dangerous pattern"
      end
    end
  end
end
