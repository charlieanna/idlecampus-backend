# Lab Testing Helper
# Provides utilities for testing hands-on labs

require 'open3'
require 'timeout'

module LabTestHelper
  class TestResult
    attr_accessor :success, :message, :output, :duration

    def initialize(success, message, output = '', duration = 0)
      @success = success
      @message = message
      @output = output
      @duration = duration
    end

    def to_s
      status = @success ? "✅ PASS" : "❌ FAIL"
      "#{status}: #{@message} (#{@duration.round(2)}s)"
    end
  end

  # Execute a shell command with timeout
  def self.execute_command(command, timeout: 30)
    start_time = Time.now
    stdout_str = ""
    stderr_str = ""
    status = nil

    begin
      Timeout.timeout(timeout) do
        stdout_str, stderr_str, status = Open3.capture3(command)
      end
    rescue Timeout::Error
      return TestResult.new(false, "Command timed out after #{timeout}s", "", Time.now - start_time)
    rescue => e
      return TestResult.new(false, "Command failed: #{e.message}", "", Time.now - start_time)
    end

    duration = Time.now - start_time
    success = status.success?
    output = stdout_str + stderr_str

    TestResult.new(success, success ? "Command executed successfully" : "Command failed", output, duration)
  end

  # Check if a Docker container is running
  def self.container_running?(container_name)
    result = execute_command("docker ps --filter name=#{container_name} --format '{{.Names}}'")
    result.success && result.output.strip.include?(container_name)
  end

  # Stop and remove a container
  def self.cleanup_container(container_name)
    execute_command("docker rm -f #{container_name} 2>/dev/null")
  end

  # Cleanup all test containers
  def self.cleanup_all_test_containers
    containers = [
      'postgres-lab', 'postgres-perf', 'postgres-tx', 'postgres-advanced',
      'system-design-test', 'aws-test', 'envoy-test', 'networking-test'
    ]
    containers.each { |name| cleanup_container(name) }
  end

  # Validate command output contains expected string
  def self.validate_output(command, expected_string, timeout: 30)
    result = execute_command(command, timeout: timeout)
    if result.success && result.output.include?(expected_string)
      TestResult.new(true, "Output contains '#{expected_string}'", result.output, result.duration)
    else
      TestResult.new(false, "Output missing '#{expected_string}'. Got: #{result.output[0..200]}", result.output, result.duration)
    end
  end

  # Run a lab step and validate
  def self.run_lab_step(step_number, title, command, validation_command = nil, timeout: 30)
    puts "\n  Step #{step_number}: #{title}"
    puts "  Command: #{command[0..100]}#{command.length > 100 ? '...' : ''}"

    # Execute the main command
    result = execute_command(command, timeout: timeout)

    unless result.success
      puts "  #{result}"
      return result
    end

    # Run validation if provided
    if validation_command
      sleep 1 # Give container time to initialize
      validation_result = execute_command(validation_command, timeout: 10)
      puts "  Validation: #{validation_result.success ? '✅' : '❌'}"
      return validation_result
    end

    puts "  #{result}"
    result
  end

  # Test a complete lab
  def self.test_lab(lab_name, steps, cleanup_containers: [])
    puts "\n" + "=" * 80
    puts "Testing Lab: #{lab_name}"
    puts "=" * 80

    start_time = Time.now
    failed_steps = []

    steps.each_with_index do |step, index|
      result = run_lab_step(
        step[:step_number] || index + 1,
        step[:title],
        step[:command],
        step[:validation],
        timeout: step[:timeout] || 30
      )

      unless result.success
        failed_steps << { step: step[:title], error: result.message }
      end
    end

    # Cleanup
    puts "\n  Cleanup: Removing test containers..."
    cleanup_containers.each { |name| cleanup_container(name) }

    duration = Time.now - start_time
    success = failed_steps.empty?

    puts "\n" + "-" * 80
    if success
      puts "✅ Lab '#{lab_name}' PASSED (#{duration.round(2)}s)"
    else
      puts "❌ Lab '#{lab_name}' FAILED (#{duration.round(2)}s)"
      puts "\nFailed steps:"
      failed_steps.each do |failure|
        puts "  - #{failure[:step]}: #{failure[:error]}"
      end
    end
    puts "=" * 80

    { success: success, duration: duration, failed_steps: failed_steps }
  end

  # Wait for container to be ready
  def self.wait_for_container(container_name, max_wait: 10)
    max_wait.times do
      return true if container_running?(container_name)
      sleep 1
    end
    false
  end

  # Check if Docker is available
  def self.docker_available?
    result = execute_command("docker --version")
    result.success
  end
end
