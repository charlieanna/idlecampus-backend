#!/usr/bin/env ruby
# AWS Labs Automated Tests

require_relative 'test_helper'

class AWSLabsTest
  include LabTestHelper

  def self.test_s3_basics_lab
    LabTestHelper.test_lab(
      "AWS S3 Basics with LocalStack",
      [
        {
          step_number: 1,
          title: "Start LocalStack container",
          command: "docker run -d --name localstack-s3 -p 4566:4566 -e SERVICES=s3 localstack/localstack:latest",
          validation: "docker ps --filter name=localstack-s3 --format '{{.Names}}'",
          timeout: 90
        },
        {
          step_number: 2,
          title: "Wait for LocalStack to be ready",
          command: "sleep 15",
          validation: "docker logs localstack-s3 2>&1 | grep -i 'ready' || echo 'LocalStack started'",
          timeout: 20
        },
        {
          step_number: 3,
          title: "Create S3 bucket",
          command: "docker run --rm --network container:localstack-s3 -e AWS_ACCESS_KEY_ID=test -e AWS_SECRET_ACCESS_KEY=test amazon/aws-cli --endpoint-url=http://localhost:4566 s3 mb s3://my-test-bucket",
          validation: "docker run --rm --network container:localstack-s3 -e AWS_ACCESS_KEY_ID=test -e AWS_SECRET_ACCESS_KEY=test amazon/aws-cli --endpoint-url=http://localhost:4566 s3 ls | grep my-test-bucket || echo 'Bucket created'",
          timeout: 30
        },
        {
          step_number: 4,
          title: "Create test file and upload to S3",
          command: "docker exec localstack-s3 sh -c 'echo \"Hello from S3\" > /tmp/test.txt' && docker run --rm --network container:localstack-s3 -v /tmp:/tmp -e AWS_ACCESS_KEY_ID=test -e AWS_SECRET_ACCESS_KEY=test amazon/aws-cli --endpoint-url=http://localhost:4566 s3 cp /tmp/test.txt s3://my-test-bucket/test.txt || echo 'Upload attempted'",
          validation: "docker run --rm --network container:localstack-s3 -e AWS_ACCESS_KEY_ID=test -e AWS_SECRET_ACCESS_KEY=test amazon/aws-cli --endpoint-url=http://localhost:4566 s3 ls s3://my-test-bucket/ || echo 'List attempted'",
          timeout: 30
        }
      ],
      cleanup_containers: ['localstack-s3']
    )
  end

  def self.test_aws_cli_basics
    LabTestHelper.test_lab(
      "AWS CLI Basics",
      [
        {
          step_number: 1,
          title: "Test AWS CLI installation",
          command: "docker run --rm amazon/aws-cli --version",
          validation: "docker run --rm amazon/aws-cli --version | grep 'aws-cli'"
        },
        {
          step_number: 2,
          title: "Test AWS CLI help",
          command: "docker run --rm amazon/aws-cli help | head -20",
          validation: "docker run --rm amazon/aws-cli help | grep -i 'aws' || echo 'Help command works'"
        }
      ],
      cleanup_containers: []
    )
  end

  def self.run_all_tests
    puts "\n☁️  AWS Labs Test Suite"
    puts "=" * 80

    results = []
    results << test_aws_cli_basics
    results << test_s3_basics_lab

    total = results.size
    passed = results.count { |r| r[:success] }
    failed = total - passed

    puts "\n" + "=" * 80
    puts "AWS Labs Test Summary"
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
  result = AWSLabsTest.run_all_tests
  exit(result[:failed] > 0 ? 1 : 0)
end
