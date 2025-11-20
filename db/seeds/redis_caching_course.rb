# Redis & Caching Strategies Course
puts "Creating Redis & Caching Strategies Course..."

redis_course = Course.find_or_create_by!(slug: 'redis-caching-strategies') do |course|
  course.title = 'Redis & Caching Strategies'
  course.description = 'Master in-memory data structures and performance optimization with Redis'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 27
  course.estimated_hours = 20
  course.learning_objectives = JSON.generate([
    "Master Redis data structures",
    "Implement caching strategies",
    "Use Redis for session storage",
    "Build pub/sub systems",
    "Optimize application performance",
    "Handle cache invalidation"
  ])
  course.prerequisites = JSON.generate(["Basic backend development", "Understanding of databases", "Python or Node.js knowledge"])
end

puts "Created course: #{redis_course.title}"

# ==========================================
# MODULE 1: Redis Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'redis-fundamentals', course: redis_course) do |mod|
  mod.title = 'Redis Fundamentals'
  mod.description = 'Master Redis data structures, operations, and core concepts'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand Redis architecture and in-memory storage",
    "Master all five core data structures",
    "Implement TTL and expiration strategies",
    "Build pub/sub messaging systems",
    "Apply Redis to real-world use cases"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Redis Data Structures and Operations") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Redis Data Structures and Operations

    **Redis** (REmote DIctionary Server) is an open-source, in-memory data structure store used as a database, cache, and message broker.

    ## Why Redis?

    ### Speed
    - All data stored in RAM (not disk)
    - Sub-millisecond latency
    - 100,000+ operations per second on commodity hardware

    ### Simplicity
    - Simple key-value model
    - Rich data structures
    - Atomic operations

    ### Versatility
    - Cache
    - Session store
    - Message broker
    - Real-time analytics
    - Leaderboards

    ## Redis Architecture

    ```
    ┌─────────────┐
    │   Client    │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │ Redis Server│ ← Single-threaded event loop
    │   (RAM)     │ ← All data in memory
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │ Persistence │ ← Optional: RDB/AOF
    │   (Disk)    │
    └─────────────┘
    ```

    **Key Characteristics:**
    - Single-threaded (no race conditions)
    - Non-blocking I/O
    - Pipelining support
    - Transactions with MULTI/EXEC

    ## 1. Strings

    **The simplest data type - binary safe strings up to 512MB**

    ### Basic Operations

    ```python
    import redis

    # Connect to Redis
    r = redis.Redis(host='localhost', port=6379, db=0)

    # SET and GET
    r.set('user:1000:name', 'Alice Johnson')
    name = r.get('user:1000:name')  # b'Alice Johnson'

    # SET with options
    r.set('session:abc123', 'user_data', ex=3600)  # Expires in 1 hour
    r.set('counter', 0, nx=True)  # Only set if not exists

    # Multiple operations
    r.mset({'key1': 'value1', 'key2': 'value2', 'key3': 'value3'})
    values = r.mget(['key1', 'key2', 'key3'])  # ['value1', 'value2', 'value3']
    ```

    ```javascript
    // Using ioredis (Node.js)
    const Redis = require('ioredis');
    const redis = new Redis();

    // SET and GET
    await redis.set('user:1000:name', 'Alice Johnson');
    const name = await redis.get('user:1000:name');  // 'Alice Johnson'

    // SET with expiration
    await redis.set('session:abc123', 'user_data', 'EX', 3600);

    // Multiple operations
    await redis.mset('key1', 'value1', 'key2', 'value2');
    const values = await redis.mget('key1', 'key2');  // ['value1', 'value2']
    ```

    ### Numeric Operations

    ```python
    # Counters
    r.set('page:views', 0)
    r.incr('page:views')  # 1
    r.incr('page:views')  # 2
    r.incrby('page:views', 10)  # 12

    # Decrement
    r.decr('inventory:item:123')  # Decrease by 1
    r.decrby('inventory:item:123', 5)  # Decrease by 5

    # Atomic increment with expiration
    r.set('rate:limit:user:1000', 0, ex=60)
    r.incr('rate:limit:user:1000')
    ```

    ### String Use Cases

    1. **Caching HTML/JSON**
    ```python
    import json

    # Cache API response
    user_data = {'id': 1000, 'name': 'Alice', 'email': 'alice@example.com'}
    r.set('cache:user:1000', json.dumps(user_data), ex=300)  # 5 min cache

    # Retrieve from cache
    cached = r.get('cache:user:1000')
    if cached:
        user = json.loads(cached)
    ```

    2. **Distributed Locks**
    ```python
    # Acquire lock with timeout
    lock_acquired = r.set('lock:resource:123', 'worker-1', nx=True, ex=10)
    if lock_acquired:
        try:
            # Do work
            process_resource()
        finally:
            r.delete('lock:resource:123')
    ```

    3. **Counters and Metrics**
    ```python
    # Track API calls
    r.incr(f'api:calls:{date}:{endpoint}')

    # Track unique visitors (simple)
    r.incr(f'visitors:{date}')
    ```

    ## 2. Lists

    **Linked lists of strings, ordered by insertion. Perfect for queues and stacks.**

    ### Basic Operations

    ```python
    # Push to list (left/right)
    r.lpush('tasks', 'task1')  # Add to beginning
    r.rpush('tasks', 'task2')  # Add to end
    r.rpush('tasks', 'task3', 'task4')  # Multiple items

    # Pop from list
    task = r.lpop('tasks')  # Remove from beginning
    task = r.rpop('tasks')  # Remove from end

    # Blocking pop (wait for item)
    task = r.blpop('tasks', timeout=5)  # Wait up to 5 seconds

    # Range operations
    r.lrange('tasks', 0, -1)  # Get all items
    r.lrange('tasks', 0, 9)   # Get first 10 items

    # Length
    count = r.llen('tasks')

    # Trim (keep only range)
    r.ltrim('tasks', 0, 99)  # Keep only first 100 items
    ```

    ```javascript
    // Node.js example
    await redis.lpush('tasks', 'task1');
    await redis.rpush('tasks', 'task2', 'task3');

    const task = await redis.lpop('tasks');
    const allTasks = await redis.lrange('tasks', 0, -1);
    ```

    ### List Use Cases

    1. **Message Queue**
    ```python
    # Producer
    def enqueue_job(job_data):
        r.rpush('jobs:queue', json.dumps(job_data))

    # Consumer
    def process_jobs():
        while True:
            job = r.blpop('jobs:queue', timeout=1)
            if job:
                queue_name, job_data = job
                data = json.loads(job_data)
                process(data)
    ```

    2. **Activity Feed**
    ```python
    # Add activity
    def add_activity(user_id, activity):
        r.lpush(f'feed:{user_id}', json.dumps(activity))
        r.ltrim(f'feed:{user_id}', 0, 99)  # Keep only 100 activities

    # Get recent activities
    def get_feed(user_id, limit=20):
        activities = r.lrange(f'feed:{user_id}', 0, limit - 1)
        return [json.loads(a) for a in activities]
    ```

    3. **Recently Viewed Items**
    ```python
    def add_recent_view(user_id, product_id):
        key = f'recent:{user_id}'
        r.lrem(key, 0, product_id)  # Remove if exists
        r.lpush(key, product_id)     # Add to front
        r.ltrim(key, 0, 19)          # Keep only 20 items
    ```

    ## 3. Sets

    **Unordered collections of unique strings. Fast membership testing.**

    ### Basic Operations

    ```python
    # Add members
    r.sadd('tags:post:100', 'python', 'redis', 'caching')
    r.sadd('tags:post:101', 'redis', 'database', 'nosql')

    # Check membership
    is_member = r.sismember('tags:post:100', 'python')  # True

    # Get all members
    tags = r.smembers('tags:post:100')  # {'python', 'redis', 'caching'}

    # Remove member
    r.srem('tags:post:100', 'caching')

    # Count members
    count = r.scard('tags:post:100')

    # Random member
    random_tag = r.srandmember('tags:post:100')

    # Pop random member
    tag = r.spop('tags:post:100')
    ```

    ### Set Operations

    ```python
    # Union (combine sets)
    all_tags = r.sunion('tags:post:100', 'tags:post:101')
    # {'python', 'redis', 'caching', 'database', 'nosql'}

    # Intersection (common members)
    common = r.sinter('tags:post:100', 'tags:post:101')
    # {'redis'}

    # Difference (in first but not second)
    unique = r.sdiff('tags:post:100', 'tags:post:101')
    # {'python', 'caching'}

    # Store result
    r.sinterstore('common:tags', 'tags:post:100', 'tags:post:101')
    ```

    ### Set Use Cases

    1. **Tagging System**
    ```python
    # Add tags to post
    def tag_post(post_id, tags):
        key = f'tags:{post_id}'
        r.sadd(key, *tags)

    # Find posts with specific tag
    def add_tag_index(post_id, tag):
        r.sadd(f'posts:tag:{tag}', post_id)

    # Get all posts with tag
    def posts_with_tag(tag):
        return r.smembers(f'posts:tag:{tag}')

    # Find posts with multiple tags (intersection)
    def posts_with_all_tags(*tags):
        keys = [f'posts:tag:{tag}' for tag in tags]
        return r.sinter(*keys)
    ```

    2. **Unique Visitors**
    ```python
    # Track unique visitors per day
    def track_visitor(date, user_id):
        r.sadd(f'visitors:{date}', user_id)

    # Count unique visitors
    def count_visitors(date):
        return r.scard(f'visitors:{date}')

    # Unique visitors across multiple days
    def unique_visitors_range(start_date, end_date):
        keys = [f'visitors:{date}' for date in date_range(start_date, end_date)]
        return r.sunion(*keys)
    ```

    3. **Following/Followers**
    ```python
    # User follows another user
    def follow(user_id, target_id):
        r.sadd(f'following:{user_id}', target_id)
        r.sadd(f'followers:{target_id}', user_id)

    # Get mutual followers
    def mutual_followers(user1, user2):
        return r.sinter(f'followers:{user1}', f'followers:{user2}')

    # Suggest users to follow (friends of friends)
    def suggest_follows(user_id):
        following = r.smembers(f'following:{user_id}')
        suggestions = set()
        for followed_id in following:
            friends_of_friend = r.smembers(f'following:{followed_id}')
            suggestions.update(friends_of_friend)
        suggestions.discard(user_id)  # Remove self
        return suggestions - following  # Remove already following
    ```

    ## 4. Sorted Sets

    **Sets ordered by score. Perfect for leaderboards and rankings.**

    ### Basic Operations

    ```python
    # Add members with scores
    r.zadd('leaderboard', {'player1': 1000, 'player2': 1500, 'player3': 1200})

    # Add or update single member
    r.zadd('leaderboard', {'player4': 1800})

    # Get score
    score = r.zscore('leaderboard', 'player1')  # 1000.0

    # Increment score
    r.zincrby('leaderboard', 100, 'player1')  # 1100.0

    # Get rank (0-based, lowest score = rank 0)
    rank = r.zrank('leaderboard', 'player1')

    # Get reverse rank (highest score = rank 0)
    rank = r.zrevrank('leaderboard', 'player4')  # 0

    # Range by rank
    top_10 = r.zrevrange('leaderboard', 0, 9, withscores=True)
    # [('player4', 1800.0), ('player2', 1500.0), ...]

    # Range by score
    high_scorers = r.zrangebyscore('leaderboard', 1500, '+inf', withscores=True)

    # Count in score range
    count = r.zcount('leaderboard', 1000, 2000)

    # Remove member
    r.zrem('leaderboard', 'player1')
    ```

    ```javascript
    // Node.js example
    await redis.zadd('leaderboard', 1000, 'player1', 1500, 'player2');

    const score = await redis.zscore('leaderboard', 'player1');
    await redis.zincrby('leaderboard', 100, 'player1');

    const top10 = await redis.zrevrange('leaderboard', 0, 9, 'WITHSCORES');
    ```

    ### Sorted Set Use Cases

    1. **Leaderboard**
    ```python
    # Update player score
    def update_score(player_id, points):
        r.zincrby('game:leaderboard', points, player_id)

    # Get top players
    def get_top_players(limit=10):
        return r.zrevrange('game:leaderboard', 0, limit - 1, withscores=True)

    # Get player rank and score
    def get_player_stats(player_id):
        score = r.zscore('game:leaderboard', player_id)
        rank = r.zrevrank('game:leaderboard', player_id)
        return {'score': score, 'rank': rank + 1 if rank is not None else None}

    # Get players around user
    def get_nearby_players(player_id, range=5):
        rank = r.zrevrank('game:leaderboard', player_id)
        if rank is None:
            return []
        start = max(0, rank - range)
        end = rank + range
        return r.zrevrange('game:leaderboard', start, end, withscores=True)
    ```

    2. **Priority Queue**
    ```python
    import time

    # Add task with priority (timestamp)
    def add_task(task_id, priority):
        r.zadd('tasks:priority', {task_id: priority})

    # Add task to run at specific time
    def schedule_task(task_id, run_at):
        r.zadd('tasks:scheduled', {task_id: run_at.timestamp()})

    # Get tasks ready to run
    def get_ready_tasks():
        now = time.time()
        tasks = r.zrangebyscore('tasks:scheduled', 0, now)
        if tasks:
            r.zrem('tasks:scheduled', *tasks)  # Remove from queue
        return tasks
    ```

    3. **Time-Series Data**
    ```python
    # Store metrics with timestamp
    def record_metric(metric_name, value, timestamp=None):
        if timestamp is None:
            timestamp = time.time()
        r.zadd(f'metrics:{metric_name}', {json.dumps(value): timestamp})

    # Get metrics in time range
    def get_metrics(metric_name, start_time, end_time):
        data = r.zrangebyscore(f'metrics:{metric_name}', start_time, end_time)
        return [json.loads(d) for d in data]

    # Clean old metrics
    def clean_old_metrics(metric_name, days=7):
        cutoff = time.time() - (days * 86400)
        r.zremrangebyscore(f'metrics:{metric_name}', 0, cutoff)
    ```

    ## 5. Hashes

    **Field-value pairs - like a mini Redis inside a key. Perfect for objects.**

    ### Basic Operations

    ```python
    # Set fields
    r.hset('user:1000', 'name', 'Alice Johnson')
    r.hset('user:1000', 'email', 'alice@example.com')

    # Set multiple fields
    r.hset('user:1000', mapping={
        'name': 'Alice Johnson',
        'email': 'alice@example.com',
        'age': '30',
        'city': 'San Francisco'
    })

    # Get field
    name = r.hget('user:1000', 'name')  # b'Alice Johnson'

    # Get all fields
    user = r.hgetall('user:1000')
    # {b'name': b'Alice Johnson', b'email': b'alice@example.com', ...}

    # Get multiple fields
    data = r.hmget('user:1000', ['name', 'email'])

    # Check field exists
    exists = r.hexists('user:1000', 'name')  # True

    # Delete field
    r.hdel('user:1000', 'age')

    # Get all keys
    fields = r.hkeys('user:1000')

    # Get all values
    values = r.hvals('user:1000')

    # Count fields
    count = r.hlen('user:1000')

    # Increment field
    r.hincrby('user:1000', 'login_count', 1)
    ```

    ### Hash Use Cases

    1. **User Objects**
    ```python
    # Store user profile
    def save_user(user_id, user_data):
        key = f'user:{user_id}'
        r.hset(key, mapping=user_data)
        r.expire(key, 3600)  # Cache for 1 hour

    # Update specific fields
    def update_user_email(user_id, email):
        r.hset(f'user:{user_id}', 'email', email)

    # Get user
    def get_user(user_id):
        return r.hgetall(f'user:{user_id}')
    ```

    2. **Session Storage**
    ```python
    # Create session
    def create_session(session_id, user_id, user_data):
        key = f'session:{session_id}'
        r.hset(key, mapping={
            'user_id': user_id,
            'created_at': time.time(),
            **user_data
        })
        r.expire(key, 86400)  # 24 hour session

    # Update session activity
    def touch_session(session_id):
        key = f'session:{session_id}'
        r.hset(key, 'last_activity', time.time())
        r.expire(key, 86400)  # Reset expiration

    # Get session
    def get_session(session_id):
        return r.hgetall(f'session:{session_id}')
    ```

    3. **Rate Limiting per User**
    ```python
    # Track API calls per endpoint
    def track_api_call(user_id, endpoint):
        key = f'rate:{user_id}:{int(time.time() / 60)}'  # Per minute
        r.hincrby(key, endpoint, 1)
        r.expire(key, 120)  # Keep for 2 minutes

    # Check rate limit
    def is_rate_limited(user_id, endpoint, limit=100):
        key = f'rate:{user_id}:{int(time.time() / 60)}'
        count = r.hget(key, endpoint)
        return int(count or 0) >= limit
    ```

    ## TTL and Expiration

    **Automatically expire keys after a specified time**

    ```python
    # Set expiration when creating key
    r.set('temp:key', 'value', ex=60)  # Expires in 60 seconds
    r.set('temp:key2', 'value', px=5000)  # Expires in 5000 milliseconds

    # Set expiration on existing key
    r.expire('mykey', 300)  # 5 minutes
    r.expireat('mykey', 1609459200)  # Unix timestamp

    # Get TTL
    ttl = r.ttl('mykey')  # Seconds remaining (-1 if no expiry, -2 if not exists)

    # Remove expiration
    r.persist('mykey')

    # Set expiration on hash
    r.hset('session:123', mapping={'user_id': '1000'})
    r.expire('session:123', 1800)  # 30 minutes
    ```

    **Common TTL Patterns:**

    ```python
    # Cache with automatic refresh
    def get_cached(key, fetch_function, ttl=300):
        value = r.get(key)
        if value is None:
            value = fetch_function()
            r.set(key, value, ex=ttl)
        return value

    # Sliding window expiration
    def access_resource(key):
        r.expire(key, 3600)  # Reset to 1 hour on each access
    ```

    ## Pub/Sub Messaging

    **Publish/Subscribe pattern for real-time messaging**

    ### Basic Pub/Sub

    ```python
    # Publisher
    def publish_message(channel, message):
        r.publish(channel, message)

    # Subscriber (blocking)
    def subscribe_to_channel(channel):
        pubsub = r.pubsub()
        pubsub.subscribe(channel)

        for message in pubsub.listen():
            if message['type'] == 'message':
                print(f"Received: {message['data']}")
                process_message(message['data'])
    ```

    ```javascript
    // Node.js Publisher
    await redis.publish('notifications', JSON.stringify({
        type: 'new_message',
        user_id: 1000
    }));

    // Node.js Subscriber
    const subscriber = new Redis();
    subscriber.subscribe('notifications', (err, count) => {
        console.log(`Subscribed to ${count} channels`);
    });

    subscriber.on('message', (channel, message) => {
        const data = JSON.parse(message);
        console.log('Received:', data);
    });
    ```

    ### Pattern Subscriptions

    ```python
    # Subscribe to pattern
    pubsub = r.pubsub()
    pubsub.psubscribe('user:*:notifications')

    # Publish to specific user
    r.publish('user:1000:notifications', 'New message')
    r.publish('user:2000:notifications', 'Friend request')
    ```

    ### Pub/Sub Use Cases

    1. **Real-time Notifications**
    ```python
    # Notification service
    def send_notification(user_id, notification):
        channel = f'user:{user_id}:notifications'
        r.publish(channel, json.dumps(notification))

    # User's notification listener
    def listen_for_notifications(user_id):
        pubsub = r.pubsub()
        pubsub.subscribe(f'user:{user_id}:notifications')

        for message in pubsub.listen():
            if message['type'] == 'message':
                notification = json.loads(message['data'])
                display_notification(notification)
    ```

    2. **Chat System**
    ```python
    # Join chat room
    def join_room(room_id):
        pubsub = r.pubsub()
        pubsub.subscribe(f'chat:room:{room_id}')
        return pubsub

    # Send message to room
    def send_message(room_id, user_id, message):
        r.publish(f'chat:room:{room_id}', json.dumps({
            'user_id': user_id,
            'message': message,
            'timestamp': time.time()
        }))
    ```

    3. **Cache Invalidation**
    ```python
    # Publish cache invalidation event
    def invalidate_cache(cache_key):
        r.publish('cache:invalidate', cache_key)

    # All app servers listen for invalidation
    def listen_for_invalidations():
        pubsub = r.pubsub()
        pubsub.subscribe('cache:invalidate')

        for message in pubsub.listen():
            if message['type'] == 'message':
                cache_key = message['data']
                local_cache.delete(cache_key)
    ```

    ## Summary: Choosing the Right Data Structure

    | Data Structure | Use When | Examples |
    |---------------|----------|----------|
    | **String** | Simple key-value, counters, locks | Cache, session tokens, rate limiting |
    | **List** | Ordered collection, queue | Message queues, activity feeds, recent items |
    | **Set** | Unique items, membership testing | Tags, unique visitors, relationships |
    | **Sorted Set** | Ranked data, time-series | Leaderboards, priority queues, scheduled tasks |
    | **Hash** | Object with fields | User profiles, sessions, settings |

    ## Next Steps

    Now that you understand Redis data structures, you'll learn how to apply them in sophisticated caching patterns and production scenarios!
  MARKDOWN
  lesson.sequence_order = 1
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
end

# ==========================================
# MODULE 2: Caching Strategies
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'caching-patterns', course: redis_course) do |mod|
  mod.title = 'Caching Patterns & Strategies'
  mod.description = 'Advanced caching patterns, session management, and real-time features'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement cache-aside, write-through, and write-behind patterns",
    "Build session storage systems",
    "Create rate limiting with Redis",
    "Design leaderboards and real-time analytics",
    "Handle cache invalidation strategies"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Advanced Caching Patterns with Redis") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Advanced Caching Patterns with Redis

    Caching is crucial for performance, but implementing it correctly requires understanding different patterns and their trade-offs.

    ## Why Cache?

    ### Performance Benefits
    - **10-100x faster** than database queries
    - **Reduced database load** - fewer queries
    - **Better scalability** - handle more traffic
    - **Lower latency** - sub-millisecond response times

    ### Cost Benefits
    - Smaller database instances
    - Reduced cloud costs
    - Better resource utilization

    ## Caching Patterns

    ### 1. Cache-Aside (Lazy Loading)

    **The application manages the cache**

    ```
    ┌──────────┐         ┌───────┐         ┌──────────┐
    │   App    │────1───▶│ Cache │         │ Database │
    │          │◀───2────│       │         │          │
    │          │         └───────┘         │          │
    │          │────3─────────────────────▶│          │
    │          │◀───4──────────────────────│          │
    │          │────5───▶│       │         │          │
    └──────────┘         └───────┘         └──────────┘

    1. Check cache
    2. Cache miss
    3. Query database
    4. Return data
    5. Store in cache
    ```

    **Implementation:**

    ```python
    import redis
    import json
    from typing import Optional

    r = redis.Redis(host='localhost', port=6379, decode_responses=True)

    def get_user(user_id: int) -> Optional[dict]:
        cache_key = f'user:{user_id}'

        # 1. Try cache first
        cached = r.get(cache_key)
        if cached:
            print('Cache HIT')
            return json.loads(cached)

        print('Cache MISS')

        # 2. Query database
        user = db.query('SELECT * FROM users WHERE id = ?', user_id)

        if user:
            # 3. Store in cache
            r.set(cache_key, json.dumps(user), ex=3600)  # 1 hour TTL

        return user
    ```

    ```javascript
    const Redis = require('ioredis');
    const redis = new Redis();

    async function getUser(userId) {
        const cacheKey = `user:${userId}`;

        // 1. Try cache first
        const cached = await redis.get(cacheKey);
        if (cached) {
            console.log('Cache HIT');
            return JSON.parse(cached);
        }

        console.log('Cache MISS');

        // 2. Query database
        const user = await db.query('SELECT * FROM users WHERE id = $1', [userId]);

        if (user) {
            // 3. Store in cache
            await redis.set(cacheKey, JSON.stringify(user), 'EX', 3600);
        }

        return user;
    }
    ```

    **Pros:**
    - Simple to implement
    - Only caches what's requested (no wasted space)
    - Cache can be cleared without affecting app

    **Cons:**
    - First request always slow (cache miss)
    - Cache and DB can be inconsistent
    - Need to handle cache invalidation

    **When to use:** Most common pattern, great for read-heavy workloads

    ### 2. Write-Through Cache

    **Data is written to cache and database simultaneously**

    ```
    ┌──────────┐         ┌───────┐         ┌──────────┐
    │   App    │────1───▶│ Cache │────2───▶│ Database │
    │          │◀───4────│       │◀───3────│          │
    └──────────┘         └───────┘         └──────────┘

    1. Write to cache
    2. Cache writes to database
    3. Database confirms
    4. Confirm to app
    ```

    **Implementation:**

    ```python
    def save_user(user_id: int, user_data: dict) -> bool:
        cache_key = f'user:{user_id}'

        try:
            # 1. Write to database first
            db.execute(
                'UPDATE users SET name=?, email=? WHERE id=?',
                user_data['name'], user_data['email'], user_id
            )

            # 2. Write to cache
            r.set(cache_key, json.dumps(user_data), ex=3600)

            return True
        except Exception as e:
            print(f'Error: {e}')
            return False

    def update_user(user_id: int, updates: dict) -> dict:
        # Get current data
        user = get_user_from_db(user_id)

        # Apply updates
        user.update(updates)

        # Save (write-through)
        save_user(user_id, user)

        return user
    ```

    ```javascript
    async function saveUser(userId, userData) {
        const cacheKey = `user:${userId}`;

        try {
            // 1. Write to database
            await db.query(
                'UPDATE users SET name=$1, email=$2 WHERE id=$3',
                [userData.name, userData.email, userId]
            );

            // 2. Update cache
            await redis.set(cacheKey, JSON.stringify(userData), 'EX', 3600);

            return true;
        } catch (error) {
            console.error('Error:', error);
            return false;
        }
    }
    ```

    **Pros:**
    - Cache always consistent with database
    - No stale data
    - Read performance maintained

    **Cons:**
    - Write latency increased (two writes)
    - Wasted cache space for rarely-read data

    **When to use:** When consistency is critical, data is read frequently after writes

    ### 3. Write-Behind (Write-Back) Cache

    **Data written to cache first, asynchronously written to database**

    ```
    ┌──────────┐         ┌───────┐         ┌──────────┐
    │   App    │────1───▶│ Cache │         │ Database │
    │          │◀───2────│       │         │          │
    │          │         │       │────3───▶│          │
    └──────────┘         └───────┘         └──────────┘

    1. Write to cache (fast)
    2. Confirm immediately
    3. Async write to DB later
    ```

    **Implementation:**

    ```python
    import time
    from queue import Queue
    from threading import Thread

    write_queue = Queue()

    def save_user_async(user_id: int, user_data: dict) -> bool:
        cache_key = f'user:{user_id}'

        # 1. Write to cache immediately
        r.set(cache_key, json.dumps(user_data), ex=3600)

        # 2. Mark as dirty (needs DB write)
        r.sadd('dirty:users', user_id)

        # 3. Queue for async write
        write_queue.put(('user', user_id, user_data))

        return True

    # Background worker
    def db_writer_worker():
        while True:
            item_type, item_id, data = write_queue.get()

            try:
                # Write to database
                if item_type == 'user':
                    db.execute(
                        'UPDATE users SET name=?, email=? WHERE id=?',
                        data['name'], data['email'], item_id
                    )

                # Remove from dirty set
                r.srem(f'dirty:{item_type}s', item_id)

            except Exception as e:
                print(f'DB write error: {e}')
                # Re-queue for retry
                write_queue.put((item_type, item_id, data))
                time.sleep(5)

            write_queue.task_done()

    # Start background worker
    worker = Thread(target=db_writer_worker, daemon=True)
    worker.start()
    ```

    ```javascript
    const Queue = require('bull');
    const writeQueue = new Queue('database-writes', 'redis://localhost:6379');

    async function saveUserAsync(userId, userData) {
        const cacheKey = `user:${userId}`;

        // 1. Write to cache immediately
        await redis.set(cacheKey, JSON.stringify(userData), 'EX', 3600);

        // 2. Mark as dirty
        await redis.sadd('dirty:users', userId);

        // 3. Queue for async write
        await writeQueue.add({
            type: 'user',
            id: userId,
            data: userData
        }, {
            attempts: 3,
            backoff: {
                type: 'exponential',
                delay: 2000
            }
        });

        return true;
    }

    // Background worker
    writeQueue.process(async (job) => {
        const { type, id, data } = job.data;

        // Write to database
        await db.query(
            'UPDATE users SET name=$1, email=$2 WHERE id=$3',
            [data.name, data.email, id]
        );

        // Remove from dirty set
        await redis.srem(`dirty:${type}s`, id);
    });
    ```

    **Pros:**
    - Extremely fast writes
    - Batching possible (write multiple at once)
    - Reduced database load

    **Cons:**
    - Risk of data loss if cache crashes
    - Complexity in handling failures
    - Eventual consistency

    **When to use:** Write-heavy workloads, analytics, logging

    ## Session Storage

    **Redis excels at session management due to speed and automatic expiration**

    ### Basic Session Implementation

    ```python
    import uuid
    import hashlib

    class SessionManager:
        def __init__(self, redis_client):
            self.r = redis_client
            self.session_ttl = 86400  # 24 hours

        def create_session(self, user_id: int, user_data: dict) -> str:
            # Generate session ID
            session_id = str(uuid.uuid4())

            # Store session data
            session_key = f'session:{session_id}'
            self.r.hset(session_key, mapping={
                'user_id': user_id,
                'created_at': time.time(),
                'last_activity': time.time(),
                **user_data
            })

            # Set expiration
            self.r.expire(session_key, self.session_ttl)

            # Index by user (for logout all devices)
            self.r.sadd(f'user:{user_id}:sessions', session_id)

            return session_id

        def get_session(self, session_id: str) -> Optional[dict]:
            session_key = f'session:{session_id}'
            session = self.r.hgetall(session_key)

            if session:
                # Update last activity
                self.r.hset(session_key, 'last_activity', time.time())
                # Reset expiration (sliding window)
                self.r.expire(session_key, self.session_ttl)

            return session if session else None

        def destroy_session(self, session_id: str):
            session = self.get_session(session_id)
            if session:
                user_id = session.get('user_id')
                # Remove session
                self.r.delete(f'session:{session_id}')
                # Remove from user's session index
                if user_id:
                    self.r.srem(f'user:{user_id}:sessions', session_id)

        def destroy_all_user_sessions(self, user_id: int):
            # Get all user sessions
            sessions = self.r.smembers(f'user:{user_id}:sessions')

            # Delete all sessions
            if sessions:
                keys = [f'session:{sid}' for sid in sessions]
                self.r.delete(*keys)
                self.r.delete(f'user:{user_id}:sessions')

    # Usage
    sm = SessionManager(r)

    # Login
    session_id = sm.create_session(1000, {
        'username': 'alice',
        'email': 'alice@example.com'
    })

    # Verify session
    session = sm.get_session(session_id)
    if session:
        print(f"Logged in as {session['username']}")

    # Logout
    sm.destroy_session(session_id)

    # Logout all devices
    sm.destroy_all_user_sessions(1000)
    ```

    ```javascript
    const { v4: uuidv4 } = require('uuid');

    class SessionManager {
        constructor(redisClient) {
            this.redis = redisClient;
            this.sessionTTL = 86400; // 24 hours
        }

        async createSession(userId, userData) {
            const sessionId = uuidv4();
            const sessionKey = `session:${sessionId}`;

            // Store session data
            await this.redis.hset(sessionKey, {
                user_id: userId,
                created_at: Date.now(),
                last_activity: Date.now(),
                ...userData
            });

            // Set expiration
            await this.redis.expire(sessionKey, this.sessionTTL);

            // Index by user
            await this.redis.sadd(`user:${userId}:sessions`, sessionId);

            return sessionId;
        }

        async getSession(sessionId) {
            const sessionKey = `session:${sessionId}`;
            const session = await this.redis.hgetall(sessionKey);

            if (Object.keys(session).length > 0) {
                // Update last activity
                await this.redis.hset(sessionKey, 'last_activity', Date.now());
                // Reset expiration
                await this.redis.expire(sessionKey, this.sessionTTL);

                return session;
            }

            return null;
        }

        async destroySession(sessionId) {
            const session = await this.getSession(sessionId);
            if (session) {
                const userId = session.user_id;
                await this.redis.del(`session:${sessionId}`);
                await this.redis.srem(`user:${userId}:sessions`, sessionId);
            }
        }
    }
    ```

    ## Rate Limiting

    **Prevent abuse and ensure fair resource usage**

    ### Fixed Window Rate Limiting

    ```python
    def is_rate_limited_fixed(user_id: str, limit: int = 100, window: int = 60) -> bool:
        """
        Fixed window: 100 requests per minute
        """
        current_minute = int(time.time() / window)
        key = f'rate:fixed:{user_id}:{current_minute}'

        # Increment counter
        count = r.incr(key)

        # Set expiration on first request
        if count == 1:
            r.expire(key, window * 2)  # Keep for 2 windows

        return count > limit

    # Usage
    if is_rate_limited_fixed('user:1000', limit=100, window=60):
        print('Rate limited! Try again later')
    else:
        process_request()
    ```

    ### Sliding Window Rate Limiting

    ```python
    def is_rate_limited_sliding(user_id: str, limit: int = 100, window: int = 60) -> bool:
        """
        Sliding window: More accurate than fixed window
        """
        now = time.time()
        key = f'rate:sliding:{user_id}'

        pipe = r.pipeline()

        # Remove old entries
        pipe.zremrangebyscore(key, 0, now - window)

        # Count requests in window
        pipe.zcard(key)

        # Add current request
        pipe.zadd(key, {str(now): now})

        # Set expiration
        pipe.expire(key, window)

        results = pipe.execute()
        request_count = results[1]

        return request_count >= limit

    # Usage
    if is_rate_limited_sliding('user:1000', limit=100, window=60):
        print('Rate limited!')
    else:
        process_request()
    ```

    ### Token Bucket Rate Limiting

    ```python
    class TokenBucket:
        def __init__(self, redis_client, capacity: int, refill_rate: float):
            self.r = redis_client
            self.capacity = capacity  # Max tokens
            self.refill_rate = refill_rate  # Tokens per second

        def allow_request(self, user_id: str) -> bool:
            key = f'rate:bucket:{user_id}'
            now = time.time()

            # Get current bucket state
            data = self.r.hgetall(key)

            if data:
                tokens = float(data.get(b'tokens', self.capacity))
                last_update = float(data.get(b'last_update', now))
            else:
                tokens = self.capacity
                last_update = now

            # Calculate new tokens
            elapsed = now - last_update
            tokens = min(self.capacity, tokens + elapsed * self.refill_rate)

            # Try to consume token
            if tokens >= 1:
                tokens -= 1
                allowed = True
            else:
                allowed = False

            # Update bucket
            self.r.hset(key, mapping={
                'tokens': tokens,
                'last_update': now
            })
            self.r.expire(key, 3600)

            return allowed

    # Usage
    bucket = TokenBucket(r, capacity=100, refill_rate=10)  # 10 tokens/second

    if bucket.allow_request('user:1000'):
        process_request()
    else:
        print('Rate limited!')
    ```

    ```javascript
    class TokenBucket {
        constructor(redis, capacity, refillRate) {
            this.redis = redis;
            this.capacity = capacity;
            this.refillRate = refillRate;
        }

        async allowRequest(userId) {
            const key = `rate:bucket:${userId}`;
            const now = Date.now() / 1000;

            const data = await this.redis.hgetall(key);

            let tokens = data.tokens ? parseFloat(data.tokens) : this.capacity;
            let lastUpdate = data.last_update ? parseFloat(data.last_update) : now;

            // Calculate new tokens
            const elapsed = now - lastUpdate;
            tokens = Math.min(this.capacity, tokens + elapsed * this.refillRate);

            // Try to consume token
            let allowed = false;
            if (tokens >= 1) {
                tokens -= 1;
                allowed = true;
            }

            // Update bucket
            await this.redis.hset(key, {
                tokens: tokens.toString(),
                last_update: now.toString()
            });
            await this.redis.expire(key, 3600);

            return allowed;
        }
    }
    ```

    ## Leaderboards

    **Sorted sets are perfect for leaderboards**

    ```python
    class Leaderboard:
        def __init__(self, redis_client, name: str):
            self.r = redis_client
            self.key = f'leaderboard:{name}'

        def add_score(self, player_id: str, score: float):
            """Add or update player score"""
            self.r.zadd(self.key, {player_id: score})

        def increment_score(self, player_id: str, amount: float):
            """Increment player score"""
            return self.r.zincrby(self.key, amount, player_id)

        def get_top(self, n: int = 10):
            """Get top N players"""
            return self.r.zrevrange(self.key, 0, n - 1, withscores=True)

        def get_rank(self, player_id: str):
            """Get player's rank (1-based)"""
            rank = self.r.zrevrank(self.key, player_id)
            return rank + 1 if rank is not None else None

        def get_score(self, player_id: str):
            """Get player's score"""
            return self.r.zscore(self.key, player_id)

        def get_around(self, player_id: str, range: int = 5):
            """Get players around given player"""
            rank = self.r.zrevrank(self.key, player_id)
            if rank is None:
                return []

            start = max(0, rank - range)
            end = rank + range
            return self.r.zrevrange(self.key, start, end, withscores=True)

        def get_percentile(self, player_id: str):
            """Get player's percentile"""
            total = self.r.zcard(self.key)
            rank = self.r.zrevrank(self.key, player_id)

            if rank is None or total == 0:
                return None

            return ((total - rank) / total) * 100

    # Usage
    lb = Leaderboard(r, 'global')

    # Add scores
    lb.add_score('player1', 1000)
    lb.add_score('player2', 1500)
    lb.add_score('player3', 1200)

    # Increment score
    lb.increment_score('player1', 100)

    # Get top 10
    top = lb.get_top(10)
    for i, (player, score) in enumerate(top, 1):
        print(f'{i}. {player}: {score}')

    # Get player stats
    rank = lb.get_rank('player1')
    score = lb.get_score('player1')
    percentile = lb.get_percentile('player1')
    print(f'Rank: {rank}, Score: {score}, Top {percentile:.1f}%')

    # Get nearby players
    nearby = lb.get_around('player1', range=3)
    ```

    ## Real-time Analytics

    **Track metrics in real-time using various data structures**

    ```python
    class Analytics:
        def __init__(self, redis_client):
            self.r = redis_client

        def track_page_view(self, page: str, user_id: str = None):
            """Track page views"""
            date = time.strftime('%Y-%m-%d')
            hour = time.strftime('%Y-%m-%d:%H')

            pipe = self.r.pipeline()

            # Total views
            pipe.incr(f'analytics:views:{page}:{date}')
            pipe.incr(f'analytics:views:{page}:{hour}')

            # Unique views
            if user_id:
                pipe.sadd(f'analytics:unique:{page}:{date}', user_id)
                pipe.sadd(f'analytics:unique:{page}:{hour}', user_id)

            pipe.execute()

        def get_page_stats(self, page: str, date: str = None):
            """Get page statistics"""
            if date is None:
                date = time.strftime('%Y-%m-%d')

            total_views = self.r.get(f'analytics:views:{page}:{date}') or 0
            unique_views = self.r.scard(f'analytics:unique:{page}:{date}')

            return {
                'total_views': int(total_views),
                'unique_views': unique_views
            }

        def track_metric(self, metric: str, value: float):
            """Track time-series metric"""
            timestamp = time.time()
            key = f'metrics:{metric}'

            # Store in sorted set (timestamp as score)
            self.r.zadd(key, {json.dumps(value): timestamp})

            # Keep only last 24 hours
            cutoff = timestamp - 86400
            self.r.zremrangebyscore(key, 0, cutoff)

        def get_metric_stats(self, metric: str, last_minutes: int = 60):
            """Get metric statistics"""
            cutoff = time.time() - (last_minutes * 60)
            key = f'metrics:{metric}'

            # Get all values in range
            data = self.r.zrangebyscore(key, cutoff, '+inf')
            if not data:
                return None

            values = [float(json.loads(d)) for d in data]

            return {
                'count': len(values),
                'sum': sum(values),
                'avg': sum(values) / len(values),
                'min': min(values),
                'max': max(values)
            }

    # Usage
    analytics = Analytics(r)

    # Track page view
    analytics.track_page_view('/products', user_id='user:1000')

    # Get stats
    stats = analytics.get_page_stats('/products')
    print(f"Views: {stats['total_views']}, Unique: {stats['unique_views']}")

    # Track metrics
    analytics.track_metric('api:latency', 45.5)
    analytics.track_metric('api:latency', 52.3)

    # Get metric stats
    metric_stats = analytics.get_metric_stats('api:latency', last_minutes=60)
    print(f"Avg latency: {metric_stats['avg']:.2f}ms")
    ```

    ## Summary

    | Pattern | Use Case | Pros | Cons |
    |---------|----------|------|------|
    | **Cache-Aside** | General caching | Simple, flexible | First request slow |
    | **Write-Through** | Consistency critical | Always consistent | Slower writes |
    | **Write-Behind** | High write volume | Fast writes | Data loss risk |
    | **Session Storage** | User sessions | Fast, auto-expire | Memory limited |
    | **Rate Limiting** | API protection | Prevent abuse | Configuration needed |
    | **Leaderboards** | Rankings | Real-time updates | Memory for all players |
    | **Analytics** | Real-time metrics | Instant insights | Approximate counts |

    ## Next Steps

    You've mastered caching patterns! Next, we'll explore production Redis deployments with clustering, persistence, and optimization techniques.
  MARKDOWN
  lesson.sequence_order = 1
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
end

# ==========================================
# MODULE 3: Redis in Production
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'redis-advanced', course: redis_course) do |mod|
  mod.title = 'Advanced Redis'
  mod.description = 'Production patterns, clustering, persistence, and optimization'
  mod.sequence_order = 3
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Deploy Redis Cluster and Sentinel",
    "Configure persistence with RDB and AOF",
    "Optimize memory usage",
    "Implement connection pooling",
    "Monitor and debug Redis",
    "Avoid common production pitfalls"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Production Redis Patterns") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Production Redis Patterns

    Running Redis in production requires understanding high availability, persistence, optimization, and monitoring.

    ## High Availability Options

    ### 1. Redis Sentinel

    **Automatic failover and monitoring for master-replica setups**

    ```
    ┌────────────┐         ┌────────────┐         ┌────────────┐
    │ Sentinel 1 │         │ Sentinel 2 │         │ Sentinel 3 │
    └─────┬──────┘         └─────┬──────┘         └─────┬──────┘
          │                      │                      │
          └──────────────┬───────┴──────────────────────┘
                         │ Monitor & Vote
                         ▼
              ┌──────────────────┐
              │   Master Redis   │
              └────────┬─────────┘
                       │ Replicate
           ┌───────────┼───────────┐
           ▼           ▼           ▼
    ┌──────────┐ ┌──────────┐ ┌──────────┐
    │ Replica 1│ │ Replica 2│ │ Replica 3│
    └──────────┘ └──────────┘ └──────────┘
    ```

    **Configuration (redis.conf for replica):**

    ```conf
    # Replica configuration
    replicaof <master-ip> <master-port>
    masterauth <password>
    replica-read-only yes
    ```

    **Sentinel configuration (sentinel.conf):**

    ```conf
    # Monitor master
    sentinel monitor mymaster 127.0.0.1 6379 2
    sentinel auth-pass mymaster yourpassword
    sentinel down-after-milliseconds mymaster 5000
    sentinel parallel-syncs mymaster 1
    sentinel failover-timeout mymaster 10000
    ```

    **Connecting with Sentinel (Python):**

    ```python
    from redis.sentinel import Sentinel

    # Sentinel configuration
    sentinel = Sentinel([
        ('localhost', 26379),
        ('localhost', 26380),
        ('localhost', 26381)
    ], socket_timeout=0.1)

    # Get master connection (for writes)
    master = sentinel.master_for('mymaster', socket_timeout=0.1)
    master.set('key', 'value')

    # Get replica connection (for reads)
    replica = sentinel.slave_for('mymaster', socket_timeout=0.1)
    value = replica.get('key')

    # Automatic failover handling
    def safe_write(key, value):
        try:
            master = sentinel.master_for('mymaster', socket_timeout=0.1)
            master.set(key, value)
            return True
        except Exception as e:
            print(f'Write failed: {e}')
            return False
    ```

    **Connecting with Sentinel (Node.js):**

    ```javascript
    const Redis = require('ioredis');

    // Sentinel configuration
    const redis = new Redis({
        sentinels: [
            { host: 'localhost', port: 26379 },
            { host: 'localhost', port: 26380 },
            { host: 'localhost', port: 26381 }
        ],
        name: 'mymaster',
        password: 'yourpassword'
    });

    // Automatic failover is handled automatically
    await redis.set('key', 'value');
    ```

    **When to use Sentinel:**
    - Simple master-replica setup
    - Automatic failover needed
    - Up to a few hundred GB of data

    ### 2. Redis Cluster

    **Distributed Redis with automatic sharding and failover**

    ```
    Cluster with 3 master nodes, each with 1 replica:

    Master 1        Master 2        Master 3
    (0-5460)       (5461-10922)    (10923-16383)
        │               │               │
        ▼               ▼               ▼
    Replica 1       Replica 2       Replica 3

    Data automatically sharded across masters by hash slot
    ```

    **Cluster configuration (redis.conf):**

    ```conf
    # Enable cluster
    cluster-enabled yes
    cluster-config-file nodes.conf
    cluster-node-timeout 5000
    appendonly yes
    ```

    **Creating a cluster:**

    ```bash
    # Start 6 Redis instances (3 masters, 3 replicas)
    redis-server --port 7000 --cluster-enabled yes --cluster-config-file nodes-7000.conf
    redis-server --port 7001 --cluster-enabled yes --cluster-config-file nodes-7001.conf
    # ... repeat for ports 7002-7005

    # Create cluster
    redis-cli --cluster create \\
      127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 \\
      127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005 \\
      --cluster-replicas 1
    ```

    **Connecting to cluster (Python):**

    ```python
    from redis.cluster import RedisCluster

    # Cluster connection
    rc = RedisCluster(
        startup_nodes=[
            {"host": "127.0.0.1", "port": "7000"},
            {"host": "127.0.0.1", "port": "7001"},
            {"host": "127.0.0.1", "port": "7002"}
        ],
        decode_responses=True
    )

    # Works transparently - client handles routing
    rc.set('key', 'value')
    value = rc.get('key')

    # Multi-key operations require same hash slot
    # Use hash tags to ensure same slot
    rc.set('{user:1000}:name', 'Alice')
    rc.set('{user:1000}:email', 'alice@example.com')

    # These will be on same node due to {user:1000} hash tag
    pipe = rc.pipeline()
    pipe.get('{user:1000}:name')
    pipe.get('{user:1000}:email')
    results = pipe.execute()
    ```

    **Connecting to cluster (Node.js):**

    ```javascript
    const Redis = require('ioredis');

    const cluster = new Redis.Cluster([
        { port: 7000, host: '127.0.0.1' },
        { port: 7001, host: '127.0.0.1' },
        { port: 7002, host: '127.0.0.1' }
    ]);

    // Automatic routing
    await cluster.set('key', 'value');

    // Hash tags for multi-key operations
    await cluster.set('{user:1000}:name', 'Alice');
    await cluster.set('{user:1000}:email', 'alice@example.com');
    ```

    **When to use Cluster:**
    - Need to scale beyond single server
    - Horizontal scaling required
    - Multi-TB datasets
    - High write throughput

    ## Persistence

    **Redis offers two persistence mechanisms**

    ### 1. RDB (Redis Database Backup)

    **Point-in-time snapshots**

    ```conf
    # Save snapshot if:
    # - At least 1 key changed in 900 seconds (15 min)
    # - At least 10 keys changed in 300 seconds (5 min)
    # - At least 10000 keys changed in 60 seconds (1 min)
    save 900 1
    save 300 10
    save 60 10000

    # Snapshot file
    dbfilename dump.rdb
    dir /var/lib/redis

    # Compression
    rdbcompression yes

    # Checksum
    rdbchecksum yes

    # Stop writes if save fails
    stop-writes-on-bgsave-error yes
    ```

    **Manual snapshots:**

    ```bash
    # Blocking save
    redis-cli SAVE

    # Background save
    redis-cli BGSAVE

    # Check last save time
    redis-cli LASTSAVE
    ```

    **Pros:**
    - Compact single file
    - Fast restart
    - Good for backups
    - Minimal performance impact

    **Cons:**
    - Can lose data since last snapshot
    - Fork can be slow for large datasets
    - Not for strict durability

    ### 2. AOF (Append-Only File)

    **Logs every write operation**

    ```conf
    # Enable AOF
    appendonly yes
    appendfilename "appendonly.aof"

    # Fsync policy
    appendfsync everysec  # Options: always, everysec, no

    # Auto rewrite
    auto-aof-rewrite-percentage 100
    auto-aof-rewrite-min-size 64mb

    # Load AOF on startup
    aof-load-truncated yes
    ```

    **AOF fsync policies:**

    1. **always** - Fsync after every write
       - Most durable
       - Slowest (1000x slower than everysec)

    2. **everysec** - Fsync every second (default)
       - Good balance
       - May lose 1 second of data

    3. **no** - Let OS decide when to fsync
       - Fastest
       - Can lose significant data

    **Manual AOF operations:**

    ```bash
    # Trigger rewrite
    redis-cli BGREWRITEAOF

    # Check AOF status
    redis-cli INFO persistence
    ```

    **Pros:**
    - More durable (less data loss)
    - Append-only (less corruption)
    - Auto-rewrite when too large

    **Cons:**
    - Larger files than RDB
    - Slower restart
    - Potentially slower writes

    ### Hybrid Persistence (RDB + AOF)

    **Best of both worlds**

    ```conf
    # Enable both
    save 900 1
    save 300 10
    save 60 10000
    appendonly yes
    appendfsync everysec

    # Use RDB format in AOF rewrites (faster)
    aof-use-rdb-preamble yes
    ```

    ## Memory Optimization

    ### 1. Eviction Policies

    **What to do when max memory is reached**

    ```conf
    # Set max memory
    maxmemory 2gb

    # Eviction policy
    maxmemory-policy allkeys-lru
    ```

    **Available policies:**

    - **noeviction** - Return errors when memory full (default)
    - **allkeys-lru** - Evict least recently used keys
    - **allkeys-lfu** - Evict least frequently used keys
    - **volatile-lru** - Evict LRU keys with TTL
    - **volatile-lfu** - Evict LFU keys with TTL
    - **volatile-ttl** - Evict keys with shortest TTL
    - **volatile-random** - Random eviction of keys with TTL
    - **allkeys-random** - Random eviction of any keys

    **Choosing a policy:**

    ```python
    # For cache (OK to lose any data)
    # maxmemory-policy allkeys-lru

    # For cache with explicit TTLs
    # maxmemory-policy volatile-lru

    # For session storage (never evict)
    # maxmemory-policy noeviction
    ```

    ### 2. Memory Usage Analysis

    ```bash
    # Check memory usage
    redis-cli INFO memory

    # Memory usage by key
    redis-cli --bigkeys

    # Detailed memory analysis
    redis-cli --memkeys

    # Memory usage of specific key
    redis-cli MEMORY USAGE key

    # Sample memory usage
    redis-cli --memkeys --memkeys-samples 10000
    ```

    **Optimizing memory:**

    ```python
    # Use hashes for small objects (< 512 fields)
    # More memory efficient than separate keys

    # Instead of:
    r.set('user:1000:name', 'Alice')
    r.set('user:1000:email', 'alice@example.com')
    r.set('user:1000:age', '30')

    # Use:
    r.hset('user:1000', mapping={
        'name': 'Alice',
        'email': 'alice@example.com',
        'age': '30'
    })

    # Compress large values
    import zlib
    import json

    data = {'large': 'object' * 1000}
    compressed = zlib.compress(json.dumps(data).encode())
    r.set('key', compressed)

    # Decompress
    compressed_data = r.get('key')
    data = json.loads(zlib.decompress(compressed_data))
    ```

    ### 3. Data Structure Tuning

    ```conf
    # Hash optimization
    hash-max-ziplist-entries 512
    hash-max-ziplist-value 64

    # List optimization
    list-max-ziplist-size -2
    list-compress-depth 0

    # Set optimization
    set-max-intset-entries 512

    # Sorted set optimization
    zset-max-ziplist-entries 128
    zset-max-ziplist-value 64
    ```

    ## Connection Pooling

    **Reuse connections for better performance**

    **Python connection pool:**

    ```python
    import redis

    # Create pool
    pool = redis.ConnectionPool(
        host='localhost',
        port=6379,
        db=0,
        max_connections=50,
        decode_responses=True
    )

    # Get connection from pool
    r = redis.Redis(connection_pool=pool)

    # Use normally
    r.set('key', 'value')

    # Connection automatically returned to pool

    # For multiple Redis instances
    class RedisPool:
        def __init__(self):
            self.pools = {}

        def get_connection(self, host='localhost', port=6379, db=0):
            key = f'{host}:{port}:{db}'

            if key not in self.pools:
                self.pools[key] = redis.ConnectionPool(
                    host=host,
                    port=port,
                    db=db,
                    max_connections=50
                )

            return redis.Redis(connection_pool=self.pools[key])

    redis_pool = RedisPool()
    r1 = redis_pool.get_connection('localhost', 6379, 0)
    r2 = redis_pool.get_connection('localhost', 6379, 1)
    ```

    **Node.js connection pool:**

    ```javascript
    const Redis = require('ioredis');

    // ioredis has built-in connection pooling
    const redis = new Redis({
        host: 'localhost',
        port: 6379,
        // Connection pool settings
        maxRetriesPerRequest: 3,
        enableReadyCheck: true,
        enableOfflineQueue: true,

        // Reconnection strategy
        retryStrategy(times) {
            const delay = Math.min(times * 50, 2000);
            return delay;
        }
    });

    // For multiple connections
    class RedisPool {
        constructor() {
            this.connections = new Map();
        }

        getConnection(host = 'localhost', port = 6379, db = 0) {
            const key = \`\${host}:\${port}:\${db}\`;

            if (!this.connections.has(key)) {
                this.connections.set(key, new Redis({
                    host,
                    port,
                    db
                }));
            }

            return this.connections.get(key);
        }
    }
    ```

    ## Monitoring and Debugging

    ### 1. INFO Command

    ```bash
    # All info
    redis-cli INFO

    # Specific sections
    redis-cli INFO server
    redis-cli INFO memory
    redis-cli INFO stats
    redis-cli INFO replication
    redis-cli INFO cpu
    redis-cli INFO persistence
    redis-cli INFO keyspace
    ```

    ### 2. Monitoring Commands

    ```bash
    # Monitor all commands in real-time
    redis-cli MONITOR

    # Slow query log
    redis-cli SLOWLOG GET 10

    # Configure slow log
    CONFIG SET slowlog-log-slower-than 10000  # 10ms
    CONFIG SET slowlog-max-len 128

    # Client list
    redis-cli CLIENT LIST

    # Kill client
    redis-cli CLIENT KILL <ip:port>

    # Current operations
    redis-cli CLIENT GETNAME
    ```

    ### 3. Performance Testing

    ```bash
    # Benchmark
    redis-benchmark -h localhost -p 6379 -c 50 -n 100000

    # Specific commands
    redis-benchmark -t set,get -n 100000 -q

    # With pipelining
    redis-benchmark -t set,get -n 100000 -P 16 -q
    ```

    ### 4. Debugging in Code

    ```python
    import redis
    import time

    class RedisDebugger:
        def __init__(self, redis_client):
            self.r = redis_client

        def timed_operation(self, operation_name, func):
            """Time an operation"""
            start = time.time()
            result = func()
            elapsed = (time.time() - start) * 1000  # ms

            if elapsed > 10:  # Log slow operations
                print(f'SLOW: {operation_name} took {elapsed:.2f}ms')

            return result

        def check_key_size(self, key):
            """Check memory usage of key"""
            memory_bytes = self.r.memory_usage(key)
            key_type = self.r.type(key)

            if key_type == 'string':
                length = self.r.strlen(key)
            elif key_type == 'list':
                length = self.r.llen(key)
            elif key_type == 'set':
                length = self.r.scard(key)
            elif key_type == 'zset':
                length = self.r.zcard(key)
            elif key_type == 'hash':
                length = self.r.hlen(key)
            else:
                length = None

            return {
                'type': key_type,
                'memory': memory_bytes,
                'length': length
            }

        def find_large_keys(self, pattern='*', sample_size=1000):
            """Find large keys"""
            large_keys = []

            for key in self.r.scan_iter(match=pattern, count=100):
                size_info = self.check_key_size(key)
                if size_info['memory'] and size_info['memory'] > 1024 * 1024:  # 1MB
                    large_keys.append((key, size_info))

                if len(large_keys) >= sample_size:
                    break

            return sorted(large_keys, key=lambda x: x[1]['memory'], reverse=True)

    # Usage
    debugger = RedisDebugger(r)

    # Time operation
    result = debugger.timed_operation(
        'get_user',
        lambda: r.hgetall('user:1000')
    )

    # Check key size
    info = debugger.check_key_size('user:1000')
    print(f"Memory: {info['memory']} bytes, Length: {info['length']}")

    # Find large keys
    large = debugger.find_large_keys()
    for key, info in large[:10]:
        print(f"{key}: {info['memory']} bytes")
    ```

    ## Common Pitfalls

    ### 1. KEYS Command in Production

    ```python
    # ❌ NEVER in production - blocks server
    keys = r.keys('user:*')

    # ✅ Use SCAN instead
    def scan_keys(pattern):
        keys = []
        cursor = 0
        while True:
            cursor, batch = r.scan(cursor, match=pattern, count=100)
            keys.extend(batch)
            if cursor == 0:
                break
        return keys

    keys = scan_keys('user:*')
    ```

    ### 2. Large Collections

    ```python
    # ❌ Don't store millions of items in one key
    for i in range(1000000):
        r.sadd('all_users', i)  # Huge memory, slow operations

    # ✅ Shard across multiple keys
    def get_shard_key(user_id, num_shards=100):
        shard = user_id % num_shards
        return f'users:shard:{shard}'

    def add_user(user_id):
        r.sadd(get_shard_key(user_id), user_id)
    ```

    ### 3. Missing Expiration

    ```python
    # ❌ No expiration - memory leak
    r.set('temp:data', value)

    # ✅ Always set expiration for temporary data
    r.set('temp:data', value, ex=3600)

    # ✅ Set default TTL for keys
    def safe_set(key, value, ttl=3600):
        r.set(key, value, ex=ttl)
    ```

    ### 4. Pipeline vs Transaction

    ```python
    # Pipeline - faster, not atomic
    pipe = r.pipeline(transaction=False)
    pipe.set('key1', 'value1')
    pipe.set('key2', 'value2')
    pipe.execute()

    # Transaction - atomic, slower
    pipe = r.pipeline(transaction=True)
    pipe.multi()
    pipe.set('key1', 'value1')
    pipe.set('key2', 'value2')
    pipe.execute()

    # Watch for concurrent modifications
    with r.pipeline() as pipe:
        while True:
            try:
                pipe.watch('balance')
                balance = int(pipe.get('balance') or 0)

                if balance >= 100:
                    pipe.multi()
                    pipe.decrby('balance', 100)
                    pipe.execute()
                    break
                else:
                    pipe.unwatch()
                    raise ValueError('Insufficient balance')
            except redis.WatchError:
                continue  # Retry
    ```

    ### 5. Connection Leaks

    ```python
    # ❌ Creating new connections
    def get_user(user_id):
        r = redis.Redis()  # New connection each time!
        return r.hgetall(f'user:{user_id}')

    # ✅ Reuse connection pool
    pool = redis.ConnectionPool()

    def get_user(user_id):
        r = redis.Redis(connection_pool=pool)
        return r.hgetall(f'user:{user_id}')
    ```

    ## Production Checklist

    - [ ] **High Availability**: Sentinel or Cluster configured
    - [ ] **Persistence**: RDB and/or AOF enabled
    - [ ] **Memory**: maxmemory and eviction policy set
    - [ ] **Security**: requirepass and bind configured
    - [ ] **Connection Pool**: Using connection pooling
    - [ ] **Monitoring**: INFO, SLOWLOG monitoring
    - [ ] **Backups**: Regular RDB backups to S3/similar
    - [ ] **TTLs**: All temporary keys have expiration
    - [ ] **Testing**: Load tested for expected traffic
    - [ ] **Documentation**: Runbooks for common issues

    ## Recommended Configuration

    ```conf
    # redis.conf for production

    # Network
    bind 127.0.0.1
    port 6379
    protected-mode yes
    tcp-backlog 511
    timeout 0
    tcp-keepalive 300

    # Security
    requirepass yourSecurePasswordHere

    # Memory
    maxmemory 2gb
    maxmemory-policy allkeys-lru

    # Persistence
    save 900 1
    save 300 10
    save 60 10000
    appendonly yes
    appendfsync everysec
    aof-use-rdb-preamble yes

    # Replication (for replicas)
    # replicaof <master-ip> 6379
    # masterauth <master-password>

    # Logging
    loglevel notice
    logfile /var/log/redis/redis.log

    # Slow log
    slowlog-log-slower-than 10000
    slowlog-max-len 128

    # Client output buffer limits
    client-output-buffer-limit normal 0 0 0
    client-output-buffer-limit replica 256mb 64mb 60
    client-output-buffer-limit pubsub 32mb 8mb 60
    ```

    ## Summary

    **Redis in production requires:**

    1. **High Availability** - Sentinel or Cluster
    2. **Persistence** - RDB and/or AOF
    3. **Memory Management** - Eviction policies and monitoring
    4. **Connection Pooling** - Efficient resource usage
    5. **Monitoring** - INFO, SLOWLOG, metrics
    6. **Best Practices** - Avoid KEYS, use SCAN, set TTLs

    Congratulations! You now have the knowledge to build high-performance, production-ready systems with Redis!
  MARKDOWN
  lesson.sequence_order = 1
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
end

puts "  ✅ Created Redis & Caching Strategies course with #{redis_course.course_modules.count} modules"
puts "📖 Modules:"
redis_course.course_modules.order(:sequence_order).each do |mod|
  lesson_count = mod.module_items.joins(:course_lesson).count
  puts "    #{mod.sequence_order}. #{mod.title} (#{lesson_count} lessons)"
end
puts ""
