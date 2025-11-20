#!/usr/bin/env ruby
# Master Test Runner for All Lab Tests
# Runs automated tests for all course labs

require_relative 'test_helper'
require_relative 'postgresql_labs_test'
require_relative 'system_design_labs_test'
require_relative 'aws_labs_test'
require_relative 'envoy_labs_test'
require_relative 'networking_labs_test'

class MasterLabTestRunner
  def self.print_header
    puts "\n" + "=" * 80
    puts "🧪 IDLECAMPUS LAB TEST SUITE - AUTOMATED TESTING"
    puts "=" * 80
    puts "Testing all newly created hands-on labs:"
    puts "  - PostgreSQL Database Mastery"
    puts "  - System Design & Back-of-Envelope"
    puts "  - AWS Cloud Architecture"
    puts "  - Envoy Proxy"
    puts "  - Networking Fundamentals"
    puts "=" * 80
    puts ""
  end

  def self.print_summary(all_results)
    puts "\n" + "=" * 80
    puts "📊 FINAL TEST SUMMARY"
    puts "=" * 80

    total_labs = 0
    total_passed = 0
    total_failed = 0

    all_results.each do |category, result|
      total_labs += result[:total]
      total_passed += result[:passed]
      total_failed += result[:failed]

      status = result[:failed] == 0 ? "✅" : "❌"
      puts "#{status} #{category.to_s.split('_').map(&:capitalize).join(' ')}: #{result[:passed]}/#{result[:total]} passed"
    end

    puts "-" * 80
    puts "Total Labs Tested: #{total_labs}"
    puts "Total Passed: #{total_passed} ✅"
    puts "Total Failed: #{total_failed} #{'❌' if total_failed > 0}"

    success_rate = (total_passed.to_f / total_labs * 100).round(1)
    puts "Success Rate: #{success_rate}%"
    puts "=" * 80

    if total_failed == 0
      puts "\n🎉 ALL TESTS PASSED! Labs are ready for production."
    else
      puts "\n⚠️  Some tests failed. Please review the output above."
    end

    { total: total_labs, passed: total_passed, failed: total_failed, success_rate: success_rate }
  end

  def self.run_all
    start_time = Time.now

    # Check prerequisites
    unless LabTestHelper.docker_available?
      puts "❌ Docker is not available. Please ensure Docker is installed and running."
      exit 1
    end

    print_header

    # Clean up any existing test containers
    puts "🧹 Cleaning up any existing test containers..."
    LabTestHelper.cleanup_all_test_containers
    puts ""

    # Run all test suites
    all_results = {}

    begin
      puts "Running test suites (this may take several minutes)..."
      puts ""

      all_results[:postgresql] = PostgreSQLLabsTest.run_all_tests
      puts "\n"

      all_results[:system_design] = SystemDesignLabsTest.run_all_tests
      puts "\n"

      all_results[:aws] = AWSLabsTest.run_all_tests
      puts "\n"

      all_results[:envoy] = EnvoyLabsTest.run_all_tests
      puts "\n"

      all_results[:networking] = NetworkingLabsTest.run_all_tests
      puts "\n"

    rescue Interrupt
      puts "\n\n⚠️  Tests interrupted by user"
      puts "🧹 Cleaning up test containers..."
      LabTestHelper.cleanup_all_test_containers
      exit 1
    rescue => e
      puts "\n\n❌ Fatal error during testing: #{e.message}"
      puts e.backtrace.first(5)
      puts "🧹 Cleaning up test containers..."
      LabTestHelper.cleanup_all_test_containers
      exit 1
    end

    # Print final summary
    summary = print_summary(all_results)

    # Cleanup
    puts "\n🧹 Final cleanup..."
    LabTestHelper.cleanup_all_test_containers

    duration = Time.now - start_time
    puts "\n⏱️  Total test duration: #{duration.round(2)}s (#{(duration / 60).round(1)} minutes)"
    puts ""

    # Exit with appropriate code
    exit(summary[:failed] > 0 ? 1 : 0)
  end
end

# Run if executed directly
if __FILE__ == $0
  MasterLabTestRunner.run_all
end
