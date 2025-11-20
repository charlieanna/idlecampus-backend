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
    "Understand message queue concepts",
    "Implement publish/subscribe patterns",
    "Use RabbitMQ for messaging",
    "Build event-driven systems with Kafka",
    "Handle message ordering and delivery guarantees",
    "Design microservices communication"
  ])
end

CourseModule.find_or_create_by!(slug: 'messaging-fundamentals', course: mq_course) do |mod|
  mod.title = 'Messaging Fundamentals'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
end

CourseModule.find_or_create_by!(slug: 'rabbitmq', course: mq_course) do |mod|
  mod.title = 'RabbitMQ Messaging'
  mod.sequence_order = 2
  mod.estimated_minutes = 130
  mod.published = true
end

CourseModule.find_or_create_by!(slug: 'apache-kafka', course: mq_course) do |mod|
  mod.title = 'Apache Kafka'
  mod.sequence_order = 3
  mod.estimated_minutes = 150
  mod.published = true
end

puts "  ✅ Created Message Queues course\n"
puts "Created course: #{mq_course.title}"
