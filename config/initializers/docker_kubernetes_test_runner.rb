# Docker and Kubernetes Learning Module Test Runner
# This initializer runs comprehensive tests on server startup to ensure
# all command validators and execution runners are working correctly

module DockerKubernetesTestRunner
  class << self
    def run_all_tests
      return unless should_run_tests?
      
      Rails.logger.info "=" * 80
      Rails.logger.info "DOCKER & KUBERNETES LEARNING MODULE TESTS - Starting"
      Rails.logger.info "=" * 80
      
      results = {
        docker_validator: test_docker_validator,
        kubernetes_validator: test_kubernetes_validator,
        docker_runner: test_docker_runner,
        kubernetes_runner: test_kubernetes_runner
      }
      
      print_summary(results)
      
      results
    end
    
    private
    
    def should_run_tests?
      # Run tests in development and test environments
      # Skip in production unless explicitly enabled
      return true if Rails.env.development? || Rails.env.test?
      return true if ENV['RUN_STARTUP_TESTS'] == 'true'
      false
    end
    
    def test_docker_validator
      Rails.logger.info "\n[TESTING] Docker Exercise Validator"
      tests = []
      
      # Test 1: Basic docker run
      tests << run_test("docker run nginx", { base_command: 'docker run', accepts_any_image: true })
      
      # Test 2: docker run with flags
      tests << run_test("docker run -d --name myapp nginx", 
                       { base_command: 'docker run', required_flags: ['-d', '--name myapp'], accepts_any_image: true })
      
      # Test 3: docker ps
      tests << run_test("docker ps", { base_command: 'docker ps' })
      
      # Test 4: docker ps -a
      tests << run_test("docker ps -a", { base_command: 'docker ps', required_flags: ['-a'] })
      
      # Test 5: docker logs
      tests << run_test("docker logs myapp", { base_command: 'docker logs', requires_argument: true })
      
      # Test 6: docker exec
      tests << run_test("docker exec -it myapp bash", 
                       { base_command: 'docker exec', required_flags: ['-it'], requires_argument: true })
      
      # Test 7: docker build
      tests << run_test("docker build -t myapp:v1 .", { base_command: 'docker build', required_flags: ['-t'] })
      
      # Test 8: docker network create
      tests << run_test("docker network create myapp-net", { base_command: 'docker network create' })
      
      # Test 9: docker volume create
      tests << run_test("docker volume create myapp-data", { base_command: 'docker volume create' })
      
      # Test 10: Invalid command rejection
      tests << run_test("", {}, expected_valid: false)
      
      # Test 11: Missing required flag
      tests << run_test("docker ps", { base_command: 'docker ps', required_flags: ['-a'] }, expected_valid: false)
      
      { total: tests.size, passed: tests.count { |t| t[:passed] }, failed: tests.count { |t| !t[:passed] }, tests: tests }
    end
    
    def test_kubernetes_validator
      Rails.logger.info "\n[TESTING] Kubernetes Exercise Validator"
      tests = []
      
      # Test 1: kubectl get pods
      tests << run_k8s_test("kubectl get pods", { base_command: 'kubectl get pods' })
      
      # Test 2: kubectl get pods -A
      tests << run_k8s_test("kubectl get pods -A", { base_command: 'kubectl get pods', required_flags: ['-A'] })
      
      # Test 3: kubectl create deployment
      tests << run_k8s_test("kubectl create deployment nginx --image=nginx", 
                           { base_command: 'kubectl create deployment', required_flags: ['--image=nginx'], requires_argument: true })
      
      # Test 4: kubectl expose
      tests << run_k8s_test("kubectl expose deployment nginx --port=80", 
                           { base_command: 'kubectl expose deployment', required_flags: ['--port=80'] })
      
      # Test 5: kubectl scale
      tests << run_k8s_test("kubectl scale deployment web --replicas=3", 
                           { base_command: 'kubectl scale deployment', required_flags: ['--replicas=3'] })
      
      # Test 6: kubectl logs
      tests << run_k8s_test("kubectl logs my-pod", { base_command: 'kubectl logs', requires_argument: true })
      
      # Test 7: kubectl exec
      tests << run_k8s_test("kubectl exec -it my-pod -- bash", 
                           { base_command: 'kubectl exec', required_flags: ['-it'], requires_argument: true })
      
      # Test 8: kubectl apply
      tests << run_k8s_test("kubectl apply -f app.yaml", { base_command: 'kubectl apply', required_flags: ['-f'] })
      
      # Test 9: kubectl delete
      tests << run_k8s_test("kubectl delete pod old-pod", { base_command: 'kubectl delete pod', requires_argument: true })
      
      # Test 10: kubectl describe
      tests << run_k8s_test("kubectl describe pod my-pod", { base_command: 'kubectl describe pod', requires_argument: true })
      
      # Test 11: Invalid command rejection
      tests << run_k8s_test("", {}, expected_valid: false)
      
      # Test 12: Missing required flag
      tests << run_k8s_test("kubectl get pods", { base_command: 'kubectl get pods', required_flags: ['-A'] }, expected_valid: false)
      
      { total: tests.size, passed: tests.count { |t| t[:passed] }, failed: tests.count { |t| !t[:passed] }, tests: tests }
    end
    
    def test_docker_runner
      Rails.logger.info "\n[TESTING] Docker Lab Runner"
      tests = []
      
      # Test command validation
      runner = DockerLabRunner.new(user_id: 1, session_id: 'test')
      
      # Test 1: Allowed command validation
      tests << {
        name: "Allows docker commands",
        passed: runner.send(:validate_command, 'docker ps'),
        command: 'docker ps'
      }
      
      # Test 2: Rejects dangerous patterns
      tests << {
        name: "Rejects dangerous rm -rf /",
        passed: !runner.send(:validate_command, 'rm -rf /'),
        command: 'rm -rf /'
      }
      
      # Test 3: Rejects sudo
      tests << {
        name: "Rejects sudo commands",
        passed: !runner.send(:validate_command, 'sudo docker ps'),
        command: 'sudo docker ps'
      }
      
      # Test 4: Allows basic file commands
      tests << {
        name: "Allows ls command",
        passed: runner.send(:validate_command, 'ls -la'),
        command: 'ls -la'
      }
      
      log_test_results("Docker Runner", tests)
      
      { total: tests.size, passed: tests.count { |t| t[:passed] }, failed: tests.count { |t| !t[:passed] }, tests: tests }
    end
    
    def test_kubernetes_runner
      Rails.logger.info "\n[TESTING] Kubernetes Lab Runner"
      tests = []
      
      # Test command validation
      runner = KubernetesLabRunner.new(user_id: 1, session_id: 'test')
      
      # Test 1: Allowed kubectl commands
      tests << {
        name: "Allows kubectl commands",
        passed: runner.send(:validate_command, 'kubectl get pods'),
        command: 'kubectl get pods'
      }
      
      # Test 2: Rejects dangerous delete all
      tests << {
        name: "Rejects kubectl delete --all",
        passed: !runner.send(:validate_command, 'kubectl delete --all'),
        command: 'kubectl delete --all'
      }
      
      # Test 3: Rejects namespace deletion
      tests << {
        name: "Rejects kubectl delete namespace",
        passed: !runner.send(:validate_command, 'kubectl delete namespace default'),
        command: 'kubectl delete namespace default'
      }
      
      # Test 4: Allows basic file commands
      tests << {
        name: "Allows ls command",
        passed: runner.send(:validate_command, 'ls -la'),
        command: 'ls -la'
      }
      
      log_test_results("Kubernetes Runner", tests)
      
      { total: tests.size, passed: tests.count { |t| t[:passed] }, failed: tests.count { |t| !t[:passed] }, tests: tests }
    end
    
    def run_test(command, spec, expected_valid: true)
      result = DockerExerciseValidator.validate(command, spec)
      passed = (result[:valid] == expected_valid)
      
      test_result = {
        name: command.empty? ? "Empty command validation" : command,
        passed: passed,
        expected: expected_valid,
        actual: result[:valid],
        message: result[:message]
      }
      
      log_single_test(test_result)
      test_result
    end
    
    def run_k8s_test(command, spec, expected_valid: true)
      result = KubernetesExerciseValidator.validate(command, spec)
      passed = (result[:valid] == expected_valid)
      
      test_result = {
        name: command.empty? ? "Empty command validation" : command,
        passed: passed,
        expected: expected_valid,
        actual: result[:valid],
        message: result[:message]
      }
      
      log_single_test(test_result)
      test_result
    end
    
    def log_single_test(test)
      status = test[:passed] ? "✓ PASS" : "✗ FAIL"
      Rails.logger.info "  #{status}: #{test[:name]}"
      unless test[:passed]
        Rails.logger.warn "    Expected: #{test[:expected]}, Got: #{test[:actual]}"
        Rails.logger.warn "    Message: #{test[:message]}" if test[:message]
      end
    end
    
    def log_test_results(component, tests)
      tests.each { |test| log_single_test(test) }
    end
    
    def print_summary(results)
      Rails.logger.info "\n" + "=" * 80
      Rails.logger.info "TEST SUMMARY"
      Rails.logger.info "=" * 80
      
      total_tests = 0
      total_passed = 0
      total_failed = 0
      
      results.each do |component, result|
        total_tests += result[:total]
        total_passed += result[:passed]
        total_failed += result[:failed]
        
        status = result[:failed] == 0 ? "✓ ALL PASSING" : "✗ HAS FAILURES"
        Rails.logger.info "#{component.to_s.upcase.gsub('_', ' ')}: #{result[:passed]}/#{result[:total]} passed #{status}"
      end
      
      Rails.logger.info "-" * 80
      Rails.logger.info "OVERALL: #{total_passed}/#{total_tests} tests passed"
      
      if total_failed > 0
        Rails.logger.warn "⚠️  #{total_failed} TEST(S) FAILED - Please review the output above"
      else
        Rails.logger.info "✓ ALL TESTS PASSED - Docker & Kubernetes modules are functioning correctly"
      end
      
      Rails.logger.info "=" * 80
    end
  end
end

# Run tests on server startup
if defined?(Rails::Server)
  Rails.application.config.after_initialize do
    DockerKubernetesTestRunner.run_all_tests
  end
end