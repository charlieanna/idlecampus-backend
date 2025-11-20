class DockerExerciseValidator
  # Simple, rule-based validator for docker practice micros
  # Input: user_command (String), spec (Hash)
  # Spec keys (all optional):
  #   :base_command => String or [String]
  #   :required_flags => [String]
  #   :requires_argument => true/false
  #   :accepts_any_image => true/false
  #   :required_image => String
  #   :required_tag => String
  # Returns: { valid: Boolean, message: String }
  # Supports both signatures:
  #   validate(user_command, spec)
  #   validate(user_command, _result, spec)
  def self.validate(*args)
    user_command = args[0]
    # Second arg might be result hash (from execute) or spec directly
    result = args.length == 3 ? args[1] : nil
    spec = args.length == 3 ? (args[2] || {}) : (args[1] || {})
    
    cmd = (user_command || '').strip
    return failure('Please enter a command.') if cmd.empty?

    tokens = shell_split(cmd)
    return failure('Invalid command format.') if tokens.empty?
    
    # Check if command actually succeeded if require_success is set
    if spec[:require_success] && result
      # Special case: docker run without -d shows container logs (normal behavior)
      # Don't treat startup logs as failures
      is_foreground_run = user_command.include?('docker run') && !user_command.include?('-d')
      
      unless result[:success] || is_foreground_run
        # Extract helpful error from output
        error_hint = if result[:output] =~ /not exist/i
                      "Image doesn't exist. Check the spelling - did you mean 'nginx'?"
                    elsif result[:output] =~ /invalid|unknown flag/i
                      "Invalid flag. Use - not = for flags (e.g., -a not =a)"
                    elsif result[:output] =~ /name.*already in use|Conflict/i
                      "Container name conflict (shouldn't happen - auto-cleanup failed). Try again or use a different name."
                    elsif result[:output]
                      "Command failed: #{result[:output].split("\n").first(2).join(' ')}"
                    else
                      "Command failed to execute. Check your syntax."
                    end
        return failure(error_hint)
      end
    end

    # Base command (supports multiple acceptable forms)
    if spec[:base_command]
      accepted = Array(spec[:base_command])
      unless accepted.any? { |base| tokens.first(accepted_base_word_count(base)) == base.split }
        # Provide a more helpful error for common mistakes
        if spec[:expected_command]
          return failure("This lesson requires: #{spec[:expected_command]}")
        else
          return failure("Start with: #{accepted.join(' or ')}")
        end
      end
    end

    # Required flags (presence anywhere)
    if spec[:required_flags]&.any?
      missing = spec[:required_flags].reject do |flag|
        # Check for exact match
        next true if tokens.include?(flag)
        
        # Check for flag with value (e.g., "--name myapp" should match "--name myapp" or "--name=myapp")
        if flag.include?(' ')
          flag_parts = flag.split(' ', 2)
          flag_name = flag_parts[0]
          flag_value = flag_parts[1]
          
          # Check if flag_name exists and next token is flag_value
          flag_index = tokens.find_index { |t| t == flag_name || t.start_with?(flag_name) }
          if flag_index
            # Check if next token is the value, or if flag is combined like "--name=myapp"
            next_token = tokens[flag_index + 1]
            combined_flag = tokens[flag_index]
            
            next true if next_token == flag_value
            next true if combined_flag == "#{flag_name}=#{flag_value}"
            next true if combined_flag.start_with?("#{flag_name}=") && combined_flag.end_with?(flag_value)
          end
        else
          # Simple flag (no value) - check if it exists or starts with it
          next true if tokens.any? { |t| t == flag || t.start_with?(flag) }
        end
        
        false
      end
      return failure("Missing required flag(s): #{missing.join(', ')}") if missing.any?
    end

    # Requires argument (e.g., image or container)
    if spec[:requires_argument]
      # crude check: at least 3 tokens (e.g., docker run nginx)
      return failure('Missing required argument (e.g., image or name).') if tokens.size < 3
    end

    # Image checks
    if spec[:required_image]
      unless tokens.any? { |t| t == spec[:required_image] || t.start_with?("#{spec[:required_image]}:") }
        return failure("Use image: #{spec[:required_image]}")
      end
    end

    if spec[:required_tag]
      img = tokens.find { |t| t.include?(':') }
      unless img&.split(':')&.last == spec[:required_tag]
        return failure("Use tag: #{spec[:required_tag]}")
      end
    end

    # Get story-aware success message
    success_msg = get_story_message(cmd, spec) || 'Looks good!'
    success(success_msg)
  rescue => e
    failure("Validation error: #{e.message}")
  end
  
  def self.get_story_message(command, spec)
    # Provide contextual success messages based on the story
    if command.include?('myapp')
      if command.include?('docker run')
        if command.include?('-d')
          "Perfect! MyApp is running in the background. You got a container ID back!"
        else
          "Good! Nginx started - you saw the startup logs above."
        end
      elsif command.include?('docker ps')
        "Excellent! You can see myapp in the list. Notice the STATUS and PORTS?"
      elsif command.include?('docker logs')
        if command.include?('-f')
          "Great! Streaming myapp's logs in real-time..."
        else
          "Perfect! These are myapp's logs since startup."
        end
      elsif command.include?('docker exec')
        if command.include?('bash')
          "Success! You're now inside myapp's container. Try 'ls' or 'pwd'!"
        else
          "Nice! Command executed inside myapp."
        end
      elsif command.include?('docker stop')
        "Well done! MyApp is shutting down gracefully. Check docker ps -a to verify."
      end
    elsif command.include?('docker run') && command.include?('nginx')
      if command.include?('-d')
        "Perfect! Nginx is running in the background. See that container ID?"
      else
        "Excellent! Nginx started successfully. Notice how it shows the configuration logs? This is normal! In the next step, you'll learn to run it in the background so your terminal isn't blocked."
      end
    elsif command.include?('myapp-net') || command.include?('network')
      "Perfect! Network created. Now myapp can communicate with other services!"
    elsif command.include?('myapp-content') || command.include?('myapp-custom')
      "Excellent! Your custom setup for myapp is ready."
    elsif command.include?('docker-compose')
      "Success! The complete myapp stack is being managed by Compose."
    elsif command.include?('nginx') || command.include?('alpine')
      "Great! Image operation successful. This supports your myapp deployment."
    end
  end

  def self.shell_split(command)
    # Basic split on whitespace; good enough for simple training commands
    command.scan(/(?:"[^"]*"|'[^']*'|\S)+/)
  end

  def self.accepted_base_word_count(base)
    base.split.size
  end

  def self.failure(message)
    { valid: false, message: message }
  end

  def self.success(message)
    { valid: true, message: message }
  end
end
