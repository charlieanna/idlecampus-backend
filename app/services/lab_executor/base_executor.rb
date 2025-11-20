# Lab Executor - Base Class
# Defines interface for all lab executors
# Handles terminal, code editor, SQL, and hybrid labs

module LabExecutor
  class BaseExecutor
    attr_reader :lab, :user, :options

    def initialize(lab, user: nil, **options)
      @lab = lab
      @user = user
      @options = options
    end

    # Main execution method - must be implemented by subclasses
    # @param input [String] User's command/code/query
    # @param step_index [Integer] Current step index (for multi-step labs)
    # @return [Hash] { success: Boolean, output: String, error: String, validation: Hash }
    def execute(input, step_index: 0)
      raise NotImplementedError, "Subclasses must implement execute method"
    end

    # Validate user input against expected output
    # @param input [String] User's input
    # @param expected [String] Expected output/command
    # @param validation_type [Symbol] :exact, :contains, :regex, :semantic
    # @return [Hash] { valid: Boolean, message: String }
    def validate(input, expected, validation_type: :exact)
      case validation_type
      when :exact
        validate_exact(input, expected)
      when :contains
        validate_contains(input, expected)
      when :regex
        validate_regex(input, expected)
      when :semantic
        validate_semantic(input, expected)
      else
        { valid: false, message: "Unknown validation type: #{validation_type}" }
      end
    end

    # Check if executor supports this lab format
    def self.supports?(lab_format)
      false
    end

    # Factory method to get appropriate executor for lab format
    def self.for_format(lab_format, **options)
      executor_class = case lab_format.to_s
      when 'terminal', 'docker', 'kubernetes', 'linux', 'docker-compose'
        TerminalExecutor
      when 'code_editor', 'python', 'golang', 'javascript', 'ruby', 'java'
        CodeEditorExecutor
      when 'sql_editor', 'sql', 'postgresql', 'mysql'
        SqlExecutor
      when 'hybrid'
        HybridExecutor
      else
        TerminalExecutor # Default fallback
      end

      executor_class
    end

    protected

    # Exact match validation
    def validate_exact(input, expected)
      normalized_input = normalize_string(input)
      normalized_expected = normalize_string(expected)

      if normalized_input == normalized_expected
        { valid: true, message: "Correct!" }
      else
        { valid: false, message: "Expected: #{expected}" }
      end
    end

    # Contains validation (input contains expected substring)
    def validate_contains(input, expected)
      if normalize_string(input).include?(normalize_string(expected))
        { valid: true, message: "Correct!" }
      else
        { valid: false, message: "Output should contain: #{expected}" }
      end
    end

    # Regex validation
    def validate_regex(input, pattern)
      regex = Regexp.new(pattern)
      if regex.match?(input)
        { valid: true, message: "Correct!" }
      else
        { valid: false, message: "Output should match pattern: #{pattern}" }
      end
    end

    # Semantic validation (command structure, not exact match)
    def validate_semantic(input, expected)
      # Extract base command
      input_cmd = extract_base_command(input)
      expected_cmd = extract_base_command(expected)

      if input_cmd == expected_cmd
        { valid: true, message: "Correct command!" }
      else
        { valid: false, message: "Expected command: #{expected_cmd}" }
      end
    end

    # Normalize string for comparison
    def normalize_string(str)
      str.to_s.strip.downcase
    end

    # Extract base command from full command line
    def extract_base_command(command_line)
      command_line.to_s.strip.split.first
    end

    # Log execution
    def log(message, level: :info)
      prefix = "[LabExecutor:#{self.class.name.split('::').last}]"
      case level
      when :info
        Rails.logger.info "#{prefix} #{message}"
      when :warn
        Rails.logger.warn "#{prefix} #{message}"
      when :error
        Rails.logger.error "#{prefix} #{message}"
      when :debug
        Rails.logger.debug "#{prefix} #{message}"
      end
    end

    # Get current step from lab
    def current_step(step_index)
      return nil unless lab.steps.is_a?(Array)
      lab.steps[step_index]
    end

    # Check if lab has multiple steps
    def multi_step?
      lab.steps.is_a?(Array) && lab.steps.size > 1
    end

    # Safe JSON parse
    def safe_parse_json(json_string)
      JSON.parse(json_string)
    rescue JSON::ParserError
      nil
    end
  end
end
