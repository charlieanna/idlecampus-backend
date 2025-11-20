# Terminal Lab Executor
# Handles execution and validation for terminal-based labs
# Supports: Docker, Kubernetes, Linux command labs
#
# Usage:
#   executor = LabExecutor::TerminalExecutor.new(lab, user: current_user)
#   result = executor.execute(user_input, step_index: 0)

module LabExecutor
  class TerminalExecutor < BaseExecutor
    # Check if this executor supports the lab format
    def self.supports?(lab_format)
      %w[terminal docker kubernetes linux docker-compose].include?(lab_format.to_s)
    end

    # Execute terminal command
    # @param input [String] User's command
    # @param step_index [Integer] Current step index
    # @return [Hash] { success: Boolean, output: String, error: String, validation: Hash }
    def execute(input, step_index: 0)
      log("Executing terminal command for step #{step_index}", level: :info)

      step = current_step(step_index)
      return error_result("Invalid step index") unless step

      # Validate command structure first
      validation = validate_command(input, step)

      unless validation[:valid]
        return {
          success: false,
          output: "",
          error: validation[:message],
          validation: validation
        }
      end

      # Execute command in sandbox environment
      execution_result = execute_in_sandbox(input, step)

      # Validate output if expected
      if step[:expected_output] || step[:validation]
        output_validation = validate_output(
          execution_result[:output],
          step[:expected_output] || step[:validation]
        )

        return {
          success: output_validation[:valid],
          output: execution_result[:output],
          error: output_validation[:valid] ? "" : output_validation[:message],
          validation: output_validation
        }
      end

      # Command executed successfully
      {
        success: true,
        output: execution_result[:output],
        error: "",
        validation: { valid: true, message: "Command executed successfully" }
      }
    rescue => e
      log("Terminal execution error: #{e.message}", level: :error)
      error_result(e.message)
    end

    private

    # Validate user command against expected command
    def validate_command(input, step)
      expected_command = step[:expected_command] || step[:command]
      return { valid: true, message: "No validation required" } unless expected_command

      # Determine validation type from lab config
      validation_type = step[:validation_type]&.to_sym || :semantic

      validate(input, expected_command, validation_type: validation_type)
    end

    # Validate command output
    def validate_output(actual_output, expected_output)
      # If expected output is a hash with validation rules
      if expected_output.is_a?(Hash)
        return validate_with_rules(actual_output, expected_output)
      end

      # Otherwise, do simple contains validation
      validate_contains(actual_output, expected_output)
    end

    # Validate with custom rules
    def validate_with_rules(output, rules)
      case rules[:type]
      when 'contains'
        validate_contains(output, rules[:value])
      when 'regex'
        validate_regex(output, rules[:pattern])
      when 'exact'
        validate_exact(output, rules[:value])
      else
        validate_contains(output, rules[:value] || rules[:expected])
      end
    end

    # Execute command in sandboxed Docker environment
    def execute_in_sandbox(command, step)
      # Determine environment image
      environment = lab.environment_image || 'docker:20-dind'

      # Build safe command with timeout and resource limits
      safe_command = build_safe_command(command, environment)

      # Execute in isolated container
      begin
        output = execute_docker_command(safe_command)
        { output: output, error: nil }
      rescue => e
        { output: "", error: e.message }
      end
    end

    # Build safe Docker command with security constraints
    def build_safe_command(user_command, environment)
      # Sanitize user input to prevent command injection
      sanitized = sanitize_command(user_command)

      # Build Docker run command with security options
      docker_opts = [
        "--rm",                           # Remove container after execution
        "--network none",                 # No network access by default
        "--memory 256m",                  # Memory limit
        "--cpus 0.5",                     # CPU limit
        "--read-only",                    # Read-only root filesystem
        "--tmpfs /tmp:rw,noexec,nosuid",  # Writable tmp with restrictions
        "--security-opt no-new-privileges" # Prevent privilege escalation
      ]

      # Add network if lab requires it
      if lab.options&.dig(:allow_network)
        docker_opts.delete("--network none")
        docker_opts << "--network bridge"
      end

      # Build full command
      "docker run #{docker_opts.join(' ')} #{environment} sh -c '#{sanitized}'"
    end

    # Sanitize user command to prevent injection
    def sanitize_command(command)
      # Escape single quotes and other dangerous characters
      command.gsub("'", "'\\\\''")
    end

    # Execute Docker command with timeout
    def execute_docker_command(command)
      # Use Open3 for execution with timeout
      require 'open3'
      require 'timeout'

      timeout_seconds = options[:timeout] || 30

      Timeout.timeout(timeout_seconds) do
        stdout, stderr, status = Open3.capture3(command)

        if status.success?
          stdout
        else
          raise "Command failed: #{stderr}"
        end
      end
    rescue Timeout::Error
      raise "Command timed out after #{timeout_seconds} seconds"
    end

    # Return error result structure
    def error_result(message)
      {
        success: false,
        output: "",
        error: message,
        validation: { valid: false, message: message }
      }
    end

    # Enhanced semantic validation for terminal commands
    def validate_semantic(input, expected)
      # Extract base command and key flags
      input_parts = parse_command(input)
      expected_parts = parse_command(expected)

      # Check base command matches
      if input_parts[:base] != expected_parts[:base]
        return {
          valid: false,
          message: "Expected command: #{expected_parts[:base]}, got: #{input_parts[:base]}"
        }
      end

      # Check required flags are present
      missing_flags = expected_parts[:flags] - input_parts[:flags]
      if missing_flags.any?
        return {
          valid: false,
          message: "Missing required flags: #{missing_flags.join(', ')}"
        }
      end

      { valid: true, message: "Command structure is correct!" }
    end

    # Parse command into base and flags
    def parse_command(command_line)
      parts = command_line.to_s.strip.split
      base = parts.first
      flags = parts.select { |p| p.start_with?('-') }

      { base: base, flags: flags, args: parts[1..] }
    end
  end
end
