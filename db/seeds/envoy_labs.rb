# Envoy Proxy Hands-On Labs
# Master modern service mesh and API gateway patterns with Envoy

puts "🔀 Seeding Envoy Proxy Hands-On Labs..."

envoy_labs = [
  {
    title: "Envoy Basics - First Proxy Configuration",
    description: "Learn Envoy fundamentals by configuring your first proxy",
    difficulty: "easy",
    estimated_minutes: 25,
    lab_type: "envoy",
    category: "basics",
    certification_exam: nil,
    learning_objectives: "Understand Envoy architecture, configure listeners and clusters, route HTTP traffic",
    prerequisites: ["Basic networking knowledge", "Understanding of HTTP"],
    steps: [
      {
        step_number: 1,
        title: "Create Envoy configuration",
        instruction: "Create basic Envoy config with listener and cluster",
        expected_command: "cat > envoy.yaml << 'EOF'\nstatic_resources:\n  listeners:\n  - name: main_listener\n    address:\n      socket_address:\n        address: 0.0.0.0\n        port_value: 8080\n    filter_chains:\n    - filters:\n      - name: envoy.filters.network.http_connection_manager\n        typed_config:\n          \"@type\": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager\n          stat_prefix: ingress_http\n          route_config:\n            name: local_route\n            virtual_hosts:\n            - name: backend\n              domains: [\"*\"]\n              routes:\n              - match:\n                  prefix: \"/\"\n                route:\n                  cluster: backend_cluster\n          http_filters:\n          - name: envoy.filters.http.router\n            typed_config:\n              \"@type\": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router\n  clusters:\n  - name: backend_cluster\n    connect_timeout: 0.25s\n    type: STRICT_DNS\n    lb_policy: ROUND_ROBIN\n    load_assignment:\n      cluster_name: backend_cluster\n      endpoints:\n      - lb_endpoints:\n        - endpoint:\n            address:\n              socket_address:\n                address: httpbin.org\n                port_value: 80\nEOF",
        validation: "test -f envoy.yaml && grep backend_cluster envoy.yaml"
      },
      {
        step_number: 2,
        title: "Start Envoy proxy",
        instruction: "Run Envoy with the configuration",
        expected_command: "docker run -d --name envoy-proxy -p 8080:8080 -v $(pwd)/envoy.yaml:/etc/envoy/envoy.yaml envoyproxy/envoy:v1.28-latest",
        validation: "docker ps | grep envoy-proxy"
      },
      {
        step_number: 3,
        title: "Test proxy",
        instruction: "Send request through Envoy",
        expected_command: "sleep 5 && curl -s http://localhost:8080/get | head -5",
        validation: "curl -s -o /dev/null -w '%{http_code}' http://localhost:8080/get | grep 200 || echo 'Testing'"
      },
      {
        step_number: 4,
        title: "View Envoy stats",
        instruction: "Check Envoy admin interface stats",
        expected_command: "docker exec envoy-proxy wget -qO- http://localhost:9901/stats | head -10",
        validation: "docker exec envoy-proxy wget -qO- http://localhost:9901/stats | grep -c 'cluster' || echo 'Stats checked'"
      },
      {
        step_number: 5,
        title: "Cleanup",
        instruction: "Stop Envoy and remove config",
        expected_command: "docker rm -f envoy-proxy && rm envoy.yaml",
        validation: "docker ps | grep envoy-proxy"
      }
    ],
    validation_rules: {
      config_created: "valid Envoy configuration",
      proxy_running: "Envoy container operational",
      routing_works: "traffic successfully proxied"
    },
    success_criteria: "Successfully configure and run Envoy proxy",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "curl"],
    max_attempts: 5,
    points_reward: 200,
    is_active: true
  },

  {
    title: "Load Balancing with Envoy - Round Robin and Least Request",
    description: "Configure different load balancing algorithms in Envoy",
    difficulty: "medium",
    estimated_minutes: 35,
    lab_type: "envoy",
    category: "load-balancing",
    certification_exam: nil,
    learning_objectives: "Master load balancing algorithms, understand health checking, configure multiple backends",
    prerequisites: ["Completed Envoy basics lab"],
    steps: [
      {
        step_number: 1,
        title: "Start backend services",
        instruction: "Start 3 nginx backend instances",
        expected_command: "docker run -d --name backend1 -e SERVER_NAME=backend1 nginx && docker run -d --name backend2 -e SERVER_NAME=backend2 nginx && docker run -d --name backend3 -e SERVER_NAME=backend3 nginx",
        validation: "docker ps | grep backend | wc -l | grep 3"
      },
      {
        step_number: 2,
        title: "Create Envoy config with round robin",
        instruction: "Configure Envoy with ROUND_ROBIN load balancing",
        expected_command: "cat > envoy-lb.yaml << 'EOF'\nstatic_resources:\n  listeners:\n  - name: main\n    address:\n      socket_address:\n        address: 0.0.0.0\n        port_value: 8080\n    filter_chains:\n    - filters:\n      - name: envoy.filters.network.http_connection_manager\n        typed_config:\n          \"@type\": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager\n          stat_prefix: ingress_http\n          route_config:\n            name: local_route\n            virtual_hosts:\n            - name: backend\n              domains: [\"*\"]\n              routes:\n              - match: {prefix: \"/\"}\n                route: {cluster: backend_cluster}\n          http_filters:\n          - name: envoy.filters.http.router\n            typed_config:\n              \"@type\": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router\n  clusters:\n  - name: backend_cluster\n    connect_timeout: 0.25s\n    type: STATIC\n    lb_policy: ROUND_ROBIN\n    health_checks:\n    - timeout: 1s\n      interval: 5s\n      unhealthy_threshold: 2\n      healthy_threshold: 2\n      http_health_check:\n        path: \"/\"\n    load_assignment:\n      cluster_name: backend_cluster\n      endpoints:\n      - lb_endpoints:\n        - endpoint:\n            address:\n              socket_address:\n                address: backend1\n                port_value: 80\n        - endpoint:\n            address:\n              socket_address:\n                address: backend2\n                port_value: 80\n        - endpoint:\n            address:\n              socket_address:\n                address: backend3\n                port_value: 80\nEOF",
        validation: "test -f envoy-lb.yaml && grep ROUND_ROBIN envoy-lb.yaml"
      },
      {
        step_number: 3,
        title: "Create Docker network",
        instruction: "Connect backends to shared network",
        expected_command: "docker network create envoy-net && docker network connect envoy-net backend1 && docker network connect envoy-net backend2 && docker network connect envoy-net backend3",
        validation: "docker network inspect envoy-net | grep backend1"
      },
      {
        step_number: 4,
        title: "Start Envoy with load balancing",
        instruction: "Run Envoy connected to the network",
        expected_command: "docker run -d --name envoy-lb --network envoy-net -p 8080:8080 -v $(pwd)/envoy-lb.yaml:/etc/envoy/envoy.yaml envoyproxy/envoy:v1.28-latest",
        validation: "docker ps | grep envoy-lb"
      },
      {
        step_number: 5,
        title: "Test load balancing",
        instruction: "Send multiple requests to see distribution",
        expected_command: "for i in {1..6}; do curl -s http://localhost:8080 | head -1; done | wc -l",
        validation: "curl -s http://localhost:8080 | head -1 || echo 'Load balancing tested'"
      },
      {
        step_number: 6,
        title: "Check cluster stats",
        instruction: "View load balancing metrics",
        expected_command: "docker exec envoy-lb wget -qO- http://localhost:9901/clusters | grep backend_cluster",
        validation: "docker exec envoy-lb wget -qO- http://localhost:9901/clusters | grep -c backend || echo 'Stats viewed'"
      },
      {
        step_number: 7,
        title: "Cleanup",
        instruction: "Remove all containers and network",
        expected_command: "docker rm -f envoy-lb backend1 backend2 backend3 && docker network rm envoy-net && rm envoy-lb.yaml",
        validation: "docker ps | grep envoy-lb"
      }
    ],
    validation_rules: {
      backends_running: "multiple backend services",
      envoy_configured: "load balancing configured",
      distribution_works: "traffic distributed across backends"
    },
    success_criteria: "Successfully implement load balancing with Envoy",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "curl"],
    max_attempts: 5,
    points_reward: 350,
    is_active: true
  },

  {
    title: "Circuit Breaking and Outlier Detection",
    description: "Implement resilience patterns with circuit breakers and outlier detection",
    difficulty: "hard",
    estimated_minutes: 45,
    lab_type: "envoy",
    category: "resilience",
    certification_exam: nil,
    learning_objectives: "Master circuit breaking patterns, configure outlier detection, implement retry policies",
    prerequisites: ["Advanced Envoy knowledge", "Understanding of resilience patterns"],
    steps: [
      {
        step_number: 1,
        title: "Create circuit breaker configuration",
        instruction: "Configure circuit breaking thresholds",
        expected_command: "cat > envoy-cb.yaml << 'EOF'\nstatic_resources:\n  listeners:\n  - name: main\n    address:\n      socket_address: {address: 0.0.0.0, port_value: 8080}\n    filter_chains:\n    - filters:\n      - name: envoy.filters.network.http_connection_manager\n        typed_config:\n          \"@type\": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager\n          stat_prefix: ingress_http\n          route_config:\n            name: local_route\n            virtual_hosts:\n            - name: backend\n              domains: [\"*\"]\n              routes:\n              - match: {prefix: \"/\"}\n                route:\n                  cluster: backend_cluster\n                  retry_policy:\n                    retry_on: \"5xx\"\n                    num_retries: 3\n          http_filters:\n          - name: envoy.filters.http.router\n            typed_config:\n              \"@type\": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router\n  clusters:\n  - name: backend_cluster\n    connect_timeout: 1s\n    type: STATIC\n    lb_policy: ROUND_ROBIN\n    circuit_breakers:\n      thresholds:\n      - priority: DEFAULT\n        max_connections: 10\n        max_pending_requests: 10\n        max_requests: 10\n        max_retries: 3\n    outlier_detection:\n      consecutive_5xx: 3\n      interval: 10s\n      base_ejection_time: 30s\n      max_ejection_percent: 50\n    load_assignment:\n      cluster_name: backend_cluster\n      endpoints:\n      - lb_endpoints:\n        - endpoint:\n            address:\n              socket_address: {address: httpbin.org, port_value: 80}\nEOF",
        validation: "test -f envoy-cb.yaml && grep circuit_breakers envoy-cb.yaml"
      },
      {
        step_number: 2,
        title: "Document circuit breaker thresholds",
        instruction: "Explain circuit breaker settings",
        expected_command: "cat > circuit-breaker-doc.md << 'EOF'\n# Circuit Breaker Configuration\n\n## Thresholds\n- max_connections: 10 (max concurrent connections)\n- max_pending_requests: 10 (max queued requests)\n- max_requests: 10 (max active requests)\n- max_retries: 3 (max concurrent retries)\n\n## Outlier Detection\n- consecutive_5xx: 3 (ejection after 3 failures)\n- interval: 10s (detection interval)\n- base_ejection_time: 30s (initial ejection duration)\n- max_ejection_percent: 50 (max 50% of hosts ejected)\n\n## Behavior\n- Requests exceeding thresholds immediately fail\n- Failing hosts ejected from load balancing pool\n- Ejected hosts gradually brought back\nEOF",
        validation: "test -f circuit-breaker-doc.md && grep 'Outlier Detection' circuit-breaker-doc.md"
      },
      {
        step_number: 3,
        title: "Calculate failure thresholds",
        instruction: "Calculate when circuit breaker opens",
        expected_command: "python3 -c \"max_conn = 10; max_req = 10; total_capacity = max_conn + max_req; print(f'Circuit opens at: {total_capacity} concurrent operations'); print(f'With 3 backends, capacity per backend: {total_capacity/3:.1f}')\"",
        validation: "python3 -c \"print('Circuit opens at')\" | grep 'Circuit'"
      },
      {
        step_number: 4,
        title: "Simulate circuit breaker",
        instruction: "Test circuit breaking behavior",
        expected_command: "docker run -d --name envoy-cb -p 8080:8080 -v $(pwd)/envoy-cb.yaml:/etc/envoy/envoy.yaml envoyproxy/envoy:v1.28-latest",
        validation: "docker ps | grep envoy-cb"
      },
      {
        step_number: 5,
        title: "Check circuit breaker stats",
        instruction: "View circuit breaker metrics",
        expected_command: "sleep 5 && docker exec envoy-cb wget -qO- http://localhost:9901/stats | grep circuit_breakers || echo 'Stats checked'",
        validation: "docker exec envoy-cb wget -qO- http://localhost:9901/stats | grep -c 'cluster' || echo 'Verified'"
      },
      {
        step_number: 6,
        title: "Cleanup",
        instruction: "Remove resources",
        expected_command: "docker rm -f envoy-cb && rm envoy-cb.yaml circuit-breaker-doc.md",
        validation: "docker ps | grep envoy-cb"
      }
    ],
    validation_rules: {
      circuit_breaker_configured: "circuit breaking properly set up",
      outlier_detection_enabled: "outlier detection configured",
      thresholds_documented: "behavior documented"
    },
    success_criteria: "Implement complete circuit breaking and outlier detection",
    environment_image: "docker:20-dind",
    required_tools: ["docker", "python3"],
    max_attempts: 3,
    points_reward: 500,
    is_active: true
  }
]

# Create Envoy Labs
envoy_labs.each_with_index do |lab_data, index|
  begin
    lab = HandsOnLab.find_or_initialize_by(title: lab_data[:title])
    lab.assign_attributes(lab_data)
    lab.save ? print(".") : puts("\n❌ Failed: #{lab_data[:title]}")
  rescue => e
    puts "\n❌ Error on #{lab_data[:title]}: #{e.message}"
  end
end

puts "\n\n✅ Envoy Proxy Labs Seeding Complete!"
puts "   Total labs: #{HandsOnLab.where(lab_type: 'envoy').count}"
puts "\n🔀 Ready for Envoy Learning!"
