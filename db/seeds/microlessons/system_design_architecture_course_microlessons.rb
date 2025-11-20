# AUTO-GENERATED from system_design_architecture_course.rb
puts "Creating Microlessons for System Design Fundamentals..."

module_var = CourseModule.find_by(slug: 'system-design-fundamentals')

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

# CAP Theorem and Consistency

    The **CAP theorem** states that a distributed system can only guarantee **two out of three** properties:

    ## The Three Properties

    ### C = Consistency
    **All nodes see the same data at the same time**

    ```
    User writes: balance = $100
    User reads from ANY node: balance = $100
    ```

    Every read receives the most recent write.

    ### A = Availability
    **Every request receives a response (success or failure)**

    ```
    User makes request → Always gets a response
    (Even if some nodes are down)
    ```

    System continues to operate despite failures.

    ### P = Partition Tolerance
    **System continues despite network partitions**

    ```
    Network split: [Node1, Node2] | [Node3, Node4]
    System still operates on both sides
    ```

    System handles arbitrary network failures.

    ## Why You Can't Have All Three

    **During a network partition, you must choose:**

    ### CP (Consistency + Partition Tolerance)
    **Sacrifice Availability**

    ```
    Network partition detected
    → Reject writes until partition heals
    → Ensures all nodes have consistent data
    → But some requests fail (unavailable)
    ```

    **Examples:** Banking systems, inventory management

    ### AP (Availability + Partition Tolerance)
    **Sacrifice Consistency**

    ```
    Network partition detected
    → Accept writes on both sides
    → All requests succeed (available)
    → But data may diverge (inconsistent)
    → Reconcile conflicts later
    ```

    **Examples:** Social media feeds, DNS, shopping carts

    ### CA (Consistency + Availability)
    **Not possible in distributed systems!**

    Network partitions will happen, so you must be partition tolerant.

    ## Real-World Systems

    ### CP Systems

    **MongoDB (with default settings)**
    ```javascript
    // Write with majority concern
    db.users.insert(
      { name: "Alice", balance: 100 },
      { writeConcern: { w: "majority" } }
    );
    // Blocks until majority of replicas confirm
    // If partition: write fails (CP)
    ```

    **HBase, Redis Cluster**

    **When to use:**
    - Financial transactions
    - Inventory management
    - Ticket booking
    - Seat reservations

    ### AP Systems

    **Cassandra**
    ```sql
    -- Write with eventual consistency
    INSERT INTO users (id, name, balance)
    VALUES (1, 'Alice', 100);
    -- Returns immediately, replicates async
    -- If partition: writes succeed on available nodes (AP)
    ```

    **DynamoDB, Riak, CouchDB**

    **When to use:**
    - Social media feeds
    - Analytics
    - Logging
    - Shopping carts
    - DNS

    ## Consistency Models

    ### 1. Strong Consistency
    **All nodes show same data at same time**

    ```python
    # Write
    db.write('key', 'value1')

    # Immediate read from ANY node
    db.read('key')  # Always returns 'value1'
    ```

    ✅ Simple to reason about
    ❌ Higher latency, lower availability

    ### 2. Eventual Consistency
    **All nodes will eventually have same data**

    ```python
    # Write to Node1
    node1.write('key', 'value1')

    # Read from Node2 (immediately)
    node2.read('key')  # Might return old value or 'value1'

    # Read from Node2 (after propagation)
    time.sleep(0.1)
    node2.read('key')  # Returns 'value1'
    ```

    ✅ Lower latency, higher availability
    ❌ Temporary inconsistencies

    **Real example: Facebook**
    ```
    User posts status update
    → Writes to primary datacenter
    → Eventually propagates to global replicas
    → Different users might see update at different times
    ```

    ### 3. Causal Consistency
    **Causally related operations are seen in order**

    ```python
    # User A posts comment
    post_comment("Great post!")  # Event 1

    # User B replies to comment
    reply_comment("Thanks!")     # Event 2 (depends on Event 1)

    # All users see Event 1 before Event 2
    # But unrelated events may appear in any order
    ```

    ### 4. Read-After-Write Consistency
    **User sees their own writes immediately**

    ```python
    # User updates profile
    user.update(name="Alice")

    # User immediately views profile
    user.get()  # Guaranteed to see "Alice"

    # Other users may see old value temporarily
    ```

    ## Quorum Reads and Writes

    **Ensure consistency by reading/writing to majority of nodes**

    ### Configuration

    ```
    N = Total replicas (e.g., 5)
    W = Write quorum (e.g., 3)
    R = Read quorum (e.g., 3)
    ```

    **Strong consistency when: W + R > N**

    ```
    N = 5 replicas
    W = 3 (write to 3 nodes)
    R = 3 (read from 3 nodes)
    W + R = 6 > N = 5 ✓

    Guaranteed to read at least one node with latest write!
    ```

    ### Example: Cassandra

    ```sql
    -- Write with quorum
    INSERT INTO users (id, name) VALUES (1, 'Alice')
    USING CONSISTENCY QUORUM;

    -- Read with quorum
    SELECT * FROM users WHERE id = 1
    USING CONSISTENCY QUORUM;
    ```

    **Tradeoffs:**

    | Configuration | Consistency | Availability | Latency |
    |--------------|-------------|--------------|---------|
    | W=1, R=1 | Weak | High | Low |
    | W=QUORUM, R=QUORUM | Strong | Medium | Medium |
    | W=ALL, R=1 | Strong reads | Low writes | High writes |

    ## Conflict Resolution

    ### Last Write Wins (LWW)

    ```python
    # Conflict: Two writes to same key
    Node1: write('user:1:name', 'Alice', timestamp=100)
    Node2: write('user:1:name', 'Alicia', timestamp=101)

    # Resolution: Keep latest timestamp
    Final value: 'Alicia' (timestamp 101)
    ```

    ❌ **Problem:** Clock skew can cause issues
    ✅ **Simple and predictable**

    ### Vector Clocks

    ```python
    # Track causality with vector clocks
    Version 1: {server1: 1, server2: 0} → name="Alice"
    Version 2: {server1: 1, server2: 1} → name="Alicia"

    # Version 2 happened after Version 1 (causally)
    # Keep Version 2
    ```

    ### Application-Level Resolution

    ```python
    # Shopping cart example
    User adds from Node1: cart = [item1, item2]
    User adds from Node2: cart = [item3]

    # Conflict!
    # Resolution: Merge carts
    Final cart = [item1, item2, item3]
    ```

    ## ACID vs BASE

    ### ACID (Traditional Databases)

    - **Atomicity**: All or nothing
    - **Consistency**: Valid state always
    - **Isolation**: Transactions don't interfere
    - **Durability**: Committed data persists

    ```sql
    BEGIN TRANSACTION;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT;  -- Both updates or neither
    ```

    ### BASE (Distributed Systems)

    - **Basically Available**: System available most of the time
    - **Soft state**: State may change over time (eventual consistency)
    - **Eventually consistent**: Will become consistent given enough time

    ```python
    # BASE example: Shopping cart
    add_to_cart(user_id, item)  # Succeeds immediately
    # Cart replicated eventually to all nodes
    # Conflicts merged later
    ```

    ## Practical Decisions

    ### E-commerce System

    **Product Catalog (AP)**
    ```
    - Eventual consistency OK
    - Availability critical (can't lose sales)
    - Temporary stale data acceptable
    → Use Cassandra or DynamoDB
    ```

    **Inventory (CP)**
    ```
    - Strong consistency required
    - Can't oversell items
    - Brief unavailability acceptable
    → Use relational DB with proper locking
    ```

    **Shopping Cart (AP)**
    ```
    - Eventual consistency OK
    - Must remain available
    - Merge conflicts (combine items)
    → Use DynamoDB or Cassandra
    ```

    **Orders/Payments (CP)**
    ```
    - Strong consistency critical
    - No duplicate charges
    - ACID transactions needed
    → Use PostgreSQL or MySQL
    ```

    ## Best Practices

    1. **Choose based on business requirements**
       - Critical data = CP (consistency)
       - User-facing = AP (availability)

    2. **Hybrid approach**
       - Different subsystems can make different tradeoffs
       - Use both CP and AP systems

    3. **Design for partition tolerance**
       - Network failures will happen
       - Plan for split-brain scenarios

    4. **Monitor and measure**
       - Track consistency lag
       - Measure availability SLAs

    **Next**: We'll explore load balancing strategies and patterns.
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

# Load Balancing Strategies

    A **load balancer** distributes incoming requests across multiple servers to improve reliability and capacity.

    ## Why Load Balancing?

    ```
    Without LB:
    Single server → 1000 RPS max → Bottleneck

    With LB:
    10 servers × 1000 RPS = 10,000 RPS capacity
    + Fault tolerance (1 server fails → 9 still work)
    ```

    ## Load Balancer Types

    ### Layer 4 (Transport Layer)
    **Operates at TCP/UDP level**

    ```nginx
    # Routes based on IP and port
    Client → LB (checks IP:port) → Server
    ```

    ✅ Fast (no need to inspect content)
    ✅ Low latency
    ❌ Limited routing logic
    ❌ No content-based routing

    ### Layer 7 (Application Layer)
    **Operates at HTTP level**

    ```nginx
    # Routes based on URL, headers, cookies
    /api/* → API servers
    /static/* → Static file servers
    ```

    ✅ Smart routing (URL, headers, cookies)
    ✅ SSL termination
    ✅ Caching
    ❌ Slightly higher latency

    ## Load Balancing Algorithms

    ### 1. Round Robin

    ```
    Request 1 → Server 1
    Request 2 → Server 2
    Request 3 → Server 3
    Request 4 → Server 1 (cycle repeats)
    ```

    ✅ Simple, fair distribution
    ❌ Doesn't account for server capacity
    ❌ Doesn't account for server load

    **When to use:** Servers have equal capacity, requests have similar load

    ### 2. Weighted Round Robin

    ```
    Server 1 (weight 3): Gets 3 requests
    Server 2 (weight 2): Gets 2 requests
    Server 3 (weight 1): Gets 1 request
    ```

    ✅ Accounts for different server capacities
    ❌ Still doesn't account for current load

    **When to use:** Servers have different capacities (e.g., different instance sizes)

    ### 3. Least Connections

    ```
    Server 1: 5 active connections
    Server 2: 3 active connections ← New request goes here
    Server 3: 7 active connections
    ```

    ✅ Accounts for current load
    ✅ Good for long-lived connections
    ❌ Requires tracking connections

    **When to use:** WebSocket connections, database connections, long-polling

    ### 4. Least Response Time

    ```
    Server 1: avg 100ms response time
    Server 2: avg 50ms response time ← New request goes here
    Server 3: avg 150ms response time
    ```

    ✅ Routes to fastest server
    ✅ Accounts for server performance
    ❌ Requires health checks with latency monitoring

    **When to use:** Servers with varying performance, heterogeneous infrastructure

    ### 5. IP Hash (Consistent Hashing)

    ```python
    # Hash client IP to determine server
    server_index = hash(client_ip) % num_servers
    ```

    ✅ Same client → same server (session affinity)
    ✅ Good for caching (server-local cache)
    ❌ Uneven distribution if few clients
    ❌ Sticky sessions (hard to scale)

    **When to use:** Stateful applications, server-side caching

    ### 6. Random

    ```python
    import random
    server = random.choice(servers)
    ```

    ✅ Simple
    ✅ Works well with large number of requests
    ❌ Can be uneven in short term

    **When to use:** Stateless apps, microservices

    ## Health Checks

    **Ensure requests only go to healthy servers**

    ### Active Health Checks

    ```python
    # Load balancer periodically checks servers
    @app.route('/health')
    def health_check():
        # Check database connection
        if not db.is_connected():
            return {'status': 'unhealthy'}, 503

        # Check critical dependencies
        if not cache.ping():
            return {'status': 'degraded'}, 200

        return {'status': 'healthy'}, 200
    ```

    **Configuration:**
    ```nginx
    upstream backend {
        server backend1:8000;
        server backend2:8000;

        # Health check every 5 seconds
        check interval=5000 rise=2 fall=3 timeout=1000;
    }
    ```

    ### Passive Health Checks

    ```
    Monitor actual traffic:
    - 3 failed requests in 10s → Mark unhealthy
    - Server recovers → Mark healthy after 2 successful requests
    ```

    ## Common Load Balancers

    ### Nginx

    ```nginx
    upstream backend {
        least_conn;  # Use least connections algorithm
        server backend1.example.com;
        server backend2.example.com;
        server backend3.example.com;
    }

    server {
        listen 80;
        location / {
            proxy_pass http://backend;
        }
    }
    ```

    ### HAProxy

    ```haproxy
    frontend http_front
        bind *:80
        default_backend http_back

    backend http_back
        balance roundrobin
        server server1 10.0.0.1:8000 check
        server server2 10.0.0.2:8000 check
        server server3 10.0.0.3:8000 check
    ```

    ### AWS Application Load Balancer (ALB)

    ```python
    # Layer 7 load balancing
    # Routes based on:
    - URL path (/api/* → API servers)
    - Host header (api.example.com → API servers)
    - HTTP headers
    - Query parameters
    ```

    ### AWS Network Load Balancer (NLB)

    ```python
    # Layer 4 load balancing
    - Ultra-low latency
    - Handles millions of RPS
    - Static IP addresses
    ```

    ## Session Persistence (Sticky Sessions)

    ### Cookie-Based

    ```nginx
    upstream backend {
        sticky cookie srv_id expires=1h domain=.example.com path=/;
        server backend1:8000;
        server backend2:8000;
    }
    ```

    **Flow:**
    ```
    1. First request → Server 1
    2. LB sets cookie: srv_id=server1
    3. Future requests include cookie → Always route to Server 1
    ```

    ### IP-Based

    ```nginx
    upstream backend {
        ip_hash;
        server backend1:8000;
        server backend2:8000;
    }
    ```

    **Problems with sticky sessions:**
    - Uneven load distribution
    - Server failure = session loss
    - Harder to scale

    **Better solution:** Use external session store (Redis)

    ## SSL/TLS Termination

    **Load balancer handles SSL, backends use HTTP**

    ```nginx
    server {
        listen 443 ssl;
        ssl_certificate /path/to/cert.pem;
        ssl_certificate_key /path/to/key.pem;

        location / {
            proxy_pass http://backend;  # HTTP to backend
        }
    }
    ```

    **Benefits:**
    - Centralized certificate management
    - Reduced CPU load on backends
    - Simpler backend configuration

    ## Global Load Balancing (GSLB)

    **Route users to nearest datacenter**

    ```
    User in US → us-east-1 datacenter
    User in EU → eu-west-1 datacenter
    User in Asia → ap-southeast-1 datacenter
    ```

    **Methods:**
    1. **DNS-based** (Route53, Cloudflare)
       ```
       example.com → Different IP based on user location
       ```

    2. **Anycast**
       ```
       Same IP announced from multiple locations
       BGP routes to nearest
       ```

    ## Real-World Example: Netflix

    **Challenge:**
    - 200+ million subscribers
    - Global traffic
    - High availability required

    **Solution:**
    ```
    1. AWS ELB for load balancing
    2. Auto-scaling groups (add/remove servers based on load)
    3. Multi-region deployment
    4. Route53 for DNS-based routing
    5. Health checks with automatic failover
    ```

    **Results:**
    - 99.99% availability
    - Handles traffic spikes (new releases)
    - Global low latency

    **Next**: We'll explore caching strategies to reduce load and improve performance.
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

# Caching Strategies

    **Caching** stores frequently accessed data in fast storage to reduce latency and load.

    ## Why Cache?

    ```
    Database query: 100ms
    Cache lookup:   1ms
    Speed up:       100x faster!

    Without cache:  1000 req/s × 100ms = Max 10 concurrent
    With cache:     1000 req/s × 1ms = Easy!
    ```

    ## Cache Levels

    ### 1. Client-Side Cache (Browser)

    ```html
    <!-- HTTP caching headers -->
    Cache-Control: public, max-age=31536000, immutable
    ```

    **Benefits:**
    - Fastest (no network request)
    - Reduces bandwidth
    - Improves UX

    **Example:**
    ```javascript
    // Static assets cached for 1 year
    app.use('/static', express.static('public', {
      maxAge: '1y',
      immutable: true
    }));
    ```

    ### 2. CDN Cache

    ```
    User in Tokyo → Tokyo edge cache (10ms latency)
    vs
    User in Tokyo → US origin server (200ms latency)
    ```

    **How it works:**
    ```
    1. User requests image.jpg
    2. CDN checks edge cache
    3. If cached → Return (fast!)
    4. If not → Fetch from origin, cache, return
    ```

    **Popular CDNs:**
    - Cloudflare
    - AWS CloudFront
    - Fastly
    - Akamai

    ### 3. Application Cache (Redis/Memcached)

    ```python
    # Check cache first
    user = cache.get(f'user:{user_id}')

    if user is None:
        # Cache miss - query database
        user = db.query('SELECT * FROM users WHERE id = ?', user_id)
        # Store in cache for 1 hour
        cache.set(f'user:{user_id}', user, ttl=3600)

    return user
    ```

    ### 4. Database Cache

    ```sql
    -- Query result cache (MySQL)
    SELECT SQL_CACHE * FROM products WHERE category = 'electronics';
    ```

    ## Caching Patterns

    ### 1. Cache-Aside (Lazy Loading)

    **Application manages cache**

    ```python
    def get_user(user_id):
        # Try cache first
        user = cache.get(f'user:{user_id}')

        if user is None:  # Cache miss
            user = db.get_user(user_id)
            cache.set(f'user:{user_id}', user, ttl=3600)

        return user

    def update_user(user_id, data):
        # Update database
        db.update_user(user_id, data)
        # Invalidate cache
        cache.delete(f'user:{user_id}')
    ```

    ✅ Only cache what's needed
    ✅ Cache survives failures
    ❌ Cache miss penalty
    ❌ Potential stale data

    **When to use:** Most common pattern, general-purpose caching

    ### 2. Write-Through

    **Write to cache AND database**

    ```python
    def update_user(user_id, data):
        # Write to database
        db.update_user(user_id, data)
        # Update cache
        cache.set(f'user:{user_id}', data, ttl=3600)
    ```

    ✅ Cache always consistent
    ❌ Write latency (2 writes)
    ❌ Most data never read (wasted cache)

    **When to use:** Read-heavy workloads where consistency is critical

    ### 3. Write-Behind (Write-Back)

    **Write to cache, async write to database**

    ```python
    def update_user(user_id, data):
        # Write to cache immediately
        cache.set(f'user:{user_id}', data)
        # Queue database update
        queue.enqueue('update_user_db', user_id, data)

    # Background worker
    def worker():
        job = queue.dequeue()
        db.update_user(job.user_id, job.data)
    ```

    ✅ Low write latency
    ✅ Batch database writes
    ❌ Data loss risk if cache fails
    ❌ Complex to implement

    **When to use:** Write-heavy workloads, analytics, logging

    ### 4. Read-Through

    **Cache automatically loads from database**

    ```python
    # Cache library handles everything
    @cache.memoize(ttl=3600)
    def get_user(user_id):
        return db.get_user(user_id)

    # First call: Cache miss → DB query → Cache store → Return
    # Later calls: Cache hit → Return (no DB query)
    ```

    ✅ Simple application code
    ❌ Cache coupled to database
    ❌ Less control

    **When to use:** Simple applications, ORMs with caching support

    ## Cache Eviction Policies

    ### LRU (Least Recently Used)

    ```python
    # Most common eviction policy
    # Removes least recently accessed items first

    Cache (max 3 items):
    Access A → [A]
    Access B → [B, A]
    Access C → [C, B, A]
    Access D → [D, C, B]  # A evicted (least recently used)
    Access B → [B, D, C]  # B moved to front
    ```

    **When to use:** General-purpose caching (default choice)

    ### LFU (Least Frequently Used)

    ```python
    # Removes least frequently accessed items
    # Tracks access count

    A: 10 accesses
    B: 5 accesses
    C: 2 accesses ← Evicted first
    ```

    **When to use:** Items have different access patterns over time

    ### FIFO (First In, First Out)

    ```python
    # Removes oldest items first
    # Like a queue

    Add A → [A]
    Add B → [B, A]
    Add C → [C, B, A]
    Add D → [D, C, B]  # A evicted (oldest)
    ```

    **When to use:** Time-based data, logs

    ### TTL (Time To Live)

    ```python
    # Auto-expire after time period
    cache.set('session:123', data, ttl=3600)  # Expires in 1 hour
    ```

    **When to use:** Sessions, temporary data, rate limiting

    ## Cache Invalidation

    **"There are only two hard things in Computer Science: cache invalidation and naming things."**

    ### 1. TTL-Based

    ```python
    # Set expiration time
    cache.set('products:list', products, ttl=300)  # 5 minutes
    ```

    ✅ Simple
    ❌ Stale data before expiration

    ### 2. Event-Based

    ```python
    # Invalidate on events
    def create_product(product):
        db.insert(product)
        cache.delete('products:list')  # Invalidate list cache
        cache.delete(f'products:category:{product.category}')
    ```

    ✅ Cache always fresh
    ❌ Careful with dependencies

    ### 3. Version-Based

    ```python
    # Include version in key
    def get_products(version):
        return cache.get(f'products:list:v{version}')

    # When data changes, increment version
    PRODUCT_VERSION = 2  # Invalidates old cache
    ```

    ✅ No explicit invalidation needed
    ❌ Must track versions

    ## Distributed Caching

    ### Redis Cluster

    ```python
    # Data sharded across nodes
    import redis

    # Connect to cluster
    rc = redis.RedisCluster(
        startup_nodes=[
            {"host": "node1", "port": 6379},
            {"host": "node2", "port": 6379},
            {"host": "node3", "port": 6379}
        ]
    )

    # Automatically routes to correct node
    rc.set('user:123', user_data)
    ```

    **Benefits:**
    - Horizontal scaling
    - High availability
    - Automatic sharding

    ### Memcached

    ```python
    # Simpler, no persistence
    from pymemcache.client import base

    client = base.Client(('localhost', 11211))
    client.set('key', 'value', expire=3600)
    value = client.get('key')
    ```

    **Redis vs Memcached:**

    | Feature | Redis | Memcached |
    |---------|-------|-----------|
    | Data structures | Hash, List, Set, Sorted Set | Only strings |
    | Persistence | Yes | No |
    | Replication | Yes | No |
    | Pub/Sub | Yes | No |
    | Transactions | Yes | No |
    | Speed | Fast | Slightly faster for simple ops |

    ## Cache Stampede Problem

    **Many requests hit cache miss simultaneously**

    ```python
    # Problem:
    # 1000 concurrent requests
    # Cache expires
    # All 1000 query database simultaneously → Database overload!
    ```

    ### Solution 1: Locking

    ```python
    def get_product(product_id):
        data = cache.get(f'product:{product_id}')

        if data is None:
            # Acquire lock
            lock_key = f'lock:product:{product_id}'
            if cache.set(lock_key, '1', nx=True, ex=10):
                # Got lock - query DB
                data = db.get_product(product_id)
                cache.set(f'product:{product_id}', data, ttl=3600)
                cache.delete(lock_key)
            else:
                # Wait and retry
                time.sleep(0.1)
                return get_product(product_id)

        return data
    ```

    ### Solution 2: Probabilistic Early Expiration

    ```python
    import random

    def get_product(product_id):
        data, ttl = cache.get_with_ttl(f'product:{product_id}')

        # Probabilistically refresh before expiration
        if ttl < 300 and random.random() < 0.1:
            # Refresh in background
            queue.enqueue('refresh_cache', product_id)

        return data
    ```

    ## Caching in Practice

    ### Facebook

    ```python
    # Memcached cluster
    # 1000s of servers
    # Trillions of requests/day
    # 95%+ cache hit rate

    # Reduces database load by 100x
    ```

    ### Twitter

    ```python
    # Redis for timeline cache
    # User's timeline cached
    # Fan-out on write:
    #   User posts → Update all follower timelines (in cache)
    #   User reads → Fast read from cache

    # Trade-off: Write amplification for read performance
    ```

    ### Amazon

    ```python
    # Multi-layer caching:
    # 1. Browser cache (static assets)
    # 2. CloudFront CDN
    # 3. Application cache (ElastiCache)
    # 4. Database query cache

    # Result: Sub-100ms page loads globally
    ```

    ## Best Practices

    1. **Cache at multiple levels**
       - Browser, CDN, application, database

    2. **Use appropriate TTL**
       - Static content: Long (hours/days)
       - User data: Medium (minutes)
       - Real-time data: Short (seconds)

    3. **Monitor cache hit rate**
       ```python
       hit_rate = cache_hits / (cache_hits + cache_misses)
       # Target: 80%+ for most workloads
       ```

    4. **Plan for cache failures**
       ```python
       try:
           data = cache.get(key)
       except CacheError:
           data = db.query(...)  # Fallback to DB
       ```

    5. **Warm up cache**
       ```python
       # Pre-populate cache on deployment
       for popular_item in get_popular_items():
           cache.set(f'item:{item.id}', item)
       ```

    **Next**: We'll explore database design patterns and when to use SQL vs NoSQL.
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

# Design a URL Shortener (like bit.ly)

    Design a service that creates short URLs from long URLs.

    ## Requirements

    ### Functional Requirements
    1. Generate short URL from long URL
    2. Redirect short URL to original long URL
    3. Custom short URLs (optional)
    4. Analytics (click tracking)
    5. Expiration (optional)

    ### Non-Functional Requirements
    - High availability (99.99%)
    - Low latency (<100ms redirects)
    - Scalable (1 billion URLs, 100K writes/sec, 10M reads/sec)
    - Durable (URLs never lost)

    ## Capacity Estimation

    ```python
    # Write (create short URL)
    new_urls_per_day = 100_000_000  # 100M
    writes_per_second = 100_000_000 / 86400 = ~1160 writes/sec

    # Read (redirect)
    read_write_ratio = 100  # 100 reads per write
    reads_per_second = 1160 * 100 = 116,000 reads/sec

    # Storage (5 years)
    urls_total = 100_000_000 * 365 * 5 = 182.5 billion URLs
    avg_url_size = 500 bytes
    total_storage = 182.5B * 500 = 91 TB
    ```

    ## API Design

    ```python
    # Create short URL
    POST /api/v1/shorten
    {
      "long_url": "https://example.com/very/long/url",
      "custom_alias": "my-link",  # Optional
      "expires_at": "2024-12-31"  # Optional
    }

    Response:
    {
      "short_url": "https://short.ly/abc123",
      "long_url": "https://example.com/very/long/url"
    }

    # Redirect
    GET /abc123
    → 302 Redirect to long_url

    # Analytics
    GET /api/v1/analytics/abc123
    {
      "clicks": 1234,
      "countries": {"US": 800, "UK": 200},
      "referrers": {"twitter.com": 500}
    }
    ```

    ## URL Encoding

    ### Base62 Encoding

    **Why Base62?** [a-z, A-Z, 0-9] = 62 characters (URL-safe)

    ```python
    import string

    BASE62 = string.ascii_letters + string.digits  # 62 chars

    def encode(num):
        if num == 0:
            return BASE62[0]

        result = []
        while num > 0:
            result.append(BASE62[num % 62])
            num //= 62

        return ''.join(reversed(result))

    def decode(s):
        num = 0
        for char in s:
            num = num * 62 + BASE62.index(char)
        return num

    # Example:
    encode(125) = "cb"
    encode(12345) = "dnh"
    encode(1000000000) = "15FTGg"
    ```

    **Length calculation:**
    ```python
    # 6 characters Base62
    62^6 = 56 billion unique URLs

    # 7 characters Base62
    62^7 = 3.5 trillion unique URLs ✓ (enough!)
    ```

    ## System Design

    ### High-Level Architecture

    ```
    ┌──────────┐
    │  Client  │
    └────┬─────┘
         │
         ▼
    ┌────────────────┐
    │  Load Balancer │
    └────┬───────────┘
         │
         ├──────────────┬──────────────┐
         ▼              ▼              ▼
    ┌─────────┐   ┌─────────┐   ┌─────────┐
    │  API    │   │  API    │   │  API    │
    │ Server  │   │ Server  │   │ Server  │
    └────┬────┘   └────┬────┘   └────┬────┘
         │             │             │
         └──────┬──────┴──────┬──────┘
                │             │
         ┌──────▼──────┐ ┌───▼──────┐
         │   Cache     │ │ Database │
         │  (Redis)    │ │(Postgres)│
         └─────────────┘ └──────────┘
    ```

    ### Database Schema

    ```sql
    CREATE TABLE urls (
        id BIGSERIAL PRIMARY KEY,
        short_code VARCHAR(10) UNIQUE NOT NULL,
        long_url TEXT NOT NULL,
        user_id BIGINT,
        created_at TIMESTAMP NOT NULL,
        expires_at TIMESTAMP,
        clicks BIGINT DEFAULT 0,

        INDEX idx_short_code (short_code),
        INDEX idx_user_id (user_id)
    );

    CREATE TABLE analytics (
        id BIGSERIAL PRIMARY KEY,
        short_code VARCHAR(10) NOT NULL,
        clicked_at TIMESTAMP NOT NULL,
        country VARCHAR(2),
        referrer TEXT,
        user_agent TEXT,

        INDEX idx_short_code (short_code),
        INDEX idx_clicked_at (clicked_at)
    );
    ```

    ## ID Generation Strategies

    ### Option 1: Auto-Increment ID + Base62

    ```python
    def create_short_url(long_url):
        # Insert into database
        url_id = db.insert(long_url)  # Returns auto-increment ID

        # Encode ID to base62
        short_code = base62_encode(url_id)

        # Update record with short_code
        db.update(url_id, short_code)

        return f"https://short.ly/{short_code}"
    ```

    ✅ Simple
    ✅ Guaranteed unique
    ❌ Sequential IDs (security concern - predictable)
    ❌ Database bottleneck

    ### Option 2: Random String + Collision Check

    ```python
    import random
    import string

    def generate_random_code(length=7):
        chars = string.ascii_letters + string.digits
        return ''.join(random.choice(chars) for _ in range(length))

    def create_short_url(long_url):
        for attempt in range(5):  # Max 5 retries
            short_code = generate_random_code()

            # Try to insert (unique constraint on short_code)
            try:
                db.insert(short_code, long_url)
                return f"https://short.ly/{short_code}"
            except UniqueViolation:
                continue  # Collision, try again

        raise Exception("Failed to generate unique code")
    ```

    ✅ Non-sequential (secure)
    ✅ Distributed-friendly
    ❌ Possible collisions
    ❌ Rare failure case

    ### Option 3: Snowflake-Style Distributed ID

    ```python
    # Twitter Snowflake ID structure
    # 64 bits:
    # - 1 bit: unused (sign bit)
    # - 41 bits: timestamp (milliseconds)
    # - 10 bits: machine ID
    # - 12 bits: sequence number

    class SnowflakeIDGenerator:
        def __init__(self, machine_id):
            self.machine_id = machine_id  # 0-1023
            self.sequence = 0
            self.last_timestamp = 0

        def generate(self):
            timestamp = int(time.time() * 1000)

            if timestamp == self.last_timestamp:
                self.sequence = (self.sequence + 1) & 0xFFF
                if self.sequence == 0:
                    # Sequence overflow, wait for next millisecond
                    while timestamp <= self.last_timestamp:
                        timestamp = int(time.time() * 1000)
            else:
                self.sequence = 0

            self.last_timestamp = timestamp

            # Combine into 64-bit ID
            id = ((timestamp << 22) |
                  (self.machine_id << 12) |
                  self.sequence)

            return id

    # Generate short code
    id_gen = SnowflakeIDGenerator(machine_id=1)
    url_id = id_gen.generate()
    short_code = base62_encode(url_id)
    ```

    ✅ Distributed (no coordination)
    ✅ Sortable by time
    ✅ Guaranteed unique
    ❌ Complex implementation
    ❌ Requires machine ID assignment

    ## Caching Strategy

    ```python
    # Redis cache for hot URLs (80/20 rule)
    def redirect(short_code):
        # Check cache first
        long_url = cache.get(f"url:{short_code}")

        if long_url is None:
            # Cache miss - query database
            url = db.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)

            if url is None:
                return 404

            long_url = url.long_url

            # Cache for 1 hour
            cache.set(f"url:{short_code}", long_url, ttl=3600)

        # Async: Track analytics
        queue.enqueue('track_click', short_code, request.headers)

        return redirect(long_url, 302)
    ```

    **Cache hit rate target: 90%+**

    ## Analytics at Scale

    **Problem:** 10M clicks/sec = too many DB writes!

    ### Solution: Batch Processing

    ```python
    # Write to message queue
    def track_click(short_code, metadata):
        kafka.send('clicks', {
            'short_code': short_code,
            'timestamp': time.time(),
            'country': metadata.get('country'),
            'referrer': metadata.get('referrer')
        })

    # Background worker: Batch insert every 10 seconds
    def analytics_worker():
        while True:
            messages = kafka.consume('clicks', max_messages=10000)

            if messages:
                # Batch insert to database
                db.bulk_insert('analytics', messages)

                # Update click counts
                click_counts = Counter(m['short_code'] for m in messages)
                for short_code, count in click_counts.items():
                    db.execute(
                        "UPDATE urls SET clicks = clicks + ? WHERE short_code = ?",
                        count, short_code
                    )

            time.sleep(10)
    ```

    ## Scaling Considerations

    ### Database Sharding

    ```python
    # Shard by short_code (consistent hashing)
    def get_shard(short_code):
        shard_num = hash(short_code) % NUM_SHARDS
        return db_connections[shard_num]

    def redirect(short_code):
        db = get_shard(short_code)
        url = db.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)
        return redirect(url.long_url)
    ```

    ### Read Replicas

    ```python
    # Write to primary
    primary_db.insert(short_code, long_url)

    # Read from replicas (5 replicas)
    replica = random.choice(read_replicas)
    url = replica.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)
    ```

    ## Security & Abuse Prevention

    ### Rate Limiting

    ```python
    # Limit to 100 URLs per hour per IP
    @rate_limit(limit=100, per=3600, by='ip')
    def create_short_url(long_url, request):
        # Implementation
        pass
    ```

    ### URL Validation

    ```python
    import re
    from urllib.parse import urlparse

    def validate_url(url):
        # Check format
        if not re.match(r'https?://.+', url):
            raise ValueError("Invalid URL format")

        # Check length
        if len(url) > 2048:
            raise ValueError("URL too long")

        # Check domain (blocklist)
        domain = urlparse(url).netloc
        if domain in BLOCKED_DOMAINS:
            raise ValueError("Domain blocked")

        return True
    ```

    ## Complete Flow

    ### Create Short URL

    ```
    1. Client POSTs long URL
    2. API validates URL
    3. Generate unique short code (Snowflake ID → Base62)
    4. Store in database
    5. Return short URL
    ```

    ### Redirect

    ```
    1. Client GETs /abc123
    2. Check Redis cache
       - Hit: Return long URL
       - Miss: Query database, cache, return
    3. Async: Track click to Kafka
    4. 302 Redirect to long URL
    ```

    ## Monitoring

    ```python
    # Key metrics
    - Requests per second
    - Cache hit rate (target: 90%+)
    - P99 latency (target: <100ms)
    - Database query time
    - Error rate
    - Queue lag (analytics)
    ```

    **Next**: We'll design a social media feed system like Twitter.
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

# Scalability Fundamentals

    **Scalability** is the ability of a system to handle increased load by adding resources.

    ## Scalability vs Performance

    ### Performance
    - How fast a system processes a single request
    - Measured in: response time, latency, throughput
    - Example: Reduce query time from 100ms to 10ms

    ### Scalability
    - How well a system handles increased load
    - Measured in: requests/second, concurrent users
    - Example: Handle 10x more users

    **Key Insight**: A performant system isn't necessarily scalable!

    ```
    Performant but not scalable:
    - Serves one user in 10ms
    - Crashes at 1000 concurrent users

    Scalable but not performant:
    - Serves one user in 500ms
    - Handles 100,000 concurrent users
    ```

    ## Types of Scalability

    ### 1. Vertical Scaling (Scale Up)

    **Add more power to existing machines**

    ```
    Before: 4 CPU cores, 8GB RAM
    After:  16 CPU cores, 64GB RAM
    ```

    ✅ **Pros:**
    - Simple to implement
    - No code changes needed
    - No distributed system complexity
    - ACID transactions remain simple

    ❌ **Cons:**
    - Hardware limits (max CPU/RAM)
    - Expensive at high end
    - Single point of failure
    - Downtime during upgrades

    **When to use:** Early stage, simple applications, databases requiring ACID

    ### 2. Horizontal Scaling (Scale Out)

    **Add more machines**

    ```
    Before: 1 server
    After:  10 servers (with load balancer)
    ```

    ✅ **Pros:**
    - Virtually unlimited scaling
    - More cost-effective
    - Better fault tolerance
    - No downtime for upgrades

    ❌ **Cons:**
    - Code must support distribution
    - Data consistency challenges
    - Network overhead
    - More complex architecture

    **When to use:** High growth, web applications, stateless services

    ## Measuring Scalability

    ### Key Metrics

    **1. Throughput**
    - Requests per second (RPS)
    - Transactions per second (TPS)
    - Data processed per second

    **2. Latency**
    - p50: 50% of requests faster than X
    - p95: 95% of requests faster than X
    - p99: 99% of requests faster than X

    ```python
    # Example latency distribution
    p50 = 100ms  # Median
    p95 = 250ms  # Most users experience this or better
    p99 = 500ms  # Outliers
    p99.9 = 2s   # Worst case (network issues, etc.)
    ```

    **3. Concurrent Users**
    - Active connections
    - Active sessions
    - Simultaneous requests

    ### Capacity Planning

    **Calculate required capacity:**

    ```python
    # Example: Social media feed
    daily_active_users = 10_000_000
    avg_requests_per_user_per_day = 50
    total_daily_requests = daily_active_users * avg_requests_per_user_per_day
    # = 500,000,000 requests/day

    peak_multiplier = 3  # Traffic 3x higher at peak
    requests_per_second = (total_daily_requests * peak_multiplier) / 86400
    # = ~17,361 RPS at peak

    # If each server handles 1000 RPS:
    servers_needed = 17361 / 1000 = 18 servers
    # Add 50% buffer: 27 servers
    ```

    ## Bottlenecks

    ### Common Bottlenecks

    **1. Database**
    ```sql
    -- Slow query on large table
    SELECT * FROM users WHERE email LIKE '%gmail.com';
    -- No index = table scan = slow!
    ```

    **Solution:**
    - Add indexes
    - Optimize queries
    - Use caching
    - Database replication
    - Sharding

    **2. Network**
    ```
    Large payloads = slow responses
    100MB image × 1000 users = network saturation
    ```

    **Solution:**
    - Compress responses (gzip)
    - Use CDN
    - Optimize payload size
    - Connection pooling

    **3. CPU**
    ```python
    # CPU-intensive operation
    for user in all_users:  # 1 million users
        calculate_recommendations(user)  # 100ms each
    # Total: 27 hours!
    ```

    **Solution:**
    - Async processing
    - Background jobs
    - Caching results
    - Horizontal scaling

    **4. Memory**
    ```python
    # Loading all users in memory
    all_users = User.all()  # 10M users × 1KB = 10GB RAM
    # Server only has 8GB = crash!
    ```

    **Solution:**
    - Pagination
    - Streaming
    - Lazy loading
    - Add more RAM (vertical scaling)

    ## Stateless vs Stateful

    ### Stateless Services

    **No session state stored on server**

    ```javascript
    // Stateless API
    app.get('/user/:id', (req, res) => {
      const user = db.getUser(req.params.id);
      res.json(user);
    });
    // Each request independent, any server can handle it
    ```

    ✅ **Benefits:**
    - Easy to scale horizontally
    - Any server can handle any request
    - No session replication needed
    - Load balancing is simple

    ### Stateful Services

    **Session state stored on server**

    ```javascript
    // Stateful (session stored in memory)
    app.get('/cart', (req, res) => {
      const cart = req.session.cart;  // Stored in this server's memory
      res.json(cart);
    });
    // Must route user to same server!
    ```

    **Solutions for stateful apps:**

    1. **Sticky Sessions** (route user to same server)
    ```nginx
    upstream backend {
        ip_hash;  # Same IP → same server
        server backend1.example.com;
        server backend2.example.com;
    }
    ```

    2. **External Session Store**
    ```javascript
    // Store session in Redis
    app.use(session({
      store: new RedisStore({ client: redisClient }),
      secret: 'secret'
    }));
    // Now any server can handle request!
    ```

    ## Reliability Metrics

    ### Availability

    **Percentage of time system is operational**

    ```
    Availability = Uptime / (Uptime + Downtime)
    ```

    **Industry Standards:**

    | Level | Availability | Downtime/Year | Downtime/Month |
    |-------|-------------|---------------|----------------|
    | 90% | "One nine" | 36.5 days | 3 days |
    | 99% | "Two nines" | 3.65 days | 7.2 hours |
    | 99.9% | "Three nines" | 8.76 hours | 43.8 minutes |
    | 99.99% | "Four nines" | 52.6 minutes | 4.38 minutes |
    | 99.999% | "Five nines" | 5.26 minutes | 26 seconds |

    **Achieving high availability:**

    1. **Redundancy**
    ```
    Single server = 99% uptime
    Two servers (failover) = 99.99% uptime
    ```

    2. **Health Checks**
    ```python
    # Load balancer checks health
    @app.route('/health')
    def health():
        if database.is_connected():
            return {'status': 'healthy'}, 200
        return {'status': 'unhealthy'}, 503
    ```

    3. **Graceful Degradation**
    ```python
    def get_recommendations():
        try:
            return recommendation_service.get()
        except Exception:
            # Fallback to cached recommendations
            return cache.get('default_recommendations')
    ```

    ### MTBF and MTTR

    **MTBF (Mean Time Between Failures)**
    - Average time between failures
    - Higher is better

    **MTTR (Mean Time To Recovery)**
    - Average time to recover from failure
    - Lower is better

    ```
    Availability = MTBF / (MTBF + MTTR)

    Example:
    MTBF = 720 hours (30 days)
    MTTR = 1 hour
    Availability = 720 / (720 + 1) = 99.86%
    ```

    ## Real-World Example: Twitter

    **Scaling challenges:**

    ```
    Users: 330 million
    Tweets per day: 500 million
    Reads: 10 billion/day (20x more reads than writes)
    Peak: 143,000 tweets/second (New Year's Eve)
    ```

    **Solutions applied:**

    1. **Read/Write Separation**
       - Write to main database
       - Read from replicas

    2. **Caching**
       - Timeline cache (Redis)
       - Reduces database load 100x

    3. **Async Processing**
       - Tweet posting → queue → background processing
       - Fan-out to followers happens async

    4. **CDN**
       - Images, videos served from edge locations
       - Reduces latency globally

    **Next**: We'll dive into the CAP theorem and distributed systems tradeoffs.
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 7: Lesson 7 ===
lesson_7 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 7',
  content: <<~MARKDOWN,
# Microlesson 🚀

# CAP Theorem and Consistency

    The **CAP theorem** states that a distributed system can only guarantee **two out of three** properties:

    ## The Three Properties

    ### C = Consistency
    **All nodes see the same data at the same time**

    ```
    User writes: balance = $100
    User reads from ANY node: balance = $100
    ```

    Every read receives the most recent write.

    ### A = Availability
    **Every request receives a response (success or failure)**

    ```
    User makes request → Always gets a response
    (Even if some nodes are down)
    ```

    System continues to operate despite failures.

    ### P = Partition Tolerance
    **System continues despite network partitions**

    ```
    Network split: [Node1, Node2] | [Node3, Node4]
    System still operates on both sides
    ```

    System handles arbitrary network failures.

    ## Why You Can't Have All Three

    **During a network partition, you must choose:**

    ### CP (Consistency + Partition Tolerance)
    **Sacrifice Availability**

    ```
    Network partition detected
    → Reject writes until partition heals
    → Ensures all nodes have consistent data
    → But some requests fail (unavailable)
    ```

    **Examples:** Banking systems, inventory management

    ### AP (Availability + Partition Tolerance)
    **Sacrifice Consistency**

    ```
    Network partition detected
    → Accept writes on both sides
    → All requests succeed (available)
    → But data may diverge (inconsistent)
    → Reconcile conflicts later
    ```

    **Examples:** Social media feeds, DNS, shopping carts

    ### CA (Consistency + Availability)
    **Not possible in distributed systems!**

    Network partitions will happen, so you must be partition tolerant.

    ## Real-World Systems

    ### CP Systems

    **MongoDB (with default settings)**
    ```javascript
    // Write with majority concern
    db.users.insert(
      { name: "Alice", balance: 100 },
      { writeConcern: { w: "majority" } }
    );
    // Blocks until majority of replicas confirm
    // If partition: write fails (CP)
    ```

    **HBase, Redis Cluster**

    **When to use:**
    - Financial transactions
    - Inventory management
    - Ticket booking
    - Seat reservations

    ### AP Systems

    **Cassandra**
    ```sql
    -- Write with eventual consistency
    INSERT INTO users (id, name, balance)
    VALUES (1, 'Alice', 100);
    -- Returns immediately, replicates async
    -- If partition: writes succeed on available nodes (AP)
    ```

    **DynamoDB, Riak, CouchDB**

    **When to use:**
    - Social media feeds
    - Analytics
    - Logging
    - Shopping carts
    - DNS

    ## Consistency Models

    ### 1. Strong Consistency
    **All nodes show same data at same time**

    ```python
    # Write
    db.write('key', 'value1')

    # Immediate read from ANY node
    db.read('key')  # Always returns 'value1'
    ```

    ✅ Simple to reason about
    ❌ Higher latency, lower availability

    ### 2. Eventual Consistency
    **All nodes will eventually have same data**

    ```python
    # Write to Node1
    node1.write('key', 'value1')

    # Read from Node2 (immediately)
    node2.read('key')  # Might return old value or 'value1'

    # Read from Node2 (after propagation)
    time.sleep(0.1)
    node2.read('key')  # Returns 'value1'
    ```

    ✅ Lower latency, higher availability
    ❌ Temporary inconsistencies

    **Real example: Facebook**
    ```
    User posts status update
    → Writes to primary datacenter
    → Eventually propagates to global replicas
    → Different users might see update at different times
    ```

    ### 3. Causal Consistency
    **Causally related operations are seen in order**

    ```python
    # User A posts comment
    post_comment("Great post!")  # Event 1

    # User B replies to comment
    reply_comment("Thanks!")     # Event 2 (depends on Event 1)

    # All users see Event 1 before Event 2
    # But unrelated events may appear in any order
    ```

    ### 4. Read-After-Write Consistency
    **User sees their own writes immediately**

    ```python
    # User updates profile
    user.update(name="Alice")

    # User immediately views profile
    user.get()  # Guaranteed to see "Alice"

    # Other users may see old value temporarily
    ```

    ## Quorum Reads and Writes

    **Ensure consistency by reading/writing to majority of nodes**

    ### Configuration

    ```
    N = Total replicas (e.g., 5)
    W = Write quorum (e.g., 3)
    R = Read quorum (e.g., 3)
    ```

    **Strong consistency when: W + R > N**

    ```
    N = 5 replicas
    W = 3 (write to 3 nodes)
    R = 3 (read from 3 nodes)
    W + R = 6 > N = 5 ✓

    Guaranteed to read at least one node with latest write!
    ```

    ### Example: Cassandra

    ```sql
    -- Write with quorum
    INSERT INTO users (id, name) VALUES (1, 'Alice')
    USING CONSISTENCY QUORUM;

    -- Read with quorum
    SELECT * FROM users WHERE id = 1
    USING CONSISTENCY QUORUM;
    ```

    **Tradeoffs:**

    | Configuration | Consistency | Availability | Latency |
    |--------------|-------------|--------------|---------|
    | W=1, R=1 | Weak | High | Low |
    | W=QUORUM, R=QUORUM | Strong | Medium | Medium |
    | W=ALL, R=1 | Strong reads | Low writes | High writes |

    ## Conflict Resolution

    ### Last Write Wins (LWW)

    ```python
    # Conflict: Two writes to same key
    Node1: write('user:1:name', 'Alice', timestamp=100)
    Node2: write('user:1:name', 'Alicia', timestamp=101)

    # Resolution: Keep latest timestamp
    Final value: 'Alicia' (timestamp 101)
    ```

    ❌ **Problem:** Clock skew can cause issues
    ✅ **Simple and predictable**

    ### Vector Clocks

    ```python
    # Track causality with vector clocks
    Version 1: {server1: 1, server2: 0} → name="Alice"
    Version 2: {server1: 1, server2: 1} → name="Alicia"

    # Version 2 happened after Version 1 (causally)
    # Keep Version 2
    ```

    ### Application-Level Resolution

    ```python
    # Shopping cart example
    User adds from Node1: cart = [item1, item2]
    User adds from Node2: cart = [item3]

    # Conflict!
    # Resolution: Merge carts
    Final cart = [item1, item2, item3]
    ```

    ## ACID vs BASE

    ### ACID (Traditional Databases)

    - **Atomicity**: All or nothing
    - **Consistency**: Valid state always
    - **Isolation**: Transactions don't interfere
    - **Durability**: Committed data persists

    ```sql
    BEGIN TRANSACTION;
    UPDATE accounts SET balance = balance - 100 WHERE id = 1;
    UPDATE accounts SET balance = balance + 100 WHERE id = 2;
    COMMIT;  -- Both updates or neither
    ```

    ### BASE (Distributed Systems)

    - **Basically Available**: System available most of the time
    - **Soft state**: State may change over time (eventual consistency)
    - **Eventually consistent**: Will become consistent given enough time

    ```python
    # BASE example: Shopping cart
    add_to_cart(user_id, item)  # Succeeds immediately
    # Cart replicated eventually to all nodes
    # Conflicts merged later
    ```

    ## Practical Decisions

    ### E-commerce System

    **Product Catalog (AP)**
    ```
    - Eventual consistency OK
    - Availability critical (can't lose sales)
    - Temporary stale data acceptable
    → Use Cassandra or DynamoDB
    ```

    **Inventory (CP)**
    ```
    - Strong consistency required
    - Can't oversell items
    - Brief unavailability acceptable
    → Use relational DB with proper locking
    ```

    **Shopping Cart (AP)**
    ```
    - Eventual consistency OK
    - Must remain available
    - Merge conflicts (combine items)
    → Use DynamoDB or Cassandra
    ```

    **Orders/Payments (CP)**
    ```
    - Strong consistency critical
    - No duplicate charges
    - ACID transactions needed
    → Use PostgreSQL or MySQL
    ```

    ## Best Practices

    1. **Choose based on business requirements**
       - Critical data = CP (consistency)
       - User-facing = AP (availability)

    2. **Hybrid approach**
       - Different subsystems can make different tradeoffs
       - Use both CP and AP systems

    3. **Design for partition tolerance**
       - Network failures will happen
       - Plan for split-brain scenarios

    4. **Monitor and measure**
       - Track consistency lag
       - Measure availability SLAs

    **Next**: We'll explore load balancing strategies and patterns.
  MARKDOWN
  sequence_order: 7,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 8: Lesson 8 ===
lesson_8 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 8',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Load Balancing Strategies

    A **load balancer** distributes incoming requests across multiple servers to improve reliability and capacity.

    ## Why Load Balancing?

    ```
    Without LB:
    Single server → 1000 RPS max → Bottleneck

    With LB:
    10 servers × 1000 RPS = 10,000 RPS capacity
    + Fault tolerance (1 server fails → 9 still work)
    ```

    ## Load Balancer Types

    ### Layer 4 (Transport Layer)
    **Operates at TCP/UDP level**

    ```nginx
    # Routes based on IP and port
    Client → LB (checks IP:port) → Server
    ```

    ✅ Fast (no need to inspect content)
    ✅ Low latency
    ❌ Limited routing logic
    ❌ No content-based routing

    ### Layer 7 (Application Layer)
    **Operates at HTTP level**

    ```nginx
    # Routes based on URL, headers, cookies
    /api/* → API servers
    /static/* → Static file servers
    ```

    ✅ Smart routing (URL, headers, cookies)
    ✅ SSL termination
    ✅ Caching
    ❌ Slightly higher latency

    ## Load Balancing Algorithms

    ### 1. Round Robin

    ```
    Request 1 → Server 1
    Request 2 → Server 2
    Request 3 → Server 3
    Request 4 → Server 1 (cycle repeats)
    ```

    ✅ Simple, fair distribution
    ❌ Doesn't account for server capacity
    ❌ Doesn't account for server load

    **When to use:** Servers have equal capacity, requests have similar load

    ### 2. Weighted Round Robin

    ```
    Server 1 (weight 3): Gets 3 requests
    Server 2 (weight 2): Gets 2 requests
    Server 3 (weight 1): Gets 1 request
    ```

    ✅ Accounts for different server capacities
    ❌ Still doesn't account for current load

    **When to use:** Servers have different capacities (e.g., different instance sizes)

    ### 3. Least Connections

    ```
    Server 1: 5 active connections
    Server 2: 3 active connections ← New request goes here
    Server 3: 7 active connections
    ```

    ✅ Accounts for current load
    ✅ Good for long-lived connections
    ❌ Requires tracking connections

    **When to use:** WebSocket connections, database connections, long-polling

    ### 4. Least Response Time

    ```
    Server 1: avg 100ms response time
    Server 2: avg 50ms response time ← New request goes here
    Server 3: avg 150ms response time
    ```

    ✅ Routes to fastest server
    ✅ Accounts for server performance
    ❌ Requires health checks with latency monitoring

    **When to use:** Servers with varying performance, heterogeneous infrastructure

    ### 5. IP Hash (Consistent Hashing)

    ```python
    # Hash client IP to determine server
    server_index = hash(client_ip) % num_servers
    ```

    ✅ Same client → same server (session affinity)
    ✅ Good for caching (server-local cache)
    ❌ Uneven distribution if few clients
    ❌ Sticky sessions (hard to scale)

    **When to use:** Stateful applications, server-side caching

    ### 6. Random

    ```python
    import random
    server = random.choice(servers)
    ```

    ✅ Simple
    ✅ Works well with large number of requests
    ❌ Can be uneven in short term

    **When to use:** Stateless apps, microservices

    ## Health Checks

    **Ensure requests only go to healthy servers**

    ### Active Health Checks

    ```python
    # Load balancer periodically checks servers
    @app.route('/health')
    def health_check():
        # Check database connection
        if not db.is_connected():
            return {'status': 'unhealthy'}, 503

        # Check critical dependencies
        if not cache.ping():
            return {'status': 'degraded'}, 200

        return {'status': 'healthy'}, 200
    ```

    **Configuration:**
    ```nginx
    upstream backend {
        server backend1:8000;
        server backend2:8000;

        # Health check every 5 seconds
        check interval=5000 rise=2 fall=3 timeout=1000;
    }
    ```

    ### Passive Health Checks

    ```
    Monitor actual traffic:
    - 3 failed requests in 10s → Mark unhealthy
    - Server recovers → Mark healthy after 2 successful requests
    ```

    ## Common Load Balancers

    ### Nginx

    ```nginx
    upstream backend {
        least_conn;  # Use least connections algorithm
        server backend1.example.com;
        server backend2.example.com;
        server backend3.example.com;
    }

    server {
        listen 80;
        location / {
            proxy_pass http://backend;
        }
    }
    ```

    ### HAProxy

    ```haproxy
    frontend http_front
        bind *:80
        default_backend http_back

    backend http_back
        balance roundrobin
        server server1 10.0.0.1:8000 check
        server server2 10.0.0.2:8000 check
        server server3 10.0.0.3:8000 check
    ```

    ### AWS Application Load Balancer (ALB)

    ```python
    # Layer 7 load balancing
    # Routes based on:
    - URL path (/api/* → API servers)
    - Host header (api.example.com → API servers)
    - HTTP headers
    - Query parameters
    ```

    ### AWS Network Load Balancer (NLB)

    ```python
    # Layer 4 load balancing
    - Ultra-low latency
    - Handles millions of RPS
    - Static IP addresses
    ```

    ## Session Persistence (Sticky Sessions)

    ### Cookie-Based

    ```nginx
    upstream backend {
        sticky cookie srv_id expires=1h domain=.example.com path=/;
        server backend1:8000;
        server backend2:8000;
    }
    ```

    **Flow:**
    ```
    1. First request → Server 1
    2. LB sets cookie: srv_id=server1
    3. Future requests include cookie → Always route to Server 1
    ```

    ### IP-Based

    ```nginx
    upstream backend {
        ip_hash;
        server backend1:8000;
        server backend2:8000;
    }
    ```

    **Problems with sticky sessions:**
    - Uneven load distribution
    - Server failure = session loss
    - Harder to scale

    **Better solution:** Use external session store (Redis)

    ## SSL/TLS Termination

    **Load balancer handles SSL, backends use HTTP**

    ```nginx
    server {
        listen 443 ssl;
        ssl_certificate /path/to/cert.pem;
        ssl_certificate_key /path/to/key.pem;

        location / {
            proxy_pass http://backend;  # HTTP to backend
        }
    }
    ```

    **Benefits:**
    - Centralized certificate management
    - Reduced CPU load on backends
    - Simpler backend configuration

    ## Global Load Balancing (GSLB)

    **Route users to nearest datacenter**

    ```
    User in US → us-east-1 datacenter
    User in EU → eu-west-1 datacenter
    User in Asia → ap-southeast-1 datacenter
    ```

    **Methods:**
    1. **DNS-based** (Route53, Cloudflare)
       ```
       example.com → Different IP based on user location
       ```

    2. **Anycast**
       ```
       Same IP announced from multiple locations
       BGP routes to nearest
       ```

    ## Real-World Example: Netflix

    **Challenge:**
    - 200+ million subscribers
    - Global traffic
    - High availability required

    **Solution:**
    ```
    1. AWS ELB for load balancing
    2. Auto-scaling groups (add/remove servers based on load)
    3. Multi-region deployment
    4. Route53 for DNS-based routing
    5. Health checks with automatic failover
    ```

    **Results:**
    - 99.99% availability
    - Handles traffic spikes (new releases)
    - Global low latency

    **Next**: We'll explore caching strategies to reduce load and improve performance.
  MARKDOWN
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Lesson 9 ===
lesson_9 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 9',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Caching Strategies

    **Caching** stores frequently accessed data in fast storage to reduce latency and load.

    ## Why Cache?

    ```
    Database query: 100ms
    Cache lookup:   1ms
    Speed up:       100x faster!

    Without cache:  1000 req/s × 100ms = Max 10 concurrent
    With cache:     1000 req/s × 1ms = Easy!
    ```

    ## Cache Levels

    ### 1. Client-Side Cache (Browser)

    ```html
    <!-- HTTP caching headers -->
    Cache-Control: public, max-age=31536000, immutable
    ```

    **Benefits:**
    - Fastest (no network request)
    - Reduces bandwidth
    - Improves UX

    **Example:**
    ```javascript
    // Static assets cached for 1 year
    app.use('/static', express.static('public', {
      maxAge: '1y',
      immutable: true
    }));
    ```

    ### 2. CDN Cache

    ```
    User in Tokyo → Tokyo edge cache (10ms latency)
    vs
    User in Tokyo → US origin server (200ms latency)
    ```

    **How it works:**
    ```
    1. User requests image.jpg
    2. CDN checks edge cache
    3. If cached → Return (fast!)
    4. If not → Fetch from origin, cache, return
    ```

    **Popular CDNs:**
    - Cloudflare
    - AWS CloudFront
    - Fastly
    - Akamai

    ### 3. Application Cache (Redis/Memcached)

    ```python
    # Check cache first
    user = cache.get(f'user:{user_id}')

    if user is None:
        # Cache miss - query database
        user = db.query('SELECT * FROM users WHERE id = ?', user_id)
        # Store in cache for 1 hour
        cache.set(f'user:{user_id}', user, ttl=3600)

    return user
    ```

    ### 4. Database Cache

    ```sql
    -- Query result cache (MySQL)
    SELECT SQL_CACHE * FROM products WHERE category = 'electronics';
    ```

    ## Caching Patterns

    ### 1. Cache-Aside (Lazy Loading)

    **Application manages cache**

    ```python
    def get_user(user_id):
        # Try cache first
        user = cache.get(f'user:{user_id}')

        if user is None:  # Cache miss
            user = db.get_user(user_id)
            cache.set(f'user:{user_id}', user, ttl=3600)

        return user

    def update_user(user_id, data):
        # Update database
        db.update_user(user_id, data)
        # Invalidate cache
        cache.delete(f'user:{user_id}')
    ```

    ✅ Only cache what's needed
    ✅ Cache survives failures
    ❌ Cache miss penalty
    ❌ Potential stale data

    **When to use:** Most common pattern, general-purpose caching

    ### 2. Write-Through

    **Write to cache AND database**

    ```python
    def update_user(user_id, data):
        # Write to database
        db.update_user(user_id, data)
        # Update cache
        cache.set(f'user:{user_id}', data, ttl=3600)
    ```

    ✅ Cache always consistent
    ❌ Write latency (2 writes)
    ❌ Most data never read (wasted cache)

    **When to use:** Read-heavy workloads where consistency is critical

    ### 3. Write-Behind (Write-Back)

    **Write to cache, async write to database**

    ```python
    def update_user(user_id, data):
        # Write to cache immediately
        cache.set(f'user:{user_id}', data)
        # Queue database update
        queue.enqueue('update_user_db', user_id, data)

    # Background worker
    def worker():
        job = queue.dequeue()
        db.update_user(job.user_id, job.data)
    ```

    ✅ Low write latency
    ✅ Batch database writes
    ❌ Data loss risk if cache fails
    ❌ Complex to implement

    **When to use:** Write-heavy workloads, analytics, logging

    ### 4. Read-Through

    **Cache automatically loads from database**

    ```python
    # Cache library handles everything
    @cache.memoize(ttl=3600)
    def get_user(user_id):
        return db.get_user(user_id)

    # First call: Cache miss → DB query → Cache store → Return
    # Later calls: Cache hit → Return (no DB query)
    ```

    ✅ Simple application code
    ❌ Cache coupled to database
    ❌ Less control

    **When to use:** Simple applications, ORMs with caching support

    ## Cache Eviction Policies

    ### LRU (Least Recently Used)

    ```python
    # Most common eviction policy
    # Removes least recently accessed items first

    Cache (max 3 items):
    Access A → [A]
    Access B → [B, A]
    Access C → [C, B, A]
    Access D → [D, C, B]  # A evicted (least recently used)
    Access B → [B, D, C]  # B moved to front
    ```

    **When to use:** General-purpose caching (default choice)

    ### LFU (Least Frequently Used)

    ```python
    # Removes least frequently accessed items
    # Tracks access count

    A: 10 accesses
    B: 5 accesses
    C: 2 accesses ← Evicted first
    ```

    **When to use:** Items have different access patterns over time

    ### FIFO (First In, First Out)

    ```python
    # Removes oldest items first
    # Like a queue

    Add A → [A]
    Add B → [B, A]
    Add C → [C, B, A]
    Add D → [D, C, B]  # A evicted (oldest)
    ```

    **When to use:** Time-based data, logs

    ### TTL (Time To Live)

    ```python
    # Auto-expire after time period
    cache.set('session:123', data, ttl=3600)  # Expires in 1 hour
    ```

    **When to use:** Sessions, temporary data, rate limiting

    ## Cache Invalidation

    **"There are only two hard things in Computer Science: cache invalidation and naming things."**

    ### 1. TTL-Based

    ```python
    # Set expiration time
    cache.set('products:list', products, ttl=300)  # 5 minutes
    ```

    ✅ Simple
    ❌ Stale data before expiration

    ### 2. Event-Based

    ```python
    # Invalidate on events
    def create_product(product):
        db.insert(product)
        cache.delete('products:list')  # Invalidate list cache
        cache.delete(f'products:category:{product.category}')
    ```

    ✅ Cache always fresh
    ❌ Careful with dependencies

    ### 3. Version-Based

    ```python
    # Include version in key
    def get_products(version):
        return cache.get(f'products:list:v{version}')

    # When data changes, increment version
    PRODUCT_VERSION = 2  # Invalidates old cache
    ```

    ✅ No explicit invalidation needed
    ❌ Must track versions

    ## Distributed Caching

    ### Redis Cluster

    ```python
    # Data sharded across nodes
    import redis

    # Connect to cluster
    rc = redis.RedisCluster(
        startup_nodes=[
            {"host": "node1", "port": 6379},
            {"host": "node2", "port": 6379},
            {"host": "node3", "port": 6379}
        ]
    )

    # Automatically routes to correct node
    rc.set('user:123', user_data)
    ```

    **Benefits:**
    - Horizontal scaling
    - High availability
    - Automatic sharding

    ### Memcached

    ```python
    # Simpler, no persistence
    from pymemcache.client import base

    client = base.Client(('localhost', 11211))
    client.set('key', 'value', expire=3600)
    value = client.get('key')
    ```

    **Redis vs Memcached:**

    | Feature | Redis | Memcached |
    |---------|-------|-----------|
    | Data structures | Hash, List, Set, Sorted Set | Only strings |
    | Persistence | Yes | No |
    | Replication | Yes | No |
    | Pub/Sub | Yes | No |
    | Transactions | Yes | No |
    | Speed | Fast | Slightly faster for simple ops |

    ## Cache Stampede Problem

    **Many requests hit cache miss simultaneously**

    ```python
    # Problem:
    # 1000 concurrent requests
    # Cache expires
    # All 1000 query database simultaneously → Database overload!
    ```

    ### Solution 1: Locking

    ```python
    def get_product(product_id):
        data = cache.get(f'product:{product_id}')

        if data is None:
            # Acquire lock
            lock_key = f'lock:product:{product_id}'
            if cache.set(lock_key, '1', nx=True, ex=10):
                # Got lock - query DB
                data = db.get_product(product_id)
                cache.set(f'product:{product_id}', data, ttl=3600)
                cache.delete(lock_key)
            else:
                # Wait and retry
                time.sleep(0.1)
                return get_product(product_id)

        return data
    ```

    ### Solution 2: Probabilistic Early Expiration

    ```python
    import random

    def get_product(product_id):
        data, ttl = cache.get_with_ttl(f'product:{product_id}')

        # Probabilistically refresh before expiration
        if ttl < 300 and random.random() < 0.1:
            # Refresh in background
            queue.enqueue('refresh_cache', product_id)

        return data
    ```

    ## Caching in Practice

    ### Facebook

    ```python
    # Memcached cluster
    # 1000s of servers
    # Trillions of requests/day
    # 95%+ cache hit rate

    # Reduces database load by 100x
    ```

    ### Twitter

    ```python
    # Redis for timeline cache
    # User's timeline cached
    # Fan-out on write:
    #   User posts → Update all follower timelines (in cache)
    #   User reads → Fast read from cache

    # Trade-off: Write amplification for read performance
    ```

    ### Amazon

    ```python
    # Multi-layer caching:
    # 1. Browser cache (static assets)
    # 2. CloudFront CDN
    # 3. Application cache (ElastiCache)
    # 4. Database query cache

    # Result: Sub-100ms page loads globally
    ```

    ## Best Practices

    1. **Cache at multiple levels**
       - Browser, CDN, application, database

    2. **Use appropriate TTL**
       - Static content: Long (hours/days)
       - User data: Medium (minutes)
       - Real-time data: Short (seconds)

    3. **Monitor cache hit rate**
       ```python
       hit_rate = cache_hits / (cache_hits + cache_misses)
       # Target: 80%+ for most workloads
       ```

    4. **Plan for cache failures**
       ```python
       try:
           data = cache.get(key)
       except CacheError:
           data = db.query(...)  # Fallback to DB
       ```

    5. **Warm up cache**
       ```python
       # Pre-populate cache on deployment
       for popular_item in get_popular_items():
           cache.set(f'item:{item.id}', item)
       ```

    **Next**: We'll explore database design patterns and when to use SQL vs NoSQL.
  MARKDOWN
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Lesson 10 ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 10',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Design a URL Shortener (like bit.ly)

    Design a service that creates short URLs from long URLs.

    ## Requirements

    ### Functional Requirements
    1. Generate short URL from long URL
    2. Redirect short URL to original long URL
    3. Custom short URLs (optional)
    4. Analytics (click tracking)
    5. Expiration (optional)

    ### Non-Functional Requirements
    - High availability (99.99%)
    - Low latency (<100ms redirects)
    - Scalable (1 billion URLs, 100K writes/sec, 10M reads/sec)
    - Durable (URLs never lost)

    ## Capacity Estimation

    ```python
    # Write (create short URL)
    new_urls_per_day = 100_000_000  # 100M
    writes_per_second = 100_000_000 / 86400 = ~1160 writes/sec

    # Read (redirect)
    read_write_ratio = 100  # 100 reads per write
    reads_per_second = 1160 * 100 = 116,000 reads/sec

    # Storage (5 years)
    urls_total = 100_000_000 * 365 * 5 = 182.5 billion URLs
    avg_url_size = 500 bytes
    total_storage = 182.5B * 500 = 91 TB
    ```

    ## API Design

    ```python
    # Create short URL
    POST /api/v1/shorten
    {
      "long_url": "https://example.com/very/long/url",
      "custom_alias": "my-link",  # Optional
      "expires_at": "2024-12-31"  # Optional
    }

    Response:
    {
      "short_url": "https://short.ly/abc123",
      "long_url": "https://example.com/very/long/url"
    }

    # Redirect
    GET /abc123
    → 302 Redirect to long_url

    # Analytics
    GET /api/v1/analytics/abc123
    {
      "clicks": 1234,
      "countries": {"US": 800, "UK": 200},
      "referrers": {"twitter.com": 500}
    }
    ```

    ## URL Encoding

    ### Base62 Encoding

    **Why Base62?** [a-z, A-Z, 0-9] = 62 characters (URL-safe)

    ```python
    import string

    BASE62 = string.ascii_letters + string.digits  # 62 chars

    def encode(num):
        if num == 0:
            return BASE62[0]

        result = []
        while num > 0:
            result.append(BASE62[num % 62])
            num //= 62

        return ''.join(reversed(result))

    def decode(s):
        num = 0
        for char in s:
            num = num * 62 + BASE62.index(char)
        return num

    # Example:
    encode(125) = "cb"
    encode(12345) = "dnh"
    encode(1000000000) = "15FTGg"
    ```

    **Length calculation:**
    ```python
    # 6 characters Base62
    62^6 = 56 billion unique URLs

    # 7 characters Base62
    62^7 = 3.5 trillion unique URLs ✓ (enough!)
    ```

    ## System Design

    ### High-Level Architecture

    ```
    ┌──────────┐
    │  Client  │
    └────┬─────┘
         │
         ▼
    ┌────────────────┐
    │  Load Balancer │
    └────┬───────────┘
         │
         ├──────────────┬──────────────┐
         ▼              ▼              ▼
    ┌─────────┐   ┌─────────┐   ┌─────────┐
    │  API    │   │  API    │   │  API    │
    │ Server  │   │ Server  │   │ Server  │
    └────┬────┘   └────┬────┘   └────┬────┘
         │             │             │
         └──────┬──────┴──────┬──────┘
                │             │
         ┌──────▼──────┐ ┌───▼──────┐
         │   Cache     │ │ Database │
         │  (Redis)    │ │(Postgres)│
         └─────────────┘ └──────────┘
    ```

    ### Database Schema

    ```sql
    CREATE TABLE urls (
        id BIGSERIAL PRIMARY KEY,
        short_code VARCHAR(10) UNIQUE NOT NULL,
        long_url TEXT NOT NULL,
        user_id BIGINT,
        created_at TIMESTAMP NOT NULL,
        expires_at TIMESTAMP,
        clicks BIGINT DEFAULT 0,

        INDEX idx_short_code (short_code),
        INDEX idx_user_id (user_id)
    );

    CREATE TABLE analytics (
        id BIGSERIAL PRIMARY KEY,
        short_code VARCHAR(10) NOT NULL,
        clicked_at TIMESTAMP NOT NULL,
        country VARCHAR(2),
        referrer TEXT,
        user_agent TEXT,

        INDEX idx_short_code (short_code),
        INDEX idx_clicked_at (clicked_at)
    );
    ```

    ## ID Generation Strategies

    ### Option 1: Auto-Increment ID + Base62

    ```python
    def create_short_url(long_url):
        # Insert into database
        url_id = db.insert(long_url)  # Returns auto-increment ID

        # Encode ID to base62
        short_code = base62_encode(url_id)

        # Update record with short_code
        db.update(url_id, short_code)

        return f"https://short.ly/{short_code}"
    ```

    ✅ Simple
    ✅ Guaranteed unique
    ❌ Sequential IDs (security concern - predictable)
    ❌ Database bottleneck

    ### Option 2: Random String + Collision Check

    ```python
    import random
    import string

    def generate_random_code(length=7):
        chars = string.ascii_letters + string.digits
        return ''.join(random.choice(chars) for _ in range(length))

    def create_short_url(long_url):
        for attempt in range(5):  # Max 5 retries
            short_code = generate_random_code()

            # Try to insert (unique constraint on short_code)
            try:
                db.insert(short_code, long_url)
                return f"https://short.ly/{short_code}"
            except UniqueViolation:
                continue  # Collision, try again

        raise Exception("Failed to generate unique code")
    ```

    ✅ Non-sequential (secure)
    ✅ Distributed-friendly
    ❌ Possible collisions
    ❌ Rare failure case

    ### Option 3: Snowflake-Style Distributed ID

    ```python
    # Twitter Snowflake ID structure
    # 64 bits:
    # - 1 bit: unused (sign bit)
    # - 41 bits: timestamp (milliseconds)
    # - 10 bits: machine ID
    # - 12 bits: sequence number

    class SnowflakeIDGenerator:
        def __init__(self, machine_id):
            self.machine_id = machine_id  # 0-1023
            self.sequence = 0
            self.last_timestamp = 0

        def generate(self):
            timestamp = int(time.time() * 1000)

            if timestamp == self.last_timestamp:
                self.sequence = (self.sequence + 1) & 0xFFF
                if self.sequence == 0:
                    # Sequence overflow, wait for next millisecond
                    while timestamp <= self.last_timestamp:
                        timestamp = int(time.time() * 1000)
            else:
                self.sequence = 0

            self.last_timestamp = timestamp

            # Combine into 64-bit ID
            id = ((timestamp << 22) |
                  (self.machine_id << 12) |
                  self.sequence)

            return id

    # Generate short code
    id_gen = SnowflakeIDGenerator(machine_id=1)
    url_id = id_gen.generate()
    short_code = base62_encode(url_id)
    ```

    ✅ Distributed (no coordination)
    ✅ Sortable by time
    ✅ Guaranteed unique
    ❌ Complex implementation
    ❌ Requires machine ID assignment

    ## Caching Strategy

    ```python
    # Redis cache for hot URLs (80/20 rule)
    def redirect(short_code):
        # Check cache first
        long_url = cache.get(f"url:{short_code}")

        if long_url is None:
            # Cache miss - query database
            url = db.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)

            if url is None:
                return 404

            long_url = url.long_url

            # Cache for 1 hour
            cache.set(f"url:{short_code}", long_url, ttl=3600)

        # Async: Track analytics
        queue.enqueue('track_click', short_code, request.headers)

        return redirect(long_url, 302)
    ```

    **Cache hit rate target: 90%+**

    ## Analytics at Scale

    **Problem:** 10M clicks/sec = too many DB writes!

    ### Solution: Batch Processing

    ```python
    # Write to message queue
    def track_click(short_code, metadata):
        kafka.send('clicks', {
            'short_code': short_code,
            'timestamp': time.time(),
            'country': metadata.get('country'),
            'referrer': metadata.get('referrer')
        })

    # Background worker: Batch insert every 10 seconds
    def analytics_worker():
        while True:
            messages = kafka.consume('clicks', max_messages=10000)

            if messages:
                # Batch insert to database
                db.bulk_insert('analytics', messages)

                # Update click counts
                click_counts = Counter(m['short_code'] for m in messages)
                for short_code, count in click_counts.items():
                    db.execute(
                        "UPDATE urls SET clicks = clicks + ? WHERE short_code = ?",
                        count, short_code
                    )

            time.sleep(10)
    ```

    ## Scaling Considerations

    ### Database Sharding

    ```python
    # Shard by short_code (consistent hashing)
    def get_shard(short_code):
        shard_num = hash(short_code) % NUM_SHARDS
        return db_connections[shard_num]

    def redirect(short_code):
        db = get_shard(short_code)
        url = db.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)
        return redirect(url.long_url)
    ```

    ### Read Replicas

    ```python
    # Write to primary
    primary_db.insert(short_code, long_url)

    # Read from replicas (5 replicas)
    replica = random.choice(read_replicas)
    url = replica.query("SELECT long_url FROM urls WHERE short_code = ?", short_code)
    ```

    ## Security & Abuse Prevention

    ### Rate Limiting

    ```python
    # Limit to 100 URLs per hour per IP
    @rate_limit(limit=100, per=3600, by='ip')
    def create_short_url(long_url, request):
        # Implementation
        pass
    ```

    ### URL Validation

    ```python
    import re
    from urllib.parse import urlparse

    def validate_url(url):
        # Check format
        if not re.match(r'https?://.+', url):
            raise ValueError("Invalid URL format")

        # Check length
        if len(url) > 2048:
            raise ValueError("URL too long")

        # Check domain (blocklist)
        domain = urlparse(url).netloc
        if domain in BLOCKED_DOMAINS:
            raise ValueError("Domain blocked")

        return True
    ```

    ## Complete Flow

    ### Create Short URL

    ```
    1. Client POSTs long URL
    2. API validates URL
    3. Generate unique short code (Snowflake ID → Base62)
    4. Store in database
    5. Return short URL
    ```

    ### Redirect

    ```
    1. Client GETs /abc123
    2. Check Redis cache
       - Hit: Return long URL
       - Miss: Query database, cache, return
    3. Async: Track click to Kafka
    4. 302 Redirect to long URL
    ```

    ## Monitoring

    ```python
    # Key metrics
    - Requests per second
    - Cache hit rate (target: 90%+)
    - P99 latency (target: <100ms)
    - Database query time
    - Error rate
    - Queue lag (analytics)
    ```

    **Next**: We'll design a social media feed system like Twitter.
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 11: Practice Question ===
lesson_11 = MicroLesson.create!(
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
  sequence_order: 11,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 12: Lesson 12 ===
lesson_12 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 12',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Scalability Fundamentals

    **Scalability** is the ability of a system to handle increased load by adding resources.

    ## Scalability vs Performance

    ### Performance
    - How fast a system processes a single request
    - Measured in: response time, latency, throughput
    - Example: Reduce query time from 100ms to 10ms

    ### Scalability
    - How well a system handles increased load
    - Measured in: requests/second, concurrent users
    - Example: Handle 10x more users

    **Key Insight**: A performant system isn't necessarily scalable!

    ```
    Performant but not scalable:
    - Serves one user in 10ms
    - Crashes at 1000 concurrent users

    Scalable but not performant:
    - Serves one user in 500ms
    - Handles 100,000 concurrent users
    ```

    ## Types of Scalability

    ### 1. Vertical Scaling (Scale Up)

    **Add more power to existing machines**

    ```
    Before: 4 CPU cores, 8GB RAM
    After:  16 CPU cores, 64GB RAM
    ```

    ✅ **Pros:**
    - Simple to implement
    - No code changes needed
    - No distributed system complexity
    - ACID transactions remain simple

    ❌ **Cons:**
    - Hardware limits (max CPU/RAM)
    - Expensive at high end
    - Single point of failure
    - Downtime during upgrades

    **When to use:** Early stage, simple applications, databases requiring ACID

    ### 2. Horizontal Scaling (Scale Out)

    **Add more machines**

    ```
    Before: 1 server
    After:  10 servers (with load balancer)
    ```

    ✅ **Pros:**
    - Virtually unlimited scaling
    - More cost-effective
    - Better fault tolerance
    - No downtime for upgrades

    ❌ **Cons:**
    - Code must support distribution
    - Data consistency challenges
    - Network overhead
    - More complex architecture

    **When to use:** High growth, web applications, stateless services

    ## Measuring Scalability

    ### Key Metrics

    **1. Throughput**
    - Requests per second (RPS)
    - Transactions per second (TPS)
    - Data processed per second

    **2. Latency**
    - p50: 50% of requests faster than X
    - p95: 95% of requests faster than X
    - p99: 99% of requests faster than X

    ```python
    # Example latency distribution
    p50 = 100ms  # Median
    p95 = 250ms  # Most users experience this or better
    p99 = 500ms  # Outliers
    p99.9 = 2s   # Worst case (network issues, etc.)
    ```

    **3. Concurrent Users**
    - Active connections
    - Active sessions
    - Simultaneous requests

    ### Capacity Planning

    **Calculate required capacity:**

    ```python
    # Example: Social media feed
    daily_active_users = 10_000_000
    avg_requests_per_user_per_day = 50
    total_daily_requests = daily_active_users * avg_requests_per_user_per_day
    # = 500,000,000 requests/day

    peak_multiplier = 3  # Traffic 3x higher at peak
    requests_per_second = (total_daily_requests * peak_multiplier) / 86400
    # = ~17,361 RPS at peak

    # If each server handles 1000 RPS:
    servers_needed = 17361 / 1000 = 18 servers
    # Add 50% buffer: 27 servers
    ```

    ## Bottlenecks

    ### Common Bottlenecks

    **1. Database**
    ```sql
    -- Slow query on large table
    SELECT * FROM users WHERE email LIKE '%gmail.com';
    -- No index = table scan = slow!
    ```

    **Solution:**
    - Add indexes
    - Optimize queries
    - Use caching
    - Database replication
    - Sharding

    **2. Network**
    ```
    Large payloads = slow responses
    100MB image × 1000 users = network saturation
    ```

    **Solution:**
    - Compress responses (gzip)
    - Use CDN
    - Optimize payload size
    - Connection pooling

    **3. CPU**
    ```python
    # CPU-intensive operation
    for user in all_users:  # 1 million users
        calculate_recommendations(user)  # 100ms each
    # Total: 27 hours!
    ```

    **Solution:**
    - Async processing
    - Background jobs
    - Caching results
    - Horizontal scaling

    **4. Memory**
    ```python
    # Loading all users in memory
    all_users = User.all()  # 10M users × 1KB = 10GB RAM
    # Server only has 8GB = crash!
    ```

    **Solution:**
    - Pagination
    - Streaming
    - Lazy loading
    - Add more RAM (vertical scaling)

    ## Stateless vs Stateful

    ### Stateless Services

    **No session state stored on server**

    ```javascript
    // Stateless API
    app.get('/user/:id', (req, res) => {
      const user = db.getUser(req.params.id);
      res.json(user);
    });
    // Each request independent, any server can handle it
    ```

    ✅ **Benefits:**
    - Easy to scale horizontally
    - Any server can handle any request
    - No session replication needed
    - Load balancing is simple

    ### Stateful Services

    **Session state stored on server**

    ```javascript
    // Stateful (session stored in memory)
    app.get('/cart', (req, res) => {
      const cart = req.session.cart;  // Stored in this server's memory
      res.json(cart);
    });
    // Must route user to same server!
    ```

    **Solutions for stateful apps:**

    1. **Sticky Sessions** (route user to same server)
    ```nginx
    upstream backend {
        ip_hash;  # Same IP → same server
        server backend1.example.com;
        server backend2.example.com;
    }
    ```

    2. **External Session Store**
    ```javascript
    // Store session in Redis
    app.use(session({
      store: new RedisStore({ client: redisClient }),
      secret: 'secret'
    }));
    // Now any server can handle request!
    ```

    ## Reliability Metrics

    ### Availability

    **Percentage of time system is operational**

    ```
    Availability = Uptime / (Uptime + Downtime)
    ```

    **Industry Standards:**

    | Level | Availability | Downtime/Year | Downtime/Month |
    |-------|-------------|---------------|----------------|
    | 90% | "One nine" | 36.5 days | 3 days |
    | 99% | "Two nines" | 3.65 days | 7.2 hours |
    | 99.9% | "Three nines" | 8.76 hours | 43.8 minutes |
    | 99.99% | "Four nines" | 52.6 minutes | 4.38 minutes |
    | 99.999% | "Five nines" | 5.26 minutes | 26 seconds |

    **Achieving high availability:**

    1. **Redundancy**
    ```
    Single server = 99% uptime
    Two servers (failover) = 99.99% uptime
    ```

    2. **Health Checks**
    ```python
    # Load balancer checks health
    @app.route('/health')
    def health():
        if database.is_connected():
            return {'status': 'healthy'}, 200
        return {'status': 'unhealthy'}, 503
    ```

    3. **Graceful Degradation**
    ```python
    def get_recommendations():
        try:
            return recommendation_service.get()
        except Exception:
            # Fallback to cached recommendations
            return cache.get('default_recommendations')
    ```

    ### MTBF and MTTR

    **MTBF (Mean Time Between Failures)**
    - Average time between failures
    - Higher is better

    **MTTR (Mean Time To Recovery)**
    - Average time to recover from failure
    - Lower is better

    ```
    Availability = MTBF / (MTBF + MTTR)

    Example:
    MTBF = 720 hours (30 days)
    MTTR = 1 hour
    Availability = 720 / (720 + 1) = 99.86%
    ```

    ## Real-World Example: Twitter

    **Scaling challenges:**

    ```
    Users: 330 million
    Tweets per day: 500 million
    Reads: 10 billion/day (20x more reads than writes)
    Peak: 143,000 tweets/second (New Year's Eve)
    ```

    **Solutions applied:**

    1. **Read/Write Separation**
       - Write to main database
       - Read from replicas

    2. **Caching**
       - Timeline cache (Redis)
       - Reduces database load 100x

    3. **Async Processing**
       - Tweet posting → queue → background processing
       - Fan-out to followers happens async

    4. **CDN**
       - Images, videos served from edge locations
       - Reduces latency globally

    **Next**: We'll dive into the CAP theorem and distributed systems tradeoffs.
  MARKDOWN
  sequence_order: 12,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 12 microlessons for System Design Fundamentals"
