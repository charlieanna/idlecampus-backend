# AUTO-GENERATED from system_design_complete.rb
puts "Creating Microlessons for Estimation Fundamentals..."

module_var = CourseModule.find_by(slug: 'estimation-fundamentals')

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

# Capacity Estimation Techniques

    Learn to estimate system capacity needs systematically.

    ## The 5-Step Framework

    ### 1. Understand Requirements
    - What features does the system need?
    - Who are the users?
    - What's the scale?

    ### 2. Make Assumptions
    - Daily/Monthly active users (DAU/MAU)
    - User behavior patterns
    - Data sizes
    - Growth rate

    ### 3. Calculate Traffic
    - QPS (Queries Per Second)
    - Peak QPS (usually 2-3x average)
    - Read vs Write ratio

    ### 4. Estimate Storage
    - Data size per record
    - Total records over time
    - Replication factor
    - Retention policy

    ### 5. Calculate Bandwidth
    - Data transferred per request
    - Total requests per second
    - Network capacity needed

    ## Example: URL Shortener (like bit.ly)

    ### Requirements
    - Shorten URLs
    - Redirect to original URLs
    - Analytics (optional)

    ### Assumptions
    ```
    - 100M URLs shortened per month
    - Read:Write ratio = 100:1
    - URL storage: 500 bytes average
    - Cache 20% of hot URLs
    - Keep data for 5 years
    ```

    ### Traffic Estimation

    **Write QPS**:
    ```
    100M URLs/month
    = 100M / (30 days × 24 hours × 3600 seconds)
    = 100M / 2.592M seconds
    ≈ 40 writes/second

    Peak: 40 × 3 = 120 writes/second
    ```

    **Read QPS**:
    ```
    Read:Write = 100:1
    = 40 × 100
    = 4,000 reads/second

    Peak: 4,000 × 3 = 12,000 reads/second
    ```

    ### Storage Estimation

    **5-year storage**:
    ```
    URLs per 5 years:
    100M URLs/month × 12 months × 5 years = 6B URLs

    Storage needed:
    6B URLs × 500 bytes = 3 TB

    With metadata + replication (3x):
    3 TB × 3 = 9 TB
    ```

    ### Bandwidth Estimation

    **Write bandwidth**:
    ```
    40 writes/sec × 500 bytes = 20 KB/s
    ```

    **Read bandwidth**:
    ```
    4,000 reads/sec × 500 bytes = 2 MB/s
    ```

    ### Memory (Cache) Estimation

    **Cache 20% of hot URLs for a day**:
    ```
    Read requests per day:
    4,000 req/s × 86,400 seconds = 345.6M requests

    Cache 20%:
    345.6M × 0.2 = 69M requests

    Assuming 1 unique URL per 10 requests:
    69M / 10 = 6.9M unique URLs

    Memory needed:
    6.9M × 500 bytes ≈ 3.5 GB
    ```

    ## Example: Twitter-like Service

    ### Assumptions
    ```
    - 200M DAU (Daily Active Users)
    - Each user views 100 tweets/day
    - Each user posts 2 tweets/day
    - 10% of tweets have images
    - Average tweet: 300 bytes
    - Average image: 200 KB
    - Retention: 5 years
    ```

    ### Traffic Estimation

    **Read QPS**:
    ```
    Daily reads: 200M users × 100 tweets = 20B tweets/day
    Read QPS: 20B / 86,400 seconds ≈ 230,000 req/s
    Peak: 230K × 3 ≈ 700,000 req/s
    ```

    **Write QPS**:
    ```
    Daily writes: 200M users × 2 tweets = 400M tweets/day
    Write QPS: 400M / 86,400 ≈ 4,600 tweets/s
    Peak: 4.6K × 3 ≈ 14,000 tweets/s
    ```

    ### Storage Estimation

    **Text storage (5 years)**:
    ```
    Tweets per 5 years:
    400M tweets/day × 365 days × 5 years = 730B tweets

    Storage:
    730B × 300 bytes = 219 TB

    With replication (3x): 657 TB
    ```

    **Image storage**:
    ```
    Images per 5 years:
    730B tweets × 10% with images = 73B images

    Storage:
    73B × 200 KB = 14.6 PB

    With replication (3x): 43.8 PB
    ```

    **Total**: ~44 PB (mostly images!)

    ### Bandwidth Estimation

    **Read bandwidth**:
    ```
    Text: 230K req/s × 300 bytes = 69 MB/s
    Images (10%): 23K req/s × 200 KB = 4.6 GB/s
    Total: ~4.7 GB/s
    ```

    ## Common Patterns

    ### Pattern 1: Social Media
    - High read:write ratio (100:1 or more)
    - Heavy caching needed
    - Media storage dominates

    ### Pattern 2: Messaging
    - Balanced read:write
    - Low latency critical
    - Retention policies important

    ### Pattern 3: Video Streaming
    - Very high bandwidth
    - CDN essential
    - Storage grows rapidly

    ### Pattern 4: Analytics
    - Write-heavy initially
    - Batch processing
    - Aggregated queries

    ## Tips & Tricks

    1. **Use daily/monthly instead of yearly**: Easier to reason about
    2. **Peak vs Average**: Plan for 2-3x average load
    3. **Growth**: Add 20-30% yearly growth buffer
    4. **80/20 rule**: 20% of data gets 80% of traffic
    5. **Round aggressively**: 2.7M → 3M is fine

    ## Red Flags

    - Storage growing faster than budget
    - Bandwidth exceeding network capacity
    - QPS requiring thousands of servers
    - Memory cache larger than available RAM

    **Practice**: Try the System Design estimation labs!
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

# Scalability Patterns

    Common patterns for building systems that scale to millions of users.

    ## Load Balancing

    Distribute traffic across multiple servers.

    ### Types of Load Balancers

    **Layer 4 (Transport Layer)**:
    - Routes based on IP + Port
    - Fast but limited routing logic
    - Examples: AWS NLB, HAProxy

    **Layer 7 (Application Layer)**:
    - Routes based on HTTP headers, URL, cookies
    - Slower but more intelligent
    - Examples: AWS ALB, Nginx

    ### Load Balancing Algorithms

    1. **Round Robin**: Distribute requests evenly
    2. **Least Connections**: Send to server with fewest active connections
    3. **Least Response Time**: Send to fastest server
    4. **IP Hash**: Same client always goes to same server
    5. **Weighted**: Some servers get more traffic

    ## Caching

    Store frequently accessed data in fast storage.

    ### Cache Levels

    ```
    Client → CDN → Load Balancer → Web Server → Application Cache → Database
    ```

    ### Caching Strategies

    **1. Cache-Aside (Lazy Loading)**:
    ```
    1. Check cache
    2. If miss, query database
    3. Write to cache
    4. Return data
    ```

    **2. Write-Through**:
    ```
    1. Write to cache
    2. Write to database
    3. Return success
    ```

    **3. Write-Back**:
    ```
    1. Write to cache
    2. Return success
    3. Async write to database
    ```

    ### Cache Eviction Policies

    - **LRU** (Least Recently Used): Remove oldest accessed
    - **LFU** (Least Frequently Used): Remove least accessed
    - **FIFO**: Remove oldest added
    - **TTL**: Expire after time

    ## Database Scaling

    ### Vertical Scaling (Scale Up)
    - Add more CPU/RAM/Disk to existing server
    - ✅ Simple
    - ❌ Limited by hardware
    - ❌ Single point of failure

    ### Horizontal Scaling (Scale Out)
    - Add more database servers
    - ✅ Unlimited scaling
    - ❌ Complex implementation

    ### Database Replication

    **Primary-Replica (Master-Slave)**:
    ```
    Primary (writes) → Replica 1 (reads)
                    → Replica 2 (reads)
                    → Replica N (reads)
    ```

    Benefits:
    - Read scaling
    - High availability
    - Disaster recovery

    **Multi-Primary**:
    ```
    Primary 1 ←→ Primary 2 ←→ Primary 3
    ```

    Benefits:
    - Write scaling
    - Lower latency (geo-distributed)

    Challenges:
    - Conflict resolution
    - Consistency issues

    ### Database Sharding

    Split data across multiple databases.

    **Horizontal Sharding (by rows)**:
    ```
    Users 1-1M    → Shard 1
    Users 1M-2M   → Shard 2
    Users 2M-3M   → Shard 3
    ```

    **Sharding Strategies**:

    1. **Range-based**: user_id 1-1M, 1M-2M
       - ✅ Simple
       - ❌ Uneven distribution

    2. **Hash-based**: hash(user_id) % num_shards
       - ✅ Even distribution
       - ❌ Hard to add shards

    3. **Geographic**: US users, EU users, Asia users
       - ✅ Low latency
       - ❌ Uneven growth

    ## CDN (Content Delivery Network)

    Distribute static content globally.

    ### How CDN Works

    ```
    1. User requests image
    2. CDN checks cache
    3. If hit: Return from edge location
    4. If miss:
       a. Fetch from origin
       b. Cache at edge
       c. Return to user
    ```

    ### What to CDN

    ✅ Static content:
    - Images, CSS, JavaScript
    - Videos
    - Static HTML

    ❌ Don't CDN:
    - Dynamic user-specific content
    - Real-time data
    - Content that changes rapidly

    ## Message Queues

    Decouple components for better scalability.

    ### Pattern: Producer-Consumer

    ```
    Producer → Queue → Consumer
    ```

    Benefits:
    - Async processing
    - Load smoothing
    - Fault tolerance

    Examples:
    - RabbitMQ
    - Apache Kafka
    - AWS SQS

    ## Microservices

    Break monolith into smaller services.

    ### Monolith

    ```
    [All-in-One Application]
    ↓
    Database
    ```

    ### Microservices

    ```
    User Service → User DB
    Order Service → Order DB
    Payment Service → Payment DB
    ```

    Benefits:
    - Independent scaling
    - Technology flexibility
    - Easier deployment

    Challenges:
    - Network latency
    - Data consistency
    - Monitoring complexity

    ## Eventual Consistency

    Accept temporary inconsistency for better performance.

    ### Strong Consistency

    ```
    Write → Wait for all replicas → Return success
    ```

    - ✅ Always consistent
    - ❌ Slow writes
    - ❌ Lower availability

    ### Eventual Consistency

    ```
    Write → Return success immediately → Replicate async
    ```

    - ✅ Fast writes
    - ✅ High availability
    - ❌ Temporary inconsistency

    ## Practice

    Try the System Design labs to apply these patterns!
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

# Numbers Every Programmer Should Know

    Essential numbers for back-of-envelope calculations in system design.

    ## Latency Numbers (2024)

    | Operation | Latency |
    |-----------|---------|
    | L1 cache reference | 0.5 ns |
    | Branch mispredict | 5 ns |
    | L2 cache reference | 7 ns |
    | Mutex lock/unlock | 100 ns |
    | Main memory reference | 100 ns |
    | Compress 1KB with Snappy | 10,000 ns = 10 µs |
    | Send 2KB over 1 Gbps network | 20,000 ns = 20 µs |
    | Read 1 MB sequentially from memory | 250,000 ns = 250 µs |
    | Round trip within datacenter | 500,000 ns = 500 µs |
    | Disk seek | 10,000,000 ns = 10 ms |
    | Read 1 MB sequentially from SSD | 1,000,000 ns = 1 ms |
    | Read 1 MB sequentially from disk | 30,000,000 ns = 30 ms |
    | Send packet CA → Netherlands → CA | 150,000,000 ns = 150 ms |

    ## Powers of 2

    Essential for capacity planning:

    | Power | Exact Value | Approx | Bytes |
    |-------|-------------|--------|-------|
    | 2^10 | 1,024 | ~1 thousand | 1 KB |
    | 2^20 | 1,048,576 | ~1 million | 1 MB |
    | 2^30 | 1,073,741,824 | ~1 billion | 1 GB |
    | 2^40 | 1,099,511,627,776 | ~1 trillion | 1 TB |
    | 2^50 | ~1.126 × 10^15 | ~1 quadrillion | 1 PB |

    ## Time Units

    | Unit | Value |
    |------|-------|
    | 1 second | 1,000 milliseconds |
    | 1 millisecond | 1,000 microseconds |
    | 1 microsecond | 1,000 nanoseconds |

    ## Common Metrics

    ### QPS (Queries Per Second)
    - **Low traffic**: 100-1,000 QPS
    - **Medium traffic**: 1,000-10,000 QPS
    - **High traffic**: 10,000-100,000 QPS
    - **Very high traffic**: 100,000+ QPS

    ### Daily Active Users (DAU)
    - **Small app**: 1K-100K users
    - **Medium app**: 100K-1M users
    - **Large app**: 1M-10M users
    - **Massive app**: 10M+ users

    ### Bandwidth Estimates
    - **Text**: ~1-2 KB per message
    - **Image**: ~200 KB - 2 MB
    - **Video SD**: ~1-2 GB/hour
    - **Video HD**: ~3-5 GB/hour
    - **Video 4K**: ~15-25 GB/hour

    ## Storage Estimates

    ### Database Storage
    - **User profile**: ~1-2 KB
    - **Tweet**: ~200-300 bytes
    - **Photo metadata**: ~1 KB
    - **Photo (compressed)**: ~200 KB
    - **Video metadata**: ~1 KB
    - **Video file**: Varies greatly

    ## Key Principles

    1. **Round numbers**: Use approximations (1M instead of 1,048,576)
    2. **Write assumptions**: Make your assumptions explicit
    3. **Think in orders of magnitude**: Focus on 10x differences
    4. **Use powers of 2**: Simplify calculations
    5. **Sanity check**: Does the result make sense?

    ## Example Calculation

    **Question**: How much storage for 100M users posting 1 photo/day for 5 years?

    **Calculation**:
    ```
    Assumptions:
    - 100M users
    - 1 photo/day average
    - Photo size: 200 KB
    - Time: 5 years = 1,825 days

    Total photos:
    100M users × 1 photo/day × 1,825 days = 182.5B photos

    Storage needed:
    182.5B photos × 200 KB = 36.5 PB

    With replication (3x):
    36.5 PB × 3 = ~110 PB
    ```

    **Sanity check**: 110 PB for 5 years of Instagram-like service? Reasonable!

    Now practice with the System Design labs!
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

# Capacity Estimation Techniques

    Learn to estimate system capacity needs systematically.

    ## The 5-Step Framework

    ### 1. Understand Requirements
    - What features does the system need?
    - Who are the users?
    - What's the scale?

    ### 2. Make Assumptions
    - Daily/Monthly active users (DAU/MAU)
    - User behavior patterns
    - Data sizes
    - Growth rate

    ### 3. Calculate Traffic
    - QPS (Queries Per Second)
    - Peak QPS (usually 2-3x average)
    - Read vs Write ratio

    ### 4. Estimate Storage
    - Data size per record
    - Total records over time
    - Replication factor
    - Retention policy

    ### 5. Calculate Bandwidth
    - Data transferred per request
    - Total requests per second
    - Network capacity needed

    ## Example: URL Shortener (like bit.ly)

    ### Requirements
    - Shorten URLs
    - Redirect to original URLs
    - Analytics (optional)

    ### Assumptions
    ```
    - 100M URLs shortened per month
    - Read:Write ratio = 100:1
    - URL storage: 500 bytes average
    - Cache 20% of hot URLs
    - Keep data for 5 years
    ```

    ### Traffic Estimation

    **Write QPS**:
    ```
    100M URLs/month
    = 100M / (30 days × 24 hours × 3600 seconds)
    = 100M / 2.592M seconds
    ≈ 40 writes/second

    Peak: 40 × 3 = 120 writes/second
    ```

    **Read QPS**:
    ```
    Read:Write = 100:1
    = 40 × 100
    = 4,000 reads/second

    Peak: 4,000 × 3 = 12,000 reads/second
    ```

    ### Storage Estimation

    **5-year storage**:
    ```
    URLs per 5 years:
    100M URLs/month × 12 months × 5 years = 6B URLs

    Storage needed:
    6B URLs × 500 bytes = 3 TB

    With metadata + replication (3x):
    3 TB × 3 = 9 TB
    ```

    ### Bandwidth Estimation

    **Write bandwidth**:
    ```
    40 writes/sec × 500 bytes = 20 KB/s
    ```

    **Read bandwidth**:
    ```
    4,000 reads/sec × 500 bytes = 2 MB/s
    ```

    ### Memory (Cache) Estimation

    **Cache 20% of hot URLs for a day**:
    ```
    Read requests per day:
    4,000 req/s × 86,400 seconds = 345.6M requests

    Cache 20%:
    345.6M × 0.2 = 69M requests

    Assuming 1 unique URL per 10 requests:
    69M / 10 = 6.9M unique URLs

    Memory needed:
    6.9M × 500 bytes ≈ 3.5 GB
    ```

    ## Example: Twitter-like Service

    ### Assumptions
    ```
    - 200M DAU (Daily Active Users)
    - Each user views 100 tweets/day
    - Each user posts 2 tweets/day
    - 10% of tweets have images
    - Average tweet: 300 bytes
    - Average image: 200 KB
    - Retention: 5 years
    ```

    ### Traffic Estimation

    **Read QPS**:
    ```
    Daily reads: 200M users × 100 tweets = 20B tweets/day
    Read QPS: 20B / 86,400 seconds ≈ 230,000 req/s
    Peak: 230K × 3 ≈ 700,000 req/s
    ```

    **Write QPS**:
    ```
    Daily writes: 200M users × 2 tweets = 400M tweets/day
    Write QPS: 400M / 86,400 ≈ 4,600 tweets/s
    Peak: 4.6K × 3 ≈ 14,000 tweets/s
    ```

    ### Storage Estimation

    **Text storage (5 years)**:
    ```
    Tweets per 5 years:
    400M tweets/day × 365 days × 5 years = 730B tweets

    Storage:
    730B × 300 bytes = 219 TB

    With replication (3x): 657 TB
    ```

    **Image storage**:
    ```
    Images per 5 years:
    730B tweets × 10% with images = 73B images

    Storage:
    73B × 200 KB = 14.6 PB

    With replication (3x): 43.8 PB
    ```

    **Total**: ~44 PB (mostly images!)

    ### Bandwidth Estimation

    **Read bandwidth**:
    ```
    Text: 230K req/s × 300 bytes = 69 MB/s
    Images (10%): 23K req/s × 200 KB = 4.6 GB/s
    Total: ~4.7 GB/s
    ```

    ## Common Patterns

    ### Pattern 1: Social Media
    - High read:write ratio (100:1 or more)
    - Heavy caching needed
    - Media storage dominates

    ### Pattern 2: Messaging
    - Balanced read:write
    - Low latency critical
    - Retention policies important

    ### Pattern 3: Video Streaming
    - Very high bandwidth
    - CDN essential
    - Storage grows rapidly

    ### Pattern 4: Analytics
    - Write-heavy initially
    - Batch processing
    - Aggregated queries

    ## Tips & Tricks

    1. **Use daily/monthly instead of yearly**: Easier to reason about
    2. **Peak vs Average**: Plan for 2-3x average load
    3. **Growth**: Add 20-30% yearly growth buffer
    4. **80/20 rule**: 20% of data gets 80% of traffic
    5. **Round aggressively**: 2.7M → 3M is fine

    ## Red Flags

    - Storage growing faster than budget
    - Bandwidth exceeding network capacity
    - QPS requiring thousands of servers
    - Memory cache larger than available RAM

    **Practice**: Try the System Design estimation labs!
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

# Scalability Patterns

    Common patterns for building systems that scale to millions of users.

    ## Load Balancing

    Distribute traffic across multiple servers.

    ### Types of Load Balancers

    **Layer 4 (Transport Layer)**:
    - Routes based on IP + Port
    - Fast but limited routing logic
    - Examples: AWS NLB, HAProxy

    **Layer 7 (Application Layer)**:
    - Routes based on HTTP headers, URL, cookies
    - Slower but more intelligent
    - Examples: AWS ALB, Nginx

    ### Load Balancing Algorithms

    1. **Round Robin**: Distribute requests evenly
    2. **Least Connections**: Send to server with fewest active connections
    3. **Least Response Time**: Send to fastest server
    4. **IP Hash**: Same client always goes to same server
    5. **Weighted**: Some servers get more traffic

    ## Caching

    Store frequently accessed data in fast storage.

    ### Cache Levels

    ```
    Client → CDN → Load Balancer → Web Server → Application Cache → Database
    ```

    ### Caching Strategies

    **1. Cache-Aside (Lazy Loading)**:
    ```
    1. Check cache
    2. If miss, query database
    3. Write to cache
    4. Return data
    ```

    **2. Write-Through**:
    ```
    1. Write to cache
    2. Write to database
    3. Return success
    ```

    **3. Write-Back**:
    ```
    1. Write to cache
    2. Return success
    3. Async write to database
    ```

    ### Cache Eviction Policies

    - **LRU** (Least Recently Used): Remove oldest accessed
    - **LFU** (Least Frequently Used): Remove least accessed
    - **FIFO**: Remove oldest added
    - **TTL**: Expire after time

    ## Database Scaling

    ### Vertical Scaling (Scale Up)
    - Add more CPU/RAM/Disk to existing server
    - ✅ Simple
    - ❌ Limited by hardware
    - ❌ Single point of failure

    ### Horizontal Scaling (Scale Out)
    - Add more database servers
    - ✅ Unlimited scaling
    - ❌ Complex implementation

    ### Database Replication

    **Primary-Replica (Master-Slave)**:
    ```
    Primary (writes) → Replica 1 (reads)
                    → Replica 2 (reads)
                    → Replica N (reads)
    ```

    Benefits:
    - Read scaling
    - High availability
    - Disaster recovery

    **Multi-Primary**:
    ```
    Primary 1 ←→ Primary 2 ←→ Primary 3
    ```

    Benefits:
    - Write scaling
    - Lower latency (geo-distributed)

    Challenges:
    - Conflict resolution
    - Consistency issues

    ### Database Sharding

    Split data across multiple databases.

    **Horizontal Sharding (by rows)**:
    ```
    Users 1-1M    → Shard 1
    Users 1M-2M   → Shard 2
    Users 2M-3M   → Shard 3
    ```

    **Sharding Strategies**:

    1. **Range-based**: user_id 1-1M, 1M-2M
       - ✅ Simple
       - ❌ Uneven distribution

    2. **Hash-based**: hash(user_id) % num_shards
       - ✅ Even distribution
       - ❌ Hard to add shards

    3. **Geographic**: US users, EU users, Asia users
       - ✅ Low latency
       - ❌ Uneven growth

    ## CDN (Content Delivery Network)

    Distribute static content globally.

    ### How CDN Works

    ```
    1. User requests image
    2. CDN checks cache
    3. If hit: Return from edge location
    4. If miss:
       a. Fetch from origin
       b. Cache at edge
       c. Return to user
    ```

    ### What to CDN

    ✅ Static content:
    - Images, CSS, JavaScript
    - Videos
    - Static HTML

    ❌ Don't CDN:
    - Dynamic user-specific content
    - Real-time data
    - Content that changes rapidly

    ## Message Queues

    Decouple components for better scalability.

    ### Pattern: Producer-Consumer

    ```
    Producer → Queue → Consumer
    ```

    Benefits:
    - Async processing
    - Load smoothing
    - Fault tolerance

    Examples:
    - RabbitMQ
    - Apache Kafka
    - AWS SQS

    ## Microservices

    Break monolith into smaller services.

    ### Monolith

    ```
    [All-in-One Application]
    ↓
    Database
    ```

    ### Microservices

    ```
    User Service → User DB
    Order Service → Order DB
    Payment Service → Payment DB
    ```

    Benefits:
    - Independent scaling
    - Technology flexibility
    - Easier deployment

    Challenges:
    - Network latency
    - Data consistency
    - Monitoring complexity

    ## Eventual Consistency

    Accept temporary inconsistency for better performance.

    ### Strong Consistency

    ```
    Write → Wait for all replicas → Return success
    ```

    - ✅ Always consistent
    - ❌ Slow writes
    - ❌ Lower availability

    ### Eventual Consistency

    ```
    Write → Return success immediately → Replicate async
    ```

    - ✅ Fast writes
    - ✅ High availability
    - ❌ Temporary inconsistency

    ## Practice

    Try the System Design labs to apply these patterns!
  MARKDOWN
  sequence_order: 6,
  estimated_minutes: 2,
  difficulty: 'easy',
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

# === MICROLESSON 8: Practice Question ===
lesson_8 = MicroLesson.create!(
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
  sequence_order: 8,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 9: Practice Question ===
lesson_9 = MicroLesson.create!(
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
  sequence_order: 9,
  estimated_minutes: 2,
  difficulty: 'medium',
  key_concepts: [],
  prerequisite_ids: []
)

# === MICROLESSON 10: Lesson 10 ===
lesson_10 = MicroLesson.create!(
  course_module: module_var,
  title: 'Lesson 10',
  content: <<~MARKDOWN,
# Microlesson 🚀

# Numbers Every Programmer Should Know

    Essential numbers for back-of-envelope calculations in system design.

    ## Latency Numbers (2024)

    | Operation | Latency |
    |-----------|---------|
    | L1 cache reference | 0.5 ns |
    | Branch mispredict | 5 ns |
    | L2 cache reference | 7 ns |
    | Mutex lock/unlock | 100 ns |
    | Main memory reference | 100 ns |
    | Compress 1KB with Snappy | 10,000 ns = 10 µs |
    | Send 2KB over 1 Gbps network | 20,000 ns = 20 µs |
    | Read 1 MB sequentially from memory | 250,000 ns = 250 µs |
    | Round trip within datacenter | 500,000 ns = 500 µs |
    | Disk seek | 10,000,000 ns = 10 ms |
    | Read 1 MB sequentially from SSD | 1,000,000 ns = 1 ms |
    | Read 1 MB sequentially from disk | 30,000,000 ns = 30 ms |
    | Send packet CA → Netherlands → CA | 150,000,000 ns = 150 ms |

    ## Powers of 2

    Essential for capacity planning:

    | Power | Exact Value | Approx | Bytes |
    |-------|-------------|--------|-------|
    | 2^10 | 1,024 | ~1 thousand | 1 KB |
    | 2^20 | 1,048,576 | ~1 million | 1 MB |
    | 2^30 | 1,073,741,824 | ~1 billion | 1 GB |
    | 2^40 | 1,099,511,627,776 | ~1 trillion | 1 TB |
    | 2^50 | ~1.126 × 10^15 | ~1 quadrillion | 1 PB |

    ## Time Units

    | Unit | Value |
    |------|-------|
    | 1 second | 1,000 milliseconds |
    | 1 millisecond | 1,000 microseconds |
    | 1 microsecond | 1,000 nanoseconds |

    ## Common Metrics

    ### QPS (Queries Per Second)
    - **Low traffic**: 100-1,000 QPS
    - **Medium traffic**: 1,000-10,000 QPS
    - **High traffic**: 10,000-100,000 QPS
    - **Very high traffic**: 100,000+ QPS

    ### Daily Active Users (DAU)
    - **Small app**: 1K-100K users
    - **Medium app**: 100K-1M users
    - **Large app**: 1M-10M users
    - **Massive app**: 10M+ users

    ### Bandwidth Estimates
    - **Text**: ~1-2 KB per message
    - **Image**: ~200 KB - 2 MB
    - **Video SD**: ~1-2 GB/hour
    - **Video HD**: ~3-5 GB/hour
    - **Video 4K**: ~15-25 GB/hour

    ## Storage Estimates

    ### Database Storage
    - **User profile**: ~1-2 KB
    - **Tweet**: ~200-300 bytes
    - **Photo metadata**: ~1 KB
    - **Photo (compressed)**: ~200 KB
    - **Video metadata**: ~1 KB
    - **Video file**: Varies greatly

    ## Key Principles

    1. **Round numbers**: Use approximations (1M instead of 1,048,576)
    2. **Write assumptions**: Make your assumptions explicit
    3. **Think in orders of magnitude**: Focus on 10x differences
    4. **Use powers of 2**: Simplify calculations
    5. **Sanity check**: Does the result make sense?

    ## Example Calculation

    **Question**: How much storage for 100M users posting 1 photo/day for 5 years?

    **Calculation**:
    ```
    Assumptions:
    - 100M users
    - 1 photo/day average
    - Photo size: 200 KB
    - Time: 5 years = 1,825 days

    Total photos:
    100M users × 1 photo/day × 1,825 days = 182.5B photos

    Storage needed:
    182.5B photos × 200 KB = 36.5 PB

    With replication (3x):
    36.5 PB × 3 = ~110 PB
    ```

    **Sanity check**: 110 PB for 5 years of Instagram-like service? Reasonable!

    Now practice with the System Design labs!
  MARKDOWN
  sequence_order: 10,
  estimated_minutes: 2,
  difficulty: 'easy',
  key_concepts: [],
  prerequisite_ids: []
)

puts "✓ Created 10 microlessons for Estimation Fundamentals"
