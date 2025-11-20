# Message Queues & Event-Driven Architecture Course
puts "Creating Message Queues & Event-Driven Architecture Course..."

mq_course = Course.find_or_create_by!(slug: 'message-queues-event-driven') do |course|
  course.title = 'Message Queues & Event-Driven Architecture'
  course.description = 'Build scalable asynchronous systems with RabbitMQ, Kafka, and event-driven patterns'
  course.difficulty_level = 'advanced'
  course.published = true
  course.sequence_order = 28
  course.estimated_hours = 30
  course.learning_objectives = JSON.generate([
    "Understand message queue concepts and patterns",
    "Implement publish/subscribe systems with RabbitMQ",
    "Build event-driven architectures with Kafka",
    "Design event sourcing and CQRS systems",
    "Handle message ordering and delivery guarantees",
    "Implement production-ready messaging patterns"
  ])
  course.prerequisites = JSON.generate(["Backend development experience", "Distributed systems basics", "Docker knowledge"])
end

puts "Created course: #{mq_course.title}"

# ==========================================
# MODULE 1: Message Queue Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'message-queue-fundamentals', course: mq_course) do |mod|
  mod.title = 'Message Queue Fundamentals'
  mod.description = 'Async processing, RabbitMQ, queues vs pub/sub, retry strategies'
  mod.sequence_order = 1
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand why message queues are essential",
    "Differentiate between queues, pub/sub, and event streams",
    "Master RabbitMQ architecture and exchanges",
    "Implement robust producer/consumer patterns",
    "Handle failures with dead letter queues and retries"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Message Queues and Async Processing") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Message Queues and Async Processing

    **Message queues** enable asynchronous communication between services, decoupling producers from consumers.

    ## Why Message Queues?

    ### Problem: Synchronous Processing

    ```python
    # Traditional synchronous approach
    def create_order(order_data):
        # All operations block the request
        order = db.save_order(order_data)          # 50ms
        send_confirmation_email(order)             # 2000ms - SLOW!
        update_inventory(order)                    # 100ms
        notify_shipping(order)                     # 500ms
        update_analytics(order)                    # 200ms

        return order  # User waits 2850ms!
    ```

    **Problems:**
    - High latency (user waits for everything)
    - Single point of failure (email service down = order fails)
    - No retry mechanism
    - Resource waste (holding connection for 3 seconds)

    ### Solution: Asynchronous with Message Queue

    ```python
    # Async approach with message queue
    def create_order(order_data):
        # Save order (critical operation)
        order = db.save_order(order_data)          # 50ms

        # Publish to queue (non-critical operations)
        queue.publish('orders.created', order)     # 1ms

        return order  # User waits only 51ms!

    # Background worker handles the rest
    def handle_order_created(order):
        send_confirmation_email(order)
        update_inventory(order)
        notify_shipping(order)
        update_analytics(order)
    ```

    **Benefits:**
    - Fast response (50ms vs 2850ms)
    - Fault tolerance (failures handled independently)
    - Automatic retries
    - Better resource utilization

    ## Three Core Benefits

    ### 1. Decoupling

    **Services don't need to know about each other**

    ```python
    # Without queue: Tight coupling
    class OrderService:
        def __init__(self, email_service, inventory_service):
            self.email = email_service      # Direct dependency
            self.inventory = inventory_service

        def create_order(self, order):
            self.email.send(order)          # Must know email service
            self.inventory.update(order)    # Must know inventory service

    # With queue: Loose coupling
    class OrderService:
        def __init__(self, queue):
            self.queue = queue  # Only knows about queue

        def create_order(self, order):
            db.save(order)
            self.queue.publish('orders.created', order)
            # Done! Don't care who consumes it
    ```

    **Real-world example: E-commerce**

    ```
    Order Service publishes: "order.created"

    Consumers (all independent):
    ├─ Email Service → Sends confirmation
    ├─ Inventory Service → Updates stock
    ├─ Shipping Service → Creates shipment
    ├─ Analytics Service → Tracks metrics
    └─ Fraud Service → Checks for fraud

    Add new service? Just subscribe to the queue!
    Remove service? Just unsubscribe!
    ```

    ### 2. Scalability

    **Handle traffic spikes and scale consumers independently**

    ```python
    # Black Friday scenario
    Orders:           10,000/second
    Email workers:    100 instances (10s delay OK)
    Inventory workers: 500 instances (must be fast)
    Analytics workers: 20 instances (1hr delay OK)

    # Each consumer scales independently!
    ```

    **Example: Image Processing**

    ```python
    # Producer: Upload service
    def upload_image(file):
        # Save original
        path = storage.save(file)

        # Queue processing tasks
        queue.publish('images.uploaded', {
            'path': path,
            'sizes': ['thumbnail', 'medium', 'large']
        })

        return {'status': 'processing'}

    # Consumers: Image workers (can scale to 100s)
    def process_image(message):
        original = storage.get(message['path'])

        for size in message['sizes']:
            resized = resize_image(original, size)
            storage.save(resized, f"{path}_{size}")

        # Update database: processing complete
        db.update_image_status(message['path'], 'complete')
    ```

    **Scaling strategy:**
    ```
    Normal load:  10 workers
    Peak load:    100 workers (auto-scale based on queue depth)
    Off-peak:     2 workers (save costs)
    ```

    ### 3. Reliability

    **Messages persist until successfully processed**

    ```python
    # Message lifecycle
    1. Producer publishes message → Queue stores it
    2. Consumer receives message → Processing...
    3a. Success → Consumer ACKs → Queue deletes message ✓
    3b. Failure → No ACK → Queue redelivers message ↻
    ```

    **Guaranteed delivery:**

    ```python
    # Without queue: Lost messages
    try:
        send_email(order)
    except NetworkError:
        # Email lost forever! ❌
        pass

    # With queue: Guaranteed delivery
    queue.publish('emails.send', order)
    # ✓ Persisted to disk
    # ✓ Will retry on failure
    # ✓ Won't lose messages
    ```

    ## Queue vs Pub/Sub vs Event Stream

    ### 1. Queue (Point-to-Point)

    **Each message consumed by ONE consumer**

    ```python
    # Example: Job processing

    Producer:
    queue.send('tasks', {'job': 'process_video', 'id': 123})

    Consumer Pool (3 workers):
    Worker 1: Gets message A
    Worker 2: Gets message B
    Worker 3: Gets message C

    # Each message to exactly one worker
    # Load balancing across workers
    ```

    **When to use:**
    - Task queues (background jobs)
    - Work distribution
    - Load balancing
    - One consumer should handle each task

    ### 2. Pub/Sub (Publish-Subscribe)

    **Each message consumed by ALL subscribers**

    ```python
    # Example: Order notifications

    Publisher:
    pubsub.publish('orders.created', order_data)

    Subscribers (all receive same message):
    ├─ Email Service:     sends confirmation
    ├─ Inventory Service: updates stock
    ├─ Analytics Service: tracks metrics
    └─ Webhook Service:   notifies external APIs

    # All subscribers get the message
    # Broadcast pattern
    ```

    **When to use:**
    - Broadcasting events
    - Multiple services need same data
    - Notification systems
    - Event-driven microservices

    ### 3. Event Stream (Log-based)

    **Ordered, append-only log of events**

    ```python
    # Example: Event sourcing

    Stream: user_actions
    Event 1: {"type": "user.created", "id": 123}
    Event 2: {"type": "user.login", "id": 123}
    Event 3: {"type": "user.updated", "id": 123}
    Event 4: {"type": "user.logout", "id": 123}

    Consumer A: Reads from offset 0 (all history)
    Consumer B: Reads from offset 3 (recent only)

    # Events never deleted
    # Consumers track their own position
    # Can replay entire history
    ```

    **When to use:**
    - Event sourcing
    - Audit logs
    - Analytics (replay historical data)
    - CQRS patterns

    ## Comparison Table

    | Feature | Queue | Pub/Sub | Event Stream |
    |---------|-------|---------|--------------|
    | Consumers | One | Many | Many |
    | Message lifetime | Until consumed | Until TTL | Retained (days/forever) |
    | Ordering | Per queue | No guarantee | Strict (per partition) |
    | Replay | No | No | Yes |
    | Use case | Task processing | Broadcasting | Event sourcing |
    | Examples | RabbitMQ, SQS | Redis Pub/Sub, SNS | Kafka, Kinesis |

    ## RabbitMQ Architecture

    **RabbitMQ** is a popular message broker implementing AMQP protocol.

    ### Core Components

    ```
    Producer → Exchange → Queue → Consumer
                  ↓
               Binding
                  ↓
                Queue
    ```

    **Components:**

    1. **Producer**: Sends messages
    2. **Exchange**: Routes messages to queues
    3. **Binding**: Rules connecting exchanges to queues
    4. **Queue**: Stores messages
    5. **Consumer**: Receives messages

    ### Exchange Types

    #### 1. Direct Exchange

    **Routes by exact routing key match**

    ```python
    # Setup
    exchange = channel.declare_exchange('logs', type='direct')
    queue_error = channel.declare_queue('errors')
    queue_info = channel.declare_queue('info')

    # Bindings
    channel.bind(queue='errors', exchange='logs', routing_key='error')
    channel.bind(queue='info', exchange='logs', routing_key='info')

    # Producer
    channel.publish(
        exchange='logs',
        routing_key='error',  # Goes to 'errors' queue
        message='Database connection failed'
    )

    channel.publish(
        exchange='logs',
        routing_key='info',   # Goes to 'info' queue
        message='Server started'
    )
    ```

    **When to use:** Simple routing based on exact match

    #### 2. Fanout Exchange

    **Broadcasts to ALL queues (pub/sub pattern)**

    ```python
    # Setup
    exchange = channel.declare_exchange('orders', type='fanout')

    # Multiple services subscribe
    email_queue = channel.declare_queue('email_service')
    inventory_queue = channel.declare_queue('inventory_service')
    analytics_queue = channel.declare_queue('analytics_service')

    # All queues bound to exchange
    channel.bind(queue='email_service', exchange='orders')
    channel.bind(queue='inventory_service', exchange='orders')
    channel.bind(queue='analytics_service', exchange='orders')

    # Producer
    channel.publish(
        exchange='orders',
        routing_key='',  # Ignored for fanout
        message={'order_id': 123, 'amount': 99.99}
    )
    # All three queues receive the message!
    ```

    **When to use:** Broadcasting to multiple consumers

    #### 3. Topic Exchange

    **Routes by pattern matching**

    ```python
    # Setup
    exchange = channel.declare_exchange('logs', type='topic')

    # Queues with pattern bindings
    channel.bind(queue='critical_logs', exchange='logs',
                 routing_key='*.critical.*')
    channel.bind(queue='user_logs', exchange='logs',
                 routing_key='user.*')
    channel.bind(queue='all_logs', exchange='logs',
                 routing_key='#')

    # Producer
    channel.publish(exchange='logs',
                   routing_key='user.critical.login',
                   message='Failed login attempts')

    # Matches:
    # ✓ critical_logs (*.critical.*)
    # ✓ user_logs (user.*)
    # ✓ all_logs (#)
    ```

    **Wildcards:**
    - `*` matches exactly one word
    - `#` matches zero or more words

    **When to use:** Complex routing logic, hierarchical topics

    #### 4. Headers Exchange

    **Routes by message headers**

    ```python
    # Bind by headers
    channel.bind(
        queue='priority_queue',
        exchange='tasks',
        arguments={'x-match': 'all', 'priority': 'high', 'urgent': True}
    )

    # Message with matching headers goes to priority_queue
    channel.publish(
        exchange='tasks',
        headers={'priority': 'high', 'urgent': True},
        message='Critical task'
    )
    ```

    **When to use:** Routing based on multiple attributes

    ## Complete Producer/Consumer Example

    ### Producer (Python + Pika)

    ```python
    import pika
    import json

    class OrderProducer:
        def __init__(self):
            # Connect to RabbitMQ
            self.connection = pika.BlockingConnection(
                pika.ConnectionParameters('localhost')
            )
            self.channel = self.connection.channel()

            # Declare exchange
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True  # Survives broker restart
            )

        def publish_order(self, order):
            routing_key = f"orders.{order['status']}.{order['country']}"

            message = json.dumps(order)

            self.channel.basic_publish(
                exchange='orders',
                routing_key=routing_key,
                body=message,
                properties=pika.BasicProperties(
                    delivery_mode=2,  # Persistent message
                    content_type='application/json',
                    timestamp=int(time.time())
                )
            )

            print(f"Published order {order['id']} with routing key {routing_key}")

        def close(self):
            self.connection.close()

    # Usage
    producer = OrderProducer()
    producer.publish_order({
        'id': 123,
        'status': 'created',
        'country': 'US',
        'amount': 99.99
    })
    producer.close()
    ```

    ### Consumer (Python + Pika)

    ```python
    import pika
    import json
    import time

    class OrderConsumer:
        def __init__(self, queue_name, routing_keys):
            self.queue_name = queue_name
            self.routing_keys = routing_keys

            # Connect
            self.connection = pika.BlockingConnection(
                pika.ConnectionParameters('localhost')
            )
            self.channel = self.connection.channel()

            # Declare exchange (idempotent)
            self.channel.exchange_declare(
                exchange='orders',
                exchange_type='topic',
                durable=True
            )

            # Declare queue
            self.channel.queue_declare(
                queue=self.queue_name,
                durable=True  # Survives broker restart
            )

            # Bind queue to exchange with routing keys
            for routing_key in self.routing_keys:
                self.channel.queue_bind(
                    queue=self.queue_name,
                    exchange='orders',
                    routing_key=routing_key
                )

            # QoS: Prefetch only 1 message (fair dispatch)
            self.channel.basic_qos(prefetch_count=1)

        def callback(self, ch, method, properties, body):
            try:
                order = json.loads(body)
                print(f"Processing order {order['id']}")

                # Simulate processing
                time.sleep(2)

                # Process order (your business logic)
                self.process_order(order)

                # Acknowledge successful processing
                ch.basic_ack(delivery_tag=method.delivery_tag)
                print(f"Order {order['id']} processed successfully")

            except Exception as e:
                print(f"Error processing order: {e}")
                # Reject and requeue
                ch.basic_nack(
                    delivery_tag=method.delivery_tag,
                    requeue=True
                )

        def process_order(self, order):
            # Your business logic here
            print(f"Sending confirmation email for order {order['id']}")

        def start(self):
            print(f"Waiting for messages in {self.queue_name}")

            self.channel.basic_consume(
                queue=self.queue_name,
                on_message_callback=self.callback,
                auto_ack=False  # Manual acknowledgment
            )

            self.channel.start_consuming()

        def close(self):
            self.connection.close()

    # Usage
    consumer = OrderConsumer(
        queue_name='email_service',
        routing_keys=['orders.created.#', 'orders.updated.#']
    )
    consumer.start()
    ```

    ## Dead Letter Queues (DLQ)

    **Handle messages that fail repeatedly**

    ```python
    # Main queue with DLQ
    channel.queue_declare(
        queue='orders',
        durable=True,
        arguments={
            'x-dead-letter-exchange': 'orders_dlx',
            'x-dead-letter-routing-key': 'failed',
            'x-message-ttl': 60000  # 60s timeout
        }
    )

    # Dead letter queue
    channel.exchange_declare(exchange='orders_dlx', type='direct')
    channel.queue_declare(queue='orders_failed', durable=True)
    channel.queue_bind(
        queue='orders_failed',
        exchange='orders_dlx',
        routing_key='failed'
    )

    # Messages go to DLQ when:
    # 1. Consumer rejects with requeue=False
    # 2. Message TTL expires
    # 3. Queue length limit exceeded
    ```

    **DLQ Consumer:**

    ```python
    def handle_failed_message(ch, method, properties, body):
        order = json.loads(body)

        # Log failure
        logger.error(f"Order {order['id']} failed after retries",
                    extra={'order': order})

        # Send alert
        send_alert(f"Order processing failed: {order['id']}")

        # Store in failure database for manual review
        db.save_failed_order(order)

        ch.basic_ack(delivery_tag=method.delivery_tag)
    ```

    ## Retry Strategies

    ### 1. Exponential Backoff

    ```python
    def process_with_retry(order):
        max_retries = 5
        retry_count = 0

        while retry_count < max_retries:
            try:
                process_order(order)
                return  # Success!
            except Exception as e:
                retry_count += 1

                if retry_count >= max_retries:
                    # Give up, send to DLQ
                    ch.basic_nack(method.delivery_tag, requeue=False)
                    raise

                # Exponential backoff: 1s, 2s, 4s, 8s, 16s
                wait_time = 2 ** retry_count
                print(f"Retry {retry_count}/{max_retries} after {wait_time}s")
                time.sleep(wait_time)
    ```

    ### 2. Delayed Retry Queue

    ```python
    # Setup delayed retry queue
    channel.queue_declare(
        queue='orders_retry',
        arguments={
            'x-dead-letter-exchange': 'orders',
            'x-dead-letter-routing-key': 'retry',
            'x-message-ttl': 5000  # 5 second delay
        }
    )

    # Consumer with retry
    def callback(ch, method, properties, body):
        try:
            process_order(json.loads(body))
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except RetryableError:
            # Send to retry queue
            ch.basic_publish(
                exchange='',
                routing_key='orders_retry',
                body=body
            )
            ch.basic_ack(delivery_tag=method.delivery_tag)
        except FatalError:
            # Don't retry, send to DLQ
            ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)
    ```

    ### 3. Retry with Attempt Tracking

    ```python
    def callback(ch, method, properties, body):
        # Get retry count from headers
        headers = properties.headers or {}
        retry_count = headers.get('x-retry-count', 0)

        try:
            order = json.loads(body)
            process_order(order)
            ch.basic_ack(delivery_tag=method.delivery_tag)

        except Exception as e:
            if retry_count >= 3:
                # Max retries exceeded
                ch.basic_nack(delivery_tag=method.delivery_tag, requeue=False)
                return

            # Increment retry count
            new_headers = headers.copy()
            new_headers['x-retry-count'] = retry_count + 1

            # Republish with updated headers
            ch.basic_publish(
                exchange='orders',
                routing_key=method.routing_key,
                body=body,
                properties=pika.BasicProperties(headers=new_headers)
            )

            ch.basic_ack(delivery_tag=method.delivery_tag)
    ```

    ## Real-World Example: E-commerce Order Processing

    ```python
    # Order creation flow

    # 1. API receives order
    @app.post('/orders')
    def create_order(order_data):
        # Save to database
        order = db.save_order(order_data)

        # Publish to message queue
        producer.publish('orders.created', order)

        return {'order_id': order.id, 'status': 'processing'}

    # 2. Multiple consumers process async

    # Email Service
    def email_consumer():
        while True:
            order = queue.consume('orders.created')
            send_confirmation_email(order)

    # Inventory Service
    def inventory_consumer():
        while True:
            order = queue.consume('orders.created')
            reserve_inventory(order)

    # Payment Service
    def payment_consumer():
        while True:
            order = queue.consume('orders.created')
            charge_payment(order)

            if payment_successful:
                queue.publish('orders.paid', order)

    # Shipping Service
    def shipping_consumer():
        while True:
            order = queue.consume('orders.paid')  # Wait for payment
            create_shipment(order)
    ```

    **Benefits achieved:**
    - Fast API response (50ms vs 3000ms)
    - Each service scales independently
    - Failures don't block other services
    - Easy to add new services (just subscribe)

    **Next**: We'll explore event-driven architectures with Kafka and event sourcing.
  MARKDOWN
  lesson.key_concepts = ['message queues', 'async processing', 'decoupling', 'RabbitMQ', 'exchanges', 'pub/sub', 'dead letter queue', 'retry strategies']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz1 = Quiz.find_or_create_by!(title: "Message Queue Fundamentals Quiz") do |quiz|
  quiz.description = 'Test your understanding of message queues and RabbitMQ'
  quiz.time_limit_minutes = 15
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the main benefit of using message queues for order processing?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Faster response time by processing non-critical tasks asynchronously", correct: true },
      { text: "Direct communication between services", correct: false },
      { text: "Simpler code without any abstractions", correct: false },
      { text: "Eliminates the need for databases", correct: false }
    ]),
    explanation: "Message queues allow you to return immediately to the user while processing non-critical tasks asynchronously, significantly reducing response time.",
    difficulty_level: "easy"
  },
  {
    question_text: "In RabbitMQ, which exchange type broadcasts messages to ALL bound queues?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Fanout", correct: true },
      { text: "Direct", correct: false },
      { text: "Topic", correct: false },
      { text: "Headers", correct: false }
    ]),
    explanation: "Fanout exchanges broadcast messages to all queues bound to them, implementing the pub/sub pattern.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the purpose of a Dead Letter Queue (DLQ)?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "To store messages that fail processing repeatedly for manual review", correct: true },
      { text: "To speed up message processing", correct: false },
      { text: "To duplicate messages for backup", correct: false },
      { text: "To delete old messages automatically", correct: false }
    ]),
    explanation: "DLQs capture messages that fail processing after multiple retries, allowing manual review and preventing infinite retry loops.",
    difficulty_level: "medium"
  },
  {
    question_text: "True or False: In a pub/sub pattern, each message is consumed by only one subscriber.",
    question_type: "true_false",
    points: 5,
    correct_answer: "false",
    explanation: "False. In pub/sub, each message is delivered to ALL subscribers. For one consumer per message, use a queue (point-to-point) pattern.",
    difficulty_level: "easy"
  },
  {
    question_text: "What wildcard character in RabbitMQ topic exchanges matches zero or more words?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "#",
    explanation: "The # wildcard matches zero or more words, while * matches exactly one word. Example: 'orders.#' matches 'orders.created', 'orders.created.us', etc.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz1, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module1, item: quiz1) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module1.title}"

# ==========================================
# MODULE 2: Event-Driven Architecture
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'event-driven-architecture', course: mq_course) do |mod|
  mod.title = 'Event-Driven Architecture'
  mod.description = 'Event sourcing, CQRS, Kafka, event stores, sagas'
  mod.sequence_order = 2
  mod.estimated_minutes = 150
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Design event-driven architectures",
    "Implement event sourcing patterns",
    "Build CQRS systems",
    "Use Kafka for event streaming",
    "Handle eventual consistency with sagas"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Event-Driven Systems") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Event-Driven Systems

    **Event-driven architecture** builds systems that react to events rather than direct calls.

    ## Event Sourcing Pattern

    **Store all changes as a sequence of events**

    ### Traditional CRUD Approach

    ```python
    # Traditional: Store current state only
    class User:
        id: int
        name: str
        email: str
        balance: Decimal

    # Update user
    user = db.get_user(123)
    user.balance = 1000.00  # Lost: What was old balance? When? Why?
    db.save(user)
    ```

    **Problems:**
    - Lost history (what was the balance before?)
    - No audit trail (who changed it? when?)
    - Can't reconstruct past states
    - No reason for changes

    ### Event Sourcing Approach

    **Store events, derive state**

    ```python
    # Events: Immutable log of what happened
    Event 1: UserCreated(user_id=123, name="Alice", email="alice@ex.com")
    Event 2: BalanceIncreased(user_id=123, amount=500, reason="deposit")
    Event 3: BalanceIncreased(user_id=123, amount=500, reason="deposit")
    Event 4: BalanceDecreased(user_id=123, amount=100, reason="purchase")

    # Current state: Replay all events
    def get_user_state(user_id):
        events = event_store.get_events(user_id)

        state = {}
        for event in events:
            state = apply_event(state, event)

        return state

    # Result: {id: 123, name: "Alice", balance: 900}
    ```

    **Benefits:**
    - Complete audit trail
    - Can reconstruct any past state
    - Time travel (what was balance on Jan 1?)
    - Debug issues (replay events to find bug)
    - Build new features on historical data

    ### Event Store Implementation

    ```python
    # Event Store with PostgreSQL
    import json
    from datetime import datetime

    class EventStore:
        def __init__(self, db):
            self.db = db

        def append_event(self, stream_id, event_type, data, metadata=None):
            """Append event to stream (aggregate)"""
            query = """
                INSERT INTO events (stream_id, event_type, data, metadata, version, created_at)
                VALUES (?, ?, ?, ?,
                    (SELECT COALESCE(MAX(version), 0) + 1 FROM events WHERE stream_id = ?),
                    ?)
                RETURNING id, version
            """

            result = self.db.execute(
                query,
                stream_id,
                event_type,
                json.dumps(data),
                json.dumps(metadata or {}),
                stream_id,
                datetime.utcnow()
            )

            return result.fetchone()

        def get_events(self, stream_id, from_version=0):
            """Get all events for an aggregate"""
            query = """
                SELECT id, stream_id, event_type, data, metadata, version, created_at
                FROM events
                WHERE stream_id = ? AND version > ?
                ORDER BY version ASC
            """

            rows = self.db.execute(query, stream_id, from_version).fetchall()

            return [
                {
                    'id': row[0],
                    'stream_id': row[1],
                    'event_type': row[2],
                    'data': json.loads(row[3]),
                    'metadata': json.loads(row[4]),
                    'version': row[5],
                    'created_at': row[6]
                }
                for row in rows
            ]

        def get_all_events(self, from_position=0, limit=100):
            """Get global event stream (for projections)"""
            query = """
                SELECT id, stream_id, event_type, data, metadata, version, created_at
                FROM events
                WHERE id > ?
                ORDER BY id ASC
                LIMIT ?
            """

            rows = self.db.execute(query, from_position, limit).fetchall()
            return [self._row_to_event(row) for row in rows]

    # Event Store Schema
    CREATE TABLE events (
        id BIGSERIAL PRIMARY KEY,
        stream_id VARCHAR(255) NOT NULL,      -- Aggregate ID
        event_type VARCHAR(255) NOT NULL,     -- Event name
        data JSONB NOT NULL,                  -- Event data
        metadata JSONB,                       -- User, timestamp, etc.
        version INTEGER NOT NULL,             -- Version within stream
        created_at TIMESTAMP NOT NULL,

        UNIQUE(stream_id, version)            -- Optimistic concurrency
    );

    CREATE INDEX idx_stream_id ON events(stream_id);
    CREATE INDEX idx_created_at ON events(created_at);
    ```

    ### Bank Account Example

    ```python
    # Domain Events
    class AccountCreated:
        def __init__(self, account_id, owner, initial_balance):
            self.account_id = account_id
            self.owner = owner
            self.initial_balance = initial_balance

    class MoneyDeposited:
        def __init__(self, account_id, amount):
            self.account_id = account_id
            self.amount = amount

    class MoneyWithdrawn:
        def __init__(self, account_id, amount):
            self.account_id = account_id
            self.amount = amount

    # Aggregate: Bank Account
    class BankAccount:
        def __init__(self, account_id):
            self.account_id = account_id
            self.balance = 0
            self.owner = None
            self.version = 0
            self.uncommitted_events = []

        # Command: Create account
        def create(self, owner, initial_balance):
            if self.owner is not None:
                raise ValueError("Account already created")

            event = AccountCreated(self.account_id, owner, initial_balance)
            self._apply_event(event)
            self.uncommitted_events.append(event)

        # Command: Deposit money
        def deposit(self, amount):
            if amount <= 0:
                raise ValueError("Amount must be positive")

            event = MoneyDeposited(self.account_id, amount)
            self._apply_event(event)
            self.uncommitted_events.append(event)

        # Command: Withdraw money
        def withdraw(self, amount):
            if amount <= 0:
                raise ValueError("Amount must be positive")
            if self.balance < amount:
                raise ValueError("Insufficient funds")

            event = MoneyWithdrawn(self.account_id, amount)
            self._apply_event(event)
            self.uncommitted_events.append(event)

        # Apply event to change state
        def _apply_event(self, event):
            if isinstance(event, AccountCreated):
                self.owner = event.owner
                self.balance = event.initial_balance
            elif isinstance(event, MoneyDeposited):
                self.balance += event.amount
            elif isinstance(event, MoneyWithdrawn):
                self.balance -= event.amount

            self.version += 1

        # Reconstitute from events
        @classmethod
        def from_events(cls, account_id, events):
            account = cls(account_id)
            for event in events:
                account._apply_event(event)
            return account

    # Repository
    class BankAccountRepository:
        def __init__(self, event_store):
            self.event_store = event_store

        def get(self, account_id):
            events = self.event_store.get_events(f"account-{account_id}")
            return BankAccount.from_events(account_id, events)

        def save(self, account):
            for event in account.uncommitted_events:
                self.event_store.append_event(
                    stream_id=f"account-{account.account_id}",
                    event_type=event.__class__.__name__,
                    data=event.__dict__
                )
            account.uncommitted_events.clear()

    # Usage
    repo = BankAccountRepository(event_store)

    # Create account
    account = BankAccount(123)
    account.create(owner="Alice", initial_balance=1000)
    repo.save(account)

    # Deposit
    account = repo.get(123)
    account.deposit(500)
    repo.save(account)

    # Withdraw
    account = repo.get(123)
    account.withdraw(200)
    repo.save(account)

    # Check balance
    account = repo.get(123)
    print(account.balance)  # 1300
    ```

    ## CQRS (Command Query Responsibility Segregation)

    **Separate read and write models**

    ### Problem: Single Model

    ```python
    # Same model for reads and writes
    class Order:
        def place_order(self, items):
            # Complex business logic
            self.validate()
            self.calculate_total()
            self.reserve_inventory()
            db.save(self)  # Write

        def get_order_summary(self):
            # Complex joins for display
            return db.query("""
                SELECT o.*, oi.*, p.*
                FROM orders o
                JOIN order_items oi ON ...
                JOIN products p ON ...
            """)  # Read
    ```

    **Problems:**
    - Write model optimized for consistency (normalized)
    - Read model needs performance (denormalized)
    - Can't optimize for both simultaneously

    ### CQRS Solution

    **Separate write model (commands) from read model (queries)**

    ```python
    # Write Model: Optimized for business logic
    class OrderCommandService:
        def place_order(self, user_id, items):
            # Validate
            if not items:
                raise ValueError("No items")

            # Create aggregate
            order = Order.create(user_id, items)

            # Save events
            event_store.append_event(
                f"order-{order.id}",
                "OrderPlaced",
                order.to_dict()
            )

            # Publish event
            event_bus.publish("OrderPlaced", order)

            return order.id

    # Read Model: Optimized for queries
    class OrderQueryService:
        def get_order_summary(self, order_id):
            # Fast lookup in denormalized table
            return db.query(
                "SELECT * FROM order_summaries WHERE id = ?",
                order_id
            )

        def get_user_orders(self, user_id):
            # Optimized for this specific query
            return db.query(
                "SELECT * FROM user_order_view WHERE user_id = ?",
                user_id
            )

    # Projection: Build read model from events
    class OrderProjection:
        def handle_order_placed(self, event):
            order = event.data

            # Update denormalized read model
            db.execute("""
                INSERT INTO order_summaries
                (id, user_id, items, total, status)
                VALUES (?, ?, ?, ?, ?)
            """, order['id'], order['user_id'],
                 json.dumps(order['items']),
                 order['total'], 'placed')

        def handle_order_shipped(self, event):
            db.execute("""
                UPDATE order_summaries
                SET status = 'shipped', shipped_at = ?
                WHERE id = ?
            """, event.data['shipped_at'], event.data['order_id'])
    ```

    **Benefits:**
    - Write model: Normalized, consistent, optimized for business logic
    - Read model: Denormalized, fast, optimized for queries
    - Scale reads and writes independently
    - Multiple read models for different use cases

    ## Kafka for Event Streaming

    **Apache Kafka** is a distributed event streaming platform.

    ### Kafka Architecture

    ```
    Producer → Topic (Partitions) → Consumer Group
                 ├─ Partition 0 → Consumer 1
                 ├─ Partition 1 → Consumer 2
                 └─ Partition 2 → Consumer 3
    ```

    **Components:**
    - **Topic**: Category of events (e.g., "orders")
    - **Partition**: Ordered log within topic (for parallelism)
    - **Producer**: Publishes events
    - **Consumer Group**: Consumers working together
    - **Offset**: Position in partition (consumer tracks it)

    ### Kafka Producer (Python)

    ```python
    from kafka import KafkaProducer
    import json

    class OrderEventProducer:
        def __init__(self):
            self.producer = KafkaProducer(
                bootstrap_servers=['localhost:9092'],
                value_serializer=lambda v: json.dumps(v).encode('utf-8'),
                key_serializer=lambda k: k.encode('utf-8'),
                acks='all',  # Wait for all replicas
                retries=3
            )

        def publish_order_created(self, order):
            event = {
                'event_type': 'OrderCreated',
                'order_id': order['id'],
                'user_id': order['user_id'],
                'items': order['items'],
                'total': order['total'],
                'timestamp': time.time()
            }

            # Partition by order_id (all events for same order go to same partition)
            self.producer.send(
                topic='orders',
                key=str(order['id']),  # Partition key
                value=event
            )

            # Flush to ensure delivery
            self.producer.flush()

    # Usage
    producer = OrderEventProducer()
    producer.publish_order_created({
        'id': 123,
        'user_id': 456,
        'items': [{'product': 'laptop', 'quantity': 1}],
        'total': 999.99
    })
    ```

    ### Kafka Consumer (Python)

    ```python
    from kafka import KafkaConsumer

    class OrderEventConsumer:
        def __init__(self, group_id):
            self.consumer = KafkaConsumer(
                'orders',  # Topic
                bootstrap_servers=['localhost:9092'],
                group_id=group_id,  # Consumer group
                auto_offset_reset='earliest',  # Start from beginning
                enable_auto_commit=False,  # Manual commit
                value_deserializer=lambda m: json.loads(m.decode('utf-8'))
            )

        def start(self):
            print("Consuming events...")

            for message in self.consumer:
                try:
                    event = message.value

                    print(f"Received: {event['event_type']} for order {event['order_id']}")

                    # Process event
                    self.process_event(event)

                    # Commit offset
                    self.consumer.commit()

                except Exception as e:
                    print(f"Error processing event: {e}")
                    # Don't commit - will retry

        def process_event(self, event):
            if event['event_type'] == 'OrderCreated':
                self.handle_order_created(event)
            elif event['event_type'] == 'OrderShipped':
                self.handle_order_shipped(event)

        def handle_order_created(self, event):
            print(f"Sending confirmation email for order {event['order_id']}")
            # Your business logic

        def handle_order_shipped(self, event):
            print(f"Sending shipping notification for order {event['order_id']}")

    # Usage
    consumer = OrderEventConsumer(group_id='email-service')
    consumer.start()
    ```

    ## Eventual Consistency

    **Data becomes consistent over time, not immediately**

    ### Example: Social Media Feed

    ```python
    # User posts update
    def post_update(user_id, content):
        # 1. Save to database
        post = db.create_post(user_id, content)

        # 2. Publish event
        kafka.publish('posts.created', {
            'post_id': post.id,
            'user_id': user_id,
            'content': content
        })

        return post  # Returns immediately!

    # Background: Fan out to followers
    def handle_post_created(event):
        user_id = event['user_id']
        post_id = event['post_id']

        # Get followers (100,000 followers)
        followers = db.get_followers(user_id)

        # Add to each follower's feed
        for follower in followers:
            cache.add_to_feed(follower.id, post_id)

        # Takes 10 seconds for 100k followers
        # But user got immediate response!

    # Different users see post at different times
    # Follower A: Sees post immediately (processed first)
    # Follower B: Sees post after 5 seconds
    # Follower C: Sees post after 10 seconds
    # Eventually: All followers see the post ✓
    ```

    **Trade-offs:**
    - ✅ Better performance (no waiting)
    - ✅ Better availability (no blocking)
    - ❌ Temporary inconsistency

    ## Saga Pattern

    **Manage distributed transactions across services**

    ### Problem: Distributed Transactions

    ```python
    # Can't use single database transaction
    def book_trip(user_id, flight, hotel):
        # Different services, different databases
        flight_booking = flight_service.book(flight)  # Service 1
        hotel_booking = hotel_service.book(hotel)     # Service 2
        payment = payment_service.charge(user_id)     # Service 3

        # What if payment fails? Need to undo flight and hotel!
    ```

    ### Saga Solution: Choreography

    **Services react to events, handle compensation**

    ```python
    # Service 1: Flight Service
    def handle_trip_requested(event):
        try:
            booking = book_flight(event['flight'])
            kafka.publish('flight.booked', {
                'trip_id': event['trip_id'],
                'booking_id': booking.id
            })
        except Exception:
            kafka.publish('flight.booking.failed', {
                'trip_id': event['trip_id']
            })

    # Service 2: Hotel Service
    def handle_flight_booked(event):
        try:
            booking = book_hotel(event['hotel'])
            kafka.publish('hotel.booked', {
                'trip_id': event['trip_id'],
                'booking_id': booking.id
            })
        except Exception:
            # Compensate: Cancel flight
            kafka.publish('flight.cancel', {
                'trip_id': event['trip_id']
            })
            kafka.publish('hotel.booking.failed', {
                'trip_id': event['trip_id']
            })

    # Service 3: Payment Service
    def handle_hotel_booked(event):
        try:
            charge_payment(event['trip_id'])
            kafka.publish('payment.completed', {
                'trip_id': event['trip_id']
            })
        except Exception:
            # Compensate: Cancel flight and hotel
            kafka.publish('flight.cancel', {'trip_id': event['trip_id']})
            kafka.publish('hotel.cancel', {'trip_id': event['trip_id']})
            kafka.publish('payment.failed', {'trip_id': event['trip_id']})

    # Compensating actions
    def handle_flight_cancel(event):
        cancel_flight_booking(event['trip_id'])
        refund_customer(event['trip_id'], 'flight')
    ```

    ### Saga Solution: Orchestration

    **Central coordinator manages saga**

    ```python
    class TripBookingSaga:
        def __init__(self, trip_id):
            self.trip_id = trip_id
            self.state = 'started'
            self.compensations = []

        def execute(self, trip_data):
            try:
                # Step 1: Book flight
                flight = self.book_flight(trip_data['flight'])
                self.compensations.append(lambda: self.cancel_flight(flight))

                # Step 2: Book hotel
                hotel = self.book_hotel(trip_data['hotel'])
                self.compensations.append(lambda: self.cancel_hotel(hotel))

                # Step 3: Charge payment
                payment = self.charge_payment(trip_data['amount'])
                self.compensations.append(lambda: self.refund_payment(payment))

                self.state = 'completed'
                return {'status': 'success', 'trip_id': self.trip_id}

            except Exception as e:
                # Rollback: Execute compensations in reverse
                self.compensate()
                self.state = 'failed'
                return {'status': 'failed', 'error': str(e)}

        def compensate(self):
            for compensation in reversed(self.compensations):
                try:
                    compensation()
                except Exception as e:
                    # Log compensation failure
                    logger.error(f"Compensation failed: {e}")

    # Usage
    saga = TripBookingSaga(trip_id=123)
    result = saga.execute({
        'flight': {'from': 'NYC', 'to': 'LAX'},
        'hotel': {'name': 'Grand Hotel', 'nights': 3},
        'amount': 500.00
    })
    ```

    **Comparison:**

    | Pattern | Pros | Cons |
    |---------|------|------|
    | Choreography | Loose coupling, no single point of failure | Hard to track saga state |
    | Orchestration | Clear flow, easy to track | Central coordinator is single point of failure |

    ## Real-World Example: E-Commerce

    ```python
    # Event-driven order processing

    # 1. Order Service: Create order
    def create_order(user_id, items):
        order_id = generate_id()

        event_store.append({
            'type': 'OrderCreated',
            'order_id': order_id,
            'user_id': user_id,
            'items': items
        })

        kafka.publish('orders', {'type': 'OrderCreated', ...})
        return order_id

    # 2. Inventory Service: Reserve stock
    def handle_order_created(event):
        for item in event['items']:
            reserve_item(item['product_id'], item['quantity'])

        kafka.publish('orders', {'type': 'InventoryReserved', ...})

    # 3. Payment Service: Charge customer
    def handle_inventory_reserved(event):
        charge_customer(event['user_id'], event['total'])
        kafka.publish('orders', {'type': 'PaymentCompleted', ...})

    # 4. Shipping Service: Create shipment
    def handle_payment_completed(event):
        create_shipment(event['order_id'])
        kafka.publish('orders', {'type': 'OrderShipped', ...})

    # 5. Read Model: Build order summary
    class OrderSummaryProjection:
        def handle_event(self, event):
            if event['type'] == 'OrderCreated':
                db.insert_order_summary(event['order_id'], status='created')
            elif event['type'] == 'InventoryReserved':
                db.update_order_summary(event['order_id'], status='reserved')
            elif event['type'] == 'PaymentCompleted':
                db.update_order_summary(event['order_id'], status='paid')
            elif event['type'] == 'OrderShipped':
                db.update_order_summary(event['order_id'], status='shipped')
    ```

    **Next**: We'll explore production patterns for message queues including idempotency and monitoring.
  MARKDOWN
  lesson.key_concepts = ['event sourcing', 'CQRS', 'Kafka', 'event store', 'eventual consistency', 'saga pattern', 'event-driven architecture']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz2 = Quiz.find_or_create_by!(title: "Event-Driven Architecture Quiz") do |quiz|
  quiz.description = 'Test your understanding of event sourcing, CQRS, and Kafka'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "What is the main advantage of event sourcing over traditional CRUD?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Complete audit trail and ability to reconstruct past states", correct: true },
      { text: "Faster query performance", correct: false },
      { text: "Simpler implementation", correct: false },
      { text: "Less storage required", correct: false }
    ]),
    explanation: "Event sourcing stores all changes as events, providing complete history and the ability to replay events to reconstruct any past state.",
    difficulty_level: "medium"
  },
  {
    question_text: "In CQRS, why do we separate read and write models?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "To optimize each model independently for their specific requirements", correct: true },
      { text: "To make the code more complex", correct: false },
      { text: "To use more databases", correct: false },
      { text: "To slow down the application", correct: false }
    ]),
    explanation: "CQRS separates read and write models so each can be optimized independently - writes for consistency, reads for performance.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the purpose of the Saga pattern in distributed systems?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "To manage distributed transactions with compensating actions", correct: true },
      { text: "To speed up database queries", correct: false },
      { text: "To cache data across services", correct: false },
      { text: "To encrypt messages", correct: false }
    ]),
    explanation: "Sagas manage distributed transactions by breaking them into steps with compensating actions that can undo previous steps if something fails.",
    difficulty_level: "hard"
  },
  {
    question_text: "True or False: In Kafka, events in the same partition are guaranteed to be ordered.",
    question_type: "true_false",
    points: 10,
    correct_answer: "true",
    explanation: "True. Kafka guarantees ordering within a partition. Messages with the same partition key go to the same partition and are processed in order.",
    difficulty_level: "easy"
  },
  {
    question_text: "What does CQRS stand for?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "Command Query Responsibility Segregation",
    explanation: "CQRS (Command Query Responsibility Segregation) is a pattern that separates read operations (queries) from write operations (commands).",
    difficulty_level: "easy"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz2, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module2, item: quiz2) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module2.title}"

# ==========================================
# MODULE 3: Production Patterns
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'production-patterns', course: mq_course) do |mod|
  mod.title = 'Production Patterns'
  mod.description = 'Idempotency, ordering, monitoring, error handling, scaling'
  mod.sequence_order = 3
  mod.estimated_minutes = 130
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement idempotent message handlers",
    "Handle message ordering guarantees",
    "Monitor and observe message queues",
    "Design error handling with circuit breakers",
    "Scale message queue systems",
    "Avoid common pitfalls"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Message Queues in Production") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Message Queues in Production

    Building production-ready message queue systems requires handling edge cases, monitoring, and robust error handling.

    ## Idempotency and Deduplication

    **Idempotency**: Processing a message multiple times has the same effect as processing it once.

    ### Why Idempotency Matters

    ```python
    # Problem: Message delivered twice
    def handle_order_payment(order_id, amount):
        charge_credit_card(order_id, amount)  # DANGER!
        # If message processed twice → Customer charged twice! ❌

    # Same message delivered twice:
    Message 1: Charge $100
    Message 2: Charge $100 (duplicate)
    Result: Customer charged $200 ❌
    ```

    **Causes of duplicates:**
    - Network failures (producer retries)
    - Consumer crashes after processing but before ACK
    - Queue redelivers message

    ### Solution 1: Idempotent Operations

    **Make operations naturally idempotent**

    ```python
    # Idempotent: Set operations
    def handle_order_status(order_id, status):
        db.execute(
            "UPDATE orders SET status = ? WHERE id = ?",
            status, order_id
        )
        # Setting status='shipped' multiple times → Same result ✓

    # Idempotent: Upsert
    def handle_user_update(user_id, data):
        db.execute("""
            INSERT INTO users (id, name, email)
            VALUES (?, ?, ?)
            ON CONFLICT (id) DO UPDATE
            SET name = EXCLUDED.name, email = EXCLUDED.email
        """, user_id, data['name'], data['email'])
        # Duplicate messages → Same final state ✓
    ```

    ### Solution 2: Deduplication with Message ID

    **Track processed message IDs**

    ```python
    # Schema for tracking processed messages
    CREATE TABLE processed_messages (
        message_id VARCHAR(255) PRIMARY KEY,
        processed_at TIMESTAMP NOT NULL,
        INDEX idx_processed_at (processed_at)
    );

    # Clean up old entries (keep 7 days)
    DELETE FROM processed_messages
    WHERE processed_at < NOW() - INTERVAL '7 days';

    # Idempotent handler
    def handle_payment(message):
        message_id = message['id']

        # Check if already processed
        if db.exists("SELECT 1 FROM processed_messages WHERE message_id = ?", message_id):
            print(f"Message {message_id} already processed, skipping")
            return  # Skip duplicate ✓

        # Process message
        try:
            # Use transaction for atomicity
            with db.transaction():
                # 1. Record message as processed
                db.execute(
                    "INSERT INTO processed_messages (message_id, processed_at) VALUES (?, ?)",
                    message_id, datetime.now()
                )

                # 2. Perform business logic
                charge_credit_card(message['order_id'], message['amount'])

                # Both succeed or both fail (atomic)
        except Exception as e:
            # Transaction rolled back
            raise
    ```

    ### Solution 3: Idempotency Key

    **Let client provide idempotency key**

    ```python
    # Client generates idempotency key
    import uuid

    idempotency_key = str(uuid.uuid4())

    response = requests.post('/api/orders', json={
        'items': [...],
        'idempotency_key': idempotency_key
    })

    # If request fails, retry with SAME key
    if response.status_code >= 500:
        # Retry with same idempotency key
        response = requests.post('/api/orders', json={
            'items': [...],
            'idempotency_key': idempotency_key  # Same key!
        })

    # Server-side
    def create_order(request):
        idempotency_key = request['idempotency_key']

        # Check if already processed
        existing = db.query(
            "SELECT * FROM orders WHERE idempotency_key = ?",
            idempotency_key
        )

        if existing:
            # Return existing result
            return existing

        # Create new order
        order = Order.create(request['items'])
        order.idempotency_key = idempotency_key
        db.save(order)

        return order
    ```

    ## Message Ordering

    **Guarantee messages processed in order**

    ### Problem: Out-of-Order Processing

    ```python
    # Events arrive in order:
    Event 1: AccountCreated(id=123, balance=0)
    Event 2: MoneyDeposited(id=123, amount=100)
    Event 3: MoneyWithdrawn(id=123, amount=50)

    # Multiple consumers process in parallel:
    Consumer A: Processes Event 2 → Error! Account doesn't exist yet ❌
    Consumer B: Processes Event 1 → Creates account ✓
    Consumer C: Processes Event 3 → Error! Insufficient funds ❌
    ```

    ### Solution 1: Partition by Key (Kafka)

    **Messages with same key go to same partition → Ordered**

    ```python
    # Producer: Use account_id as key
    producer.send(
        topic='accounts',
        key=str(account_id),  # Partition key
        value=event
    )

    # Kafka guarantees:
    # - All messages with key=123 go to same partition
    # - Single partition → Ordered processing ✓
    # - Single consumer per partition → No race conditions ✓

    # Consumer
    consumer = KafkaConsumer(
        'accounts',
        group_id='account-service',
        max_poll_records=1  # Process one message at a time
    )

    for message in consumer:
        process_event(message.value)  # Ordered! ✓
    ```

    ### Solution 2: Sequence Numbers

    **Track sequence, detect gaps**

    ```python
    # Add sequence number to messages
    class EventProducer:
        def __init__(self):
            self.sequences = {}  # {aggregate_id: sequence}

        def publish(self, aggregate_id, event):
            # Get next sequence for this aggregate
            seq = self.sequences.get(aggregate_id, 0) + 1
            self.sequences[aggregate_id] = seq

            event['sequence'] = seq
            event['aggregate_id'] = aggregate_id

            kafka.send('events', event)

    # Consumer with sequence tracking
    class EventConsumer:
        def __init__(self):
            self.next_expected = {}  # {aggregate_id: next_seq}
            self.buffer = {}  # {aggregate_id: [events]}

        def process(self, event):
            aggregate_id = event['aggregate_id']
            sequence = event['sequence']

            expected = self.next_expected.get(aggregate_id, 1)

            if sequence == expected:
                # Process this event
                self.handle_event(event)
                self.next_expected[aggregate_id] = sequence + 1

                # Process buffered events
                self._process_buffer(aggregate_id)

            elif sequence > expected:
                # Gap detected! Buffer this event
                if aggregate_id not in self.buffer:
                    self.buffer[aggregate_id] = []
                self.buffer[aggregate_id].append(event)

                print(f"Gap detected: expected {expected}, got {sequence}")

            else:
                # Duplicate (sequence < expected)
                print(f"Duplicate: {sequence} already processed")

        def _process_buffer(self, aggregate_id):
            if aggregate_id not in self.buffer:
                return

            # Sort buffered events by sequence
            self.buffer[aggregate_id].sort(key=lambda e: e['sequence'])

            # Process consecutive events
            expected = self.next_expected[aggregate_id]
            for event in self.buffer[aggregate_id][:]:
                if event['sequence'] == expected:
                    self.handle_event(event)
                    self.next_expected[aggregate_id] = expected + 1
                    expected += 1
                    self.buffer[aggregate_id].remove(event)
                else:
                    break
    ```

    ### Solution 3: Single-Threaded Consumer per Aggregate

    **Ensure one consumer per aggregate ID**

    ```python
    # RabbitMQ with consistent hashing
    def get_queue_for_aggregate(aggregate_id, num_queues=10):
        # Hash aggregate_id to queue number
        queue_num = hash(aggregate_id) % num_queues
        return f"accounts_queue_{queue_num}"

    # Producer
    def publish_event(aggregate_id, event):
        queue = get_queue_for_aggregate(aggregate_id)
        channel.basic_publish(
            exchange='',
            routing_key=queue,
            body=json.dumps(event)
        )

    # Multiple consumers, each handling different queues
    # Consumer 1: accounts_queue_0
    # Consumer 2: accounts_queue_1
    # ...
    # Consumer 10: accounts_queue_9

    # Same aggregate_id always goes to same queue → Same consumer → Ordered! ✓
    ```

    ## Monitoring and Observability

    **Track message queue health and performance**

    ### Key Metrics

    ```python
    # 1. Queue Depth (Messages Waiting)
    queue_depth = rabbitmq.get_queue_depth('orders')

    # Alert if queue backs up
    if queue_depth > 10000:
        alert("Queue depth too high: consumers can't keep up")

    # 2. Processing Rate
    messages_per_second = processed_count / time_window

    # 3. Consumer Lag (Kafka)
    consumer_lag = latest_offset - current_offset

    if consumer_lag > 100000:
        alert("Consumer lag too high: falling behind")

    # 4. Processing Time
    start = time.time()
    process_message(message)
    duration = time.time() - start

    metrics.histogram('message.processing_time', duration)

    # 5. Error Rate
    error_rate = errors / total_messages

    if error_rate > 0.01:  # 1%
        alert("High error rate")

    # 6. Dead Letter Queue Size
    dlq_size = rabbitmq.get_queue_depth('orders_dlq')

    if dlq_size > 100:
        alert("Many messages failing")
    ```

    ### Prometheus Metrics

    ```python
    from prometheus_client import Counter, Histogram, Gauge

    # Define metrics
    messages_processed = Counter(
        'messages_processed_total',
        'Total messages processed',
        ['queue', 'status']
    )

    processing_duration = Histogram(
        'message_processing_duration_seconds',
        'Time to process message',
        ['queue']
    )

    queue_depth = Gauge(
        'queue_depth',
        'Current queue depth',
        ['queue']
    )

    # Instrument consumer
    def process_message(message):
        start = time.time()

        try:
            # Business logic
            handle_order(message)

            # Record success
            messages_processed.labels(queue='orders', status='success').inc()

        except Exception as e:
            # Record failure
            messages_processed.labels(queue='orders', status='error').inc()
            raise

        finally:
            # Record duration
            duration = time.time() - start
            processing_duration.labels(queue='orders').observe(duration)

    # Background: Update queue depth
    def update_queue_metrics():
        while True:
            depth = rabbitmq.get_queue_depth('orders')
            queue_depth.labels(queue='orders').set(depth)
            time.sleep(10)
    ```

    ### Distributed Tracing

    ```python
    from opentelemetry import trace
    from opentelemetry.propagate import extract

    tracer = trace.get_tracer(__name__)

    # Producer: Inject trace context
    def publish_order(order):
        with tracer.start_as_current_span('publish_order') as span:
            span.set_attribute('order_id', order['id'])

            # Inject trace context into message
            ctx = {}
            inject(ctx)

            message = {
                'data': order,
                'trace_context': ctx  # Propagate trace
            }

            kafka.send('orders', message)

    # Consumer: Extract trace context
    def handle_order(message):
        # Extract trace context
        ctx = extract(message['trace_context'])

        with tracer.start_as_current_span('handle_order', context=ctx) as span:
            span.set_attribute('order_id', message['data']['id'])

            # Process order
            process_order(message['data'])

        # Now entire flow traced across services! ✓
    ```

    ## Error Handling and Circuit Breakers

    ### Circuit Breaker Pattern

    **Stop calling failing service**

    ```python
    class CircuitBreaker:
        def __init__(self, failure_threshold=5, timeout=60):
            self.failure_threshold = failure_threshold
            self.timeout = timeout
            self.failures = 0
            self.last_failure_time = None
            self.state = 'closed'  # closed, open, half_open

        def call(self, func, *args, **kwargs):
            if self.state == 'open':
                if time.time() - self.last_failure_time > self.timeout:
                    # Try again (half-open)
                    self.state = 'half_open'
                else:
                    # Still open, fail fast
                    raise Exception("Circuit breaker open")

            try:
                result = func(*args, **kwargs)

                # Success - reset
                if self.state == 'half_open':
                    self.state = 'closed'
                    self.failures = 0

                return result

            except Exception as e:
                self.failures += 1
                self.last_failure_time = time.time()

                if self.failures >= self.failure_threshold:
                    self.state = 'open'
                    print(f"Circuit breaker opened after {self.failures} failures")

                raise

    # Usage in message handler
    email_circuit_breaker = CircuitBreaker(failure_threshold=5, timeout=60)

    def handle_order(message):
        try:
            # Try to send email
            email_circuit_breaker.call(send_email, message['email'], message['order'])
        except Exception as e:
            # Circuit breaker open or email failed
            print(f"Email failed: {e}")

            # Store for retry later
            db.save_failed_email(message)

            # Don't fail entire message processing
            # Continue with other logic

        # Update inventory (critical - must succeed)
        update_inventory(message['items'])
    ```

    ### Bulkhead Pattern

    **Isolate resources to prevent cascading failures**

    ```python
    import concurrent.futures

    # Separate thread pools for different operations
    email_pool = concurrent.futures.ThreadPoolExecutor(max_workers=5)
    inventory_pool = concurrent.futures.ThreadPoolExecutor(max_workers=20)
    analytics_pool = concurrent.futures.ThreadPoolExecutor(max_workers=2)

    def handle_order(message):
        # Non-critical: Email (limited pool)
        email_future = email_pool.submit(send_email, message)

        # Critical: Inventory (larger pool)
        inventory_future = inventory_pool.submit(update_inventory, message)

        # Non-critical: Analytics (small pool)
        analytics_future = analytics_pool.submit(track_analytics, message)

        # Wait for critical operations
        inventory_future.result()  # Must succeed

        # Best effort for non-critical
        try:
            email_future.result(timeout=5)
        except Exception:
            pass  # Don't fail if email fails
    ```

    ## Scaling Strategies

    ### Horizontal Scaling

    **Add more consumers**

    ```python
    # Scale consumers based on queue depth

    # Kubernetes HPA (Horizontal Pod Autoscaler)
    apiVersion: autoscaling/v2
    kind: HorizontalPodAutoscaler
    metadata:
      name: order-consumer
    spec:
      scaleTargetRef:
        apiVersion: apps/v1
        kind: Deployment
        name: order-consumer
      minReplicas: 2
      maxReplicas: 50
      metrics:
      - type: External
        external:
          metric:
            name: rabbitmq_queue_messages_ready
            selector:
              matchLabels:
                queue: orders
          target:
            type: AverageValue
            averageValue: "100"  # Scale if >100 msgs per pod
    ```

    ### Partitioning

    **Distribute load across partitions**

    ```python
    # Kafka: More partitions = more parallelism

    # Create topic with 30 partitions
    kafka.create_topic('orders', num_partitions=30, replication_factor=3)

    # Deploy 30 consumers in same group
    # Each consumer gets 1 partition
    # 30x parallelism! ✓

    # Scale up: Add more partitions + consumers
    kafka.alter_topic('orders', num_partitions=60)
    # Deploy 60 consumers → 60x parallelism
    ```

    ### Batch Processing

    **Process multiple messages together**

    ```python
    # Process in batches for efficiency
    def batch_consumer():
        batch = []
        batch_size = 100

        for message in consumer:
            batch.append(message)

            if len(batch) >= batch_size:
                process_batch(batch)
                batch = []

    def process_batch(messages):
        # Extract data
        orders = [msg['data'] for msg in messages]

        # Bulk database insert
        db.bulk_insert('orders', orders)

        # Bulk commit offsets
        consumer.commit()

        # 100x fewer DB calls! ✓
    ```

    ## Common Pitfalls

    ### 1. Poison Messages

    **Message that always fails**

    ```python
    # Problem: Poison message blocks queue
    def handle_message(message):
        data = json.loads(message)  # Parse error!
        # Message redelivered infinitely ❌

    # Solution: Dead letter queue with retry limit
    def handle_message(message):
        retry_count = message.get('retry_count', 0)

        try:
            data = json.loads(message)
            process(data)
        except Exception as e:
            if retry_count >= 3:
                # Send to DLQ
                dlq.send(message)
                ack(message)
            else:
                # Retry
                message['retry_count'] = retry_count + 1
                nack(message)
    ```

    ### 2. Large Messages

    **Messages too big for queue**

    ```python
    # Problem: Send 10MB image in message
    kafka.send('images', {
        'image_data': base64.encode(large_image)  # Too big! ❌
    })

    # Solution: Send reference, not data
    # 1. Upload to S3
    s3_url = s3.upload(large_image)

    # 2. Send reference
    kafka.send('images', {
        'image_url': s3_url,  # Small message ✓
        'size': len(large_image)
    })

    # 3. Consumer downloads from S3
    def handle_image(message):
        image = s3.download(message['image_url'])
        process_image(image)
    ```

    ### 3. Message Loss

    **Producer doesn't wait for confirmation**

    ```python
    # Problem: Fire and forget
    kafka.send('orders', order)  # Not confirmed! ❌

    # Solution: Wait for ack
    future = kafka.send('orders', order)
    future.get(timeout=10)  # Wait for confirmation ✓

    # Solution: Transactions
    producer.begin_transaction()
    try:
        producer.send('orders', order1)
        producer.send('orders', order2)
        producer.commit_transaction()  # Atomic ✓
    except Exception:
        producer.abort_transaction()
    ```

    ### 4. Consumer Too Slow

    **Processing takes too long**

    ```python
    # Problem: Slow processing blocks queue
    def handle_message(message):
        time.sleep(60)  # 60 seconds! ❌
        # Other messages wait

    # Solution: Async processing
    executor = ThreadPoolExecutor(max_workers=20)

    def handle_message(message):
        # Process in thread pool
        executor.submit(process_message, message)
        # Immediately ready for next message ✓

    def process_message(message):
        time.sleep(60)  # OK in background
        # Other messages processed in parallel
    ```

    ## Production Checklist

    ✅ **Idempotency**: Can handle duplicate messages
    ✅ **Ordering**: Messages processed in correct order (if needed)
    ✅ **Error Handling**: Retry logic, DLQ, circuit breakers
    ✅ **Monitoring**: Metrics, alerts, tracing
    ✅ **Scaling**: Auto-scaling based on queue depth
    ✅ **Persistence**: Messages survive broker restart
    ✅ **Security**: Authentication, encryption, ACLs
    ✅ **Testing**: Test with failures, duplicates, out-of-order
    ✅ **Documentation**: Runbooks for common issues

    **Congratulations!** You now understand how to build production-ready message queue systems.
  MARKDOWN
  lesson.key_concepts = ['idempotency', 'deduplication', 'message ordering', 'circuit breaker', 'monitoring', 'observability', 'scaling', 'error handling']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

quiz3 = Quiz.find_or_create_by!(title: "Production Patterns Quiz") do |quiz|
  quiz.description = 'Test your understanding of production-ready messaging patterns'
  quiz.time_limit_minutes = 20
  quiz.passing_score = 70
  quiz.max_attempts = 3
end

[
  {
    question_text: "Why is idempotency important in message processing?",
    question_type: "mcq",
    points: 10,
    options: JSON.generate([
      { text: "Messages can be delivered multiple times, so processing must be safe to repeat", correct: true },
      { text: "To make messages process faster", correct: false },
      { text: "To reduce memory usage", correct: false },
      { text: "To encrypt messages", correct: false }
    ]),
    explanation: "Idempotency ensures that processing a message multiple times has the same effect as processing it once, which is critical since queues can deliver duplicates.",
    difficulty_level: "medium"
  },
  {
    question_text: "How does Kafka guarantee message ordering?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "Messages with the same partition key go to the same partition which maintains order", correct: true },
      { text: "All messages are globally ordered", correct: false },
      { text: "Ordering is not guaranteed in Kafka", correct: false },
      { text: "Using timestamps", correct: false }
    ]),
    explanation: "Kafka guarantees ordering within a partition. Messages with the same key are sent to the same partition, ensuring ordered processing.",
    difficulty_level: "medium"
  },
  {
    question_text: "What is the purpose of a circuit breaker in message processing?",
    question_type: "mcq",
    points: 15,
    options: JSON.generate([
      { text: "To stop calling a failing service and fail fast instead of wasting resources", correct: true },
      { text: "To route messages to different queues", correct: false },
      { text: "To compress messages", correct: false },
      { text: "To delete old messages", correct: false }
    ]),
    explanation: "Circuit breakers detect failing services and stop calling them temporarily, preventing resource waste and cascading failures.",
    difficulty_level: "hard"
  },
  {
    question_text: "True or False: Large data payloads should be sent directly in message queue messages.",
    question_type: "true_false",
    points: 5,
    correct_answer: "false",
    explanation: "False. Large payloads should be stored externally (e.g., S3) and only a reference should be sent in the message to avoid overwhelming the queue.",
    difficulty_level: "easy"
  },
  {
    question_text: "What metric indicates that consumers cannot keep up with the message rate?",
    question_type: "fill_blank",
    points: 10,
    correct_answer: "queue depth|consumer lag|lag",
    explanation: "Queue depth (or consumer lag in Kafka) indicates how many messages are waiting to be processed. High values mean consumers can't keep up with producers.",
    difficulty_level: "medium"
  }
].each_with_index do |q_data, index|
  QuizQuestion.find_or_create_by!(quiz: quiz3, sequence_order: index + 1) do |question|
    question.question_text = q_data[:question_text]
    question.question_type = q_data[:question_type]
    question.points = q_data[:points]
    question.options = q_data[:options] if q_data[:options]
    question.correct_answer = q_data[:correct_answer] if q_data[:correct_answer]
    question.explanation = q_data[:explanation]
    question.difficulty_level = q_data[:difficulty_level]
  end
end

ModuleItem.find_or_create_by!(course_module: module3, item: quiz3) do |item|
  item.sequence_order = 2
  item.required = true
end

puts "  ✅ Created module: #{module3.title}"

puts "\n✅ Message Queues & Event-Driven Architecture Course Created!"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
puts "📚 Course: #{mq_course.title}"
puts "📖 Modules: #{mq_course.course_modules.count}"
puts "📝 Lessons: Comprehensive content with RabbitMQ, Kafka, and production patterns"
puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
