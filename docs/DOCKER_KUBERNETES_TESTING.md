# Docker & Kubernetes Learning Module Testing System

## Overview

This document describes the comprehensive testing system for the Docker and Kubernetes learning modules. The system ensures that command validators and lab runners work correctly through automated tests that run on server startup and can be executed manually.

## Problem Statement

The Docker and Kubernetes learning modules have complex command validation logic that sometimes passes and sometimes fails. This testing system ensures:

1. **Consistency**: All commands are validated correctly every time
2. **Reliability**: Validators catch errors and provide helpful feedback
3. **Safety**: Lab runners block dangerous commands
4. **Visibility**: Developers know immediately when something breaks

## Components

### 1. RSpec Test Suites

Located in `spec/services/`:

- **`docker_exercise_validator_spec.rb`**: 230+ lines of comprehensive tests for Docker command validation
- **`kubernetes_exercise_validator_spec.rb`**: 250+ lines of comprehensive tests for Kubernetes command validation

#### What They Test

**Docker Validator Tests:**
- ✓ Basic command validation (docker run, docker ps, etc.)
- ✓ Flag validation (-d, --name, -it, etc.)
- ✓ Image and tag requirements
- ✓ Argument requirements
- ✓ Error handling and helpful messages
- ✓ Command success/failure detection
- ✓ Alternative command formats (docker run vs docker container run)
- ✓ Story-aware contextual messages

**Kubernetes Validator Tests:**
- ✓ kubectl command validation (get, create, expose, etc.)
- ✓ Resource type validation (pods, deployments, services)
- ✓ Flag validation (-A, -o wide, --watch, etc.)
- ✓ Complex flag combinations
- ✓ Namespace and selector validation
- ✓ Apply/delete with files and URLs
- ✓ Error handling for cluster connectivity issues

### 2. Automated Test Runner

Located in `config/initializers/docker_kubernetes_test_runner.rb`

**Purpose:** Runs automatically when the Rails server starts

**Features:**
- Tests all validators and runners on startup
- Provides detailed pass/fail output
- Shows helpful error messages for failures
- Summarizes results with counts
- Configurable (runs in dev/test, optional in production)

**Test Coverage:**
- 11 Docker validator tests
- 12 Kubernetes validator tests  
- 4 Docker runner security tests
- 4 Kubernetes runner security tests
- **Total: 31 automated tests on every server start**

### 3. Rake Tasks

Located in `lib/tasks/docker_kubernetes_tests.rake`

**Available Commands:**

```bash
# Run all tests
bundle exec rake docker_k8s:test

# Run only Docker validator tests
bundle exec rake docker_k8s:test_docker_validator

# Run only Kubernetes validator tests
bundle exec rake docker_k8s:test_kubernetes_validator

# Run only Docker runner tests
bundle exec rake docker_k8s:test_docker_runner

# Run only Kubernetes runner tests
bundle exec rake docker_k8s:test_kubernetes_validator

# Run with verbose output
bundle exec rake docker_k8s:test_verbose
```

## Running Tests

### Automatic (On Server Startup)

Tests run automatically when you start the Rails server:

```bash
rails server
```

You'll see output like:

```
================================================================================
DOCKER & KUBERNETES LEARNING MODULE TESTS - Starting
================================================================================

[TESTING] Docker Exercise Validator
  ✓ PASS: docker run nginx
  ✓ PASS: docker run -d --name myapp nginx
  ✓ PASS: docker ps
  ...

[TESTING] Kubernetes Exercise Validator
  ✓ PASS: kubectl get pods
  ✓ PASS: kubectl get pods -A
  ...

================================================================================
TEST SUMMARY
================================================================================
DOCKER VALIDATOR: 11/11 passed ✓ ALL PASSING
KUBERNETES VALIDATOR: 12/12 passed ✓ ALL PASSING
DOCKER RUNNER: 4/4 passed ✓ ALL PASSING
KUBERNETES RUNNER: 4/4 passed ✓ ALL PASSING
--------------------------------------------------------------------------------
OVERALL: 31/31 tests passed
✓ ALL TESTS PASSED - Docker & Kubernetes modules are functioning correctly
================================================================================
```

### Manual (RSpec)

Run the full RSpec test suite:

```bash
# All specs
bundle exec rspec

# Only Docker validator specs
bundle exec rspec spec/services/docker_exercise_validator_spec.rb

# Only Kubernetes validator specs
bundle exec rspec spec/services/kubernetes_exercise_validator_spec.rb

# With documentation format
bundle exec rspec spec/services/docker_exercise_validator_spec.rb --format documentation
```

### Manual (Rake Tasks)

Run specific test groups:

```bash
# Quick test of all components
bundle exec rake docker_k8s:test

# Test individual components
bundle exec rake docker_k8s:test_docker_validator
bundle exec rake docker_k8s:test_kubernetes_validator
```

## Configuration

### Environment Variables

**`RUN_STARTUP_TESTS`**: Set to `'true'` to enable tests in production

```bash
RUN_STARTUP_TESTS=true rails server
```

**Default Behavior:**
- **Development**: Tests run automatically ✓
- **Test**: Tests run automatically ✓
- **Production**: Tests skip by default (enable with env var)

### Disabling Startup Tests

If you need to disable automatic tests temporarily:

1. Edit `config/initializers/docker_kubernetes_test_runner.rb`
2. Comment out the initialization block at the bottom:

```ruby
# if defined?(Rails::Server)
#   Rails.application.config.after_initialize do
#     DockerKubernetesTestRunner.run_all_tests
#   end
# end
```

## What Gets Tested

### Docker Commands Validated

1. `docker run` - Basic and with flags (-d, --name)
2. `docker ps` - With and without -a flag
3. `docker logs` - With container names and -f flag
4. `docker exec` - Interactive and non-interactive
5. `docker build` - With -t and --no-cache
6. `docker network create` - Network creation
7. `docker volume create` - Volume creation
8. `docker images` - Image listing
9. `docker pull` - Image pulling
10. `docker stop` - Container stopping

### Kubernetes Commands Validated

1. `kubectl get pods` - With -A, -o wide, --watch
2. `kubectl create deployment` - With --image, --replicas, --port
3. `kubectl expose` - ClusterIP, NodePort, LoadBalancer
4. `kubectl scale` - Basic and conditional scaling
5. `kubectl logs` - With -f, --previous, --tail
6. `kubectl exec` - Interactive shell and single commands
7. `kubectl apply` - Files, directories, URLs
8. `kubectl delete` - Resources, files, label selectors
9. `kubectl describe` - Pods, deployments, nodes
10. `kubectl get namespaces` - Namespace operations

### Security Validations

**Docker Runner Blocks:**
- `rm -rf /` (destructive file operations)
- `sudo` commands (privilege escalation)
- Piped shell execution (`curl | sh`)
- System configuration writes

**Kubernetes Runner Blocks:**
- `kubectl delete --all` (mass deletion)
- `kubectl delete namespace` (namespace deletion)
- Dangerous resource operations

## Troubleshooting

### Tests Failing on Startup

**Issue**: You see test failures when starting the server

**Solution**:
1. Check the specific failing test in the output
2. Run that component's tests individually:
   ```bash
   bundle exec rake docker_k8s:test_docker_validator
   ```
3. Review the error message and fix the validator logic
4. Restart the server to confirm the fix

### Tests Not Running

**Issue**: No test output when starting the server

**Possible Causes:**
- Running in production without `RUN_STARTUP_TESTS=true`
- Initializer was commented out
- Rails server not detected (using something other than `rails server`)

**Solution**: 
- Check environment: `Rails.env`
- Run manually: `bundle exec rake docker_k8s:test`

### Individual Test Failures

**Issue**: Some commands pass validation but shouldn't (or vice versa)

**Solution**:
1. Add a test case to the appropriate spec file
2. Run the spec to confirm it fails:
   ```bash
   bundle exec rspec spec/services/docker_exercise_validator_spec.rb
   ```
3. Fix the validator logic
4. Run the spec again to confirm it passes

## Adding New Tests

### Adding a Docker Validator Test

Edit `spec/services/docker_exercise_validator_spec.rb`:

```ruby
it 'validates docker stop with timeout' do
  spec = { base_command: 'docker stop', required_flags: ['-t'], requires_argument: true }
  result = described_class.validate('docker stop -t 30 myapp', spec)
  expect(result[:valid]).to be true
end
```

### Adding a Kubernetes Validator Test

Edit `spec/services/kubernetes_exercise_validator_spec.rb`:

```ruby
it 'validates kubectl rollout status' do
  spec = { base_command: 'kubectl rollout status', requires_argument: true }
  result = described_class.validate('kubectl rollout status deployment/nginx', spec)
  expect(result[:valid]).to be true
end
```

### Adding to Startup Tests

Edit `config/initializers/docker_kubernetes_test_runner.rb`:

```ruby
def test_docker_validator
  tests = []
  # ... existing tests ...
  
  # Add your new test
  tests << run_test("docker stop -t 30 myapp", 
                   { base_command: 'docker stop', required_flags: ['-t'], requires_argument: true })
  
  { total: tests.size, passed: tests.count { |t| t[:passed] }, failed: tests.count { |t| !t[:passed] }, tests: tests }
end
```

## Benefits

### For Developers

- **Immediate feedback**: Know instantly if your changes broke something
- **Confidence**: Deploy knowing validators work correctly
- **Documentation**: Tests serve as examples of expected behavior
- **Debugging**: Detailed output helps identify issues quickly

### For Users

- **Consistency**: Commands validated the same way every time
- **Better errors**: Helpful feedback when commands are wrong
- **Safety**: Dangerous commands blocked reliably
- **Learning**: Correct validation helps users learn faster

## Maintenance

### When to Update Tests

Update tests when you:
- Add new command validators
- Change validation logic
- Add new flags or options
- Modify error messages
- Add security restrictions

### Test Coverage Goals

Maintain:
- **100% of base commands** tested
- **All required flags** have test coverage
- **Error cases** are tested
- **Security blocks** are verified

## Summary

This testing system provides:

✅ **31 automated tests** running on every server start  
✅ **Comprehensive RSpec suites** for detailed testing  
✅ **Rake tasks** for manual test execution  
✅ **Detailed documentation** for maintenance  
✅ **Security validation** for lab runners  
✅ **Immediate feedback** on startup  

**Result**: Reliable, consistent command validation for Docker and Kubernetes learning modules.