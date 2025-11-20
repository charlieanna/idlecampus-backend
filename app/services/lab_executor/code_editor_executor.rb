# Code Editor Lab Executor
# Handles execution and validation for code editor labs
# Supports: Python, Golang, JavaScript, Ruby, Java
#
# Usage:
#   executor = LabExecutor::CodeEditorExecutor.new(lab, user: current_user)
#   result = executor.execute(user_code, step_index: 0)

module LabExecutor
  class CodeEditorExecutor < BaseExecutor
    # Check if this executor supports the lab format
    def self.supports?(lab_format)
      %w[code_editor python golang javascript ruby java].include?(lab_format.to_s)
    end

    # Execute code and run test cases
    # @param input [String] User's code
    # @param step_index [Integer] Current step index (usually 0 for code labs)
    # @return [Hash] { success: Boolean, output: String, error: String, validation: Hash }
    def execute(input, step_index: 0)
      log("Executing code for language: #{programming_language}", level: :info)

      # Validate code syntax first
      syntax_check = validate_syntax(input)
      unless syntax_check[:valid]
        return error_result(syntax_check[:message])
      end

      # Run all test cases
      test_results = run_test_cases(input)

      # Calculate overall success
      all_passed = test_results.all? { |result| result[:passed] }
      passed_count = test_results.count { |result| result[:passed] }
      total_count = test_results.size

      # Calculate score
      total_points = test_results.sum { |r| r[:points] || 0 }
      earned_points = test_results.select { |r| r[:passed] }.sum { |r| r[:points] || 0 }
      score = total_points > 0 ? (earned_points.to_f / total_points * 100).round(2) : 0

      {
        success: all_passed,
        output: format_test_output(test_results),
        error: all_passed ? "" : "#{total_count - passed_count} test(s) failed",
        validation: {
          valid: all_passed,
          message: "#{passed_count}/#{total_count} tests passed",
          score: score,
          test_results: test_results
        }
      }
    rescue => e
      log("Code execution error: #{e.message}", level: :error)
      error_result(e.message)
    end

    private

    # Get programming language from lab
    def programming_language
      @programming_language ||= lab.programming_language || lab.lab_format || 'python'
    end

    # Validate code syntax
    def validate_syntax(code)
      case programming_language.to_s
      when 'python', 'python3'
        validate_python_syntax(code)
      when 'golang', 'go'
        validate_golang_syntax(code)
      when 'javascript', 'js', 'node'
        validate_javascript_syntax(code)
      when 'ruby'
        validate_ruby_syntax(code)
      else
        { valid: true, message: "Syntax validation not available for #{programming_language}" }
      end
    end

    # Validate Python syntax
    def validate_python_syntax(code)
      # Write code to temporary file and check with python -m py_compile
      require 'tempfile'

      Tempfile.create(['user_code', '.py']) do |f|
        f.write(code)
        f.flush

        output = `python3 -m py_compile #{f.path} 2>&1`
        if $?.success?
          { valid: true, message: "Syntax OK" }
        else
          { valid: false, message: "Syntax Error: #{output}" }
        end
      end
    rescue => e
      { valid: false, message: "Syntax validation error: #{e.message}" }
    end

    # Validate Golang syntax
    def validate_golang_syntax(code)
      # Simple syntax check - can be enhanced
      { valid: true, message: "Golang syntax validation pending" }
    end

    # Validate JavaScript syntax
    def validate_javascript_syntax(code)
      # Use Node.js to check syntax
      require 'tempfile'

      Tempfile.create(['user_code', '.js']) do |f|
        f.write(code)
        f.flush

        output = `node --check #{f.path} 2>&1`
        if $?.success?
          { valid: true, message: "Syntax OK" }
        else
          { valid: false, message: "Syntax Error: #{output}" }
        end
      end
    rescue => e
      { valid: false, message: "Syntax validation error: #{e.message}" }
    end

    # Validate Ruby syntax
    def validate_ruby_syntax(code)
      # Use ruby -c to check syntax
      require 'tempfile'

      Tempfile.create(['user_code', '.rb']) do |f|
        f.write(code)
        f.flush

        output = `ruby -c #{f.path} 2>&1`
        if $?.success?
          { valid: true, message: "Syntax OK" }
        else
          { valid: false, message: "Syntax Error: #{output}" }
        end
      end
    rescue => e
      { valid: false, message: "Syntax validation error: #{e.message}" }
    end

    # Run all test cases
    def run_test_cases(code)
      test_cases = lab.test_cases || []

      return [{ passed: true, message: "No test cases defined" }] if test_cases.empty?

      test_cases.map.with_index do |test_case, index|
        run_single_test(code, test_case, index)
      end
    end

    # Run a single test case
    def run_single_test(code, test_case, index)
      log("Running test case #{index + 1}: #{test_case[:name] || test_case[:description]}", level: :debug)

      # Execute code with test input
      result = execute_code_with_input(code, test_case[:input])

      # Compare output
      actual_output = result[:output].strip
      expected_output = (test_case[:expected_output] || test_case[:output]).to_s.strip

      passed = actual_output == expected_output

      {
        name: test_case[:name] || test_case[:description] || "Test #{index + 1}",
        passed: passed,
        input: test_case[:input],
        expected: expected_output,
        actual: actual_output,
        hidden: test_case[:hidden] || false,
        points: test_case[:points] || 10,
        message: passed ? "Passed" : "Expected: #{expected_output}, Got: #{actual_output}"
      }
    rescue => e
      {
        name: test_case[:name] || "Test #{index + 1}",
        passed: false,
        error: e.message,
        points: test_case[:points] || 10
      }
    end

    # Execute code with specific input
    def execute_code_with_input(code, input)
      case programming_language.to_s
      when 'python', 'python3'
        execute_python_code(code, input)
      when 'golang', 'go'
        execute_golang_code(code, input)
      when 'javascript', 'js', 'node'
        execute_javascript_code(code, input)
      when 'ruby'
        execute_ruby_code(code, input)
      else
        { output: "", error: "Unsupported language: #{programming_language}" }
      end
    end

    # Execute Python code in Docker container
    def execute_python_code(code, input)
      require 'tempfile'
      require 'open3'

      Tempfile.create(['user_code', '.py']) do |f|
        f.write(code)
        f.flush

        # Build Docker command
        timeout = lab.time_limit_seconds || 5
        memory = lab.memory_limit_mb || 128

        docker_cmd = [
          "timeout", timeout.to_s,
          "docker", "run",
          "--rm",
          "--network", "none",
          "--memory", "#{memory}m",
          "--cpus", "0.5",
          "-v", "#{f.path}:/code.py:ro",
          "python:3.11-slim",
          "python", "/code.py"
        ]

        # Execute with input
        stdout, stderr, status = Open3.capture3(*docker_cmd, stdin_data: input.to_s)

        {
          output: stdout,
          error: stderr,
          exit_code: status.exitstatus
        }
      end
    rescue => e
      { output: "", error: e.message, exit_code: 1 }
    end

    # Execute JavaScript code in Docker container
    def execute_javascript_code(code, input)
      require 'tempfile'
      require 'open3'

      Tempfile.create(['user_code', '.js']) do |f|
        f.write(code)
        f.flush

        timeout = lab.time_limit_seconds || 5
        memory = lab.memory_limit_mb || 128

        docker_cmd = [
          "timeout", timeout.to_s,
          "docker", "run",
          "--rm",
          "--network", "none",
          "--memory", "#{memory}m",
          "--cpus", "0.5",
          "-v", "#{f.path}:/code.js:ro",
          "node:18-slim",
          "node", "/code.js"
        ]

        stdout, stderr, status = Open3.capture3(*docker_cmd, stdin_data: input.to_s)

        {
          output: stdout,
          error: stderr,
          exit_code: status.exitstatus
        }
      end
    rescue => e
      { output: "", error: e.message, exit_code: 1 }
    end

    # Execute Golang code (simplified - needs Go toolchain setup)
    def execute_golang_code(code, input)
      # Placeholder - implement full Go execution in Docker
      { output: "Golang execution not yet implemented", error: "", exit_code: 0 }
    end

    # Execute Ruby code
    def execute_ruby_code(code, input)
      require 'tempfile'
      require 'open3'

      Tempfile.create(['user_code', '.rb']) do |f|
        f.write(code)
        f.flush

        timeout = lab.time_limit_seconds || 5
        memory = lab.memory_limit_mb || 128

        docker_cmd = [
          "timeout", timeout.to_s,
          "docker", "run",
          "--rm",
          "--network", "none",
          "--memory", "#{memory}m",
          "--cpus", "0.5",
          "-v", "#{f.path}:/code.rb:ro",
          "ruby:3.2-slim",
          "ruby", "/code.rb"
        ]

        stdout, stderr, status = Open3.capture3(*docker_cmd, stdin_data: input.to_s)

        {
          output: stdout,
          error: stderr,
          exit_code: status.exitstatus
        }
      end
    rescue => e
      { output: "", error: e.message, exit_code: 1 }
    end

    # Format test results for output
    def format_test_output(test_results)
      output = []
      output << "Test Results:"
      output << "=" * 50

      test_results.each_with_index do |result, index|
        next if result[:hidden] # Don't show hidden test cases

        status = result[:passed] ? "✓ PASS" : "✗ FAIL"
        output << "\n#{index + 1}. #{result[:name]}: #{status}"

        unless result[:passed]
          output << "   Expected: #{result[:expected]}"
          output << "   Got: #{result[:actual]}"
        end
      end

      output << "\n" + "=" * 50
      passed = test_results.count { |r| r[:passed] }
      total = test_results.size
      output << "Total: #{passed}/#{total} tests passed"

      output.join("\n")
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
  end
end
