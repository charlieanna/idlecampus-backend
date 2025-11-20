# Link Interactive Learning Units to Course Modules
puts "🔗 Linking Interactive Learning Units to Course Modules..."

# Find the Docker Fundamentals course
docker_course = Course.find_by(slug: "docker-fundamentals")

unless docker_course
  puts "⚠️  Docker Fundamentals course not found. Please run course_system.rb seed first."
  exit
end

# Find or create the "Container Basics" module
container_basics_module = docker_course.course_modules.find_or_create_by!(
  slug: "container-basics"
) do |mod|
  mod.title = "Container Basics"
  mod.description = "Master Docker fundamentals through interactive, hands-on learning"
  mod.sequence_order = 1
  mod.estimated_minutes = 60
  mod.published = true
  mod.learning_objectives = [
    "Run and manage Docker containers",
    "Understand container lifecycle",
    "Work with ports and environment variables"
  ]
end

puts "  ✅ Found/Created module: #{container_basics_module.title}"

# Link basic container units to the module
basic_units_slugs = [
  "running-first-container",
  "running-nginx",
  "naming-containers",
  "port-mapping",
  "environment-variables",
  "listing-containers",
  "stopping-containers",
  "removing-containers"
]

basic_units_slugs.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  
  if unit
    # Check if already linked
    existing = ModuleInteractiveUnit.find_by(
      course_module: container_basics_module,
      interactive_learning_unit: unit
    )
    
    unless existing
      ModuleInteractiveUnit.create!(
        course_module: container_basics_module,
        interactive_learning_unit: unit,
        sequence_order: index + 1,
        required: true
      )
      puts "    ✓ Linked: #{unit.title}"
    else
      puts "    • Already linked: #{unit.title}"
    end
  else
    puts "    ⚠️  Unit not found: #{slug}"
  end
end

# Find or create the "Storage and Volumes" module
storage_module = docker_course.course_modules.find_or_create_by!(
  slug: "storage-volumes"
) do |mod|
  mod.title = "Storage and Volumes"
  mod.description = "Learn to persist data using Docker volumes"
  mod.sequence_order = 2
  mod.estimated_minutes = 30
  mod.published = true
  mod.learning_objectives = [
    "Create and manage Docker volumes",
    "Mount volumes to containers",
    "Persist data across container restarts"
  ]
end

puts "  ✅ Found/Created module: #{storage_module.title}"

# Link volume units to the module
volume_units_slugs = [
  "creating-volumes",
  "mounting-volumes"
]

volume_units_slugs.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  
  if unit
    existing = ModuleInteractiveUnit.find_by(
      course_module: storage_module,
      interactive_learning_unit: unit
    )
    
    unless existing
      ModuleInteractiveUnit.create!(
        course_module: storage_module,
        interactive_learning_unit: unit,
        sequence_order: index + 1,
        required: true
      )
      puts "    ✓ Linked: #{unit.title}"
    else
      puts "    • Already linked: #{unit.title}"
    end
  else
    puts "    ⚠️  Unit not found: #{slug}"
  end
end

# Find or create the "Debugging and Troubleshooting" module
debugging_module = docker_course.course_modules.find_or_create_by!(
  slug: "debugging-troubleshooting"
) do |mod|
  mod.title = "Debugging and Troubleshooting"
  mod.description = "Learn to debug containers and view logs"
  mod.sequence_order = 3
  mod.estimated_minutes = 20
  mod.published = true
  mod.learning_objectives = [
    "View container logs",
    "Execute commands in running containers",
    "Troubleshoot common issues"
  ]
end

puts "  ✅ Found/Created module: #{debugging_module.title}"

# Link debugging units to the module
debugging_units_slugs = [
  "container-logs",
  "docker-exec"
]

debugging_units_slugs.each_with_index do |slug, index|
  unit = InteractiveLearningUnit.find_by(slug: slug)
  
  if unit
    existing = ModuleInteractiveUnit.find_by(
      course_module: debugging_module,
      interactive_learning_unit: unit
    )
    
    unless existing
      ModuleInteractiveUnit.create!(
        course_module: debugging_module,
        interactive_learning_unit: unit,
        sequence_order: index + 1,
        required: true
      )
      puts "    ✓ Linked: #{unit.title}"
    else
      puts "    • Already linked: #{unit.title}"
    end
  else
    puts "    ⚠️  Unit not found: #{slug}"
  end
end

puts ""
puts "📊 Summary:"
puts "  Total Interactive Units: #{InteractiveLearningUnit.count}"
puts "  Linked to Modules: #{ModuleInteractiveUnit.count}"
puts "  Course Modules: #{docker_course.course_modules.count}"
puts ""
puts "🎉 Integration complete!"

