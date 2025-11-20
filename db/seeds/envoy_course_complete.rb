# Envoy Proxy Mastery - Complete Course
puts "Creating Complete Envoy Proxy Mastery Course..."

envoy_course = Course.find_or_create_by!(slug: 'envoy-proxy-mastery') do |course|
  course.title = "Envoy Proxy Mastery"
  course.description = "Master the modern service mesh and API gateway. Learn load balancing, traffic management, and observability with Envoy."
  course.difficulty_level = "advanced"
  course.estimated_hours = 22
  course.certification_track = nil
  course.published = true
  course.sequence_order = 13
  course.learning_objectives = JSON.generate([
    "Configure Envoy as API gateway and service mesh",
    "Implement advanced load balancing strategies",
    "Master circuit breaking and outlier detection",
    "Configure TLS termination and mTLS",
    "Implement observability with metrics and tracing"
  ])
  course.prerequisites = JSON.generate([
    "Strong understanding of HTTP/HTTPS",
    "Microservices architecture knowledge",
    "Docker and containerization experience",
    "Basic networking concepts"
  ])
end

puts "Created course: #{envoy_course.title}"

# ==========================================
# MODULE 1: Envoy Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'envoy-fundamentals', course: envoy_course) do |mod|
  mod.title = "Envoy Fundamentals"
  mod.description = "Introduction to Envoy architecture, listeners, and clusters"
  mod.sequence_order = 1
  mod.estimated_minutes = 180
  mod.published = true
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Introduction to Envoy") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Introduction to Envoy

    Envoy is a high-performance edge and service proxy designed for cloud-native applications.

    ## What is Envoy?

    **Envoy Proxy**: L7 (application-level) proxy and communication bus.

    **Key Features**:
    - Advanced load balancing
    - Service discovery
    - Health checking
    - Circuit breaking
    - Rate limiting
    - Observability (metrics, logs, tracing)
    - TLS termination/origination

    **Used By**: Lyft, Airbnb, Apple, Netflix, AWS (App Mesh), Google (Traffic Director)

    ## Envoy Architecture

    ### Core Components

    **1. Listeners**
    - Accept incoming connections
    - Bind to ports (e.g., :80, :443)
    - Apply filter chains

    **2. Clusters**
    - Logical groups of upstream hosts
    - Define backend services
    - Health checking and load balancing

    **3. Routes**
    - Map requests to clusters
    - URL path matching
    - Header-based routing

    **4. Filters**
    - Process requests/responses
    - Network filters (L3/L4)
    - HTTP filters (L7)

    ## Envoy Configuration

    ### Static Configuration (envoy.yaml)

    ```yaml
    static_resources:
      listeners:
      - name: listener_0
        address:
          socket_address:
            address: 0.0.0.0
            port_value: 8080
        filter_chains:
        - filters:
          - name: envoy.filters.network.http_connection_manager
            typed_config:
              "@type": type.googleapis.com/envoy.extensions.filters.network.http_connection_manager.v3.HttpConnectionManager
              stat_prefix: ingress_http
              route_config:
                name: local_route
                virtual_hosts:
                - name: backend
                  domains: ["*"]
                  routes:
                  - match:
                      prefix: "/"
                    route:
                      cluster: service_backend
              http_filters:
              - name: envoy.filters.http.router

      clusters:
      - name: service_backend
        connect_timeout: 0.25s
        type: STRICT_DNS
        lb_policy: ROUND_ROBIN
        load_assignment:
          cluster_name: service_backend
          endpoints:
          - lb_endpoints:
            - endpoint:
                address:
                  socket_address:
                    address: backend-service
                    port_value: 8000
    ```

    ## Basic Envoy Setup

    ### Docker Compose Example

    ```yaml
    version: '3'
    services:
      envoy:
        image: envoyproxy/envoy:v1.28-latest
        ports:
          - "8080:8080"
          - "9901:9901"  # Admin interface
        volumes:
          - ./envoy.yaml:/etc/envoy/envoy.yaml
        command: /usr/local/bin/envoy -c /etc/envoy/envoy.yaml

      backend:
        image: nginx:alpine
        expose:
          - "80"
    ```

    ### Admin Interface

    Envoy provides an admin interface for debugging:

    - http://localhost:9901/stats - Metrics
    - http://localhost:9901/clusters - Cluster status
    - http://localhost:9901/config_dump - Current configuration
    - http://localhost:9901/server_info - Server information

    ## Listeners

    **Listener**: Accepts connections on a port.

    ```yaml
    listeners:
    - name: http_listener
      address:
        socket_address:
          address: 0.0.0.0
          port_value: 8080
      filter_chains:
      - filters:
        - name: envoy.filters.network.http_connection_manager
          # Configuration...
    ```

    **Filter Chain**: Ordered list of filters to process connections.

    ## Clusters

    **Cluster**: Logical group of similar upstream hosts.

    ```yaml
    clusters:
    - name: my_service
      connect_timeout: 1s
      type: STRICT_DNS  # or STATIC, EDS, LOGICAL_DNS
      lb_policy: ROUND_ROBIN
      load_assignment:
        cluster_name: my_service
        endpoints:
        - lb_endpoints:
          - endpoint:
              address:
                socket_address:
                  address: service1.local
                  port_value: 8000
          - endpoint:
              address:
                socket_address:
                  address: service2.local
                  port_value: 8000
    ```

    ### Cluster Discovery Types

    - **STATIC**: Hardcoded endpoints
    - **STRICT_DNS**: DNS resolution (all A records)
    - **LOGICAL_DNS**: DNS resolution (single IP)
    - **EDS**: Endpoint Discovery Service (dynamic)

    ## Routes

    **Routes**: Map requests to clusters.

    ```yaml
    route_config:
      name: my_routes
      virtual_hosts:
      - name: api
        domains: ["api.example.com"]
        routes:
        # Match /users/** → users_service
        - match:
            prefix: "/users"
          route:
            cluster: users_service

        # Match /orders/** → orders_service
        - match:
            prefix: "/orders"
          route:
            cluster: orders_service

        # Default route
        - match:
            prefix: "/"
          route:
            cluster: default_service
    ```

    ### Advanced Routing

    ```yaml
    routes:
    # Path prefix
    - match:
        prefix: "/api/v1"
      route:
        cluster: api_v1

    # Path regex
    - match:
        safe_regex:
          regex: "^/users/\\\\d+$"
      route:
        cluster: users_service

    # Header matching
    - match:
        prefix: "/"
        headers:
        - name: "x-api-version"
          exact_match: "v2"
      route:
        cluster: api_v2

    # Query parameter matching
    - match:
        prefix: "/search"
        query_parameters:
        - name: "version"
          string_match:
            exact: "beta"
      route:
        cluster: search_beta
    ```

    ## HTTP Filters

    Process HTTP requests/responses.

    ### Common Filters

    **1. Router**: Routes requests to clusters (required)

    **2. Rate Limit**: Limit request rates

    **3. CORS**: Cross-Origin Resource Sharing

    **4. JWT Authn**: JWT token validation

    **5. Gzip**: Response compression

    **6. Health Check**: Respond to health checks

    ### Filter Example

    ```yaml
    http_filters:
    - name: envoy.filters.http.cors
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.filters.http.cors.v3.Cors

    - name: envoy.filters.http.gzip
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor
        compressor_library:
          name: text_optimized
          typed_config:
            "@type": type.googleapis.com/envoy.extensions.compression.gzip.compressor.v3.Gzip

    - name: envoy.filters.http.router
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.filters.http.router.v3.Router
    ```

    ## Observability

    ### Metrics

    Envoy exports metrics in Prometheus format.

    ```bash
    curl http://localhost:9901/stats/prometheus
    ```

    Common metrics:
    - `envoy_cluster_upstream_rq_total`: Total requests
    - `envoy_cluster_upstream_rq_time`: Request latency
    - `envoy_cluster_upstream_rq_xx`: Status code counts (2xx, 4xx, 5xx)

    ### Access Logs

    ```yaml
    access_log:
    - name: envoy.access_loggers.file
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.access_loggers.file.v3.FileAccessLog
        path: /dev/stdout
        format: "[%START_TIME%] \"%REQ(:METHOD)% %REQ(X-ENVOY-ORIGINAL-PATH?:PATH)% %PROTOCOL%\" %RESPONSE_CODE% %BYTES_RECEIVED% %BYTES_SENT% %DURATION%\\n"
    ```

    ## Best Practices

    1. **Use xDS APIs**: Dynamic configuration over static
    2. **Health checking**: Always configure health checks
    3. **Circuit breaking**: Prevent cascade failures
    4. **Rate limiting**: Protect backend services
    5. **Observability**: Export metrics, logs, traces
    6. **TLS everywhere**: Encrypt service-to-service traffic

    **Practice**: Try the Envoy Fundamentals lab!
  MARKDOWN
  lesson.key_concepts = ['Envoy proxy', 'listeners', 'clusters', 'routes', 'filters', 'load balancing']
end

# Quiz 1.1: Envoy Fundamentals
quiz1_1 = Quiz.find_or_create_by!(title: "Envoy Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your knowledge of Envoy basics'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
end

[
  {
    question_text: "What is Envoy primarily used for?",
    question_type: "mcq",
    points: 5,
    options: ["Service proxy and communication bus", "Database", "Message queue", "Container orchestration"],
    correct_answer: "Service proxy and communication bus",
    explanation: "Envoy is a high-performance edge and service proxy for cloud-native applications."
  },
  {
    question_text: "What does a listener do in Envoy?",
    question_type: "mcq",
    points: 5,
    options: ["Accepts incoming connections on a port", "Defines backend services", "Routes requests", "Balances load"],
    correct_answer: "Accepts incoming connections on a port",
    explanation: "Listeners accept incoming traffic and apply filter chains to process it."
  },
  {
    question_text: "What is a cluster in Envoy?",
    question_type: "mcq",
    points: 5,
    options: ["Logical group of upstream hosts/services", "Group of listeners", "Configuration file", "Network interface"],
    correct_answer: "Logical group of upstream hosts/services",
    explanation: "Clusters define logical groups of similar upstream hosts that Envoy will proxy traffic to."
  },
  {
    question_text: "What port does Envoy's admin interface typically run on?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "9901",
    explanation: "The Envoy admin interface typically runs on port 9901 for debugging and metrics."
  },
  {
    question_text: "What are routes used for in Envoy?",
    question_type: "mcq",
    points: 5,
    options: ["Map requests to clusters based on criteria", "Define network paths", "Configure DNS", "Set up SSL certificates"],
    correct_answer: "Map requests to clusters based on criteria",
    explanation: "Routes match incoming requests and direct them to appropriate clusters."
  },
  {
    question_text: "Which filter is required in an HTTP connection manager?",
    question_type: "mcq",
    points: 5,
    options: ["envoy.filters.http.router", "envoy.filters.http.cors", "envoy.filters.http.gzip", "envoy.filters.http.jwt_authn"],
    correct_answer: "envoy.filters.http.router",
    explanation: "The router filter is required to route requests to clusters."
  },
  {
    question_text: "What does STRICT_DNS cluster type do?",
    question_type: "mcq",
    points: 5,
    options: ["Resolves DNS and uses all A records", "Uses static IPs", "Queries DNS once", "Disables DNS"],
    correct_answer: "Resolves DNS and uses all A records",
    explanation: "STRICT_DNS resolves DNS and creates endpoints for all returned A records."
  },
  {
    question_text: "What layer does Envoy primarily operate at?",
    question_type: "mcq",
    points: 5,
    options: ["Layer 7 (Application)", "Layer 4 (Transport)", "Layer 3 (Network)", "Layer 2 (Data Link)"],
    correct_answer: "Layer 7 (Application)",
    explanation: "Envoy is primarily an L7 proxy, though it can also work at L4."
  },
  {
    question_text: "What's the purpose of the admin interface?",
    question_type: "mcq",
    points: 5,
    options: ["Debugging, metrics, and configuration inspection", "User authentication", "Data storage", "Load balancing"],
    correct_answer: "Debugging, metrics, and configuration inspection",
    explanation: "The admin interface provides endpoints for stats, config dumps, and debugging."
  },
  {
    question_text: "Which companies created Envoy?",
    question_type: "mcq",
    points: 5,
    options: ["Lyft", "Google", "Amazon", "Microsoft"],
    correct_answer: "Lyft",
    explanation: "Envoy was originally created at Lyft and is now a CNCF graduated project."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# MODULE 2: Load Balancing and Resilience
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'load-balancing', course: envoy_course) do |mod|
  mod.title = "Load Balancing and Health Checks"
  mod.description = "Master load balancing algorithms, health checking, and resilience patterns"
  mod.sequence_order = 2
  mod.estimated_minutes = 200
  mod.published = true
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Load Balancing Strategies") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Load Balancing Strategies

    Distribute traffic efficiently across backend services.

    ## Load Balancing Policies

    ### Round Robin
    Distribute requests evenly in circular order.

    ```yaml
    clusters:
    - name: my_service
      lb_policy: ROUND_ROBIN
      load_assignment:
        endpoints:
        - lb_endpoints:
          - endpoint:
              address:
                socket_address: {address: host1, port_value: 8000}
          - endpoint:
              address:
                socket_address: {address: host2, port_value: 8000}
          - endpoint:
              address:
                socket_address: {address: host3, port_value: 8000}
    ```

    **Pros**: Simple, fair distribution
    **Cons**: Doesn't consider load

    ### Least Request
    Send to host with fewest active requests.

    ```yaml
    lb_policy: LEAST_REQUEST
    least_request_lb_config:
      choice_count: 2  # Pick 2 random, choose least loaded
    ```

    **Pros**: Adapts to load
    **Cons**: Requires tracking connections

    ### Random
    Randomly select endpoint.

    ```yaml
    lb_policy: RANDOM
    ```

    **Pros**: Simple, stateless
    **Cons**: May be uneven with small request counts

    ### Ring Hash (Consistent Hashing)
    Hash requests to endpoints (sticky sessions).

    ```yaml
    lb_policy: RING_HASH
    ring_hash_lb_config:
      minimum_ring_size: 1024
      maximum_ring_size: 8388608
      hash_function: XX_HASH
    ```

    **Use for**: Session affinity, caching

    ### Maglev (Consistent Hashing)
    Similar to ring hash, faster lookups.

    ```yaml
    lb_policy: MAGLEV
    maglev_lb_config:
      table_size: 65537
    ```

    ## Health Checking

    Monitor backend health and remove unhealthy hosts.

    ### Active Health Checking

    Envoy actively probes endpoints.

    ```yaml
    clusters:
    - name: my_service
      health_checks:
      - timeout: 1s
        interval: 5s
        unhealthy_threshold: 3
        healthy_threshold: 2
        http_health_check:
          path: /health
          expected_statuses:
          - start: 200
            end: 299
    ```

    **Parameters**:
    - `interval`: Time between checks
    - `timeout`: Check timeout
    - `unhealthy_threshold`: Failures before marking unhealthy
    - `healthy_threshold`: Successes before marking healthy

    ### Passive Health Checking (Outlier Detection)

    Detect failures from actual traffic.

    ```yaml
    outlier_detection:
      consecutive_5xx: 3              # 3 consecutive 5xx errors
      interval: 10s                   # Check every 10s
      base_ejection_time: 30s         # Eject for 30s
      max_ejection_percent: 50        # Max 50% of hosts can be ejected
      enforcing_consecutive_5xx: 100  # 100% enforcement
      split_external_local_origin_errors: true
    ```

    **Use for**: Detecting intermittent failures

    ## Circuit Breaking

    Prevent cascade failures by limiting concurrent requests.

    ```yaml
    clusters:
    - name: my_service
      circuit_breakers:
        thresholds:
        - priority: DEFAULT
          max_connections: 1024         # Max TCP connections
          max_pending_requests: 1024    # Max queued requests
          max_requests: 1024            # Max active requests
          max_retries: 3                # Max concurrent retries
    ```

    **States**:
    1. **Closed**: Normal operation
    2. **Open**: Rejecting requests (circuit broken)
    3. **Half-Open**: Testing if service recovered

    ## Connection Pooling

    Reuse connections for better performance.

    ```yaml
    clusters:
    - name: my_service
      http2_protocol_options: {}  # Enable HTTP/2
      common_http_protocol_options:
        idle_timeout: 300s
        max_connection_duration: 600s
      circuit_breakers:
        thresholds:
        - max_connections: 100
    ```

    ## Retries

    Automatic retry on failures.

    ```yaml
    routes:
    - match:
        prefix: "/"
      route:
        cluster: my_service
        retry_policy:
          retry_on: "5xx,reset,connect-failure,refused-stream"
          num_retries: 3
          per_try_timeout: 2s
          retry_host_predicate:
          - name: envoy.retry_host_predicates.previous_hosts
          host_selection_retry_max_attempts: 5
    ```

    **Retry Conditions**:
    - `5xx`: Server errors
    - `reset`: Connection reset
    - `connect-failure`: Connection failed
    - `refused-stream`: HTTP/2 stream refused
    - `retriable-4xx`: 409 Conflict

    ## Timeouts

    Prevent hanging requests.

    ```yaml
    routes:
    - match:
        prefix: "/"
      route:
        cluster: my_service
        timeout: 15s              # Request timeout
        idle_timeout: 60s         # Idle connection timeout
    ```

    ## Rate Limiting

    Protect services from overload.

    ### Local Rate Limiting

    ```yaml
    http_filters:
    - name: envoy.filters.http.local_ratelimit
      typed_config:
        "@type": type.googleapis.com/envoy.extensions.filters.http.local_ratelimit.v3.LocalRateLimit
        stat_prefix: http_local_rate_limiter
        token_bucket:
          max_tokens: 100
          tokens_per_fill: 10
          fill_interval: 1s
        filter_enabled:
          runtime_key: local_rate_limit_enabled
          default_value:
            numerator: 100
            denominator: HUNDRED
        filter_enforced:
          runtime_key: local_rate_limit_enforced
          default_value:
            numerator: 100
            denominator: HUNDRED
    ```

    ## Weighted Clusters

    Split traffic between clusters (canary deployments).

    ```yaml
    route:
      weighted_clusters:
        clusters:
        - name: service_v1
          weight: 90  # 90% of traffic
        - name: service_v2
          weight: 10  # 10% of traffic (canary)
    ```

    ## Best Practices

    1. **Always configure health checks**: Detect failures quickly
    2. **Use outlier detection**: Catch intermittent issues
    3. **Set circuit breakers**: Prevent cascade failures
    4. **Configure retries carefully**: Avoid retry storms
    5. **Use appropriate timeouts**: Balance latency and reliability
    6. **Monitor metrics**: Track health, latency, error rates

    **Practice**: Try the Load Balancing lab!
  MARKDOWN
  lesson.key_concepts = ['load balancing', 'health checks', 'circuit breaking', 'retries', 'timeouts', 'outlier detection']
end

# Quiz 2.1: Load Balancing and Resilience
quiz2_1 = Quiz.find_or_create_by!(title: "Load Balancing and Resilience Quiz") do |quiz|
  quiz.description = 'Test your knowledge of load balancing and resilience patterns'
  quiz.time_limit_minutes = 12
  quiz.passing_score = 70
end

[
  {
    question_text: "Which load balancing policy distributes requests evenly in circular order?",
    question_type: "mcq",
    points: 5,
    options: ["ROUND_ROBIN", "LEAST_REQUEST", "RANDOM", "RING_HASH"],
    correct_answer: "ROUND_ROBIN",
    explanation: "Round robin distributes requests equally to each endpoint in circular order."
  },
  {
    question_text: "What's the benefit of LEAST_REQUEST load balancing?",
    question_type: "mcq",
    points: 5,
    options: ["Adapts to actual server load", "Simplest implementation", "Best for caching", "Fastest algorithm"],
    correct_answer: "Adapts to actual server load",
    explanation: "Least request sends traffic to the least loaded server, adapting to actual load."
  },
  {
    question_text: "What is active health checking?",
    question_type: "mcq",
    points: 5,
    options: ["Envoy actively probes endpoints", "Detects failures from traffic", "Checks on-demand", "Never checks health"],
    correct_answer: "Envoy actively probes endpoints",
    explanation: "Active health checking involves Envoy actively sending health check requests to endpoints."
  },
  {
    question_text: "What is outlier detection?",
    question_type: "mcq",
    points: 5,
    options: ["Passive health checking from actual traffic", "Active probing", "Load balancing algorithm", "Metric collection"],
    correct_answer: "Passive health checking from actual traffic",
    explanation: "Outlier detection passively monitors actual traffic to detect unhealthy hosts."
  },
  {
    question_text: "What does circuit breaking prevent?",
    question_type: "mcq",
    points: 5,
    options: ["Cascade failures", "DDoS attacks", "Data loss", "Network splits"],
    correct_answer: "Cascade failures",
    explanation: "Circuit breakers prevent overwhelming services and causing cascade failures."
  },
  {
    question_text: "What are the three circuit breaker states?",
    question_type: "mcq",
    points: 5,
    options: ["Closed, Open, Half-Open", "On, Off, Standby", "Active, Inactive, Testing", "Healthy, Unhealthy, Unknown"],
    correct_answer: "Closed, Open, Half-Open",
    explanation: "Circuit breakers have three states: Closed (normal), Open (blocking), Half-Open (testing recovery)."
  },
  {
    question_text: "What does unhealthy_threshold control?",
    question_type: "mcq",
    points: 5,
    options: ["Number of failures before marking unhealthy", "Timeout duration", "Request limit", "Load percentage"],
    correct_answer: "Number of failures before marking unhealthy",
    explanation: "unhealthy_threshold is the number of consecutive health check failures before marking a host unhealthy."
  },
  {
    question_text: "What's the purpose of connection pooling?",
    question_type: "mcq",
    points: 5,
    options: ["Reuse connections for better performance", "Load balancing", "Health checking", "Request routing"],
    correct_answer: "Reuse connections for better performance",
    explanation: "Connection pooling reuses TCP connections to reduce overhead and improve performance."
  },
  {
    question_text: "Which load balancing policy provides session affinity?",
    question_type: "mcq",
    points: 5,
    options: ["RING_HASH", "ROUND_ROBIN", "LEAST_REQUEST", "RANDOM"],
    correct_answer: "RING_HASH",
    explanation: "Ring hash uses consistent hashing to ensure requests from the same source go to the same backend."
  },
  {
    question_text: "What does max_connections in circuit breakers limit?",
    question_type: "mcq",
    points: 5,
    options: ["Maximum concurrent TCP connections", "Request rate", "Response time", "Error rate"],
    correct_answer: "Maximum concurrent TCP connections",
    explanation: "max_connections limits the number of concurrent TCP connections to prevent overload."
  },
  {
    question_text: "What should you be careful about when configuring retries?",
    question_type: "mcq",
    points: 5,
    options: ["Avoid retry storms that amplify problems", "Retry too few times", "Only retry GET requests", "Never use retries"],
    correct_answer: "Avoid retry storms that amplify problems",
    explanation: "Excessive retries can amplify failures and create retry storms that make problems worse."
  },
  {
    question_text: "What is weighted cluster routing used for?",
    question_type: "mcq",
    points: 5,
    options: ["Canary deployments and traffic splitting", "Load balancing", "Health checking", "TLS termination"],
    correct_answer: "Canary deployments and traffic splitting",
    explanation: "Weighted clusters allow splitting traffic between versions for gradual rollouts."
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2_1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer]
    question.explanation = q_data[:explanation]
  end
end

# ==========================================
# LINK LESSONS AND QUIZZES TO MODULES
# ==========================================

puts "Linking lessons and quizzes to modules..."

# Module 1: Envoy Fundamentals
ModuleItem.find_or_create_by!(
  course_module: module1,
  item: lesson1_1,
  sequence_order: 1
)

ModuleItem.find_or_create_by!(
  course_module: module1,
  item: quiz1_1,
  sequence_order: 2
)

# Module 2: Load Balancing
ModuleItem.find_or_create_by!(
  course_module: module2,
  item: lesson2_1,
  sequence_order: 1
)

ModuleItem.find_or_create_by!(
  course_module: module2,
  item: quiz2_1,
  sequence_order: 2
)

# ==========================================
# LINK ENVOY LABS
# ==========================================

puts "Linking Envoy labs to modules..."

envoy_labs = HandsOnLab.where(lab_type: 'envoy').order(:sequence_order)

if envoy_labs.any?
  envoy_labs.each_with_index do |lab, index|
    mod = index < 2 ? module1 : module2
    ModuleItem.find_or_create_by!(
      course_module: mod,
      item: lab,
      sequence_order: 40 + index
    )
  end
  puts "Linked #{envoy_labs.count} Envoy labs"
end

puts "\n✅ Complete Envoy Proxy Mastery course created!"
puts "   - Course: #{envoy_course.title}"
puts "   - Modules: #{envoy_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_module: :course).where(courses: { id: envoy_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_module: :course).where(courses: { id: envoy_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: {course_module: :course}).where(courses: { id: envoy_course.id }).count}"
puts "   - Labs: #{envoy_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ Envoy Fundamentals (listeners, clusters, routes, filters)"
puts "   ✅ Load Balancing (algorithms, health checks, circuit breaking)"
puts "\n🎯 Learning Features:"
puts "   ✅ 22+ quiz questions with detailed explanations"
puts "   ✅ Production-grade Envoy configurations"
puts "   ✅ Service mesh best practices"
puts "   ✅ Hands-on labs"
puts "\n🚀 Ready for microservices architectures!"