# Assign all InteractiveLearningUnit lessons to appropriate CourseModule records
# This creates a structured learning path with 7 logical modules

puts "🔧 Assigning lessons to modules..."

# Find or update modules (using existing module records 780-786 + 791)
modules = {
  container_basics: CourseModule.find_or_create_by!(id: 791) do |m|
    m.title = "Module 1: Container Basics"
    m.description = "Master the fundamentals of running, managing, and inspecting Docker containers"
    m.sequence_order = 1
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  building_images: CourseModule.find_or_create_by!(id: 781) do |m|
    m.title = "Module 2: Building Images"
    m.description = "Learn to build custom Docker images for your applications"
    m.sequence_order = 2
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  networking: CourseModule.find_or_create_by!(id: 782) do |m|
    m.title = "Module 3: Networking"
    m.description = "Connect containers and services with Docker networking"
    m.sequence_order = 3
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  data_persistence: CourseModule.find_or_create_by!(id: 783) do |m|
    m.title = "Module 4: Data Persistence"
    m.description = "Store and manage data with Docker volumes"
    m.sequence_order = 4
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  docker_compose: CourseModule.find_or_create_by!(id: 784) do |m|
    m.title = "Module 5: Docker Compose"
    m.description = "Orchestrate multi-container applications with Docker Compose"
    m.sequence_order = 5
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  advanced_operations: CourseModule.find_or_create_by!(id: 785) do |m|
    m.title = "Module 6: Advanced Operations"
    m.description = "Master advanced Docker techniques and optimization"
    m.sequence_order = 6
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end,

  production_readiness: CourseModule.find_or_create_by!(id: 786) do |m|
    m.title = "Module 7: Production Readiness"
    m.description = "Deploy production-ready containers with security and monitoring"
    m.sequence_order = 7
    m.published = true
    m.course_id = Course.find_by(slug: 'docker-fundamentals')&.id
  end
}

# Update titles for consistency
modules[:container_basics].update!(title: "Module 1: Container Basics")
modules[:building_images].update!(title: "Module 2: Building Images")
modules[:networking].update!(title: "Module 3: Networking")
modules[:data_persistence].update!(title: "Module 4: Data Persistence")
modules[:docker_compose].update!(title: "Module 5: Docker Compose")
modules[:advanced_operations].update!(title: "Module 6: Advanced Operations")
modules[:production_readiness].update!(title: "Module 7: Production Readiness")

# Clear existing assignments (except module 791 which we'll rebuild)
ModuleInteractiveUnit.delete_all

# Module 1: Container Basics (9 lessons)
container_basics_lessons = [
  'codesprout-docker-run',
  'codesprout-detached-nginx',
  'codesprout-naming-containers',
  'codesprout-docker-ps',
  'codesprout-docker-stop',
  'codesprout-docker-rm',
  'codesprout-docker-exec',
  'codesprout-docker-logs'
]

container_basics_lessons.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  if unit
    ModuleInteractiveUnit.find_or_create_by!(
      course_module_id: modules[:container_basics].id,
      interactive_learning_unit_id: unit.id
    ) do |miu|
      miu.sequence_order = index + 1
    end
    puts "✅ Assigned #{slug} to Module 1 (position #{index + 1})"
  else
    puts "⚠️  Could not find lesson: #{slug}"
  end
end

# Module 2: Building Images (3 lessons)
building_images_lessons = [
  'codesprout-build-frontend',
  'codesprout-run-frontend',
  'codesprout-frontend-env'
]

building_images_lessons.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  if unit
    ModuleInteractiveUnit.find_or_create_by!(
      course_module_id: modules[:building_images].id,
      interactive_learning_unit_id: unit.id
    ) do |miu|
      miu.sequence_order = index + 1
    end
    puts "✅ Assigned #{slug} to Module 2 (position #{index + 1})"
  else
    puts "⚠️  Could not find lesson: #{slug}"
  end
end

# Module 3: Networking (4 lessons)
networking_lessons = [
  'codesprout-build-backend',
  'codesprout-connect-services',
  'codesprout-create-network'
]

networking_lessons.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  if unit
    ModuleInteractiveUnit.find_or_create_by!(
      course_module_id: modules[:networking].id,
      interactive_learning_unit_id: unit.id
    ) do |miu|
      miu.sequence_order = index + 1
    end
    puts "✅ Assigned #{slug} to Module 3 (position #{index + 1})"
  else
    puts "⚠️  Could not find lesson: #{slug}"
  end
end

# Module 4: Data Persistence (3 lessons)
data_persistence_lessons = [
  'codesprout-run-database',
  'codesprout-db-volume',
  'codesprout-db-credentials'
]

data_persistence_lessons.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  if unit
    ModuleInteractiveUnit.find_or_create_by!(
      course_module_id: modules[:data_persistence].id,
      interactive_learning_unit_id: unit.id
    ) do |miu|
      miu.sequence_order = index + 1
    end
    puts "✅ Assigned #{slug} to Module 4 (position #{index + 1})"
  else
    puts "⚠️  Could not find lesson: #{slug}"
  end
end

# Module 5: Docker Compose (6 lessons)
docker_compose_lessons = [
  'codesprout-compose-file',
  'codesprout-compose-depends',
  'codesprout-compose-manage',
  'codesprout-compose-logs',
  'codesprout-compose-update',
  'codesprout-compose-scale'
]

docker_compose_lessons.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  if unit
    ModuleInteractiveUnit.find_or_create_by!(
      course_module_id: modules[:docker_compose].id,
      interactive_learning_unit_id: unit.id
    ) do |miu|
      miu.sequence_order = index + 1
    end
    puts "✅ Assigned #{slug} to Module 5 (position #{index + 1})"
  else
    puts "⚠️  Could not find lesson: #{slug}"
  end
end

puts ""
puts "📊 Module Assignment Summary:"
modules.each do |key, mod|
  count = mod.interactive_learning_units.count
  puts "  #{mod.title}: #{count} lessons"
end

puts ""
puts "✅ Module assignments complete!"
