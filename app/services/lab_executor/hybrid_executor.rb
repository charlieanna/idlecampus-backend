# Hybrid Lab Executor
# Handles labs that combine multiple execution types
# Supports: Terminal + Code Editor, Terminal + SQL, All three combined
#
# Example use cases:
# - PostgreSQL labs: Terminal (psql commands) + SQL (query execution)
# - DevOps labs: Terminal (docker commands) + Code (write scripts)
# - Full-stack labs: All three types
#
# Usage:
#   executor = LabExecutor::HybridExecutor.new(lab, user: current_user)
#   result = executor.execute(user_input, step_index: 0, execution_type: :terminal)

module LabExecutor
  class HybridExecutor < BaseExecutor
    # Check if this executor supports the lab format
    def self.supports?(lab_format)
      lab_format.to_s == 'hybrid'
    end

    # Execute based on current step's type
    # @param input [String] User's input (command/code/query)
    # @param step_index [Integer] Current step index
    # @param execution_type [Symbol] :terminal, :code, or :sql (optional, auto-detected)
    # @return [Hash] { success: Boolean, output: String, error: String, validation: Hash }
    def execute(input, step_index: 0, execution_type: nil)
      log("Executing hybrid lab step #{step_index}", level: :info)

      step = current_step(step_index)
      return error_result("Invalid step index") unless step

      # Determine execution type for this step
      exec_type = execution_type || detect_execution_type(step)

      log("Detected execution type: #{exec_type}", level: :debug)

      # Delegate to appropriate executor
      case exec_type
      when :terminal
        execute_terminal(input, step_index)
      when :code, :code_editor
        execute_code(input, step_index)
      when :sql, :sql_editor
        execute_sql(input, step_index)
      else
        error_result("Unknown execution type: #{exec_type}")
      end
    rescue => e
      log("Hybrid execution error: #{e.message}", level: :error)
      error_result(e.message)
    end

    private

    # Detect execution type from step metadata
    def detect_execution_type(step)
      # Check explicit type in step
      if step[:type] || step[:execution_type]
        return (step[:type] || step[:execution_type]).to_sym
      end

      # Infer from step attributes
      if step[:expected_command] || step[:command]
        return :terminal
      end

      if step[:programming_language] || step[:test_cases]
        return :code
      end

      if step[:expected_query] || step[:expected_result]
        return :sql
      end

      # Check lab format as fallback
      if lab.lab_format.to_s.include?('sql')
        return :sql
      end

      if lab.lab_format.to_s.include?('code')
        return :code
      end

      # Default to terminal
      :terminal
    end

    # Execute terminal command using TerminalExecutor
    def execute_terminal(input, step_index)
      executor = TerminalExecutor.new(lab, user: user, **options)
      result = executor.execute(input, step_index: step_index)

      # Add execution type to result
      result.merge(execution_type: :terminal)
    end

    # Execute code using CodeEditorExecutor
    def execute_code(input, step_index)
      executor = CodeEditorExecutor.new(lab, user: user, **options)
      result = executor.execute(input, step_index: step_index)

      # Add execution type to result
      result.merge(execution_type: :code)
    end

    # Execute SQL using SqlExecutor
    def execute_sql(input, step_index)
      executor = SqlExecutor.new(lab, user: user, **options)
      result = executor.execute(input, step_index: step_index)

      # Add execution type to result
      result.merge(execution_type: :sql)
    end

    # Get step metadata with hybrid support
    def current_step(step_index)
      step = super(step_index)
      return nil unless step

      # Enhance step with hybrid metadata
      enhance_step_metadata(step)
    end

    # Enhance step metadata for hybrid labs
    def enhance_step_metadata(step)
      # Add execution type if not present
      unless step[:execution_type] || step[:type]
        step[:execution_type] = detect_execution_type(step)
      end

      # Add hints based on execution type
      exec_type = step[:execution_type] || step[:type]
      step[:hints] ||= default_hints_for_type(exec_type)

      step
    end

    # Get default hints for execution type
    def default_hints_for_type(exec_type)
      case exec_type.to_sym
      when :terminal
        [
          "Use the terminal to execute commands",
          "Check command syntax carefully",
          "Use --help flag for command documentation"
        ]
      when :code
        [
          "Write your code in the editor",
          "Test with sample inputs first",
          "Check for edge cases"
        ]
      when :sql
        [
          "Write your SQL query",
          "Test with SELECT first",
          "Check table schema if needed"
        ]
      else
        []
      end
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

    # Override validation to support multiple types
    def validate(input, expected, validation_type: :exact)
      # Detect if we need type-specific validation
      step = current_step(0) # Use current step context if available

      if step
        exec_type = detect_execution_type(step)

        case exec_type
        when :terminal
          # Use semantic validation for terminal commands by default
          validation_type = :semantic if validation_type == :exact
        when :sql
          # Normalize SQL queries before validation
          input = normalize_sql(input)
          expected = normalize_sql(expected)
        end
      end

      super(input, expected, validation_type: validation_type)
    end

    # Normalize SQL query for comparison
    def normalize_sql(query)
      query.to_s
        .gsub(/\s+/, ' ')        # Normalize whitespace
        .gsub(/;\s*$/, '')       # Remove trailing semicolon
        .strip
        .downcase
    end

    # Get progress for hybrid lab
    def get_progress
      steps = lab.steps || []
      return { total: 0, completed: 0, by_type: {} } if steps.empty?

      progress_by_type = {
        terminal: { total: 0, completed: 0 },
        code: { total: 0, completed: 0 },
        sql: { total: 0, completed: 0 }
      }

      steps.each do |step|
        exec_type = detect_execution_type(step)
        progress_by_type[exec_type][:total] += 1

        # Check if step is completed (would need to track in database)
        # This is a placeholder - implement based on your progress tracking
      end

      {
        total: steps.size,
        completed: 0, # Implement progress tracking
        by_type: progress_by_type
      }
    end
  end
end
