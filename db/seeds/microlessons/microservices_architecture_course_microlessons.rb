# AUTO-GENERATED from microservices_architecture_course.rb
puts "Creating Microlessons for Microservices Intro..."

module_var = CourseModule.find_by(slug: 'microservices-intro')

# === MICROLESSON 1: Lesson 1 ===
lesson_1 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 1',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Microservices Architecture Principles

    **Microservices** is an architectural style that structures an application as a collection of small, autonomous services organized around business capabilities.

    ## Monolith vs Microservices

    ### Monolithic Architecture

    **All components in a single codebase and deployment unit**

    ```
    ┌─────────────────────────────────────┐
    │         Monolithic Application      │
    │  ┌──────────┬──────────┬─────────┐ │
    │  │   User   │ Product  │ Payment │ │
    │  │ Service  │ Service  │ Service │ │
    │  └──────────┴──────────┴─────────┘ │
    │  ┌──────────────────────────────┐  │
    │  │      Shared Database         │  │
    │  └──────────────────────────────┘  │
    └─────────────────────────────────────┘
    ```

    ✅ **Advantages:**
    - Simple to develop initially
    - Easy to test (everything together)
    - Simple deployment (single unit)
    - No network latency between components
    - ACID transactions work easily
    - Straightforward debugging

    ❌ **Disadvantages:**
    - Tight coupling (change one thing, test everything)
    - Scaling limitations (must scale entire app)
    - Technology lock-in (one language/framework)
    - Long deployment cycles
    - Large codebase becomes hard to understand
    - Single point of failure

    ### Microservices Architecture

    **Multiple independent services, each with own database**

    ```
    ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
    │    User     │  │   Product   │  │   Payment   │
    │   Service   │  │   Service   │  │   Service   │
    ├─────────────┤  ├─────────────┤  ├─────────────┤
    │   User DB   │  │ Product DB  │  │ Payment DB  │
    └─────────────┘  └─────────────┘  └─────────────┘
         ↑                ↑                 ↑
         └────────────────┴─────────────────┘
                  API Gateway / Service Mesh
    ```

    ✅ **Advantages:**
    - Independent scaling (scale what you need)
    - Technology diversity (right tool per service)
    - Faster deployments (deploy one service)
    - Fault isolation (one service fails, others run)
    - Team autonomy (teams own services)
    - Easier to understand (smaller codebases)

    ❌ **Disadvantages:**
    - Distributed system complexity
    - Network latency between services
    - Distributed transactions are hard
    - Testing is more complex
    - Deployment complexity (many services)
    - Data consistency challenges
    - Debugging is harder

    ## When to Use Microservices (and When NOT to)

    ### ✅ Use Microservices When:

    **1. Application has grown too large**
    ```
    - 100K+ lines of code
    - 20+ developers
    - Multiple teams working on same codebase
    - Frequent merge conflicts
    ```

    **2. Different scaling requirements**
    ```python
    # Example: E-commerce platform
    - Product catalog: Read-heavy, needs 10 servers
    - Order processing: Write-heavy, needs 2 servers
    - Image processing: CPU-intensive, needs GPU servers

    # Microservices: Scale each independently
    # Monolith: Must scale entire app (wasteful)
    ```

    **3. Need for technology diversity**
    ```
    - User service: Node.js (I/O intensive)
    - Recommendation engine: Python (ML libraries)
    - Payment processing: Java (enterprise libraries)
    - Real-time chat: Go (concurrency)
    ```

    **4. Independent deployment needed**
    ```
    - Update payment service without redeploying entire app
    - Deploy new features faster
    - Reduce risk (smaller deployments)
    ```

    **5. Team structure supports it**
    ```
    - Multiple teams
    - Each team can own a service
    - Clear domain boundaries
    ```

    ### ❌ DON'T Use Microservices When:

    **1. Small application**
    ```python
    # Simple blog application
    - 1-3 developers
    - Simple CRUD operations
    - Low traffic

    # Verdict: Monolith is perfect!
    # Microservices would be over-engineering
    ```

    **2. Unclear domain boundaries**
    ```
    - Don't know how to split services yet
    - Requirements still changing rapidly
    - Domain not well understood

    # Start with monolith, extract services later!
    ```

    **3. Limited operational capability**
    ```
    - No DevOps expertise
    - No container orchestration (Kubernetes)
    - Small team (1-5 developers)
    - Limited monitoring/logging infrastructure

    # Microservices require operational maturity
    ```

    **4. Performance-critical application**
    ```
    - Sub-millisecond latency required
    - In-process calls needed
    - Complex transactions across components

    # Network calls add latency
    ```

    ## Service Boundaries and Domain-Driven Design

    ### Domain-Driven Design (DDD)

    **Define service boundaries based on business domains**

    ```
    E-commerce Platform Domains:

    ┌─────────────────────────────────────────────────┐
    │  User Management (Bounded Context)              │
    │  - User registration                            │
    │  - Authentication                               │
    │  - Profile management                           │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Product Catalog (Bounded Context)              │
    │  - Product listings                             │
    │  - Search                                       │
    │  - Categories                                   │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Order Management (Bounded Context)             │
    │  - Shopping cart                                │
    │  - Order placement                              │
    │  - Order tracking                               │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Payment Processing (Bounded Context)           │
    │  - Payment methods                              │
    │  - Transaction processing                       │
    │  - Refunds                                      │
    └─────────────────────────────────────────────────┘
    ```

    ### Identifying Service Boundaries

    **Ask these questions:**

    1. **Single Responsibility**: Does the service have one clear purpose?
    2. **Cohesion**: Do related functions belong together?
    3. **Coupling**: Can it change independently?
    4. **Data Ownership**: Does it own its data?

    **Example: Order Service**
    ```python
    # Good: Clear boundary
    class OrderService:
        def create_order(user_id, items)
        def get_order(order_id)
        def cancel_order(order_id)
        def update_order_status(order_id, status)

    # Bad: Doing too much
    class OrderService:
        def create_order(...)
        def process_payment(...)      # Payment service!
        def send_email(...)            # Notification service!
        def update_inventory(...)      # Inventory service!
    ```

    ### Service Size: How Small is "Micro"?

    **Not about lines of code, but about purpose**

    ```python
    # Too small (nano-services)
    class AddService:
        def add(a, b):
            return a + b

    class SubtractService:
        def subtract(a, b):
            return a - b

    # Too big (mini-monolith)
    class EverythingService:
        def handle_users(...)
        def handle_products(...)
        def handle_orders(...)
        def handle_payments(...)

    # Just right
    class OrderService:
        # Manages entire order lifecycle
        # ~2000-5000 lines of code
        # One team can understand and maintain it
    ```

    ## Communication Patterns (Sync vs Async)

    ### Synchronous Communication (Request-Response)

    **Service waits for response**

    ```python
    # HTTP/REST example
    def create_order(user_id, items):
        # Synchronous call to user service
        user = http_client.get(f'http://user-service/users/{user_id}')

        if not user:
            return {'error': 'User not found'}, 404

        # Synchronous call to product service
        products = http_client.post('http://product-service/validate',
                                    json={'items': items})

        # Create order
        order = db.save_order(user_id, items)

        # Synchronous call to payment service
        payment = http_client.post('http://payment-service/charge',
                                  json={'order_id': order.id, 'amount': order.total})

        return order
    ```

    ✅ **Pros:**
    - Simple to understand
    - Immediate response
    - Easy error handling
    - Natural request-response flow

    ❌ **Cons:**
    - Tight coupling (service must be available)
    - Cascading failures (one service down = all fail)
    - Higher latency (sequential calls)
    - Reduced availability

    **When to use:**
    - Need immediate response
    - Simple queries
    - Critical operations (payments)

    ### Asynchronous Communication (Events/Messages)

    **Service doesn't wait for response**

    ```python
    # Event-driven example
    def create_order(user_id, items):
        # Create order
        order = db.save_order(user_id, items, status='PENDING')

        # Publish event (non-blocking)
        event_bus.publish('order.created', {
            'order_id': order.id,
            'user_id': user_id,
            'items': items,
            'total': order.total
        })

        return order  # Return immediately!

    # Other services react to events (independently)
    @event_bus.subscribe('order.created')
    def handle_order_payment(event):
        # Payment service processes payment
        process_payment(event['order_id'], event['total'])

    @event_bus.subscribe('order.created')
    def handle_order_notification(event):
        # Notification service sends email
        send_order_confirmation_email(event['user_id'], event['order_id'])

    @event_bus.subscribe('order.created')
    def handle_inventory_update(event):
        # Inventory service updates stock
        update_inventory(event['items'])
    ```

    ✅ **Pros:**
    - Loose coupling (services independent)
    - Better fault tolerance
    - Natural for workflows
    - Easier to add new services

    ❌ **Cons:**
    - Eventual consistency
    - Complex debugging
    - Message ordering issues
    - Requires message infrastructure

    **When to use:**
    - Long-running operations
    - Fire-and-forget operations
    - Fan-out scenarios (notify multiple services)
    - High availability requirements

    ## API Gateway Pattern

    **Single entry point for all client requests**

    ```
              Clients (Web, Mobile, IoT)
                        │
                        ▼
              ┌─────────────────┐
              │   API Gateway   │
              │  - Routing      │
              │  - Auth         │
              │  - Rate limit   │
              │  - Aggregation  │
              └────────┬────────┘
                       │
           ┌───────────┼───────────┬──────────┐
           │           │           │          │
           ▼           ▼           ▼          ▼
      ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐
      │  User  │  │Product │  │ Order  │  │Payment │
      │Service │  │Service │  │Service │  │Service │
      └────────┘  └────────┘  └────────┘  └────────┘
    ```

    ### API Gateway Responsibilities

    **1. Request Routing**
    ```python
    # Route requests to appropriate services
    @gateway.route('/users/*')
    def route_to_user_service(request):
        return forward_to('user-service', request)

    @gateway.route('/products/*')
    def route_to_product_service(request):
        return forward_to('product-service', request)
    ```

    **2. Authentication & Authorization**
    ```python
    @gateway.before_request
    def authenticate():
        token = request.headers.get('Authorization')
        user = verify_jwt_token(token)

        if not user:
            return {'error': 'Unauthorized'}, 401

        request.user = user  # Attach to request
    ```

    **3. Rate Limiting**
    ```python
    @gateway.route('/api/*')
    @rate_limit(limit=1000, per=3600)  # 1000 requests/hour
    def handle_api_request(request):
        return forward_request(request)
    ```

    **4. Request Aggregation**
    ```python
    # Single request to gateway → Multiple service calls
    @gateway.route('/user-dashboard/:user_id')
    async def get_dashboard(user_id):
        # Call multiple services in parallel
        user, orders, recommendations = await asyncio.gather(
            http_client.get(f'user-service/users/{user_id}'),
            http_client.get(f'order-service/users/{user_id}/orders'),
            http_client.get(f'recommendation-service/users/{user_id}')
        )

        return {
            'user': user,
            'recent_orders': orders,
            'recommendations': recommendations
        }
    ```

    **5. Protocol Translation**
    ```python
    # Client uses REST, service uses gRPC
    @gateway.route('/products', methods=['GET'])
    def get_products():
        # Translate REST to gRPC
        grpc_response = product_grpc_client.GetProducts()

        # Convert to JSON
        return json_format.MessageToDict(grpc_response)
    ```

    **Popular API Gateways:**
    - Kong
    - AWS API Gateway
    - Nginx
    - Envoy
    - Traefik

    ## Service Discovery

    **How services find each other in dynamic environments**

    ### The Problem

    ```
    Problem: Service addresses change constantly
    - Containers restart → New IP addresses
    - Auto-scaling → New instances added/removed
    - Health issues → Instances removed

    How does Order Service find Payment Service?
    ```

    ### Client-Side Discovery

    **Client queries service registry and load balances**

    ```python
    # Service Registry (Consul, Eureka, etcd)
    registry = {
        'payment-service': [
            '10.0.1.5:8000',
            '10.0.1.6:8000',
            '10.0.1.7:8000'
        ]
    }

    # Client-side discovery
    class ServiceClient:
        def call_service(self, service_name, path):
            # 1. Query registry for available instances
            instances = registry.get(service_name)

            # 2. Client-side load balancing
            instance = random.choice(instances)

            # 3. Make request
            return http_client.get(f'http://{instance}{path}')

    # Usage
    client = ServiceClient()
    payment = client.call_service('payment-service', '/charge')
    ```

    ✅ Simple, no additional infrastructure
    ❌ Client must implement discovery logic

    ### Server-Side Discovery

    **Load balancer queries service registry**

    ```
    ┌──────────┐
    │  Client  │
    └────┬─────┘
         │
         ▼
    ┌─────────────┐      ┌──────────────────┐
    │Load Balancer│─────▶│ Service Registry │
    └──────┬──────┘      └──────────────────┘
           │
           ├──────────┬──────────┬──────────┐
           ▼          ▼          ▼          ▼
      Instance1  Instance2  Instance3  Instance4
    ```

    **Example: Kubernetes Service Discovery**
    ```yaml
    # Kubernetes Service automatically discovers pods
    apiVersion: v1
    kind: Service
    metadata:
      name: payment-service
    spec:
      selector:
        app: payment
      ports:
        - port: 80
          targetPort: 8000

    # Application code (simple!)
    # Kubernetes DNS resolves payment-service to actual pod IPs
    payment = http_client.get('http://payment-service/charge')
    ```

    ✅ Simpler client code
    ✅ Centralized logic
    ❌ Additional infrastructure (load balancer)

    ### Service Registration

    **How services register themselves**

    **Self-Registration**
    ```python
    # Service registers itself on startup
    class PaymentService:
        def start(self):
            # Register with service registry
            registry.register(
                service_name='payment-service',
                address=f'{self.host}:{self.port}',
                health_check_url=f'http://{self.host}:{self.port}/health'
            )

            # Start HTTP server
            self.run()

        def shutdown(self):
            # Deregister on shutdown
            registry.deregister('payment-service', f'{self.host}:{self.port}')
    ```

    **Third-Party Registration (Kubernetes)**
    ```yaml
    # Kubernetes automatically registers/deregisters pods
    # No code changes needed!
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: payment-service
    spec:
      replicas: 3
      template:
        spec:
          containers:
          - name: payment
            image: payment-service:1.0
            ports:
            - containerPort: 8000
    ```

    ## Real-World Examples

    ### Netflix

    **One of the largest microservices deployments**

    ```
    Services: 700+
    Requests: Billions per day
    Engineers: 1000s

    Architecture:
    - Eureka: Service discovery
    - Zuul: API Gateway
    - Ribbon: Client-side load balancing
    - Hystrix: Circuit breaker
    - AWS: Infrastructure
    ```

    **Benefits achieved:**
    - Deploy 100s of times per day
    - Scale services independently
    - Technology diversity (Java, Node.js, Python)
    - Global deployment

    ### Uber

    **Microservices for ride-sharing platform**

    ```
    Core Services:
    - Rider Service (mobile app backend)
    - Driver Service (driver app backend)
    - Trip Service (manage trips)
    - Routing Service (calculate routes)
    - Pricing Service (surge pricing)
    - Dispatch Service (match riders/drivers)
    - Payment Service (process payments)

    Communication:
    - Synchronous: REST, gRPC (real-time)
    - Asynchronous: Kafka (events, analytics)
    ```

    **Key learnings:**
    - Start with monolith, extract services gradually
    - Strong service ownership (team per service)
    - Invest in observability early

    ### Amazon

    **Pioneered microservices (2001)**

    ```
    "Two-pizza teams"
    - Team small enough to feed with 2 pizzas
    - Each team owns a service
    - Full autonomy (build, deploy, operate)

    Results:
    - Faster innovation
    - Independent deployments
    - Better fault isolation
    ```

    ## Best Practices

    **1. Start with a Monolith**
    ```
    - Build monolith first
    - Learn domain boundaries
    - Extract services when needed
    - Don't over-engineer early
    ```

    **2. Design for Failure**
    ```python
    # Always assume services can fail
    try:
        recommendations = recommendation_service.get(user_id)
    except ServiceUnavailable:
        # Fallback: Show default recommendations
        recommendations = get_popular_products()
    ```

    **3. Decentralize Everything**
    ```
    - Decentralized data (each service owns data)
    - Decentralized governance (teams choose tech)
    - Decentralized deployment (deploy independently)
    ```

    **4. Build Observable Systems**
    ```python
    # Logging, metrics, tracing from day 1
    @app.route('/checkout')
    def checkout():
        logger.info('Checkout started', user_id=user.id)
        metrics.increment('checkout.started')

        with tracer.start_span('checkout'):
            result = process_checkout()

        return result
    ```

    **5. Automate Everything**
    ```
    - CI/CD pipelines
    - Automated testing
    - Automated deployment
    - Automated monitoring
    ```

    **Next**: We'll explore inter-service communication patterns in depth, including REST, gRPC, message queues, and handling distributed transactions.
  MARKDOWN
  sequence_order: 1,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 2: Lesson 2 ===
lesson_2 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 2',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Communication Patterns

    In microservices, services must communicate over the network. Choosing the right communication pattern is critical for performance, reliability, and maintainability.

    ## REST APIs Between Services

    **RESTful HTTP is the most common synchronous communication pattern**

    ### Basic REST Communication

    ```python
    # Order Service → User Service (REST)
    import requests

    class UserServiceClient:
        def __init__(self, base_url):
            self.base_url = base_url

        def get_user(self, user_id):
            response = requests.get(
                f'{self.base_url}/users/{user_id}',
                timeout=5  # Important: Always set timeout!
            )

            response.raise_for_status()  # Raise on 4xx/5xx
            return response.json()

        def update_user(self, user_id, data):
            response = requests.put(
                f'{self.base_url}/users/{user_id}',
                json=data,
                timeout=5
            )

            response.raise_for_status()
            return response.json()

    # Usage in Order Service
    user_client = UserServiceClient('http://user-service:8000')

    def create_order(user_id, items):
        # Verify user exists
        try:
            user = user_client.get_user(user_id)
        except requests.HTTPError as e:
            if e.response.status_code == 404:
                return {'error': 'User not found'}, 404
            raise

        # Create order
        order = db.save_order(user_id, items)
        return order
    ```

    ### REST API Design Best Practices

    **1. Use Resource-Based URLs**
    ```
    ✅ Good:
    GET    /users/123           (get user)
    POST   /users               (create user)
    PUT    /users/123           (update user)
    DELETE /users/123           (delete user)
    GET    /users/123/orders    (get user's orders)

    ❌ Bad:
    GET    /getUser?id=123
    POST   /createUser
    POST   /updateUser
    POST   /deleteUser
    ```

    **2. Use HTTP Methods Correctly**
    ```
    GET    - Read (idempotent, safe)
    POST   - Create
    PUT    - Update/Replace (idempotent)
    PATCH  - Partial update
    DELETE - Delete (idempotent)
    ```

    **3. Use Proper Status Codes**
    ```python
    # Success codes
    200 OK           # Successful GET, PUT, PATCH
    201 Created      # Successful POST
    204 No Content   # Successful DELETE

    # Client error codes
    400 Bad Request      # Invalid input
    401 Unauthorized     # Missing/invalid auth
    403 Forbidden        # Insufficient permissions
    404 Not Found        # Resource doesn't exist
    409 Conflict         # Duplicate/conflict
    422 Unprocessable    # Validation error

    # Server error codes
    500 Internal Server Error
    502 Bad Gateway          # Upstream service error
    503 Service Unavailable  # Temporary overload
    504 Gateway Timeout      # Upstream timeout
    ```

    **4. Version Your APIs**
    ```python
    # URL versioning
    GET /api/v1/users/123
    GET /api/v2/users/123

    # Header versioning
    GET /api/users/123
    Accept: application/vnd.myapp.v1+json

    # Maintain backward compatibility!
    # Support old versions during migration
    ```

    ### REST Challenges

    ❌ **Problems:**
    - **Verbose**: JSON over HTTP has overhead
    - **Latency**: HTTP/1.1 has limitations
    - **No type safety**: Client doesn't know schema
    - **Over/under-fetching**: Can't customize response

    ## gRPC for Performance

    **gRPC uses Protocol Buffers (binary format) and HTTP/2 for high-performance RPC**

    ### Why gRPC?

    ```
    Comparison (10,000 requests):

    REST (JSON over HTTP/1.1):
    - Payload: 500 bytes (JSON)
    - Latency: 50ms
    - Throughput: 5,000 req/sec

    gRPC (Protobuf over HTTP/2):
    - Payload: 150 bytes (binary)
    - Latency: 10ms
    - Throughput: 25,000 req/sec

    gRPC is 3-5x faster!
    ```

    ### Define Service with Protocol Buffers

    ```protobuf
    // user_service.proto
    syntax = "proto3";

    package user;

    // Service definition
    service UserService {
      rpc GetUser(GetUserRequest) returns (User);
      rpc CreateUser(CreateUserRequest) returns (User);
      rpc UpdateUser(UpdateUserRequest) returns (User);
      rpc ListUsers(ListUsersRequest) returns (stream User);  // Streaming!
    }

    // Messages
    message User {
      int64 id = 1;
      string email = 2;
      string name = 3;
      string created_at = 4;
    }

    message GetUserRequest {
      int64 id = 1;
    }

    message CreateUserRequest {
      string email = 1;
      string name = 2;
    }

    message UpdateUserRequest {
      int64 id = 1;
      string email = 2;
      string name = 3;
    }

    message ListUsersRequest {
      int32 page = 1;
      int32 page_size = 2;
    }
    ```

    ### Generate Code

    ```bash
    # Generate Python code from proto file
    python -m grpc_tools.protoc \
      -I. \
      --python_out=. \
      --grpc_python_out=. \
      user_service.proto

    # Generates:
    # - user_service_pb2.py (messages)
    # - user_service_pb2_grpc.py (service stubs)
    ```

    ### Implement gRPC Server

    ```python
    import grpc
    from concurrent import futures
    import user_service_pb2
    import user_service_pb2_grpc

    class UserServiceServicer(user_service_pb2_grpc.UserServiceServicer):
        def GetUser(self, request, context):
            # Get user from database
            user_data = db.get_user(request.id)

            if not user_data:
                context.set_code(grpc.StatusCode.NOT_FOUND)
                context.set_details('User not found')
                return user_service_pb2.User()

            # Return protobuf message
            return user_service_pb2.User(
                id=user_data['id'],
                email=user_data['email'],
                name=user_data['name'],
                created_at=user_data['created_at']
            )

        def CreateUser(self, request, context):
            # Validate
            if not request.email:
                context.set_code(grpc.StatusCode.INVALID_ARGUMENT)
                context.set_details('Email is required')
                return user_service_pb2.User()

            # Create user
            user_id = db.create_user(request.email, request.name)
            user_data = db.get_user(user_id)

            return user_service_pb2.User(
                id=user_data['id'],
                email=user_data['email'],
                name=user_data['name'],
                created_at=user_data['created_at']
            )

        def ListUsers(self, request, context):
            # Server-side streaming
            users = db.get_users(
                page=request.page,
                page_size=request.page_size
            )

            for user_data in users:
                yield user_service_pb2.User(
                    id=user_data['id'],
                    email=user_data['email'],
                    name=user_data['name'],
                    created_at=user_data['created_at']
                )

    # Start server
    def serve():
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
        user_service_pb2_grpc.add_UserServiceServicer_to_server(
            UserServiceServicer(), server
        )
        server.add_insecure_port('[::]:50051')
        server.start()
        server.wait_for_termination()

    if __name__ == '__main__':
        serve()
    ```

    ### Implement gRPC Client

    ```python
    import grpc
    import user_service_pb2
    import user_service_pb2_grpc

    class UserServiceClient:
        def __init__(self, host, port):
            # Create channel
            self.channel = grpc.insecure_channel(f'{host}:{port}')
            # Create stub (client)
            self.stub = user_service_pb2_grpc.UserServiceStub(self.channel)

        def get_user(self, user_id):
            request = user_service_pb2.GetUserRequest(id=user_id)

            try:
                response = self.stub.GetUser(request, timeout=5)
                return {
                    'id': response.id,
                    'email': response.email,
                    'name': response.name,
                    'created_at': response.created_at
                }
            except grpc.RpcError as e:
                if e.code() == grpc.StatusCode.NOT_FOUND:
                    return None
                raise

        def create_user(self, email, name):
            request = user_service_pb2.CreateUserRequest(
                email=email,
                name=name
            )
            response = self.stub.CreateUser(request, timeout=5)
            return response

        def list_users(self, page=1, page_size=10):
            request = user_service_pb2.ListUsersRequest(
                page=page,
                page_size=page_size
            )

            # Receive stream
            users = []
            for user in self.stub.ListUsers(request):
                users.append({
                    'id': user.id,
                    'email': user.email,
                    'name': user.name
                })

            return users

    # Usage
    client = UserServiceClient('user-service', 50051)
    user = client.get_user(123)
    ```

    ### gRPC Features

    **1. Four types of RPC**
    ```protobuf
    service MyService {
      // Unary: Single request, single response
      rpc GetUser(GetUserRequest) returns (User);

      // Server streaming: Single request, stream responses
      rpc ListUsers(ListUsersRequest) returns (stream User);

      // Client streaming: Stream requests, single response
      rpc CreateUsers(stream CreateUserRequest) returns (CreateUsersResponse);

      // Bidirectional streaming: Stream both ways
      rpc Chat(stream ChatMessage) returns (stream ChatMessage);
    }
    ```

    **2. Built-in features**
    - Load balancing
    - Retries
    - Timeouts
    - Deadlines
    - Cancellation
    - Authentication (TLS, JWT)

    **gRPC vs REST:**

    | Feature | REST | gRPC |
    |---------|------|------|
    | Format | JSON (text) | Protobuf (binary) |
    | Performance | Slower | 3-5x faster |
    | Browser support | Yes | Limited |
    | Streaming | No (HTTP/1.1) | Yes (HTTP/2) |
    | Type safety | No | Yes |
    | Learning curve | Easy | Medium |

    **When to use gRPC:**
    - Internal microservices communication
    - Performance-critical services
    - Real-time/streaming data
    - Polyglot environments (language-agnostic)

    **When to use REST:**
    - Public APIs
    - Browser clients
    - Simple CRUD operations
    - When JSON is preferred

    ## Message Queues (RabbitMQ, Kafka)

    **Asynchronous communication via message brokers**

    ### Why Message Queues?

    ```
    Problem (Synchronous):
    Order Service → (HTTP) → Email Service

    Issues:
    - Order Service waits for email to send
    - If Email Service down, order fails
    - Tight coupling

    Solution (Asynchronous):
    Order Service → (Publish message) → Queue → Email Service

    Benefits:
    - Order Service doesn't wait
    - Email Service processes when ready
    - Loose coupling
    - Email Service can be down temporarily
    ```

    ### RabbitMQ (Message Queue)

    **Traditional message queue with exchanges and queues**

    ```python
    import pika

    # Producer (Order Service)
    class OrderEventPublisher:
        def __init__(self):
            connection = pika.BlockingConnection(
                pika.ConnectionParameters('rabbitmq')
            )
            self.channel = connection.channel()

            # Declare exchange
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True
            )

        def publish_order_created(self, order):
            message = {
                'order_id': order.id,
                'user_id': order.user_id,
                'items': order.items,
                'total': order.total,
                'timestamp': time.time()
            }

            self.channel.basic_publish(
                exchange='orders',
                routing_key='order.created',
                body=json.dumps(message),
                properties=pika.BasicProperties(
                    delivery_mode=2,  # Persistent message
                )
            )

            print(f"Published order.created: {order.id}")

    # Consumer (Email Service)
    class OrderEventConsumer:
        def __init__(self):
            connection = pika.BlockingConnection(
                pika.ConnectionParameters('rabbitmq')
            )
            self.channel = connection.channel()

            # Declare exchange
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True
            )

            # Declare queue
            result = self.channel.queue_declare(
                queue='email_service_queue',
                durable=True
            )

            # Bind queue to exchange
            self.channel.queue_bind(
                exchange='orders',
                queue='email_service_queue',
                routing_key='order.created'
            )

        def start_consuming(self):
            self.channel.basic_consume(
                queue='email_service_queue',
                on_message_callback=self.handle_order_created
            )

            print('Waiting for messages...')
            self.channel.start_consuming()

        def handle_order_created(self, ch, method, properties, body):
            message = json.loads(body)

            try:
                # Send email
                send_order_confirmation_email(
                    order_id=message['order_id'],
                    user_id=message['user_id']
                )

                # Acknowledge message (remove from queue)
                ch.basic_ack(delivery_tag=method.delivery_tag)

                print(f"Processed order: {message['order_id']}")

            except Exception as e:
                # Reject message, requeue for retry
                ch.basic_nack(
                    delivery_tag=method.delivery_tag,
                    requeue=True
                )
                print(f"Failed to process order: {e}")

    # Start consumer
    consumer = OrderEventConsumer()
    consumer.start_consuming()
    ```

    ### Kafka (Event Streaming Platform)

    **Distributed log for high-throughput event streaming**

    ```python
    from kafka import KafkaProducer, KafkaConsumer

    # Producer (Order Service)
    class OrderEventProducer:
        def __init__(self):
            self.producer = KafkaProducer(
                bootstrap_servers=['kafka:9092'],
                value_serializer=lambda v: json.dumps(v).encode('utf-8')
            )

        def publish_order_created(self, order):
            event = {
                'order_id': order.id,
                'user_id': order.user_id,
                'items': order.items,
                'total': order.total,
                'timestamp': time.time()
            }

            # Send to Kafka topic
            future = self.producer.send(
                'order-events',
                key=str(order.id).encode('utf-8'),  # Partition by order_id
                value=event
            )

            # Block until sent (or use async)
            future.get(timeout=10)

            print(f"Published to Kafka: {order.id}")

    # Consumer (Email Service)
    class OrderEventConsumer:
        def __init__(self):
            self.consumer = KafkaConsumer(
                'order-events',
                bootstrap_servers=['kafka:9092'],
                group_id='email-service',  # Consumer group
                value_deserializer=lambda m: json.loads(m.decode('utf-8')),
                auto_offset_reset='earliest',  # Start from beginning
                enable_auto_commit=False  # Manual commit
            )

        def start_consuming(self):
            for message in self.consumer:
                try:
                    event = message.value

                    # Process event
                    send_order_confirmation_email(
                        order_id=event['order_id'],
                        user_id=event['user_id']
                    )

                    # Commit offset (mark as processed)
                    self.consumer.commit()

                    print(f"Processed: {event['order_id']}")

                except Exception as e:
                    print(f"Error processing message: {e}")
                    # Don't commit - will retry

    # Multiple consumers in same group (load balancing)
    # Each message processed by one consumer in group
    consumer = OrderEventConsumer()
    consumer.start_consuming()
    ```

    **RabbitMQ vs Kafka:**

    | Feature | RabbitMQ | Kafka |
    |---------|----------|-------|
    | Model | Message queue | Event log |
    | Throughput | 10K-50K msg/sec | 100K-1M msg/sec |
    | Message retention | Until consumed | Configurable (days) |
    | Ordering | Queue level | Partition level |
    | Use case | Task queues | Event streaming |
    | Replay | No | Yes |

    **When to use RabbitMQ:**
    - Task queues (job processing)
    - Request-reply patterns
    - Message routing (complex routing)
    - Lower throughput

    **When to use Kafka:**
    - Event sourcing
    - Stream processing
    - High throughput
    - Message replay needed
    - Analytics/logging

    ## Event-Driven Architecture

    **Services react to domain events**

    ### Event Types

    **1. Domain Events**
    ```python
    # Events that represent business facts
    OrderCreated(order_id, user_id, items, total)
    OrderShipped(order_id, tracking_number)
    OrderCancelled(order_id, reason)
    PaymentProcessed(payment_id, order_id, amount)
    UserRegistered(user_id, email)
    ```

    **2. Event Notification**
    ```python
    # Minimal information, receiver fetches details
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        order_id = event['order_id']

        # Fetch full order details
        order = order_service.get_order(order_id)

        # Process
        send_confirmation_email(order)
    ```

    **3. Event-Carried State Transfer**
    ```python
    # Full information in event, no need to fetch
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        # Event contains everything needed
        order_id = event['order_id']
        user_id = event['user_id']
        items = event['items']
        total = event['total']

        # Process without additional calls
        send_confirmation_email(user_id, order_id, items, total)
    ```

    ### Event Sourcing

    **Store events instead of current state**

    ```python
    # Traditional: Store current state
    orders_table:
      id | user_id | status    | total
      1  | 123     | SHIPPED   | 99.99

    # Event Sourcing: Store all events
    events_table:
      id | aggregate_id | event_type         | data
      1  | order-1      | OrderCreated       | {user_id: 123, total: 99.99}
      2  | order-1      | PaymentProcessed   | {amount: 99.99}
      3  | order-1      | OrderShipped       | {tracking: ABC123}

    # Rebuild state by replaying events
    def get_order_state(order_id):
        events = db.get_events(aggregate_id=order_id)

        state = {}
        for event in events:
            if event.type == 'OrderCreated':
                state['user_id'] = event.data['user_id']
                state['total'] = event.data['total']
                state['status'] = 'CREATED'
            elif event.type == 'PaymentProcessed':
                state['status'] = 'PAID'
            elif event.type == 'OrderShipped':
                state['status'] = 'SHIPPED'
                state['tracking'] = event.data['tracking']

        return state
    ```

    ✅ **Benefits:**
    - Complete audit trail
    - Time travel (rebuild state at any point)
    - Easy debugging
    - Can add new projections

    ❌ **Challenges:**
    - Complex queries
    - Need snapshots for performance
    - Schema evolution
    - Learning curve

    ## Saga Pattern for Distributed Transactions

    **Handle transactions across multiple services**

    ### The Problem

    ```python
    # Create order workflow (spans 3 services):
    # 1. Order Service: Create order
    # 2. Payment Service: Charge customer
    # 3. Inventory Service: Reserve items

    # Problem: What if payment succeeds but inventory fails?
    # Can't use database transactions across services!
    ```

    ### Saga Pattern (Choreography)

    **Services coordinate via events**

    ```python
    # Order Service
    def create_order(user_id, items):
        # 1. Create order (pending)
        order = db.save_order(user_id, items, status='PENDING')

        # 2. Publish event
        event_bus.publish('order.created', {
            'order_id': order.id,
            'user_id': user_id,
            'items': items,
            'total': order.total
        })

        return order

    @event_bus.subscribe('payment.succeeded')
    def handle_payment_succeeded(event):
        order_id = event['order_id']
        db.update_order_status(order_id, 'PAID')

    @event_bus.subscribe('payment.failed')
    def handle_payment_failed(event):
        # Compensating transaction: Cancel order
        order_id = event['order_id']
        db.update_order_status(order_id, 'CANCELLED')

        event_bus.publish('order.cancelled', {'order_id': order_id})

    # Payment Service
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        order_id = event['order_id']
        total = event['total']

        try:
            # Charge customer
            payment = process_payment(event['user_id'], total)

            # Success
            event_bus.publish('payment.succeeded', {
                'order_id': order_id,
                'payment_id': payment.id
            })

        except PaymentError:
            # Failed
            event_bus.publish('payment.failed', {
                'order_id': order_id,
                'reason': 'insufficient_funds'
            })

    # Inventory Service
    @event_bus.subscribe('payment.succeeded')
    def handle_payment_succeeded(event):
        order_id = event['order_id']

        try:
            # Reserve inventory
            reserve_items(event['order_id'])

            event_bus.publish('inventory.reserved', {'order_id': order_id})

        except InsufficientInventory:
            # Compensating transaction: Refund payment
            event_bus.publish('inventory.failed', {
                'order_id': order_id,
                'reason': 'out_of_stock'
            })

    @event_bus.subscribe('order.cancelled')
    def handle_order_cancelled(event):
        # Release reserved inventory (if any)
        release_items(event['order_id'])
    ```

    **Flow:**
    ```
    Happy Path:
    Order Service: Create order → Publish order.created
    Payment Service: Receive order.created → Charge → Publish payment.succeeded
    Inventory Service: Receive payment.succeeded → Reserve → Publish inventory.reserved
    Order Service: Receive payment.succeeded → Update status to PAID
    ✅ Done!

    Failure Path:
    Order Service: Create order → Publish order.created
    Payment Service: Receive order.created → Charge fails → Publish payment.failed
    Order Service: Receive payment.failed → Cancel order → Publish order.cancelled
    ❌ Order cancelled (compensating transaction)
    ```

    ### Saga Pattern (Orchestration)

    **Central coordinator manages saga**

    ```python
    # Order Saga Orchestrator
    class OrderSagaOrchestrator:
        def execute_order_saga(self, user_id, items, total):
            saga_id = generate_uuid()

            # Track saga state
            saga_state = {
                'saga_id': saga_id,
                'user_id': user_id,
                'items': items,
                'total': total,
                'current_step': 'START',
                'order_id': None,
                'payment_id': None
            }

            try:
                # Step 1: Create order
                saga_state['current_step'] = 'CREATE_ORDER'
                order = order_service.create_order(user_id, items)
                saga_state['order_id'] = order.id

                # Step 2: Process payment
                saga_state['current_step'] = 'PROCESS_PAYMENT'
                payment = payment_service.charge(user_id, total)
                saga_state['payment_id'] = payment.id

                # Step 3: Reserve inventory
                saga_state['current_step'] = 'RESERVE_INVENTORY'
                inventory_service.reserve(order.id, items)

                # Success!
                saga_state['current_step'] = 'COMPLETED'
                return {'status': 'success', 'order_id': order.id}

            except Exception as e:
                # Execute compensating transactions
                return self.compensate(saga_state, e)

        def compensate(self, saga_state, error):
            # Undo completed steps (reverse order)

            if saga_state['current_step'] in ['RESERVE_INVENTORY', 'COMPLETED']:
                # Unreserve inventory
                inventory_service.release(saga_state['order_id'])

            if saga_state['current_step'] in ['PROCESS_PAYMENT', 'RESERVE_INVENTORY']:
                # Refund payment
                payment_service.refund(saga_state['payment_id'])

            if saga_state['order_id']:
                # Cancel order
                order_service.cancel(saga_state['order_id'])

            return {
                'status': 'failed',
                'error': str(error),
                'saga_id': saga_state['saga_id']
            }
    ```

    **Choreography vs Orchestration:**

    | Aspect | Choreography | Orchestration |
    |--------|--------------|---------------|
    | Coordination | Decentralized (events) | Centralized (orchestrator) |
    | Complexity | Simple sagas | Complex sagas |
    | Dependencies | Loose coupling | Orchestrator knows all |
    | Debugging | Harder | Easier (central view) |

    ## Circuit Breaker Pattern

    **Prevent cascading failures**

    ### The Problem

    ```python
    # Payment service is down
    # Order service keeps calling it
    # All requests fail after 30s timeout
    # Order service becomes slow/unavailable
    # Cascading failure!
    ```

    ### Circuit Breaker Solution

    ```python
    from circuitbreaker import circuit

    class PaymentServiceClient:
        @circuit(failure_threshold=5, recovery_timeout=60, expected_exception=RequestException)
        def charge(self, user_id, amount):
            response = requests.post(
                f'{self.base_url}/charge',
                json={'user_id': user_id, 'amount': amount},
                timeout=5
            )
            response.raise_for_status()
            return response.json()

    # Usage
    payment_client = PaymentServiceClient()

    try:
        payment = payment_client.charge(user_id=123, amount=99.99)
    except CircuitBreakerError:
        # Circuit is open (service is down)
        # Fail fast instead of waiting for timeout
        return {'error': 'Payment service temporarily unavailable'}, 503
    ```

    **Circuit Breaker States:**

    ```
    ┌─────────┐
    │ CLOSED  │  (Normal operation)
    │         │  Requests pass through
    └────┬────┘  Count failures
         │
         │ failures >= threshold
         │
         ▼
    ┌─────────┐
    │  OPEN   │  (Service down)
    │         │  Fail fast, don't call service
    └────┬────┘  Start recovery timeout
         │
         │ after timeout
         │
         ▼
    ┌─────────┐
    │ HALF    │  (Testing recovery)
    │ OPEN    │  Allow limited requests
    └────┬────┘
         │
         ├──► Success → CLOSED
         └──► Failure → OPEN
    ```

    **Implementation with fallback:**

    ```python
    from circuitbreaker import circuit

    @circuit(failure_threshold=5, recovery_timeout=60)
    def get_recommendations(user_id):
        response = requests.get(
            f'http://recommendation-service/users/{user_id}',
            timeout=2
        )
        response.raise_for_status()
        return response.json()

    def get_recommendations_with_fallback(user_id):
        try:
            return get_recommendations(user_id)
        except CircuitBreakerError:
            # Circuit open - use fallback
            logger.warning('Recommendation service circuit open, using fallback')
            return get_popular_products()  # Fallback to popular products
        except Exception as e:
            logger.error(f'Recommendation service error: {e}')
            return get_popular_products()
    ```

    ## Best Practices

    **1. Timeouts everywhere**
    ```python
    # Always set timeouts on external calls
    requests.get(url, timeout=5)  # 5 seconds max
    ```

    **2. Idempotency**
    ```python
    # Same request multiple times = same result
    # Use idempotency keys
    payment_service.charge(
        user_id=123,
        amount=99.99,
        idempotency_key='order-456'  # Prevents duplicate charges
    )
    ```

    **3. Retry with exponential backoff**
    ```python
    from tenacity import retry, wait_exponential, stop_after_attempt

    @retry(wait=wait_exponential(multiplier=1, min=2, max=30),
           stop=stop_after_attempt(5))
    def call_service():
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        return response.json()
    ```

    **4. Monitor everything**
    ```python
    # Track metrics
    - Request rate
    - Error rate
    - Latency (p50, p95, p99)
    - Circuit breaker state
    - Queue depth
    ```

    **Next**: We'll explore deployment and operations - containerization with Docker, orchestration with Kubernetes, and observability strategies.
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

# Microservices in Production

    Running microservices in production requires containerization, orchestration, observability, and operational discipline.

    ## Docker Containerization

    **Containers package applications with all dependencies for consistent deployment**

    ### Why Containers?

    ```
    Problem (Traditional):
    - "Works on my machine"
    - Different environments (dev, staging, prod)
    - Dependency conflicts
    - Complex deployment

    Solution (Containers):
    - Consistent environment everywhere
    - Isolated dependencies
    - Fast startup
    - Easy scaling
    ```

    ### Dockerfile for Microservice

    ```dockerfile
    # Python microservice Dockerfile
    FROM python:3.11-slim

    # Set working directory
    WORKDIR /app

    # Install dependencies
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

    # Copy application code
    COPY . .

    # Create non-root user for security
    RUN useradd -m appuser && chown -R appuser:appuser /app
    USER appuser

    # Expose port
    EXPOSE 8000

    # Health check
    HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
      CMD python -c "import requests; requests.get('http://localhost:8000/health')"

    # Run application
    CMD ["python", "app.py"]
    ```

    ### Multi-Stage Build (Optimization)

    ```dockerfile
    # Stage 1: Build
    FROM node:18 AS builder

    WORKDIR /app
    COPY package*.json ./
    RUN npm ci --only=production

    COPY . .
    RUN npm run build

    # Stage 2: Runtime
    FROM node:18-slim

    WORKDIR /app

    # Copy only necessary files from builder
    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/node_modules ./node_modules
    COPY --from=builder /app/package*.json ./

    USER node

    EXPOSE 3000

    CMD ["node", "dist/main.js"]

    # Result: 200MB → 80MB image size!
    ```

    ### Build and Run

    ```bash
    # Build image
    docker build -t user-service:1.0 .

    # Run container
    docker run -d \
      --name user-service \
      -p 8000:8000 \
      -e DATABASE_URL=postgres://db:5432/users \
      -e REDIS_URL=redis://redis:6379 \
      user-service:1.0

    # View logs
    docker logs -f user-service

    # Execute command in container
    docker exec -it user-service bash
    ```

    ### Docker Compose (Local Development)

    ```yaml
    # docker-compose.yml
    version: '3.8'

    services:
      user-service:
        build: ./user-service
        ports:
          - "8001:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/users
          REDIS_URL: redis://redis:6379
        depends_on:
          - db
          - redis

      order-service:
        build: ./order-service
        ports:
          - "8002:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/orders
          USER_SERVICE_URL: http://user-service:8000
        depends_on:
          - db
          - user-service

      payment-service:
        build: ./payment-service
        ports:
          - "8003:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/payments

      db:
        image: postgres:15
        environment:
          POSTGRES_PASSWORD: password
        volumes:
          - postgres_data:/var/lib/postgresql/data

      redis:
        image: redis:7
        ports:
          - "6379:6379"

    volumes:
      postgres_data:
    ```

    ```bash
    # Start all services
    docker-compose up -d

    # View logs
    docker-compose logs -f user-service

    # Scale service
    docker-compose up -d --scale order-service=3

    # Stop all services
    docker-compose down
    ```

    ## Kubernetes Orchestration Basics

    **Kubernetes (K8s) automates deployment, scaling, and management of containerized applications**

    ### Why Kubernetes?

    ```
    Problems Docker doesn't solve:
    - How to scale to 100 containers?
    - How to handle failures (restart containers)?
    - How to load balance traffic?
    - How to do zero-downtime deployments?
    - How to manage configuration/secrets?

    Kubernetes solves all of these!
    ```

    ### Key Kubernetes Concepts

    **1. Pod**
    ```yaml
    # Smallest deployable unit (one or more containers)
    apiVersion: v1
    kind: Pod
    metadata:
      name: user-service-pod
    spec:
      containers:
      - name: user-service
        image: user-service:1.0
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          value: postgres://db:5432/users
    ```

    **2. Deployment**
    ```yaml
    # Manages replicas, rolling updates, rollbacks
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: user-service
    spec:
      replicas: 3  # Run 3 instances
      selector:
        matchLabels:
          app: user-service
      template:
        metadata:
          labels:
            app: user-service
        spec:
          containers:
          - name: user-service
            image: user-service:1.0
            ports:
            - containerPort: 8000
            env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: url
            resources:
              requests:
                memory: "256Mi"
                cpu: "250m"
              limits:
                memory: "512Mi"
                cpu: "500m"
            livenessProbe:  # Restart if unhealthy
              httpGet:
                path: /health
                port: 8000
              initialDelaySeconds: 10
              periodSeconds: 10
            readinessProbe:  # Don't send traffic if not ready
              httpGet:
                path: /ready
                port: 8000
              initialDelaySeconds: 5
              periodSeconds: 5
    ```

    **3. Service**
    ```yaml
    # Load balancing and service discovery
    apiVersion: v1
    kind: Service
    metadata:
      name: user-service
    spec:
      selector:
        app: user-service
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8000
      type: ClusterIP  # Internal only

    # Now other services can call: http://user-service/
    ```

    **4. ConfigMap and Secret**
    ```yaml
    # ConfigMap (non-sensitive config)
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: user-service-config
    data:
      LOG_LEVEL: "info"
      CACHE_TTL: "3600"

    ---
    # Secret (sensitive data)
    apiVersion: v1
    kind: Secret
    metadata:
      name: db-credentials
    type: Opaque
    data:
      url: cG9zdGdyZXM6Ly9kYjo1NDMyL3VzZXJz  # Base64 encoded
    ```

    **5. Ingress**
    ```yaml
    # External access and routing
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: api-ingress
    spec:
      rules:
      - host: api.example.com
        http:
          paths:
          - path: /users
            pathType: Prefix
            backend:
              service:
                name: user-service
                port:
                  number: 80
          - path: /orders
            pathType: Prefix
            backend:
              service:
                name: order-service
                port:
                  number: 80
    ```

    ### Deploy to Kubernetes

    ```bash
    # Apply configuration
    kubectl apply -f user-service-deployment.yaml
    kubectl apply -f user-service-service.yaml

    # Check status
    kubectl get pods
    kubectl get deployments
    kubectl get services

    # View logs
    kubectl logs -f deployment/user-service

    # Scale
    kubectl scale deployment user-service --replicas=5

    # Update image (rolling update)
    kubectl set image deployment/user-service user-service=user-service:1.1

    # Rollback
    kubectl rollout undo deployment/user-service

    # Execute command in pod
    kubectl exec -it user-service-pod -- bash
    ```

    ### Horizontal Pod Autoscaler

    ```yaml
    # Auto-scale based on CPU/memory
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
      name: user-service-hpa
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: user-service
      minReplicas: 2
      maxReplicas: 10
      metrics:
      - type: Resource
        resource:
          name: cpu
          target:
            type: Utilization
            averageUtilization: 70  # Scale when CPU > 70%
      - type: Resource
        resource:
          name: memory
          target:
            type: Utilization
            averageUtilization: 80  # Scale when memory > 80%
    ```

    ## Service Mesh (Istio Overview)

    **Service mesh handles service-to-service communication, security, and observability**

    ### Why Service Mesh?

    ```
    Without Service Mesh:
    - Each service implements: retries, timeouts, circuit breaking
    - Inconsistent behavior
    - Code changes required for new features

    With Service Mesh:
    - Infrastructure handles: retries, timeouts, circuit breaking
    - Consistent across all services
    - Configuration-based (no code changes)
    ```

    ### Istio Architecture

    ```
    ┌──────────────────────────────────────┐
    │  Control Plane (istiod)              │
    │  - Configuration                     │
    │  - Service discovery                 │
    │  - Certificate management            │
    └──────────────────────────────────────┘
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
    ┌────────┐  ┌────────┐  ┌────────┐
    │  Pod   │  │  Pod   │  │  Pod   │
    │ ┌────┐ │  │ ┌────┐ │  │ ┌────┐ │
    │ │App │ │  │ │App │ │  │ │App │ │
    │ └────┘ │  │ └────┘ │  │ └────┘ │
    │ ┌────┐ │  │ ┌────┐ │  │ ┌────┐ │
    │ │Envoy│ │  │ │Envoy│ │  │ │Envoy│ │  Sidecar Proxy
    │ └────┘ │  │ └────┘ │  │ └────┘ │
    └────────┘  └────────┘  └────────┘
    ```

    ### Istio Features (Configuration Examples)

    **1. Traffic Management**
    ```yaml
    # Circuit breaking
    apiVersion: networking.istio.io/v1alpha3
    kind: DestinationRule
    metadata:
      name: payment-service
    spec:
      host: payment-service
      trafficPolicy:
        connectionPool:
          tcp:
            maxConnections: 100
          http:
            http1MaxPendingRequests: 50
            maxRequestsPerConnection: 2
        outlierDetection:
          consecutiveErrors: 5
          interval: 30s
          baseEjectionTime: 30s
    ```

    **2. Retries and Timeouts**
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: user-service
    spec:
      hosts:
      - user-service
      http:
      - route:
        - destination:
            host: user-service
        timeout: 5s
        retries:
          attempts: 3
          perTryTimeout: 2s
          retryOn: 5xx,reset,connect-failure
    ```

    **3. Canary Deployments**
    ```yaml
    # Route 90% to v1, 10% to v2 (canary)
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: user-service
    spec:
      hosts:
      - user-service
      http:
      - match:
        - headers:
            user-type:
              exact: "beta"
        route:
        - destination:
            host: user-service
            subset: v2
      - route:
        - destination:
            host: user-service
            subset: v1
          weight: 90
        - destination:
            host: user-service
            subset: v2
          weight: 10
    ```

    ## Distributed Tracing (Jaeger)

    **Track requests across multiple services**

    ### The Problem

    ```
    User request fails
    Which service caused the error?
    How long did each service take?
    What was the call chain?

    Without tracing: Check logs in 10+ services → Hours of debugging
    With tracing: See entire request flow → Minutes to find issue
    ```

    ### OpenTelemetry Instrumentation

    ```python
    from opentelemetry import trace
    from opentelemetry.exporter.jaeger.thrift import JaegerExporter
    from opentelemetry.sdk.trace import TracerProvider
    from opentelemetry.sdk.trace.export import BatchSpanProcessor
    from opentelemetry.instrumentation.flask import FlaskInstrumentor
    from opentelemetry.instrumentation.requests import RequestsInstrumentor

    # Setup tracing
    trace.set_tracer_provider(TracerProvider())
    jaeger_exporter = JaegerExporter(
        agent_host_name="jaeger",
        agent_port=6831,
    )
    trace.get_tracer_provider().add_span_processor(
        BatchSpanProcessor(jaeger_exporter)
    )

    # Auto-instrument Flask
    FlaskInstrumentor().instrument_app(app)

    # Auto-instrument requests library
    RequestsInstrumentor().instrument()

    # Manual instrumentation
    tracer = trace.get_tracer(__name__)

    @app.route('/create-order')
    def create_order():
        with tracer.start_as_current_span("create_order") as span:
            span.set_attribute("user_id", user_id)
            span.set_attribute("items_count", len(items))

            # This call automatically traced (requests instrumented)
            user = requests.get(f'http://user-service/users/{user_id}')

            # Custom span
            with tracer.start_as_current_span("save_to_database"):
                order = db.save_order(user_id, items)

            span.set_attribute("order_id", order.id)

            return order
    ```

    **Trace visualization in Jaeger:**
    ```
    Trace ID: abc123
    Total duration: 250ms

    → API Gateway (5ms)
      → Order Service (200ms)
        → User Service (50ms)
          → Database query (30ms)
        → Payment Service (100ms)  ← Slow! Found the issue!
          → Payment gateway API (95ms)
        → Inventory Service (30ms)
    ```

    ## Centralized Logging (ELK Stack)

    **Aggregate logs from all services in one place**

    ### ELK Stack Components

    ```
    Services → Filebeat/Fluentd → Logstash → Elasticsearch → Kibana
                 (Collect)       (Process)   (Store)        (Visualize)
    ```

    ### Structured Logging

    ```python
    import structlog
    import logging

    # Configure structured logging
    structlog.configure(
        processors=[
            structlog.stdlib.filter_by_level,
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.JSONRenderer()
        ],
        context_class=dict,
        logger_factory=structlog.stdlib.LoggerFactory(),
    )

    logger = structlog.get_logger()

    # Structured log (JSON)
    @app.route('/orders/<order_id>')
    def get_order(order_id):
        logger.info(
            "fetching_order",
            order_id=order_id,
            user_id=current_user.id,
            service="order-service"
        )

        try:
            order = db.get_order(order_id)

            logger.info(
                "order_fetched",
                order_id=order_id,
                status=order.status,
                duration_ms=10
            )

            return order

        except Exception as e:
            logger.error(
                "order_fetch_failed",
                order_id=order_id,
                error=str(e),
                exc_info=True
            )
            raise

    # Output (JSON):
    # {
    #   "event": "fetching_order",
    #   "order_id": "123",
    #   "user_id": "456",
    #   "service": "order-service",
    #   "timestamp": "2024-01-15T10:30:00.000Z",
    #   "level": "info"
    # }
    ```

    ### Log Aggregation with Fluentd

    ```yaml
    # fluentd-daemonset.yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: fluentd
    spec:
      template:
        spec:
          containers:
          - name: fluentd
            image: fluent/fluentd-kubernetes-daemonset:v1-debian-elasticsearch
            env:
            - name: FLUENT_ELASTICSEARCH_HOST
              value: "elasticsearch"
            - name: FLUENT_ELASTICSEARCH_PORT
              value: "9200"
            volumeMounts:
            - name: varlog
              mountPath: /var/log
            - name: containers
              mountPath: /var/lib/docker/containers
          volumes:
          - name: varlog
            hostPath:
              path: /var/log
          - name: containers
            hostPath:
              path: /var/lib/docker/containers

    # Fluentd collects logs from all pods and sends to Elasticsearch
    ```

    ### Query Logs in Kibana

    ```
    # Find all errors in last hour
    level:error AND @timestamp:[now-1h TO now]

    # Find specific order
    order_id:"123"

    # Find slow requests
    duration_ms:>1000

    # Find errors from specific service
    service:"payment-service" AND level:error
    ```

    ## Monitoring and Observability

    ### Prometheus Metrics

    ```python
    from prometheus_client import Counter, Histogram, Gauge, start_http_server

    # Define metrics
    request_count = Counter(
        'http_requests_total',
        'Total HTTP requests',
        ['method', 'endpoint', 'status']
    )

    request_duration = Histogram(
        'http_request_duration_seconds',
        'HTTP request duration',
        ['method', 'endpoint']
    )

    active_users = Gauge(
        'active_users',
        'Number of active users'
    )

    # Instrument application
    @app.route('/orders')
    def list_orders():
        # Increment counter
        request_count.labels(method='GET', endpoint='/orders', status=200).inc()

        # Track duration
        with request_duration.labels(method='GET', endpoint='/orders').time():
            orders = db.get_orders()

        return orders

    # Update gauge
    active_users.set(len(get_active_users()))

    # Expose metrics endpoint
    start_http_server(8001)  # Metrics at http://localhost:8001/metrics
    ```

    ### Grafana Dashboards

    ```
    Key metrics to monitor:

    1. Golden Signals:
       - Latency (request duration)
       - Traffic (requests per second)
       - Errors (error rate)
       - Saturation (CPU, memory usage)

    2. Service-specific:
       - Queue depth (message queues)
       - Cache hit rate
       - Database connection pool
       - Circuit breaker state

    3. Business metrics:
       - Orders per minute
       - Revenue per hour
       - User signups
    ```

    ## Common Challenges and Solutions

    ### 1. Service Discovery Issues

    ```python
    # Problem: Service address changes
    # Solution: Use Kubernetes DNS
    user_service_url = "http://user-service"  # Not IP address!
    ```

    ### 2. Configuration Management

    ```python
    # Problem: Different config per environment
    # Solution: Use ConfigMaps/Secrets + environment variables
    DATABASE_URL = os.getenv('DATABASE_URL')
    ```

    ### 3. Debugging Distributed Systems

    ```python
    # Problem: Request fails, which service?
    # Solution: Correlation IDs + Distributed tracing
    import uuid

    @app.before_request
    def add_correlation_id():
        # Generate or get correlation ID
        correlation_id = request.headers.get('X-Correlation-ID', str(uuid.uuid4()))
        g.correlation_id = correlation_id
        logger.info("request_started", correlation_id=correlation_id)

    @app.after_request
    def add_correlation_header(response):
        response.headers['X-Correlation-ID'] = g.correlation_id
        return response
    ```

    ### 4. Zero-Downtime Deployments

    ```yaml
    # Rolling update strategy
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxUnavailable: 0      # Don't kill pods before new ones ready
          maxSurge: 1            # Create 1 extra pod during update

      # Graceful shutdown
      containers:
      - name: app
        lifecycle:
          preStop:
            exec:
              command: ["/bin/sh", "-c", "sleep 15"]  # Allow requests to drain
    ```

    ### 5. Database Migrations

    ```python
    # Problem: Schema changes with zero downtime
    # Solution: Backward-compatible migrations

    # Bad: Breaks old version
    ALTER TABLE users DROP COLUMN phone;

    # Good: Multi-step migration
    # Step 1: Deploy code that doesn't use 'phone'
    # Step 2: Deploy migration that drops column
    ```

    ## Production Checklist

    ✅ **Before going to production:**

    - [ ] Health check endpoints implemented
    - [ ] Graceful shutdown handling
    - [ ] Resource limits set (CPU, memory)
    - [ ] Logging configured (structured, JSON)
    - [ ] Metrics exposed (Prometheus)
    - [ ] Distributed tracing enabled
    - [ ] Circuit breakers on external calls
    - [ ] Timeouts on all network calls
    - [ ] Retries with exponential backoff
    - [ ] Database connection pooling
    - [ ] Secrets in Secret manager (not code)
    - [ ] TLS/HTTPS enabled
    - [ ] Auto-scaling configured
    - [ ] Monitoring alerts set up
    - [ ] Runbooks for common issues
    - [ ] Disaster recovery plan
    - [ ] Load testing completed

    **Congratulations!** You now understand the fundamentals of microservices architecture - from principles and communication patterns to production deployment. The key is to start simple, add complexity only when needed, and always design for failure.
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

# Microservices Architecture Principles

    **Microservices** is an architectural style that structures an application as a collection of small, autonomous services organized around business capabilities.

    ## Monolith vs Microservices

    ### Monolithic Architecture

    **All components in a single codebase and deployment unit**

    ```
    ┌─────────────────────────────────────┐
    │         Monolithic Application      │
    │  ┌──────────┬──────────┬─────────┐ │
    │  │   User   │ Product  │ Payment │ │
    │  │ Service  │ Service  │ Service │ │
    │  └──────────┴──────────┴─────────┘ │
    │  ┌──────────────────────────────┐  │
    │  │      Shared Database         │  │
    │  └──────────────────────────────┘  │
    └─────────────────────────────────────┘
    ```

    ✅ **Advantages:**
    - Simple to develop initially
    - Easy to test (everything together)
    - Simple deployment (single unit)
    - No network latency between components
    - ACID transactions work easily
    - Straightforward debugging

    ❌ **Disadvantages:**
    - Tight coupling (change one thing, test everything)
    - Scaling limitations (must scale entire app)
    - Technology lock-in (one language/framework)
    - Long deployment cycles
    - Large codebase becomes hard to understand
    - Single point of failure

    ### Microservices Architecture

    **Multiple independent services, each with own database**

    ```
    ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
    │    User     │  │   Product   │  │   Payment   │
    │   Service   │  │   Service   │  │   Service   │
    ├─────────────┤  ├─────────────┤  ├─────────────┤
    │   User DB   │  │ Product DB  │  │ Payment DB  │
    └─────────────┘  └─────────────┘  └─────────────┘
         ↑                ↑                 ↑
         └────────────────┴─────────────────┘
                  API Gateway / Service Mesh
    ```

    ✅ **Advantages:**
    - Independent scaling (scale what you need)
    - Technology diversity (right tool per service)
    - Faster deployments (deploy one service)
    - Fault isolation (one service fails, others run)
    - Team autonomy (teams own services)
    - Easier to understand (smaller codebases)

    ❌ **Disadvantages:**
    - Distributed system complexity
    - Network latency between services
    - Distributed transactions are hard
    - Testing is more complex
    - Deployment complexity (many services)
    - Data consistency challenges
    - Debugging is harder

    ## When to Use Microservices (and When NOT to)

    ### ✅ Use Microservices When:

    **1. Application has grown too large**
    ```
    - 100K+ lines of code
    - 20+ developers
    - Multiple teams working on same codebase
    - Frequent merge conflicts
    ```

    **2. Different scaling requirements**
    ```python
    # Example: E-commerce platform
    - Product catalog: Read-heavy, needs 10 servers
    - Order processing: Write-heavy, needs 2 servers
    - Image processing: CPU-intensive, needs GPU servers

    # Microservices: Scale each independently
    # Monolith: Must scale entire app (wasteful)
    ```

    **3. Need for technology diversity**
    ```
    - User service: Node.js (I/O intensive)
    - Recommendation engine: Python (ML libraries)
    - Payment processing: Java (enterprise libraries)
    - Real-time chat: Go (concurrency)
    ```

    **4. Independent deployment needed**
    ```
    - Update payment service without redeploying entire app
    - Deploy new features faster
    - Reduce risk (smaller deployments)
    ```

    **5. Team structure supports it**
    ```
    - Multiple teams
    - Each team can own a service
    - Clear domain boundaries
    ```

    ### ❌ DON'T Use Microservices When:

    **1. Small application**
    ```python
    # Simple blog application
    - 1-3 developers
    - Simple CRUD operations
    - Low traffic

    # Verdict: Monolith is perfect!
    # Microservices would be over-engineering
    ```

    **2. Unclear domain boundaries**
    ```
    - Don't know how to split services yet
    - Requirements still changing rapidly
    - Domain not well understood

    # Start with monolith, extract services later!
    ```

    **3. Limited operational capability**
    ```
    - No DevOps expertise
    - No container orchestration (Kubernetes)
    - Small team (1-5 developers)
    - Limited monitoring/logging infrastructure

    # Microservices require operational maturity
    ```

    **4. Performance-critical application**
    ```
    - Sub-millisecond latency required
    - In-process calls needed
    - Complex transactions across components

    # Network calls add latency
    ```

    ## Service Boundaries and Domain-Driven Design

    ### Domain-Driven Design (DDD)

    **Define service boundaries based on business domains**

    ```
    E-commerce Platform Domains:

    ┌─────────────────────────────────────────────────┐
    │  User Management (Bounded Context)              │
    │  - User registration                            │
    │  - Authentication                               │
    │  - Profile management                           │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Product Catalog (Bounded Context)              │
    │  - Product listings                             │
    │  - Search                                       │
    │  - Categories                                   │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Order Management (Bounded Context)             │
    │  - Shopping cart                                │
    │  - Order placement                              │
    │  - Order tracking                               │
    └─────────────────────────────────────────────────┘

    ┌─────────────────────────────────────────────────┐
    │  Payment Processing (Bounded Context)           │
    │  - Payment methods                              │
    │  - Transaction processing                       │
    │  - Refunds                                      │
    └─────────────────────────────────────────────────┘
    ```

    ### Identifying Service Boundaries

    **Ask these questions:**

    1. **Single Responsibility**: Does the service have one clear purpose?
    2. **Cohesion**: Do related functions belong together?
    3. **Coupling**: Can it change independently?
    4. **Data Ownership**: Does it own its data?

    **Example: Order Service**
    ```python
    # Good: Clear boundary
    class OrderService:
        def create_order(user_id, items)
        def get_order(order_id)
        def cancel_order(order_id)
        def update_order_status(order_id, status)

    # Bad: Doing too much
    class OrderService:
        def create_order(...)
        def process_payment(...)      # Payment service!
        def send_email(...)            # Notification service!
        def update_inventory(...)      # Inventory service!
    ```

    ### Service Size: How Small is "Micro"?

    **Not about lines of code, but about purpose**

    ```python
    # Too small (nano-services)
    class AddService:
        def add(a, b):
            return a + b

    class SubtractService:
        def subtract(a, b):
            return a - b

    # Too big (mini-monolith)
    class EverythingService:
        def handle_users(...)
        def handle_products(...)
        def handle_orders(...)
        def handle_payments(...)

    # Just right
    class OrderService:
        # Manages entire order lifecycle
        # ~2000-5000 lines of code
        # One team can understand and maintain it
    ```

    ## Communication Patterns (Sync vs Async)

    ### Synchronous Communication (Request-Response)

    **Service waits for response**

    ```python
    # HTTP/REST example
    def create_order(user_id, items):
        # Synchronous call to user service
        user = http_client.get(f'http://user-service/users/{user_id}')

        if not user:
            return {'error': 'User not found'}, 404

        # Synchronous call to product service
        products = http_client.post('http://product-service/validate',
                                    json={'items': items})

        # Create order
        order = db.save_order(user_id, items)

        # Synchronous call to payment service
        payment = http_client.post('http://payment-service/charge',
                                  json={'order_id': order.id, 'amount': order.total})

        return order
    ```

    ✅ **Pros:**
    - Simple to understand
    - Immediate response
    - Easy error handling
    - Natural request-response flow

    ❌ **Cons:**
    - Tight coupling (service must be available)
    - Cascading failures (one service down = all fail)
    - Higher latency (sequential calls)
    - Reduced availability

    **When to use:**
    - Need immediate response
    - Simple queries
    - Critical operations (payments)

    ### Asynchronous Communication (Events/Messages)

    **Service doesn't wait for response**

    ```python
    # Event-driven example
    def create_order(user_id, items):
        # Create order
        order = db.save_order(user_id, items, status='PENDING')

        # Publish event (non-blocking)
        event_bus.publish('order.created', {
            'order_id': order.id,
            'user_id': user_id,
            'items': items,
            'total': order.total
        })

        return order  # Return immediately!

    # Other services react to events (independently)
    @event_bus.subscribe('order.created')
    def handle_order_payment(event):
        # Payment service processes payment
        process_payment(event['order_id'], event['total'])

    @event_bus.subscribe('order.created')
    def handle_order_notification(event):
        # Notification service sends email
        send_order_confirmation_email(event['user_id'], event['order_id'])

    @event_bus.subscribe('order.created')
    def handle_inventory_update(event):
        # Inventory service updates stock
        update_inventory(event['items'])
    ```

    ✅ **Pros:**
    - Loose coupling (services independent)
    - Better fault tolerance
    - Natural for workflows
    - Easier to add new services

    ❌ **Cons:**
    - Eventual consistency
    - Complex debugging
    - Message ordering issues
    - Requires message infrastructure

    **When to use:**
    - Long-running operations
    - Fire-and-forget operations
    - Fan-out scenarios (notify multiple services)
    - High availability requirements

    ## API Gateway Pattern

    **Single entry point for all client requests**

    ```
              Clients (Web, Mobile, IoT)
                        │
                        ▼
              ┌─────────────────┐
              │   API Gateway   │
              │  - Routing      │
              │  - Auth         │
              │  - Rate limit   │
              │  - Aggregation  │
              └────────┬────────┘
                       │
           ┌───────────┼───────────┬──────────┐
           │           │           │          │
           ▼           ▼           ▼          ▼
      ┌────────┐  ┌────────┐  ┌────────┐  ┌────────┐
      │  User  │  │Product │  │ Order  │  │Payment │
      │Service │  │Service │  │Service │  │Service │
      └────────┘  └────────┘  └────────┘  └────────┘
    ```

    ### API Gateway Responsibilities

    **1. Request Routing**
    ```python
    # Route requests to appropriate services
    @gateway.route('/users/*')
    def route_to_user_service(request):
        return forward_to('user-service', request)

    @gateway.route('/products/*')
    def route_to_product_service(request):
        return forward_to('product-service', request)
    ```

    **2. Authentication & Authorization**
    ```python
    @gateway.before_request
    def authenticate():
        token = request.headers.get('Authorization')
        user = verify_jwt_token(token)

        if not user:
            return {'error': 'Unauthorized'}, 401

        request.user = user  # Attach to request
    ```

    **3. Rate Limiting**
    ```python
    @gateway.route('/api/*')
    @rate_limit(limit=1000, per=3600)  # 1000 requests/hour
    def handle_api_request(request):
        return forward_request(request)
    ```

    **4. Request Aggregation**
    ```python
    # Single request to gateway → Multiple service calls
    @gateway.route('/user-dashboard/:user_id')
    async def get_dashboard(user_id):
        # Call multiple services in parallel
        user, orders, recommendations = await asyncio.gather(
            http_client.get(f'user-service/users/{user_id}'),
            http_client.get(f'order-service/users/{user_id}/orders'),
            http_client.get(f'recommendation-service/users/{user_id}')
        )

        return {
            'user': user,
            'recent_orders': orders,
            'recommendations': recommendations
        }
    ```

    **5. Protocol Translation**
    ```python
    # Client uses REST, service uses gRPC
    @gateway.route('/products', methods=['GET'])
    def get_products():
        # Translate REST to gRPC
        grpc_response = product_grpc_client.GetProducts()

        # Convert to JSON
        return json_format.MessageToDict(grpc_response)
    ```

    **Popular API Gateways:**
    - Kong
    - AWS API Gateway
    - Nginx
    - Envoy
    - Traefik

    ## Service Discovery

    **How services find each other in dynamic environments**

    ### The Problem

    ```
    Problem: Service addresses change constantly
    - Containers restart → New IP addresses
    - Auto-scaling → New instances added/removed
    - Health issues → Instances removed

    How does Order Service find Payment Service?
    ```

    ### Client-Side Discovery

    **Client queries service registry and load balances**

    ```python
    # Service Registry (Consul, Eureka, etcd)
    registry = {
        'payment-service': [
            '10.0.1.5:8000',
            '10.0.1.6:8000',
            '10.0.1.7:8000'
        ]
    }

    # Client-side discovery
    class ServiceClient:
        def call_service(self, service_name, path):
            # 1. Query registry for available instances
            instances = registry.get(service_name)

            # 2. Client-side load balancing
            instance = random.choice(instances)

            # 3. Make request
            return http_client.get(f'http://{instance}{path}')

    # Usage
    client = ServiceClient()
    payment = client.call_service('payment-service', '/charge')
    ```

    ✅ Simple, no additional infrastructure
    ❌ Client must implement discovery logic

    ### Server-Side Discovery

    **Load balancer queries service registry**

    ```
    ┌──────────┐
    │  Client  │
    └────┬─────┘
         │
         ▼
    ┌─────────────┐      ┌──────────────────┐
    │Load Balancer│─────▶│ Service Registry │
    └──────┬──────┘      └──────────────────┘
           │
           ├──────────┬──────────┬──────────┐
           ▼          ▼          ▼          ▼
      Instance1  Instance2  Instance3  Instance4
    ```

    **Example: Kubernetes Service Discovery**
    ```yaml
    # Kubernetes Service automatically discovers pods
    apiVersion: v1
    kind: Service
    metadata:
      name: payment-service
    spec:
      selector:
        app: payment
      ports:
        - port: 80
          targetPort: 8000

    # Application code (simple!)
    # Kubernetes DNS resolves payment-service to actual pod IPs
    payment = http_client.get('http://payment-service/charge')
    ```

    ✅ Simpler client code
    ✅ Centralized logic
    ❌ Additional infrastructure (load balancer)

    ### Service Registration

    **How services register themselves**

    **Self-Registration**
    ```python
    # Service registers itself on startup
    class PaymentService:
        def start(self):
            # Register with service registry
            registry.register(
                service_name='payment-service',
                address=f'{self.host}:{self.port}',
                health_check_url=f'http://{self.host}:{self.port}/health'
            )

            # Start HTTP server
            self.run()

        def shutdown(self):
            # Deregister on shutdown
            registry.deregister('payment-service', f'{self.host}:{self.port}')
    ```

    **Third-Party Registration (Kubernetes)**
    ```yaml
    # Kubernetes automatically registers/deregisters pods
    # No code changes needed!
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: payment-service
    spec:
      replicas: 3
      template:
        spec:
          containers:
          - name: payment
            image: payment-service:1.0
            ports:
            - containerPort: 8000
    ```

    ## Real-World Examples

    ### Netflix

    **One of the largest microservices deployments**

    ```
    Services: 700+
    Requests: Billions per day
    Engineers: 1000s

    Architecture:
    - Eureka: Service discovery
    - Zuul: API Gateway
    - Ribbon: Client-side load balancing
    - Hystrix: Circuit breaker
    - AWS: Infrastructure
    ```

    **Benefits achieved:**
    - Deploy 100s of times per day
    - Scale services independently
    - Technology diversity (Java, Node.js, Python)
    - Global deployment

    ### Uber

    **Microservices for ride-sharing platform**

    ```
    Core Services:
    - Rider Service (mobile app backend)
    - Driver Service (driver app backend)
    - Trip Service (manage trips)
    - Routing Service (calculate routes)
    - Pricing Service (surge pricing)
    - Dispatch Service (match riders/drivers)
    - Payment Service (process payments)

    Communication:
    - Synchronous: REST, gRPC (real-time)
    - Asynchronous: Kafka (events, analytics)
    ```

    **Key learnings:**
    - Start with monolith, extract services gradually
    - Strong service ownership (team per service)
    - Invest in observability early

    ### Amazon

    **Pioneered microservices (2001)**

    ```
    "Two-pizza teams"
    - Team small enough to feed with 2 pizzas
    - Each team owns a service
    - Full autonomy (build, deploy, operate)

    Results:
    - Faster innovation
    - Independent deployments
    - Better fault isolation
    ```

    ## Best Practices

    **1. Start with a Monolith**
    ```
    - Build monolith first
    - Learn domain boundaries
    - Extract services when needed
    - Don't over-engineer early
    ```

    **2. Design for Failure**
    ```python
    # Always assume services can fail
    try:
        recommendations = recommendation_service.get(user_id)
    except ServiceUnavailable:
        # Fallback: Show default recommendations
        recommendations = get_popular_products()
    ```

    **3. Decentralize Everything**
    ```
    - Decentralized data (each service owns data)
    - Decentralized governance (teams choose tech)
    - Decentralized deployment (deploy independently)
    ```

    **4. Build Observable Systems**
    ```python
    # Logging, metrics, tracing from day 1
    @app.route('/checkout')
    def checkout():
        logger.info('Checkout started', user_id=user.id)
        metrics.increment('checkout.started')

        with tracer.start_span('checkout'):
            result = process_checkout()

        return result
    ```

    **5. Automate Everything**
    ```
    - CI/CD pipelines
    - Automated testing
    - Automated deployment
    - Automated monitoring
    ```

    **Next**: We'll explore inter-service communication patterns in depth, including REST, gRPC, message queues, and handling distributed transactions.
  MARKDOWN
  sequence_order: 4,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 5: Lesson 5 ===
lesson_5 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 5',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Communication Patterns

    In microservices, services must communicate over the network. Choosing the right communication pattern is critical for performance, reliability, and maintainability.

    ## REST APIs Between Services

    **RESTful HTTP is the most common synchronous communication pattern**

    ### Basic REST Communication

    ```python
    # Order Service → User Service (REST)
    import requests

    class UserServiceClient:
        def __init__(self, base_url):
            self.base_url = base_url

        def get_user(self, user_id):
            response = requests.get(
                f'{self.base_url}/users/{user_id}',
                timeout=5  # Important: Always set timeout!
            )

            response.raise_for_status()  # Raise on 4xx/5xx
            return response.json()

        def update_user(self, user_id, data):
            response = requests.put(
                f'{self.base_url}/users/{user_id}',
                json=data,
                timeout=5
            )

            response.raise_for_status()
            return response.json()

    # Usage in Order Service
    user_client = UserServiceClient('http://user-service:8000')

    def create_order(user_id, items):
        # Verify user exists
        try:
            user = user_client.get_user(user_id)
        except requests.HTTPError as e:
            if e.response.status_code == 404:
                return {'error': 'User not found'}, 404
            raise

        # Create order
        order = db.save_order(user_id, items)
        return order
    ```

    ### REST API Design Best Practices

    **1. Use Resource-Based URLs**
    ```
    ✅ Good:
    GET    /users/123           (get user)
    POST   /users               (create user)
    PUT    /users/123           (update user)
    DELETE /users/123           (delete user)
    GET    /users/123/orders    (get user's orders)

    ❌ Bad:
    GET    /getUser?id=123
    POST   /createUser
    POST   /updateUser
    POST   /deleteUser
    ```

    **2. Use HTTP Methods Correctly**
    ```
    GET    - Read (idempotent, safe)
    POST   - Create
    PUT    - Update/Replace (idempotent)
    PATCH  - Partial update
    DELETE - Delete (idempotent)
    ```

    **3. Use Proper Status Codes**
    ```python
    # Success codes
    200 OK           # Successful GET, PUT, PATCH
    201 Created      # Successful POST
    204 No Content   # Successful DELETE

    # Client error codes
    400 Bad Request      # Invalid input
    401 Unauthorized     # Missing/invalid auth
    403 Forbidden        # Insufficient permissions
    404 Not Found        # Resource doesn't exist
    409 Conflict         # Duplicate/conflict
    422 Unprocessable    # Validation error

    # Server error codes
    500 Internal Server Error
    502 Bad Gateway          # Upstream service error
    503 Service Unavailable  # Temporary overload
    504 Gateway Timeout      # Upstream timeout
    ```

    **4. Version Your APIs**
    ```python
    # URL versioning
    GET /api/v1/users/123
    GET /api/v2/users/123

    # Header versioning
    GET /api/users/123
    Accept: application/vnd.myapp.v1+json

    # Maintain backward compatibility!
    # Support old versions during migration
    ```

    ### REST Challenges

    ❌ **Problems:**
    - **Verbose**: JSON over HTTP has overhead
    - **Latency**: HTTP/1.1 has limitations
    - **No type safety**: Client doesn't know schema
    - **Over/under-fetching**: Can't customize response

    ## gRPC for Performance

    **gRPC uses Protocol Buffers (binary format) and HTTP/2 for high-performance RPC**

    ### Why gRPC?

    ```
    Comparison (10,000 requests):

    REST (JSON over HTTP/1.1):
    - Payload: 500 bytes (JSON)
    - Latency: 50ms
    - Throughput: 5,000 req/sec

    gRPC (Protobuf over HTTP/2):
    - Payload: 150 bytes (binary)
    - Latency: 10ms
    - Throughput: 25,000 req/sec

    gRPC is 3-5x faster!
    ```

    ### Define Service with Protocol Buffers

    ```protobuf
    // user_service.proto
    syntax = "proto3";

    package user;

    // Service definition
    service UserService {
      rpc GetUser(GetUserRequest) returns (User);
      rpc CreateUser(CreateUserRequest) returns (User);
      rpc UpdateUser(UpdateUserRequest) returns (User);
      rpc ListUsers(ListUsersRequest) returns (stream User);  // Streaming!
    }

    // Messages
    message User {
      int64 id = 1;
      string email = 2;
      string name = 3;
      string created_at = 4;
    }

    message GetUserRequest {
      int64 id = 1;
    }

    message CreateUserRequest {
      string email = 1;
      string name = 2;
    }

    message UpdateUserRequest {
      int64 id = 1;
      string email = 2;
      string name = 3;
    }

    message ListUsersRequest {
      int32 page = 1;
      int32 page_size = 2;
    }
    ```

    ### Generate Code

    ```bash
    # Generate Python code from proto file
    python -m grpc_tools.protoc \
      -I. \
      --python_out=. \
      --grpc_python_out=. \
      user_service.proto

    # Generates:
    # - user_service_pb2.py (messages)
    # - user_service_pb2_grpc.py (service stubs)
    ```

    ### Implement gRPC Server

    ```python
    import grpc
    from concurrent import futures
    import user_service_pb2
    import user_service_pb2_grpc

    class UserServiceServicer(user_service_pb2_grpc.UserServiceServicer):
        def GetUser(self, request, context):
            # Get user from database
            user_data = db.get_user(request.id)

            if not user_data:
                context.set_code(grpc.StatusCode.NOT_FOUND)
                context.set_details('User not found')
                return user_service_pb2.User()

            # Return protobuf message
            return user_service_pb2.User(
                id=user_data['id'],
                email=user_data['email'],
                name=user_data['name'],
                created_at=user_data['created_at']
            )

        def CreateUser(self, request, context):
            # Validate
            if not request.email:
                context.set_code(grpc.StatusCode.INVALID_ARGUMENT)
                context.set_details('Email is required')
                return user_service_pb2.User()

            # Create user
            user_id = db.create_user(request.email, request.name)
            user_data = db.get_user(user_id)

            return user_service_pb2.User(
                id=user_data['id'],
                email=user_data['email'],
                name=user_data['name'],
                created_at=user_data['created_at']
            )

        def ListUsers(self, request, context):
            # Server-side streaming
            users = db.get_users(
                page=request.page,
                page_size=request.page_size
            )

            for user_data in users:
                yield user_service_pb2.User(
                    id=user_data['id'],
                    email=user_data['email'],
                    name=user_data['name'],
                    created_at=user_data['created_at']
                )

    # Start server
    def serve():
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
        user_service_pb2_grpc.add_UserServiceServicer_to_server(
            UserServiceServicer(), server
        )
        server.add_insecure_port('[::]:50051')
        server.start()
        server.wait_for_termination()

    if __name__ == '__main__':
        serve()
    ```

    ### Implement gRPC Client

    ```python
    import grpc
    import user_service_pb2
    import user_service_pb2_grpc

    class UserServiceClient:
        def __init__(self, host, port):
            # Create channel
            self.channel = grpc.insecure_channel(f'{host}:{port}')
            # Create stub (client)
            self.stub = user_service_pb2_grpc.UserServiceStub(self.channel)

        def get_user(self, user_id):
            request = user_service_pb2.GetUserRequest(id=user_id)

            try:
                response = self.stub.GetUser(request, timeout=5)
                return {
                    'id': response.id,
                    'email': response.email,
                    'name': response.name,
                    'created_at': response.created_at
                }
            except grpc.RpcError as e:
                if e.code() == grpc.StatusCode.NOT_FOUND:
                    return None
                raise

        def create_user(self, email, name):
            request = user_service_pb2.CreateUserRequest(
                email=email,
                name=name
            )
            response = self.stub.CreateUser(request, timeout=5)
            return response

        def list_users(self, page=1, page_size=10):
            request = user_service_pb2.ListUsersRequest(
                page=page,
                page_size=page_size
            )

            # Receive stream
            users = []
            for user in self.stub.ListUsers(request):
                users.append({
                    'id': user.id,
                    'email': user.email,
                    'name': user.name
                })

            return users

    # Usage
    client = UserServiceClient('user-service', 50051)
    user = client.get_user(123)
    ```

    ### gRPC Features

    **1. Four types of RPC**
    ```protobuf
    service MyService {
      // Unary: Single request, single response
      rpc GetUser(GetUserRequest) returns (User);

      // Server streaming: Single request, stream responses
      rpc ListUsers(ListUsersRequest) returns (stream User);

      // Client streaming: Stream requests, single response
      rpc CreateUsers(stream CreateUserRequest) returns (CreateUsersResponse);

      // Bidirectional streaming: Stream both ways
      rpc Chat(stream ChatMessage) returns (stream ChatMessage);
    }
    ```

    **2. Built-in features**
    - Load balancing
    - Retries
    - Timeouts
    - Deadlines
    - Cancellation
    - Authentication (TLS, JWT)

    **gRPC vs REST:**

    | Feature | REST | gRPC |
    |---------|------|------|
    | Format | JSON (text) | Protobuf (binary) |
    | Performance | Slower | 3-5x faster |
    | Browser support | Yes | Limited |
    | Streaming | No (HTTP/1.1) | Yes (HTTP/2) |
    | Type safety | No | Yes |
    | Learning curve | Easy | Medium |

    **When to use gRPC:**
    - Internal microservices communication
    - Performance-critical services
    - Real-time/streaming data
    - Polyglot environments (language-agnostic)

    **When to use REST:**
    - Public APIs
    - Browser clients
    - Simple CRUD operations
    - When JSON is preferred

    ## Message Queues (RabbitMQ, Kafka)

    **Asynchronous communication via message brokers**

    ### Why Message Queues?

    ```
    Problem (Synchronous):
    Order Service → (HTTP) → Email Service

    Issues:
    - Order Service waits for email to send
    - If Email Service down, order fails
    - Tight coupling

    Solution (Asynchronous):
    Order Service → (Publish message) → Queue → Email Service

    Benefits:
    - Order Service doesn't wait
    - Email Service processes when ready
    - Loose coupling
    - Email Service can be down temporarily
    ```

    ### RabbitMQ (Message Queue)

    **Traditional message queue with exchanges and queues**

    ```python
    import pika

    # Producer (Order Service)
    class OrderEventPublisher:
        def __init__(self):
            connection = pika.BlockingConnection(
                pika.ConnectionParameters('rabbitmq')
            )
            self.channel = connection.channel()

            # Declare exchange
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True
            )

        def publish_order_created(self, order):
            message = {
                'order_id': order.id,
                'user_id': order.user_id,
                'items': order.items,
                'total': order.total,
                'timestamp': time.time()
            }

            self.channel.basic_publish(
                exchange='orders',
                routing_key='order.created',
                body=json.dumps(message),
                properties=pika.BasicProperties(
                    delivery_mode=2,  # Persistent message
                )
            )

            print(f"Published order.created: {order.id}")

    # Consumer (Email Service)
    class OrderEventConsumer:
        def __init__(self):
            connection = pika.BlockingConnection(
                pika.ConnectionParameters('rabbitmq')
            )
            self.channel = connection.channel()

            # Declare exchange
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True
            )

            # Declare queue
            result = self.channel.queue_declare(
                queue='email_service_queue',
                durable=True
            )

            # Bind queue to exchange
            self.channel.queue_bind(
                exchange='orders',
                queue='email_service_queue',
                routing_key='order.created'
            )

        def start_consuming(self):
            self.channel.basic_consume(
                queue='email_service_queue',
                on_message_callback=self.handle_order_created
            )

            print('Waiting for messages...')
            self.channel.start_consuming()

        def handle_order_created(self, ch, method, properties, body):
            message = json.loads(body)

            try:
                # Send email
                send_order_confirmation_email(
                    order_id=message['order_id'],
                    user_id=message['user_id']
                )

                # Acknowledge message (remove from queue)
                ch.basic_ack(delivery_tag=method.delivery_tag)

                print(f"Processed order: {message['order_id']}")

            except Exception as e:
                # Reject message, requeue for retry
                ch.basic_nack(
                    delivery_tag=method.delivery_tag,
                    requeue=True
                )
                print(f"Failed to process order: {e}")

    # Start consumer
    consumer = OrderEventConsumer()
    consumer.start_consuming()
    ```

    ### Kafka (Event Streaming Platform)

    **Distributed log for high-throughput event streaming**

    ```python
    from kafka import KafkaProducer, KafkaConsumer

    # Producer (Order Service)
    class OrderEventProducer:
        def __init__(self):
            self.producer = KafkaProducer(
                bootstrap_servers=['kafka:9092'],
                value_serializer=lambda v: json.dumps(v).encode('utf-8')
            )

        def publish_order_created(self, order):
            event = {
                'order_id': order.id,
                'user_id': order.user_id,
                'items': order.items,
                'total': order.total,
                'timestamp': time.time()
            }

            # Send to Kafka topic
            future = self.producer.send(
                'order-events',
                key=str(order.id).encode('utf-8'),  # Partition by order_id
                value=event
            )

            # Block until sent (or use async)
            future.get(timeout=10)

            print(f"Published to Kafka: {order.id}")

    # Consumer (Email Service)
    class OrderEventConsumer:
        def __init__(self):
            self.consumer = KafkaConsumer(
                'order-events',
                bootstrap_servers=['kafka:9092'],
                group_id='email-service',  # Consumer group
                value_deserializer=lambda m: json.loads(m.decode('utf-8')),
                auto_offset_reset='earliest',  # Start from beginning
                enable_auto_commit=False  # Manual commit
            )

        def start_consuming(self):
            for message in self.consumer:
                try:
                    event = message.value

                    # Process event
                    send_order_confirmation_email(
                        order_id=event['order_id'],
                        user_id=event['user_id']
                    )

                    # Commit offset (mark as processed)
                    self.consumer.commit()

                    print(f"Processed: {event['order_id']}")

                except Exception as e:
                    print(f"Error processing message: {e}")
                    # Don't commit - will retry

    # Multiple consumers in same group (load balancing)
    # Each message processed by one consumer in group
    consumer = OrderEventConsumer()
    consumer.start_consuming()
    ```

    **RabbitMQ vs Kafka:**

    | Feature | RabbitMQ | Kafka |
    |---------|----------|-------|
    | Model | Message queue | Event log |
    | Throughput | 10K-50K msg/sec | 100K-1M msg/sec |
    | Message retention | Until consumed | Configurable (days) |
    | Ordering | Queue level | Partition level |
    | Use case | Task queues | Event streaming |
    | Replay | No | Yes |

    **When to use RabbitMQ:**
    - Task queues (job processing)
    - Request-reply patterns
    - Message routing (complex routing)
    - Lower throughput

    **When to use Kafka:**
    - Event sourcing
    - Stream processing
    - High throughput
    - Message replay needed
    - Analytics/logging

    ## Event-Driven Architecture

    **Services react to domain events**

    ### Event Types

    **1. Domain Events**
    ```python
    # Events that represent business facts
    OrderCreated(order_id, user_id, items, total)
    OrderShipped(order_id, tracking_number)
    OrderCancelled(order_id, reason)
    PaymentProcessed(payment_id, order_id, amount)
    UserRegistered(user_id, email)
    ```

    **2. Event Notification**
    ```python
    # Minimal information, receiver fetches details
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        order_id = event['order_id']

        # Fetch full order details
        order = order_service.get_order(order_id)

        # Process
        send_confirmation_email(order)
    ```

    **3. Event-Carried State Transfer**
    ```python
    # Full information in event, no need to fetch
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        # Event contains everything needed
        order_id = event['order_id']
        user_id = event['user_id']
        items = event['items']
        total = event['total']

        # Process without additional calls
        send_confirmation_email(user_id, order_id, items, total)
    ```

    ### Event Sourcing

    **Store events instead of current state**

    ```python
    # Traditional: Store current state
    orders_table:
      id | user_id | status    | total
      1  | 123     | SHIPPED   | 99.99

    # Event Sourcing: Store all events
    events_table:
      id | aggregate_id | event_type         | data
      1  | order-1      | OrderCreated       | {user_id: 123, total: 99.99}
      2  | order-1      | PaymentProcessed   | {amount: 99.99}
      3  | order-1      | OrderShipped       | {tracking: ABC123}

    # Rebuild state by replaying events
    def get_order_state(order_id):
        events = db.get_events(aggregate_id=order_id)

        state = {}
        for event in events:
            if event.type == 'OrderCreated':
                state['user_id'] = event.data['user_id']
                state['total'] = event.data['total']
                state['status'] = 'CREATED'
            elif event.type == 'PaymentProcessed':
                state['status'] = 'PAID'
            elif event.type == 'OrderShipped':
                state['status'] = 'SHIPPED'
                state['tracking'] = event.data['tracking']

        return state
    ```

    ✅ **Benefits:**
    - Complete audit trail
    - Time travel (rebuild state at any point)
    - Easy debugging
    - Can add new projections

    ❌ **Challenges:**
    - Complex queries
    - Need snapshots for performance
    - Schema evolution
    - Learning curve

    ## Saga Pattern for Distributed Transactions

    **Handle transactions across multiple services**

    ### The Problem

    ```python
    # Create order workflow (spans 3 services):
    # 1. Order Service: Create order
    # 2. Payment Service: Charge customer
    # 3. Inventory Service: Reserve items

    # Problem: What if payment succeeds but inventory fails?
    # Can't use database transactions across services!
    ```

    ### Saga Pattern (Choreography)

    **Services coordinate via events**

    ```python
    # Order Service
    def create_order(user_id, items):
        # 1. Create order (pending)
        order = db.save_order(user_id, items, status='PENDING')

        # 2. Publish event
        event_bus.publish('order.created', {
            'order_id': order.id,
            'user_id': user_id,
            'items': items,
            'total': order.total
        })

        return order

    @event_bus.subscribe('payment.succeeded')
    def handle_payment_succeeded(event):
        order_id = event['order_id']
        db.update_order_status(order_id, 'PAID')

    @event_bus.subscribe('payment.failed')
    def handle_payment_failed(event):
        # Compensating transaction: Cancel order
        order_id = event['order_id']
        db.update_order_status(order_id, 'CANCELLED')

        event_bus.publish('order.cancelled', {'order_id': order_id})

    # Payment Service
    @event_bus.subscribe('order.created')
    def handle_order_created(event):
        order_id = event['order_id']
        total = event['total']

        try:
            # Charge customer
            payment = process_payment(event['user_id'], total)

            # Success
            event_bus.publish('payment.succeeded', {
                'order_id': order_id,
                'payment_id': payment.id
            })

        except PaymentError:
            # Failed
            event_bus.publish('payment.failed', {
                'order_id': order_id,
                'reason': 'insufficient_funds'
            })

    # Inventory Service
    @event_bus.subscribe('payment.succeeded')
    def handle_payment_succeeded(event):
        order_id = event['order_id']

        try:
            # Reserve inventory
            reserve_items(event['order_id'])

            event_bus.publish('inventory.reserved', {'order_id': order_id})

        except InsufficientInventory:
            # Compensating transaction: Refund payment
            event_bus.publish('inventory.failed', {
                'order_id': order_id,
                'reason': 'out_of_stock'
            })

    @event_bus.subscribe('order.cancelled')
    def handle_order_cancelled(event):
        # Release reserved inventory (if any)
        release_items(event['order_id'])
    ```

    **Flow:**
    ```
    Happy Path:
    Order Service: Create order → Publish order.created
    Payment Service: Receive order.created → Charge → Publish payment.succeeded
    Inventory Service: Receive payment.succeeded → Reserve → Publish inventory.reserved
    Order Service: Receive payment.succeeded → Update status to PAID
    ✅ Done!

    Failure Path:
    Order Service: Create order → Publish order.created
    Payment Service: Receive order.created → Charge fails → Publish payment.failed
    Order Service: Receive payment.failed → Cancel order → Publish order.cancelled
    ❌ Order cancelled (compensating transaction)
    ```

    ### Saga Pattern (Orchestration)

    **Central coordinator manages saga**

    ```python
    # Order Saga Orchestrator
    class OrderSagaOrchestrator:
        def execute_order_saga(self, user_id, items, total):
            saga_id = generate_uuid()

            # Track saga state
            saga_state = {
                'saga_id': saga_id,
                'user_id': user_id,
                'items': items,
                'total': total,
                'current_step': 'START',
                'order_id': None,
                'payment_id': None
            }

            try:
                # Step 1: Create order
                saga_state['current_step'] = 'CREATE_ORDER'
                order = order_service.create_order(user_id, items)
                saga_state['order_id'] = order.id

                # Step 2: Process payment
                saga_state['current_step'] = 'PROCESS_PAYMENT'
                payment = payment_service.charge(user_id, total)
                saga_state['payment_id'] = payment.id

                # Step 3: Reserve inventory
                saga_state['current_step'] = 'RESERVE_INVENTORY'
                inventory_service.reserve(order.id, items)

                # Success!
                saga_state['current_step'] = 'COMPLETED'
                return {'status': 'success', 'order_id': order.id}

            except Exception as e:
                # Execute compensating transactions
                return self.compensate(saga_state, e)

        def compensate(self, saga_state, error):
            # Undo completed steps (reverse order)

            if saga_state['current_step'] in ['RESERVE_INVENTORY', 'COMPLETED']:
                # Unreserve inventory
                inventory_service.release(saga_state['order_id'])

            if saga_state['current_step'] in ['PROCESS_PAYMENT', 'RESERVE_INVENTORY']:
                # Refund payment
                payment_service.refund(saga_state['payment_id'])

            if saga_state['order_id']:
                # Cancel order
                order_service.cancel(saga_state['order_id'])

            return {
                'status': 'failed',
                'error': str(error),
                'saga_id': saga_state['saga_id']
            }
    ```

    **Choreography vs Orchestration:**

    | Aspect | Choreography | Orchestration |
    |--------|--------------|---------------|
    | Coordination | Decentralized (events) | Centralized (orchestrator) |
    | Complexity | Simple sagas | Complex sagas |
    | Dependencies | Loose coupling | Orchestrator knows all |
    | Debugging | Harder | Easier (central view) |

    ## Circuit Breaker Pattern

    **Prevent cascading failures**

    ### The Problem

    ```python
    # Payment service is down
    # Order service keeps calling it
    # All requests fail after 30s timeout
    # Order service becomes slow/unavailable
    # Cascading failure!
    ```

    ### Circuit Breaker Solution

    ```python
    from circuitbreaker import circuit

    class PaymentServiceClient:
        @circuit(failure_threshold=5, recovery_timeout=60, expected_exception=RequestException)
        def charge(self, user_id, amount):
            response = requests.post(
                f'{self.base_url}/charge',
                json={'user_id': user_id, 'amount': amount},
                timeout=5
            )
            response.raise_for_status()
            return response.json()

    # Usage
    payment_client = PaymentServiceClient()

    try:
        payment = payment_client.charge(user_id=123, amount=99.99)
    except CircuitBreakerError:
        # Circuit is open (service is down)
        # Fail fast instead of waiting for timeout
        return {'error': 'Payment service temporarily unavailable'}, 503
    ```

    **Circuit Breaker States:**

    ```
    ┌─────────┐
    │ CLOSED  │  (Normal operation)
    │         │  Requests pass through
    └────┬────┘  Count failures
         │
         │ failures >= threshold
         │
         ▼
    ┌─────────┐
    │  OPEN   │  (Service down)
    │         │  Fail fast, don't call service
    └────┬────┘  Start recovery timeout
         │
         │ after timeout
         │
         ▼
    ┌─────────┐
    │ HALF    │  (Testing recovery)
    │ OPEN    │  Allow limited requests
    └────┬────┘
         │
         ├──► Success → CLOSED
         └──► Failure → OPEN
    ```

    **Implementation with fallback:**

    ```python
    from circuitbreaker import circuit

    @circuit(failure_threshold=5, recovery_timeout=60)
    def get_recommendations(user_id):
        response = requests.get(
            f'http://recommendation-service/users/{user_id}',
            timeout=2
        )
        response.raise_for_status()
        return response.json()

    def get_recommendations_with_fallback(user_id):
        try:
            return get_recommendations(user_id)
        except CircuitBreakerError:
            # Circuit open - use fallback
            logger.warning('Recommendation service circuit open, using fallback')
            return get_popular_products()  # Fallback to popular products
        except Exception as e:
            logger.error(f'Recommendation service error: {e}')
            return get_popular_products()
    ```

    ## Best Practices

    **1. Timeouts everywhere**
    ```python
    # Always set timeouts on external calls
    requests.get(url, timeout=5)  # 5 seconds max
    ```

    **2. Idempotency**
    ```python
    # Same request multiple times = same result
    # Use idempotency keys
    payment_service.charge(
        user_id=123,
        amount=99.99,
        idempotency_key='order-456'  # Prevents duplicate charges
    )
    ```

    **3. Retry with exponential backoff**
    ```python
    from tenacity import retry, wait_exponential, stop_after_attempt

    @retry(wait=wait_exponential(multiplier=1, min=2, max=30),
           stop=stop_after_attempt(5))
    def call_service():
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        return response.json()
    ```

    **4. Monitor everything**
    ```python
    # Track metrics
    - Request rate
    - Error rate
    - Latency (p50, p95, p99)
    - Circuit breaker state
    - Queue depth
    ```

    **Next**: We'll explore deployment and operations - containerization with Docker, orchestration with Kubernetes, and observability strategies.
  MARKDOWN
  sequence_order: 5,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 6: Lesson 6 ===
lesson_6 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 6',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Microservices in Production

    Running microservices in production requires containerization, orchestration, observability, and operational discipline.

    ## Docker Containerization

    **Containers package applications with all dependencies for consistent deployment**

    ### Why Containers?

    ```
    Problem (Traditional):
    - "Works on my machine"
    - Different environments (dev, staging, prod)
    - Dependency conflicts
    - Complex deployment

    Solution (Containers):
    - Consistent environment everywhere
    - Isolated dependencies
    - Fast startup
    - Easy scaling
    ```

    ### Dockerfile for Microservice

    ```dockerfile
    # Python microservice Dockerfile
    FROM python:3.11-slim

    # Set working directory
    WORKDIR /app

    # Install dependencies
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt

    # Copy application code
    COPY . .

    # Create non-root user for security
    RUN useradd -m appuser && chown -R appuser:appuser /app
    USER appuser

    # Expose port
    EXPOSE 8000

    # Health check
    HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
      CMD python -c "import requests; requests.get('http://localhost:8000/health')"

    # Run application
    CMD ["python", "app.py"]
    ```

    ### Multi-Stage Build (Optimization)

    ```dockerfile
    # Stage 1: Build
    FROM node:18 AS builder

    WORKDIR /app
    COPY package*.json ./
    RUN npm ci --only=production

    COPY . .
    RUN npm run build

    # Stage 2: Runtime
    FROM node:18-slim

    WORKDIR /app

    # Copy only necessary files from builder
    COPY --from=builder /app/dist ./dist
    COPY --from=builder /app/node_modules ./node_modules
    COPY --from=builder /app/package*.json ./

    USER node

    EXPOSE 3000

    CMD ["node", "dist/main.js"]

    # Result: 200MB → 80MB image size!
    ```

    ### Build and Run

    ```bash
    # Build image
    docker build -t user-service:1.0 .

    # Run container
    docker run -d \
      --name user-service \
      -p 8000:8000 \
      -e DATABASE_URL=postgres://db:5432/users \
      -e REDIS_URL=redis://redis:6379 \
      user-service:1.0

    # View logs
    docker logs -f user-service

    # Execute command in container
    docker exec -it user-service bash
    ```

    ### Docker Compose (Local Development)

    ```yaml
    # docker-compose.yml
    version: '3.8'

    services:
      user-service:
        build: ./user-service
        ports:
          - "8001:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/users
          REDIS_URL: redis://redis:6379
        depends_on:
          - db
          - redis

      order-service:
        build: ./order-service
        ports:
          - "8002:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/orders
          USER_SERVICE_URL: http://user-service:8000
        depends_on:
          - db
          - user-service

      payment-service:
        build: ./payment-service
        ports:
          - "8003:8000"
        environment:
          DATABASE_URL: postgres://postgres:password@db:5432/payments

      db:
        image: postgres:15
        environment:
          POSTGRES_PASSWORD: password
        volumes:
          - postgres_data:/var/lib/postgresql/data

      redis:
        image: redis:7
        ports:
          - "6379:6379"

    volumes:
      postgres_data:
    ```

    ```bash
    # Start all services
    docker-compose up -d

    # View logs
    docker-compose logs -f user-service

    # Scale service
    docker-compose up -d --scale order-service=3

    # Stop all services
    docker-compose down
    ```

    ## Kubernetes Orchestration Basics

    **Kubernetes (K8s) automates deployment, scaling, and management of containerized applications**

    ### Why Kubernetes?

    ```
    Problems Docker doesn't solve:
    - How to scale to 100 containers?
    - How to handle failures (restart containers)?
    - How to load balance traffic?
    - How to do zero-downtime deployments?
    - How to manage configuration/secrets?

    Kubernetes solves all of these!
    ```

    ### Key Kubernetes Concepts

    **1. Pod**
    ```yaml
    # Smallest deployable unit (one or more containers)
    apiVersion: v1
    kind: Pod
    metadata:
      name: user-service-pod
    spec:
      containers:
      - name: user-service
        image: user-service:1.0
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          value: postgres://db:5432/users
    ```

    **2. Deployment**
    ```yaml
    # Manages replicas, rolling updates, rollbacks
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: user-service
    spec:
      replicas: 3  # Run 3 instances
      selector:
        matchLabels:
          app: user-service
      template:
        metadata:
          labels:
            app: user-service
        spec:
          containers:
          - name: user-service
            image: user-service:1.0
            ports:
            - containerPort: 8000
            env:
            - name: DATABASE_URL
              valueFrom:
                secretKeyRef:
                  name: db-credentials
                  key: url
            resources:
              requests:
                memory: "256Mi"
                cpu: "250m"
              limits:
                memory: "512Mi"
                cpu: "500m"
            livenessProbe:  # Restart if unhealthy
              httpGet:
                path: /health
                port: 8000
              initialDelaySeconds: 10
              periodSeconds: 10
            readinessProbe:  # Don't send traffic if not ready
              httpGet:
                path: /ready
                port: 8000
              initialDelaySeconds: 5
              periodSeconds: 5
    ```

    **3. Service**
    ```yaml
    # Load balancing and service discovery
    apiVersion: v1
    kind: Service
    metadata:
      name: user-service
    spec:
      selector:
        app: user-service
      ports:
      - protocol: TCP
        port: 80
        targetPort: 8000
      type: ClusterIP  # Internal only

    # Now other services can call: http://user-service/
    ```

    **4. ConfigMap and Secret**
    ```yaml
    # ConfigMap (non-sensitive config)
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: user-service-config
    data:
      LOG_LEVEL: "info"
      CACHE_TTL: "3600"

    ---
    # Secret (sensitive data)
    apiVersion: v1
    kind: Secret
    metadata:
      name: db-credentials
    type: Opaque
    data:
      url: cG9zdGdyZXM6Ly9kYjo1NDMyL3VzZXJz  # Base64 encoded
    ```

    **5. Ingress**
    ```yaml
    # External access and routing
    apiVersion: networking.k8s.io/v1
    kind: Ingress
    metadata:
      name: api-ingress
    spec:
      rules:
      - host: api.example.com
        http:
          paths:
          - path: /users
            pathType: Prefix
            backend:
              service:
                name: user-service
                port:
                  number: 80
          - path: /orders
            pathType: Prefix
            backend:
              service:
                name: order-service
                port:
                  number: 80
    ```

    ### Deploy to Kubernetes

    ```bash
    # Apply configuration
    kubectl apply -f user-service-deployment.yaml
    kubectl apply -f user-service-service.yaml

    # Check status
    kubectl get pods
    kubectl get deployments
    kubectl get services

    # View logs
    kubectl logs -f deployment/user-service

    # Scale
    kubectl scale deployment user-service --replicas=5

    # Update image (rolling update)
    kubectl set image deployment/user-service user-service=user-service:1.1

    # Rollback
    kubectl rollout undo deployment/user-service

    # Execute command in pod
    kubectl exec -it user-service-pod -- bash
    ```

    ### Horizontal Pod Autoscaler

    ```yaml
    # Auto-scale based on CPU/memory
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
      name: user-service-hpa
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: user-service
      minReplicas: 2
      maxReplicas: 10
      metrics:
      - type: Resource
        resource:
          name: cpu
          target:
            type: Utilization
            averageUtilization: 70  # Scale when CPU > 70%
      - type: Resource
        resource:
          name: memory
          target:
            type: Utilization
            averageUtilization: 80  # Scale when memory > 80%
    ```

    ## Service Mesh (Istio Overview)

    **Service mesh handles service-to-service communication, security, and observability**

    ### Why Service Mesh?

    ```
    Without Service Mesh:
    - Each service implements: retries, timeouts, circuit breaking
    - Inconsistent behavior
    - Code changes required for new features

    With Service Mesh:
    - Infrastructure handles: retries, timeouts, circuit breaking
    - Consistent across all services
    - Configuration-based (no code changes)
    ```

    ### Istio Architecture

    ```
    ┌──────────────────────────────────────┐
    │  Control Plane (istiod)              │
    │  - Configuration                     │
    │  - Service discovery                 │
    │  - Certificate management            │
    └──────────────────────────────────────┘
                     │
         ┌───────────┼───────────┐
         │           │           │
         ▼           ▼           ▼
    ┌────────┐  ┌────────┐  ┌────────┐
    │  Pod   │  │  Pod   │  │  Pod   │
    │ ┌────┐ │  │ ┌────┐ │  │ ┌────┐ │
    │ │App │ │  │ │App │ │  │ │App │ │
    │ └────┘ │  │ └────┘ │  │ └────┘ │
    │ ┌────┐ │  │ ┌────┐ │  │ ┌────┐ │
    │ │Envoy│ │  │ │Envoy│ │  │ │Envoy│ │  Sidecar Proxy
    │ └────┘ │  │ └────┘ │  │ └────┘ │
    └────────┘  └────────┘  └────────┘
    ```

    ### Istio Features (Configuration Examples)

    **1. Traffic Management**
    ```yaml
    # Circuit breaking
    apiVersion: networking.istio.io/v1alpha3
    kind: DestinationRule
    metadata:
      name: payment-service
    spec:
      host: payment-service
      trafficPolicy:
        connectionPool:
          tcp:
            maxConnections: 100
          http:
            http1MaxPendingRequests: 50
            maxRequestsPerConnection: 2
        outlierDetection:
          consecutiveErrors: 5
          interval: 30s
          baseEjectionTime: 30s
    ```

    **2. Retries and Timeouts**
    ```yaml
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: user-service
    spec:
      hosts:
      - user-service
      http:
      - route:
        - destination:
            host: user-service
        timeout: 5s
        retries:
          attempts: 3
          perTryTimeout: 2s
          retryOn: 5xx,reset,connect-failure
    ```

    **3. Canary Deployments**
    ```yaml
    # Route 90% to v1, 10% to v2 (canary)
    apiVersion: networking.istio.io/v1alpha3
    kind: VirtualService
    metadata:
      name: user-service
    spec:
      hosts:
      - user-service
      http:
      - match:
        - headers:
            user-type:
              exact: "beta"
        route:
        - destination:
            host: user-service
            subset: v2
      - route:
        - destination:
            host: user-service
            subset: v1
          weight: 90
        - destination:
            host: user-service
            subset: v2
          weight: 10
    ```

    ## Distributed Tracing (Jaeger)

    **Track requests across multiple services**

    ### The Problem

    ```
    User request fails
    Which service caused the error?
    How long did each service take?
    What was the call chain?

    Without tracing: Check logs in 10+ services → Hours of debugging
    With tracing: See entire request flow → Minutes to find issue
    ```

    ### OpenTelemetry Instrumentation

    ```python
    from opentelemetry import trace
    from opentelemetry.exporter.jaeger.thrift import JaegerExporter
    from opentelemetry.sdk.trace import TracerProvider
    from opentelemetry.sdk.trace.export import BatchSpanProcessor
    from opentelemetry.instrumentation.flask import FlaskInstrumentor
    from opentelemetry.instrumentation.requests import RequestsInstrumentor

    # Setup tracing
    trace.set_tracer_provider(TracerProvider())
    jaeger_exporter = JaegerExporter(
        agent_host_name="jaeger",
        agent_port=6831,
    )
    trace.get_tracer_provider().add_span_processor(
        BatchSpanProcessor(jaeger_exporter)
    )

    # Auto-instrument Flask
    FlaskInstrumentor().instrument_app(app)

    # Auto-instrument requests library
    RequestsInstrumentor().instrument()

    # Manual instrumentation
    tracer = trace.get_tracer(__name__)

    @app.route('/create-order')
    def create_order():
        with tracer.start_as_current_span("create_order") as span:
            span.set_attribute("user_id", user_id)
            span.set_attribute("items_count", len(items))

            # This call automatically traced (requests instrumented)
            user = requests.get(f'http://user-service/users/{user_id}')

            # Custom span
            with tracer.start_as_current_span("save_to_database"):
                order = db.save_order(user_id, items)

            span.set_attribute("order_id", order.id)

            return order
    ```

    **Trace visualization in Jaeger:**
    ```
    Trace ID: abc123
    Total duration: 250ms

    → API Gateway (5ms)
      → Order Service (200ms)
        → User Service (50ms)
          → Database query (30ms)
        → Payment Service (100ms)  ← Slow! Found the issue!
          → Payment gateway API (95ms)
        → Inventory Service (30ms)
    ```

    ## Centralized Logging (ELK Stack)

    **Aggregate logs from all services in one place**

    ### ELK Stack Components

    ```
    Services → Filebeat/Fluentd → Logstash → Elasticsearch → Kibana
                 (Collect)       (Process)   (Store)        (Visualize)
    ```

    ### Structured Logging

    ```python
    import structlog
    import logging

    # Configure structured logging
    structlog.configure(
        processors=[
            structlog.stdlib.filter_by_level,
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.processors.JSONRenderer()
        ],
        context_class=dict,
        logger_factory=structlog.stdlib.LoggerFactory(),
    )

    logger = structlog.get_logger()

    # Structured log (JSON)
    @app.route('/orders/<order_id>')
    def get_order(order_id):
        logger.info(
            "fetching_order",
            order_id=order_id,
            user_id=current_user.id,
            service="order-service"
        )

        try:
            order = db.get_order(order_id)

            logger.info(
                "order_fetched",
                order_id=order_id,
                status=order.status,
                duration_ms=10
            )

            return order

        except Exception as e:
            logger.error(
                "order_fetch_failed",
                order_id=order_id,
                error=str(e),
                exc_info=True
            )
            raise

    # Output (JSON):
    # {
    #   "event": "fetching_order",
    #   "order_id": "123",
    #   "user_id": "456",
    #   "service": "order-service",
    #   "timestamp": "2024-01-15T10:30:00.000Z",
    #   "level": "info"
    # }
    ```

    ### Log Aggregation with Fluentd

    ```yaml
    # fluentd-daemonset.yaml
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: fluentd
    spec:
      template:
        spec:
          containers:
          - name: fluentd
            image: fluent/fluentd-kubernetes-daemonset:v1-debian-elasticsearch
            env:
            - name: FLUENT_ELASTICSEARCH_HOST
              value: "elasticsearch"
            - name: FLUENT_ELASTICSEARCH_PORT
              value: "9200"
            volumeMounts:
            - name: varlog
              mountPath: /var/log
            - name: containers
              mountPath: /var/lib/docker/containers
          volumes:
          - name: varlog
            hostPath:
              path: /var/log
          - name: containers
            hostPath:
              path: /var/lib/docker/containers

    # Fluentd collects logs from all pods and sends to Elasticsearch
    ```

    ### Query Logs in Kibana

    ```
    # Find all errors in last hour
    level:error AND @timestamp:[now-1h TO now]

    # Find specific order
    order_id:"123"

    # Find slow requests
    duration_ms:>1000

    # Find errors from specific service
    service:"payment-service" AND level:error
    ```

    ## Monitoring and Observability

    ### Prometheus Metrics

    ```python
    from prometheus_client import Counter, Histogram, Gauge, start_http_server

    # Define metrics
    request_count = Counter(
        'http_requests_total',
        'Total HTTP requests',
        ['method', 'endpoint', 'status']
    )

    request_duration = Histogram(
        'http_request_duration_seconds',
        'HTTP request duration',
        ['method', 'endpoint']
    )

    active_users = Gauge(
        'active_users',
        'Number of active users'
    )

    # Instrument application
    @app.route('/orders')
    def list_orders():
        # Increment counter
        request_count.labels(method='GET', endpoint='/orders', status=200).inc()

        # Track duration
        with request_duration.labels(method='GET', endpoint='/orders').time():
            orders = db.get_orders()

        return orders

    # Update gauge
    active_users.set(len(get_active_users()))

    # Expose metrics endpoint
    start_http_server(8001)  # Metrics at http://localhost:8001/metrics
    ```

    ### Grafana Dashboards

    ```
    Key metrics to monitor:

    1. Golden Signals:
       - Latency (request duration)
       - Traffic (requests per second)
       - Errors (error rate)
       - Saturation (CPU, memory usage)

    2. Service-specific:
       - Queue depth (message queues)
       - Cache hit rate
       - Database connection pool
       - Circuit breaker state

    3. Business metrics:
       - Orders per minute
       - Revenue per hour
       - User signups
    ```

    ## Common Challenges and Solutions

    ### 1. Service Discovery Issues

    ```python
    # Problem: Service address changes
    # Solution: Use Kubernetes DNS
    user_service_url = "http://user-service"  # Not IP address!
    ```

    ### 2. Configuration Management

    ```python
    # Problem: Different config per environment
    # Solution: Use ConfigMaps/Secrets + environment variables
    DATABASE_URL = os.getenv('DATABASE_URL')
    ```

    ### 3. Debugging Distributed Systems

    ```python
    # Problem: Request fails, which service?
    # Solution: Correlation IDs + Distributed tracing
    import uuid

    @app.before_request
    def add_correlation_id():
        # Generate or get correlation ID
        correlation_id = request.headers.get('X-Correlation-ID', str(uuid.uuid4()))
        g.correlation_id = correlation_id
        logger.info("request_started", correlation_id=correlation_id)

    @app.after_request
    def add_correlation_header(response):
        response.headers['X-Correlation-ID'] = g.correlation_id
        return response
    ```

    ### 4. Zero-Downtime Deployments

    ```yaml
    # Rolling update strategy
    spec:
      strategy:
        type: RollingUpdate
        rollingUpdate:
          maxUnavailable: 0      # Don't kill pods before new ones ready
          maxSurge: 1            # Create 1 extra pod during update

      # Graceful shutdown
      containers:
      - name: app
        lifecycle:
          preStop:
            exec:
              command: ["/bin/sh", "-c", "sleep 15"]  # Allow requests to drain
    ```

    ### 5. Database Migrations

    ```python
    # Problem: Schema changes with zero downtime
    # Solution: Backward-compatible migrations

    # Bad: Breaks old version
    ALTER TABLE users DROP COLUMN phone;

    # Good: Multi-step migration
    # Step 1: Deploy code that doesn't use 'phone'
    # Step 2: Deploy migration that drops column
    ```

    ## Production Checklist

    ✅ **Before going to production:**

    - [ ] Health check endpoints implemented
    - [ ] Graceful shutdown handling
    - [ ] Resource limits set (CPU, memory)
    - [ ] Logging configured (structured, JSON)
    - [ ] Metrics exposed (Prometheus)
    - [ ] Distributed tracing enabled
    - [ ] Circuit breakers on external calls
    - [ ] Timeouts on all network calls
    - [ ] Retries with exponential backoff
    - [ ] Database connection pooling
    - [ ] Secrets in Secret manager (not code)
    - [ ] TLS/HTTPS enabled
    - [ ] Auto-scaling configured
    - [ ] Monitoring alerts set up
    - [ ] Runbooks for common issues
    - [ ] Disaster recovery plan
    - [ ] Load testing completed

    **Congratulations!** You now understand the fundamentals of microservices architecture - from principles and communication patterns to production deployment. The key is to start simple, add complexity only when needed, and always design for failure.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 6 microlessons for Microservices Intro"
