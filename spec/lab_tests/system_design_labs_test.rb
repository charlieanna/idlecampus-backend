#!/usr/bin/env ruby
# System Design Labs Automated Tests

require_relative 'test_helper'

class SystemDesignLabsTest
  include LabTestHelper

  def self.test_storage_calculation_lab
    LabTestHelper.test_lab(
      "Storage Capacity Planning Lab",
      [
        {
          step_number: 1,
          title: "Start Python container",
          command: "docker run -d --name system-design-storage -it python:3.11-alpine sleep 3600",
          validation: "docker ps --filter name=system-design-storage --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Calculate storage for 1M users",
          command: "docker exec system-design-storage python3 -c 'users = 1_000_000; avg_size_kb = 50; total_gb = (users * avg_size_kb) / (1024 * 1024); print(f\"Storage needed: {total_gb:.2f} GB\")'",
          validation: "docker exec system-design-storage python3 -c 'print(1_000_000 * 50 / (1024 * 1024))' | grep -E '[0-9]+'"
        },
        {
          step_number: 3,
          title: "Calculate with growth factor",
          command: "docker exec system-design-storage python3 -c 'storage_gb = 47.68; growth_rate = 0.20; years = 3; future_storage = storage_gb * ((1 + growth_rate) ** years); print(f\"Storage in 3 years: {future_storage:.2f} GB\")'",
          validation: "docker exec system-design-storage python3 -c 'print(47.68 * (1.2 ** 3))' | grep -E '[0-9]+'"
        },
        {
          step_number: 4,
          title: "Calculate replication overhead",
          command: "docker exec system-design-storage python3 -c 'base_storage = 82.48; replication_factor = 3; total_with_replication = base_storage * replication_factor; print(f\"Total with 3x replication: {total_with_replication:.2f} GB\")'",
          validation: "docker exec system-design-storage python3 -c 'print(82.48 * 3)' | grep -E '[0-9]+'"
        }
      ],
      cleanup_containers: ['system-design-storage']
    )
  end

  def self.test_qps_calculation_lab
    LabTestHelper.test_lab(
      "QPS and Traffic Estimation Lab",
      [
        {
          step_number: 1,
          title: "Start Python container",
          command: "docker run -d --name system-design-qps -it python:3.11-alpine sleep 3600",
          validation: "docker ps --filter name=system-design-qps --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Calculate average QPS",
          command: "docker exec system-design-qps python3 -c 'daily_users = 10_000_000; requests_per_user = 20; total_requests = daily_users * requests_per_user; seconds_per_day = 86400; avg_qps = total_requests / seconds_per_day; print(f\"Average QPS: {avg_qps:.0f}\")'",
          validation: "docker exec system-design-qps python3 -c 'print(10_000_000 * 20 / 86400)' | grep -E '[0-9]+'"
        },
        {
          step_number: 3,
          title: "Calculate peak QPS",
          command: "docker exec system-design-qps python3 -c 'avg_qps = 2314; peak_multiplier = 3; peak_qps = avg_qps * peak_multiplier; print(f\"Peak QPS: {peak_qps:.0f}\")'",
          validation: "docker exec system-design-qps python3 -c 'print(2314 * 3)' | grep -E '[0-9]+'"
        },
        {
          step_number: 4,
          title: "Calculate servers needed",
          command: "docker exec system-design-qps python3 -c 'import math; peak_qps = 6942; qps_per_server = 1000; servers_needed = math.ceil(peak_qps / qps_per_server); print(f\"Servers needed: {servers_needed}\")'",
          validation: "docker exec system-design-qps python3 -c 'import math; print(math.ceil(6942 / 1000))' | grep -E '[0-9]+'"
        }
      ],
      cleanup_containers: ['system-design-qps']
    )
  end

  def self.test_bandwidth_calculation_lab
    LabTestHelper.test_lab(
      "Bandwidth and Network Capacity Lab",
      [
        {
          step_number: 1,
          title: "Start Python container",
          command: "docker run -d --name system-design-bandwidth -it python:3.11-alpine sleep 3600",
          validation: "docker ps --filter name=system-design-bandwidth --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Calculate video streaming bandwidth",
          command: "docker exec system-design-bandwidth python3 -c 'concurrent_users = 100_000; bitrate_mbps = 5; total_bandwidth_mbps = concurrent_users * bitrate_mbps; total_bandwidth_gbps = total_bandwidth_mbps / 1000; print(f\"Bandwidth needed: {total_bandwidth_gbps:.0f} Gbps\")'",
          validation: "docker exec system-design-bandwidth python3 -c 'print(100_000 * 5 / 1000)' | grep -E '[0-9]+'"
        },
        {
          step_number: 3,
          title: "Calculate CDN bandwidth cost",
          command: "docker exec system-design-bandwidth python3 -c 'bandwidth_gbps = 500; cost_per_gbps = 100; total_cost = bandwidth_gbps * cost_per_gbps; print(f\"Monthly CDN cost: ${total_cost:,.0f}\")'",
          validation: "docker exec system-design-bandwidth python3 -c 'print(500 * 100)' | grep -E '[0-9]+'"
        }
      ],
      cleanup_containers: ['system-design-bandwidth']
    )
  end

  def self.run_all_tests
    puts "\n📐 System Design Labs Test Suite"
    puts "=" * 80

    results = []
    results << test_storage_calculation_lab
    results << test_qps_calculation_lab
    results << test_bandwidth_calculation_lab

    total = results.size
    passed = results.count { |r| r[:success] }
    failed = total - passed

    puts "\n" + "=" * 80
    puts "System Design Labs Test Summary"
    puts "=" * 80
    puts "Total Labs Tested: #{total}"
    puts "Passed: #{passed} ✅"
    puts "Failed: #{failed} #{'❌' if failed > 0}"
    puts "=" * 80

    { total: total, passed: passed, failed: failed, results: results }
  end
end

# Run tests if executed directly
if __FILE__ == $0
  unless LabTestHelper.docker_available?
    puts "❌ Docker is not available. Please ensure Docker is installed and running."
    exit 1
  end

  LabTestHelper.cleanup_all_test_containers
  result = SystemDesignLabsTest.run_all_tests
  exit(result[:failed] > 0 ? 1 : 0)
end
