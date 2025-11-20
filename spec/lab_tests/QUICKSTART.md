# Quick Start Guide - Lab Testing

## Running Tests Locally

### Prerequisites Check

```bash
# Check Docker is installed
docker --version

# Check Docker is running
docker ps

# Check Ruby is installed
ruby --version
```

### Running the Full Test Suite

```bash
cd entry-app/SOVisits/spec/lab_tests
ruby run_all_tests.rb
```

Expected output:

```
================================================================================
🧪 IDLECAMPUS LAB TEST SUITE - AUTOMATED TESTING
================================================================================
Testing all newly created hands-on labs:
  - PostgreSQL Database Mastery
  - System Design & Back-of-Envelope
  - AWS Cloud Architecture
  - Envoy Proxy
  - Networking Fundamentals
================================================================================

🧹 Cleaning up any existing test containers...

Running test suites (this may take several minutes)...

🐘 PostgreSQL Labs Test Suite
================================================================================
Testing Lab: PostgreSQL Basics - First Database and Table
...

📊 FINAL TEST SUMMARY
================================================================================
✅ PostgreSQL: 3/3 passed
✅ System Design: 3/3 passed
✅ AWS: 2/2 passed
✅ Envoy: 2/2 passed
✅ Networking: 3/3 passed
--------------------------------------------------------------------------------
Total Labs Tested: 13
Total Passed: 13 ✅
Total Failed: 0
Success Rate: 100.0%
================================================================================

🎉 ALL TESTS PASSED! Labs are ready for production.
```

### Running Individual Test Suites

**PostgreSQL Labs (most comprehensive):**
```bash
ruby postgresql_labs_test.rb
```

Tests:
- ✅ PostgreSQL Basics (database creation, CRUD)
- ✅ Indexes and Performance (1000 rows, EXPLAIN)
- ✅ Transactions and ACID (banking scenario)

**System Design Labs (fastest):**
```bash
ruby system_design_labs_test.rb
```

Tests:
- ✅ Storage Capacity Planning
- ✅ QPS and Traffic Estimation
- ✅ Bandwidth Calculations

**AWS Labs:**
```bash
ruby aws_labs_test.rb
```

Tests:
- ✅ AWS CLI Basics
- ✅ S3 with LocalStack

**Envoy Labs:**
```bash
ruby envoy_labs_test.rb
```

Tests:
- ✅ Envoy Installation
- ✅ Configuration Validation

**Networking Labs:**
```bash
ruby networking_labs_test.rb
```

Tests:
- ✅ Networking Tools (ping, DNS, traceroute)
- ✅ Subnetting Calculations
- ✅ TCP/IP Analysis

## First Time Setup

### 1. Pre-pull Docker Images (Optional but Recommended)

This speeds up test execution:

```bash
# PostgreSQL
docker pull postgres:15

# Python for calculations
docker pull python:3.11-alpine

# AWS tools
docker pull amazon/aws-cli:latest
docker pull localstack/localstack:latest

# Networking
docker pull nicolaka/netshoot

# Envoy
docker pull envoyproxy/envoy:v1.28-latest
```

### 2. Verify Docker Setup

```bash
# Make sure Docker daemon is running
sudo systemctl start docker  # Linux
# or
open -a Docker  # macOS

# Test Docker
docker run hello-world
```

### 3. Run a Quick Test

```bash
cd entry-app/SOVisits/spec/lab_tests

# Run the fastest test suite first
ruby system_design_labs_test.rb

# If that passes, run all tests
ruby run_all_tests.rb
```

## Interpreting Results

### Success ✅

```
✅ Lab 'PostgreSQL Basics - First Database and Table' PASSED (28.34s)
```

All steps completed successfully!

### Failure ❌

```
❌ Lab 'PostgreSQL Basics' FAILED (15.67s)

Failed steps:
  - Create database: Output missing 'appdb'. Got: ERROR: database already exists
```

Check:
1. Container naming conflicts
2. Port conflicts
3. Previous test cleanup incomplete

Run cleanup:
```bash
docker rm -f $(docker ps -aq --filter "name=postgres-")
```

## Continuous Integration

Add to `.github/workflows/test-labs.yml`:

```yaml
name: Test Labs

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test-labs:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 3.1

    - name: Run lab tests
      run: |
        cd entry-app/SOVisits/spec/lab_tests
        ruby run_all_tests.rb

    - name: Cleanup
      if: always()
      run: docker system prune -af
```

## Troubleshooting

### "Docker is not available"

```bash
# Check Docker status
docker info

# Start Docker
sudo systemctl start docker  # Linux
```

### "Container already exists"

```bash
# Remove conflicting containers
docker rm -f postgres-lab postgres-perf postgres-tx postgres-advanced
docker rm -f system-design-storage system-design-qps system-design-bandwidth
docker rm -f localstack-s3 netshoot-test networking-calc tcp-test
```

### "Port already in use"

```bash
# Find process using port (example: 15432)
lsof -i :15432

# Kill the process
kill -9 <PID>
```

### Tests timeout

Increase timeout in test files or ensure:
- Sufficient CPU/memory
- Good network connection
- Docker performance is optimal

## Performance Tips

1. **Pre-pull images** - Saves time on first run
2. **Keep Docker running** - Faster container startup
3. **Run tests in order** - Fastest first (System Design → Networking → Envoy → PostgreSQL → AWS)
4. **Use SSD** - Faster container I/O
5. **Allocate resources** - Give Docker enough CPU/memory

## What's Being Tested

| Lab Type | Tests | Duration | Complexity |
|----------|-------|----------|------------|
| PostgreSQL | 3 labs | ~2-3 min | High |
| System Design | 3 labs | ~1-2 min | Low |
| AWS | 2 labs | ~2-3 min | Medium |
| Envoy | 2 labs | ~1 min | Low |
| Networking | 3 labs | ~1-2 min | Medium |
| **TOTAL** | **13 labs** | **~7-11 min** | |

## Need Help?

1. Check the full README.md for detailed documentation
2. Review individual test files for specific lab steps
3. Run tests with verbose output (modify timeout values)
4. Check Docker logs: `docker logs <container-name>`
