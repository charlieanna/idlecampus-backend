# Lab Testing Suite

Automated tests for all hands-on labs in the IdleCampus learning platform.

## Overview

This test suite validates that all newly created lab courses work correctly:

- **PostgreSQL Database Mastery** - 3 labs tested
- **System Design & Back-of-Envelope** - 3 labs tested
- **AWS Cloud Architecture** - 2 labs tested
- **Envoy Proxy** - 2 labs tested
- **Networking Fundamentals** - 3 labs tested

## Prerequisites

- Docker installed and running
- Ruby 2.7+ installed
- Port availability (tests use various ports)
- Internet connection (for pulling Docker images)

## Quick Start

### Run All Tests

```bash
cd entry-app/SOVisits/spec/lab_tests
ruby run_all_tests.rb
```

This will:
1. Check Docker availability
2. Clean up any existing test containers
3. Run all lab test suites
4. Display detailed results
5. Clean up after tests
6. Exit with code 0 (success) or 1 (failure)

### Run Individual Test Suites

```bash
# PostgreSQL labs only
ruby postgresql_labs_test.rb

# System Design labs only
ruby system_design_labs_test.rb

# AWS labs only
ruby aws_labs_test.rb

# Envoy labs only
ruby envoy_labs_test.rb

# Networking labs only
ruby networking_labs_test.rb
```

## What Gets Tested

### PostgreSQL Labs

1. **Basic Database Operations**
   - Container startup
   - Database creation
   - Table creation with constraints
   - CRUD operations
   - Data validation

2. **Indexes and Performance**
   - Test data generation (1000 rows)
   - Index creation
   - EXPLAIN query analysis
   - Composite indexes
   - Performance comparison

3. **Transactions and ACID**
   - Transaction BEGIN/COMMIT/ROLLBACK
   - Atomic operations
   - Consistency validation
   - Banking scenario simulation

### System Design Labs

1. **Storage Calculations**
   - Capacity planning
   - Growth projections
   - Replication overhead

2. **QPS and Traffic**
   - Average QPS calculation
   - Peak traffic estimation
   - Server capacity planning

3. **Bandwidth Calculations**
   - Video streaming bandwidth
   - CDN cost estimation

### AWS Labs

1. **AWS CLI Basics**
   - CLI installation verification
   - Help command functionality

2. **S3 with LocalStack**
   - LocalStack container startup
   - S3 bucket creation
   - File upload operations
   - Bucket listing

### Envoy Labs

1. **Envoy Installation**
   - Image pull
   - Version verification

2. **Configuration Validation**
   - Config file creation
   - Config validation

### Networking Labs

1. **Networking Tools**
   - netshoot container
   - ping, DNS, traceroute
   - Network interface inspection

2. **Subnetting Calculations**
   - CIDR calculations
   - AWS VPC subnet calculations
   - Subnet mask conversions

3. **TCP/IP Analysis**
   - Network connections
   - Socket statistics
   - HTTP client testing

## Test Output

### Successful Test Output

```
================================================================================
Testing Lab: PostgreSQL Basics - First Database and Table
================================================================================

  Step 1: Start PostgreSQL container
  Command: docker run -d --name postgres-lab -e POSTGRES_PASSWORD=secret...
  ✅ PASS: Command executed successfully (2.45s)

  Step 2: Wait for PostgreSQL to be ready
  Command: sleep 5 && docker exec postgres-lab pg_isready -U postgres
  Validation: ✅
  ✅ PASS: Command executed successfully (5.12s)

...

✅ Lab 'PostgreSQL Basics - First Database and Table' PASSED (28.34s)
```

### Failed Test Output

```
❌ Lab 'Example Lab' FAILED (15.67s)

Failed steps:
  - Create database: Output missing 'appdb'. Got: ERROR: database already exists
```

## Cleanup

Tests automatically clean up after themselves, but if needed, manual cleanup:

```bash
# Remove all test containers
docker rm -f postgres-lab postgres-perf postgres-tx postgres-advanced \
            system-design-storage system-design-qps system-design-bandwidth \
            localstack-s3 netshoot-test networking-calc tcp-test

# Or use the helper
ruby -r ./test_helper -e "LabTestHelper.cleanup_all_test_containers"
```

## Troubleshooting

### Tests timeout

- Increase timeout values in test files
- Check Docker performance
- Ensure sufficient system resources

### Container conflicts

```bash
# Clean up existing containers
docker rm -f $(docker ps -aq --filter "name=postgres-")
docker rm -f $(docker ps -aq --filter "name=system-design-")
docker rm -f $(docker ps -aq --filter "name=localstack-")
```

### Port conflicts

Tests use these ports:
- PostgreSQL: 15432, 15433, 15434
- LocalStack: 4566

Ensure these ports are free before running tests.

### Image pull failures

```bash
# Pre-pull images
docker pull postgres:15
docker pull python:3.11-alpine
docker pull amazon/aws-cli:latest
docker pull localstack/localstack:latest
docker pull envoyproxy/envoy:v1.28-latest
docker pull nicolaka/netshoot
```

## Adding New Tests

1. Create a new test file in `spec/lab_tests/`
2. Follow the pattern in existing test files
3. Use `LabTestHelper` utilities
4. Add to `run_all_tests.rb`

Example:

```ruby
require_relative 'test_helper'

class MyNewLabsTest
  include LabTestHelper

  def self.test_my_lab
    LabTestHelper.test_lab(
      "My Lab Name",
      [
        {
          step_number: 1,
          title: "Step description",
          command: "command to run",
          validation: "validation command",
          timeout: 30
        }
      ],
      cleanup_containers: ['container-name']
    )
  end

  def self.run_all_tests
    results = []
    results << test_my_lab
    # ... summarize results
  end
end
```

## CI/CD Integration

Add to your CI pipeline:

```yaml
# .github/workflows/test-labs.yml
name: Test Labs
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run lab tests
        run: |
          cd entry-app/SOVisits/spec/lab_tests
          ruby run_all_tests.rb
```

## Performance

Typical test durations:
- PostgreSQL: ~2-3 minutes
- System Design: ~1-2 minutes
- AWS: ~2-3 minutes
- Envoy: ~1 minute
- Networking: ~1-2 minutes

**Total: ~7-11 minutes** for all tests

## Exit Codes

- `0` - All tests passed
- `1` - One or more tests failed
- `1` - Docker not available
- `1` - Fatal error occurred

## Support

For issues or questions:
1. Check container logs: `docker logs <container-name>`
2. Review test output carefully
3. Ensure Docker is running properly
4. Check system resources (CPU, memory, disk)
