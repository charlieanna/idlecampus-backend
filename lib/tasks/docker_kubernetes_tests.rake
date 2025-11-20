namespace :docker_k8s do
  desc "Run Docker and Kubernetes learning module tests"
  task test: :environment do
    puts "\n"
    puts "=" * 80
    puts "Running Docker & Kubernetes Learning Module Tests"
    puts "=" * 80
    puts "\n"
    
    results = DockerKubernetesTestRunner.run_all_tests
    
    # Exit with error code if any tests failed
    total_failed = results.values.sum { |r| r[:failed] }
    exit(1) if total_failed > 0
  end
  
  desc "Run only Docker validator tests"
  task test_docker_validator: :environment do
    puts "\nRunning Docker Validator Tests...\n"
    result = DockerKubernetesTestRunner.send(:test_docker_validator)
    puts "\nResult: #{result[:passed]}/#{result[:total]} passed"
    exit(1) if result[:failed] > 0
  end
  
  desc "Run only Kubernetes validator tests"
  task test_kubernetes_validator: :environment do
    puts "\nRunning Kubernetes Validator Tests...\n"
    result = DockerKubernetesTestRunner.send(:test_kubernetes_validator)
    puts "\nResult: #{result[:passed]}/#{result[:total]} passed"
    exit(1) if result[:failed] > 0
  end
  
  desc "Run only Docker runner tests"
  task test_docker_runner: :environment do
    puts "\nRunning Docker Runner Tests...\n"
    result = DockerKubernetesTestRunner.send(:test_docker_runner)
    puts "\nResult: #{result[:passed]}/#{result[:total]} passed"
    exit(1) if result[:failed] > 0
  end
  
  desc "Run only Kubernetes runner tests"
  task test_kubernetes_runner: :environment do
    puts "\nRunning Kubernetes Runner Tests...\n"
    result = DockerKubernetesTestRunner.send(:test_kubernetes_runner)
    puts "\nResult: #{result[:passed]}/#{result[:total]} passed"
    exit(1) if result[:failed] > 0
  end
  
  desc "Run all Docker/Kubernetes tests with detailed output"
  task test_verbose: :environment do
    ENV['VERBOSE_TESTS'] = 'true'
    Rake::Task['docker_k8s:test'].invoke
  end
end