# System Design & Back-of-Envelope Calculations - Complete Course
puts "Creating Complete System Design Course..."

# Find or create course
system_design_course = Course.find_or_create_by!(slug: 'system-design-fundamentals') do |course|
  course.title = "System Design & Back-of-Envelope Calculations"
  course.description = "Master system design interviews and architecture decisions through practical back-of-envelope calculations and real-world scenarios."
  course.difficulty_level = "intermediate"
  course.estimated_hours = 28
  course.certification_track = nil
  course.published = true
  course.sequence_order = 10
  course.learning_objectives = JSON.generate([
    "Master back-of-envelope calculation techniques",
    "Estimate capacity, QPS, bandwidth, and storage requirements",
    "Design scalable systems for millions of users",
    "Understand trade-offs in distributed system design",
    "Prepare for system design interviews at FAANG companies"
  ])
  course.prerequisites = JSON.generate([
    "Basic understanding of web applications",
    "Familiarity with databases",
    "Understanding of networking concepts"
  ])
end

puts "Created course: #{system_design_course.title}"

# ==========================================
# MODULE 1: Estimation Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'estimation-fundamentals', course: system_design_course) do |mod|
  mod.title = "Estimation Fundamentals"
  mod.description = "Learn the basics of back-of-envelope calculations for system design"
  mod.sequence_order = 1
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand powers of 2 and data size units",
    "Calculate storage requirements",
    "Estimate bandwidth and QPS",
    "Master latency numbers every programmer should know"
  ])
end

# Lesson 1.1: Numbers You Should Know
lesson1_1 = CourseLesson.find_or_create_by!(title: "Numbers Every Programmer Should Know") do |lesson|
  lesson.reading_time_minutes = 20
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['latency numbers', 'powers of 2', 'QPS', 'bandwidth estimation', 'storage calculation']
end

# Lesson 1.2: Capacity Estimation
lesson1_2 = CourseLesson.find_or_create_by!(title: "Capacity Estimation Techniques") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['traffic estimation', 'storage calculation', 'bandwidth planning', 'QPS calculation', 'capacity planning']
end

# Quiz 1.1: System Design Fundamentals
quiz1_1 = Quiz.find_or_create_by!(title: "System Design Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your knowledge of capacity planning and estimation'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

[
  {
    question_text: "How many bytes are in 1 GB (using powers of 2)?",
    question_type: "mcq",
    points: 5,
    options: ["2^30 bytes", "1,000,000,000 bytes", "2^20 bytes", "2^40 bytes"],
    correct_answer: "2^30 bytes",
    explanation: "1 GB = 2^30 bytes = 1,073,741,824 bytes"
  },
  {
    question_text: "What's the typical Read:Write ratio for social media apps?",
    question_type: "mcq",
    points: 5,
    options: ["100:1 or higher", "1:1", "1:100", "10:1"],
    correct_answer: "100:1 or higher",
    explanation: "Social media apps have far more reads than writes, typically 100:1 or even 1000:1."
  },
  {
    question_text: "If a system has 1000 QPS average, what should you plan for peak?",
    question_type: "mcq",
    points: 5,
    options: ["2000-3000 QPS", "1000 QPS", "10000 QPS", "1500 QPS"],
    correct_answer: "2000-3000 QPS",
    explanation: "Peak traffic is typically 2-3x the average QPS."
  },
  {
    question_text: "How many seconds are in a day?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "86400",
    explanation: "24 hours × 60 minutes × 60 seconds = 86,400 seconds"
  },
  {
    question_text: "What's a reasonable image size assumption for capacity planning?",
    question_type: "mcq",
    points: 5,
    options: ["200 KB - 2 MB", "10 KB", "100 MB", "1 GB"],
    correct_answer: "200 KB - 2 MB",
    explanation: "Compressed images typically range from 200 KB to 2 MB."
  },
  {
    question_text: "What operation is typically slowest?",
    question_type: "mcq",
    points: 5,
    options: ["Disk seek (~10 ms)", "Main memory reference (~100 ns)", "L1 cache reference (~1 ns)", "Network round trip in datacenter (~500 µs)"],
    correct_answer: "Disk seek (~10 ms)",
    explanation: "Disk seeks are orders of magnitude slower than memory or cache access."
  },
  {
    question_text: "If 100M users each post 1 photo/day at 500 KB, what's daily storage?",
    question_type: "mcq",
    points: 5,
    options: ["50 TB/day", "500 GB/day", "5 PB/day", "50 GB/day"],
    correct_answer: "50 TB/day",
    explanation: "100M × 500 KB = 50 TB per day"
  },
  {
    question_text: "What's the typical replication factor for production databases?",
    question_type: "mcq",
    points: 5,
    options: ["3x", "2x", "5x", "No replication"],
    correct_answer: "3x",
    explanation: "3x replication is standard: 1 primary + 2 replicas for high availability."
  },
  {
    question_text: "What percentage of data typically gets 80% of traffic (80/20 rule)?",
    question_type: "fill_blank",
    points: 5,
    correct_answer: "20",
    explanation: "The 80/20 rule: 20% of content generates 80% of traffic."
  },
  {
    question_text: "What does QPS stand for?",
    question_type: "mcq",
    points: 5,
    options: ["Queries Per Second", "Quality Per Second", "Queue Processing System", "Quick Processing Service"],
    correct_answer: "Queries Per Second",
    explanation: "QPS measures how many requests/queries a system handles per second."
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
# MODULE 2: System Design Patterns
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'system-design-patterns', course: system_design_course) do |mod|
  mod.title = "System Design Patterns"
  mod.description = "Learn common patterns for building scalable systems"
  mod.sequence_order = 2
  mod.estimated_minutes = 180
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand load balancing and caching strategies",
    "Master database sharding and replication",
    "Design CDN and distributed systems",
    "Apply CAP theorem in practice"
  ])
end

# Lesson 2.1: Scalability Patterns
lesson2_1 = CourseLesson.find_or_create_by!(title: "Scalability Patterns") do |lesson|
  lesson.reading_time_minutes = 40
  lesson.content = <<~MARKDOWN
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
  lesson.key_concepts = ['load balancing', 'caching', 'database sharding', 'replication', 'CDN', 'microservices']
end

# Quiz 2.1: System Design Patterns
quiz2_1 = Quiz.find_or_create_by!(title: "System Design Patterns Quiz") do |quiz|
  quiz.description = 'Test your knowledge of scalability patterns'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
end

[
  {
    question_text: "What's the main benefit of database replication?",
    question_type: "mcq",
    points: 5,
    options: ["Read scaling and high availability", "Faster writes", "Less storage needed", "Simpler queries"],
    correct_answer: "Read scaling and high availability",
    explanation: "Replication allows reads to be distributed across replicas and provides failover capability."
  },
  {
    question_text: "What is database sharding?",
    question_type: "mcq",
    points: 5,
    options: ["Splitting data across multiple databases", "Compressing data", "Encrypting data", "Backing up data"],
    correct_answer: "Splitting data across multiple databases",
    explanation: "Sharding horizontally partitions data across multiple database instances."
  },
  {
    question_text: "Which cache eviction policy removes the least recently used items?",
    question_type: "mcq",
    points: 5,
    options: ["LRU", "FIFO", "LFU", "Random"],
    correct_answer: "LRU",
    explanation: "LRU (Least Recently Used) removes items that haven't been accessed for the longest time."
  },
  {
    question_text: "What should you serve from a CDN?",
    question_type: "mcq",
    points: 5,
    options: ["Static content like images and CSS", "User-specific dynamic content", "Real-time data", "Database queries"],
    correct_answer: "Static content like images and CSS",
    explanation: "CDNs are best for static content that doesn't change frequently and can be cached."
  },
  {
    question_text: "What does eventual consistency mean?",
    question_type: "mcq",
    points: 5,
    options: ["Data will be consistent eventually, not immediately", "Data is always consistent", "Data is never consistent", "Data consistency is random"],
    correct_answer: "Data will be consistent eventually, not immediately",
    explanation: "Eventual consistency allows temporary inconsistency for better availability and performance."
  },
  {
    question_text: "What's a message queue used for?",
    question_type: "mcq",
    points: 5,
    options: ["Decoupling and async processing", "Storing messages permanently", "Real-time chat", "Database queries"],
    correct_answer: "Decoupling and async processing",
    explanation: "Message queues decouple producers from consumers and enable asynchronous processing."
  },
  {
    question_text: "What layer does an application load balancer operate at?",
    question_type: "mcq",
    points: 5,
    options: ["Layer 7 (Application)", "Layer 4 (Transport)", "Layer 3 (Network)", "Layer 2 (Data Link)"],
    correct_answer: "Layer 7 (Application)",
    explanation: "Application load balancers operate at Layer 7 and can route based on HTTP headers and URLs."
  },
  {
    question_text: "What's the main challenge of microservices?",
    question_type: "mcq",
    points: 5,
    options: ["Increased complexity and network calls", "Too simple", "Can't scale", "Uses too little memory"],
    correct_answer: "Increased complexity and network calls",
    explanation: "Microservices add complexity through inter-service communication and distributed system challenges."
  },
  {
    question_text: "In database sharding, what determines which shard to use?",
    question_type: "mcq",
    points: 5,
    options: ["Shard key", "Random selection", "Time of day", "Server load"],
    correct_answer: "Shard key",
    explanation: "The shard key (e.g., user_id) determines which shard stores the data."
  },
  {
    question_text: "What's cache-aside (lazy loading)?",
    question_type: "mcq",
    points: 5,
    options: ["Check cache, if miss load from DB and cache it", "Always write to cache first", "Never use cache", "Cache everything upfront"],
    correct_answer: "Check cache, if miss load from DB and cache it",
    explanation: "Cache-aside loads data into cache only when requested and not found (lazy loading)."
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

# Module 1: Estimation Fundamentals
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_2, sequence_order: 2)
ModuleItem.find_or_create_by!(course_module: module1, item: quiz1_1, sequence_order: 3)

# Module 2: System Design Patterns
ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1, sequence_order: 1)
ModuleItem.find_or_create_by!(course_module: module2, item: quiz2_1, sequence_order: 2)

# ==========================================
# LINK SYSTEM DESIGN LABS
# ==========================================

puts "Linking System Design labs to modules..."

system_design_labs = HandsOnLab.where(lab_type: 'system-design').order(:sequence_order)

if system_design_labs.any?
  # Distribute labs across modules
  system_design_labs.each_with_index do |lab, index|
    mod = index < 3 ? module1 : module2
    ModuleItem.find_or_create_by!(
      course_module: mod,
      item: lab,
      sequence_order: 10 + index
    )
  end
  puts "Linked #{system_design_labs.count} system design labs"
end

puts "\n✅ Complete System Design course created!"
puts "   - Course: #{system_design_course.title}"
puts "   - Modules: #{system_design_course.course_modules.count}"
puts "   - Lessons: #{CourseLesson.joins(course_module: :course).where(courses: { id: system_design_course.id }).count}"
puts "   - Quizzes: #{Quiz.joins(course_module: :course).where(courses: { id: system_design_course.id }).count}"
puts "   - Quiz Questions: #{QuizQuestion.joins(quiz: {course_module: :course}).where(courses: { id: system_design_course.id }).count}"
puts "   - Labs: #{system_design_labs.count}"
puts "\n📚 Content Coverage:"
puts "   ✅ Estimation Fundamentals (latency numbers, capacity planning)"
puts "   ✅ System Design Patterns (load balancing, caching, sharding, CDN)"
puts "\n🎯 Learning Features:"
puts "   ✅ 20+ quiz questions"
puts "   ✅ Real-world examples (Twitter, URL shortener)"
puts "   ✅ Back-of-envelope calculation practice"
puts "   ✅ Interview preparation focus"
puts "\n🚀 Ready for FAANG interviews!"