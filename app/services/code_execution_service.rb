# Service to execute code in isolated Docker containers
# Supports Python and Go with security sandboxing
class CodeExecutionService
  SUPPORTED_LANGUAGES = {
    'python' => {
      extension: '.py',
      image: 'python:3.11-alpine',
      command: 'python3',
      timeout_cmd: 'timeout'
    },
    'golang' => {
      extension: '.go',
      image: 'golang:1.21-alpine',
      command: 'go run',
      timeout_cmd: 'timeout'
    }
  }.freeze

  class ExecutionError < StandardError; end
  class TimeoutError < StandardError; end
  class UnsupportedLanguageError < StandardError; end

  attr_reader :lab, :user, :language_config

  def initialize(lab, user = nil)
    @lab = lab
    @user = user

    unless SUPPORTED_LANGUAGES.key?(lab.programming_language)
      raise UnsupportedLanguageError, "Language #{lab.programming_language} is not supported"
    end

    @language_config = SUPPORTED_LANGUAGES[lab.programming_language]
  end

  # Execute code without validation (for testing/debugging)
  def execute(code, test_input = nil)
    container_name = generate_container_name
    temp_dir = nil

    begin
      # Create temporary directory for code
      temp_dir = create_temp_directory
      code_file = write_code_to_file(temp_dir, code)

      # Execute in isolated container
      result = execute_in_container(
        container_name,
        code_file,
        test_input
      )

      {
        success: result[:exit_code] == 0,
        output: result[:stdout],
        error: result[:stderr],
        execution_time: result[:execution_time],
        memory_used: result[:memory_used],
        exit_code: result[:exit_code]
      }
    rescue Timeout::Error => e
      {
        success: false,
        error: "Execution timed out after #{@lab.time_limit_seconds} seconds",
        execution_time: @lab.time_limit_seconds,
        timeout: true
      }
    rescue => e
      Rails.logger.error("Code execution error: #{e.message}\n#{e.backtrace.join("\n")}")
      {
        success: false,
        error: "Execution error: #{e.message}",
        execution_time: 0
      }
    ensure
      cleanup_container(container_name)
      cleanup_temp_directory(temp_dir) if temp_dir
    end
  end

  # Validate code against all test cases
  def validate_against_tests(code)
    results = []
    all_tests = @lab.all_test_cases

    return { error: 'No test cases defined' } if all_tests.empty?

    all_tests.each_with_index do |test_case, index|
      result = run_single_test(code, test_case, index + 1)
      results << result
    end

    passed_count = results.count { |r| r[:passed] }

    {
      total_tests: results.length,
      passed_tests: passed_count,
      failed_tests: results.length - passed_count,
      results: results,
      all_passed: results.all? { |r| r[:passed] },
      pass_percentage: (passed_count.to_f / results.length * 100).round(2)
    }
  end

  # Run code against a single test case
  def run_single_test(code, test_case, test_number)
    test_input = test_case['input']
    expected_output = test_case['expected_output']
    description = test_case['description']

    # Wrap code with test input/output handling
    wrapped_code = wrap_code_with_test(code, test_input)

    execution_result = execute(wrapped_code, test_input)

    actual_output = execution_result[:output]&.strip
    expected_output_clean = expected_output&.strip

    passed = if execution_result[:success]
               compare_outputs(actual_output, expected_output_clean)
             else
               false
             end

    {
      test_number: test_number,
      description: description,
      input: test_input,
      expected_output: expected_output,
      actual_output: actual_output,
      passed: passed,
      execution_time: execution_result[:execution_time],
      error: execution_result[:error],
      timeout: execution_result[:timeout] || false
    }
  end

  private

  def generate_container_name
    prefix = @user ? "code-exec-#{@user.id}" : "code-exec-guest"
    "#{prefix}-#{SecureRandom.hex(8)}"
  end

  def create_temp_directory
    dir = File.join(Dir.tmpdir, "code_exec_#{SecureRandom.hex(8)}")
    FileUtils.mkdir_p(dir)
    dir
  end

  def write_code_to_file(dir, code)
    filename = "main#{@language_config[:extension]}"
    filepath = File.join(dir, filename)
    File.write(filepath, code)
    filepath
  end

  def execute_in_container(container_name, code_file, test_input)
    image = @language_config[:image]
    command = @language_config[:command]
    filename = File.basename(code_file)

    # Build Docker command with security restrictions
    docker_cmd = build_docker_command(container_name, image, File.dirname(code_file), filename, command)

    start_time = Time.now

    # Execute with timeout
    stdout, stderr, status = nil, nil, nil
    begin
      Timeout.timeout(@lab.time_limit_seconds + 1) do
        stdout, stderr, status = Open3.capture3(
          *docker_cmd,
          stdin_data: test_input.to_s
        )
      end
    rescue Timeout::Error
      # Force kill the container
      cleanup_container(container_name)
      raise TimeoutError, "Execution exceeded time limit"
    end

    execution_time = Time.now - start_time

    # Get memory usage (if container still exists)
    memory_used = get_container_memory_usage(container_name)

    {
      stdout: stdout,
      stderr: stderr,
      exit_code: status.exitstatus,
      execution_time: execution_time.round(3),
      memory_used: memory_used
    }
  end

  def build_docker_command(container_name, image, code_dir, filename, command)
    cmd = [
      'docker', 'run',
      '--name', container_name,
      '--rm',
      '--network', 'none',                              # No network access
      '--memory', "#{@lab.memory_limit_mb}m",           # Memory limit
      '--memory-swap', "#{@lab.memory_limit_mb}m",      # No swap
      '--cpus', '0.5',                                   # CPU limit
      '--pids-limit', '50',                              # Process limit
      '--read-only',                                     # Read-only filesystem
      '--tmpfs', '/tmp:rw,noexec,nosuid,size=10m',      # Small writable tmp
      '-v', "#{code_dir}:/workspace:ro",                # Mount code read-only
      '-w', '/workspace',                                # Working directory
      '-i',                                              # Interactive (for stdin)
      image,
      'timeout', '-s', 'KILL', @lab.time_limit_seconds.to_s,  # Internal timeout
      command, filename
    ]

    cmd
  end

  def get_container_memory_usage(container_name)
    # Try to get memory stats
    output = `docker stats #{container_name} --no-stream --format "{{.MemUsage}}" 2>/dev/null`
    if output.present?
      # Parse output like "10.5MiB / 128MiB"
      match = output.match(/(\d+\.?\d*)(MiB|KiB|GiB)/)
      return match[1].to_f if match
    end
    0.0
  rescue
    0.0
  end

  def cleanup_container(container_name)
    system("docker rm -f #{container_name} > /dev/null 2>&1")
  end

  def cleanup_temp_directory(dir)
    FileUtils.rm_rf(dir) if Dir.exist?(dir)
  rescue => e
    Rails.logger.warn("Failed to cleanup temp directory #{dir}: #{e.message}")
  end

  def wrap_code_with_test(code, test_input)
    # For Python, wrap with test input handling
    case @lab.programming_language
    when 'python'
      wrap_python_code(code, test_input)
    when 'golang'
      wrap_golang_code(code, test_input)
    else
      code
    end
  end

  def wrap_python_code(code, test_input)
    # If test input is provided, make it available via stdin simulation
    # Otherwise, just run the code
    if test_input.present?
      # Prepend input simulation
      input_lines = test_input.split("\n")
      input_setup = <<~PYTHON
        import sys
        from io import StringIO

        # Simulate stdin for testing
        test_input = #{input_lines.inspect}
        sys.stdin = StringIO('\\n'.join(test_input))

      PYTHON
      input_setup + code
    else
      code
    end
  end

  def wrap_golang_code(code, test_input)
    # For Go, we can't easily inject stdin simulation
    # So we'll rely on the actual stdin from Docker
    code
  end

  def compare_outputs(actual, expected)
    return false if actual.nil? || expected.nil?

    # Normalize whitespace and compare
    actual_normalized = normalize_output(actual)
    expected_normalized = normalize_output(expected)

    actual_normalized == expected_normalized
  end

  def normalize_output(output)
    # Remove trailing whitespace from each line
    # Remove empty lines at the end
    # Normalize line endings
    output.to_s
      .lines
      .map(&:rstrip)
      .join("\n")
      .strip
  end

  # Check if code contains forbidden imports
  def validate_imports(code)
    case @lab.programming_language
    when 'python'
      validate_python_imports(code)
    when 'golang'
      validate_golang_imports(code)
    else
      { valid: true }
    end
  end

  def validate_python_imports(code)
    # Extract all import statements
    import_pattern = /^\s*(?:import|from)\s+([\w.]+)/
    imports = code.scan(import_pattern).flatten

    allowed = @lab.allowed_imports_list
    return { valid: true } if allowed.empty?  # No restrictions

    forbidden = imports.reject { |imp| allowed.include?(imp.split('.').first) }

    if forbidden.any?
      { valid: false, forbidden_imports: forbidden }
    else
      { valid: true }
    end
  end

  def validate_golang_imports(code)
    # Extract all import statements
    import_pattern = /import\s+(?:"([^"]+)"|(?:\(([^)]+)\)))/m
    matches = code.scan(import_pattern)

    imports = []
    matches.each do |single, multi|
      if single
        imports << single
      elsif multi
        imports.concat(multi.scan(/"([^"]+)"/).flatten)
      end
    end

    allowed = @lab.allowed_imports_list
    return { valid: true } if allowed.empty?

    forbidden = imports.reject { |imp| allowed.any? { |a| imp.start_with?(a) } }

    if forbidden.any?
      { valid: false, forbidden_imports: forbidden }
    else
      { valid: true }
    end
  end
end
