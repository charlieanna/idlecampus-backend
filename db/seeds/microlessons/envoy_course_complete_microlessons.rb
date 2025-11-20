# AUTO-GENERATED from envoy_course_complete.rb
puts "Creating Microlessons for Envoy Fundamentals..."

module_var = CourseModule.find_by(slug: 'envoy-fundamentals')

# === MICROLESSON 1: Practice Question ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 2,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 3: Lesson 3 ===
lesson_3 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 3',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 3,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 4: Lesson 4 ===
lesson_4 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 4',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Practice Question ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Practice Question ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Practice Question ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Practice Question',
  content: <<~MARKDOWN,
# Practice Question 🚀

## What is this?
A concise explanation of the concept.

## Key Points

- Re-read the question carefully.

- Recall the relevant formula or rule.

- Review the explanation once you answer.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Lesson 8 ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 8',
  content: <<~MARKDOWN,
# Microlesson 🚀

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
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 8 microlessons for Envoy Fundamentals"
