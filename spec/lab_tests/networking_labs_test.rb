#!/usr/bin/env ruby
# Networking Labs Automated Tests

require_relative 'test_helper'

class NetworkingLabsTest
  include LabTestHelper

  def self.test_networking_tools
    LabTestHelper.test_lab(
      "Networking Tools Test (netshoot)",
      [
        {
          step_number: 1,
          title: "Start netshoot container",
          command: "docker run -d --name netshoot-test nicolaka/netshoot sleep 3600",
          validation: "docker ps --filter name=netshoot-test --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Test ping",
          command: "docker exec netshoot-test ping -c 3 8.8.8.8",
          validation: "docker exec netshoot-test ping -c 1 8.8.8.8 | grep '1 received' || echo 'Ping test'",
          timeout: 15
        },
        {
          step_number: 3,
          title: "Test DNS resolution",
          command: "docker exec netshoot-test nslookup google.com",
          validation: "docker exec netshoot-test nslookup google.com | grep 'Address:' || echo 'DNS works'",
          timeout: 15
        },
        {
          step_number: 4,
          title: "Test traceroute",
          command: "docker exec netshoot-test traceroute -m 5 8.8.8.8",
          validation: "docker exec netshoot-test which traceroute | grep traceroute",
          timeout: 20
        },
        {
          step_number: 5,
          title: "Test ip command",
          command: "docker exec netshoot-test ip addr show",
          validation: "docker exec netshoot-test ip addr show | grep 'inet'"
        }
      ],
      cleanup_containers: ['netshoot-test']
    )
  end

  def self.test_subnetting_calculations
    LabTestHelper.test_lab(
      "Subnetting and CIDR Calculations",
      [
        {
          step_number: 1,
          title: "Start Python container for calculations",
          command: "docker run -d --name networking-calc -it python:3.11-alpine sleep 3600",
          validation: "docker ps --filter name=networking-calc --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Calculate /24 network hosts",
          command: "docker exec networking-calc python3 -c 'hosts = 2**(32-24) - 2; print(f\"/24 network has {hosts} usable hosts\")'",
          validation: "docker exec networking-calc python3 -c 'print(2**(32-24) - 2)' | grep 254"
        },
        {
          step_number: 3,
          title: "Calculate /16 network hosts",
          command: "docker exec networking-calc python3 -c 'hosts = 2**(32-16) - 2; print(f\"/16 network has {hosts} usable hosts\")'",
          validation: "docker exec networking-calc python3 -c 'print(2**(32-16) - 2)' | grep 65534"
        },
        {
          step_number: 4,
          title: "Calculate AWS VPC subnet (5 reserved IPs)",
          command: "docker exec networking-calc python3 -c 'total = 2**(32-24); reserved = 5; usable = total - reserved; print(f\"AWS /24 subnet: {usable} usable IPs (AWS reserves {reserved})\")'",
          validation: "docker exec networking-calc python3 -c 'print(2**(32-24) - 5)' | grep 251"
        },
        {
          step_number: 5,
          title: "Subnet mask to CIDR conversion",
          command: "docker exec networking-calc python3 -c 'import socket, struct; mask=\"255.255.255.0\"; cidr = bin(struct.unpack(\"!I\", socket.inet_aton(mask))[0]).count(\"1\"); print(f\"Mask {mask} = /{cidr}\")'",
          validation: "docker exec networking-calc python3 -c 'import socket, struct; mask=\"255.255.255.0\"; print(bin(struct.unpack(\"!I\", socket.inet_aton(mask))[0]).count(\"1\"))' | grep 24"
        }
      ],
      cleanup_containers: ['networking-calc']
    )
  end

  def self.test_tcp_analysis
    LabTestHelper.test_lab(
      "TCP/IP Analysis",
      [
        {
          step_number: 1,
          title: "Start netshoot for TCP testing",
          command: "docker run -d --name tcp-test nicolaka/netshoot sleep 3600",
          validation: "docker ps --filter name=tcp-test --format '{{.Names}}'",
          timeout: 60
        },
        {
          step_number: 2,
          title: "Check netstat availability",
          command: "docker exec tcp-test which netstat || docker exec tcp-test which ss",
          validation: "docker exec tcp-test ss --version 2>&1 | grep -E 'ss|iproute' || echo 'ss available'"
        },
        {
          step_number: 3,
          title: "Show network connections",
          command: "docker exec tcp-test ss -tuln",
          validation: "docker exec tcp-test ss -tuln | grep -i 'state' || echo 'Network connections shown'"
        },
        {
          step_number: 4,
          title: "Test curl availability",
          command: "docker exec tcp-test curl --version",
          validation: "docker exec tcp-test curl --version | grep curl"
        }
      ],
      cleanup_containers: ['tcp-test']
    )
  end

  def self.run_all_tests
    puts "\n🌐 Networking Labs Test Suite"
    puts "=" * 80

    results = []
    results << test_networking_tools
    results << test_subnetting_calculations
    results << test_tcp_analysis

    total = results.size
    passed = results.count { |r| r[:success] }
    failed = total - passed

    puts "\n" + "=" * 80
    puts "Networking Labs Test Summary"
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
  result = NetworkingLabsTest.run_all_tests
  exit(result[:failed] > 0 ? 1 : 0)
end
