# Clone Docker Fundamentals to Docker Containers Professional Bootcamp
# This script copies all 93 InteractiveLearningUnits, 83 HandsOnLabs, and all modules

puts "=" * 60
puts "Cloning Docker Fundamentals → Docker Containers Bootcamp"
puts "=" * 60

# Find source course
docker_fund = Course.find_by(slug: 'docker-fundamentals')
unless docker_fund
  puts "❌ Docker Fundamentals course not found!"
  exit 1
end

# Delete existing bootcamp if exists
existing_bootcamp = Course.find_by(slug: 'docker-containers-bootcamp')
if existing_bootcamp
  puts "🗑️  Deleting existing bootcamp..."
  existing_bootcamp.destroy
end

puts "\n📊 Source Course Stats:"
puts "  Title: #{docker_fund.title}"
puts "  Modules: #{docker_fund.course_modules.count}"
puts "  Total InteractiveLearningUnits: #{InteractiveLearningUnit.count}"
puts "  Total HandsOnLabs: #{HandsOnLab.count}"

# Create new bootcamp course
puts "\n🚀 Creating Docker Containers Professional Bootcamp..."
bootcamp = Course.create!(
  title: 'Docker Containers Professional Bootcamp',
  slug: 'docker-containers-bootcamp',
  description: 'Comprehensive 7-week Docker training with 93 interactive exercises, 83 hands-on labs, and real-world projects including CodeSprout deployment',
  certification_track: 'docker',
  difficulty_level: docker_fund.difficulty_level || 'intermediate',
  estimated_hours: docker_fund.estimated_hours || 40,
  published: true,
  sequence_order: 2,
  learning_objectives: docker_fund.learning_objectives,
  prerequisites: docker_fund.prerequisites
)

puts "✅ Created bootcamp course (ID: #{bootcamp.id})"

# Copy all modules
puts "\n📦 Copying modules and content..."
module_count = 0
item_count = 0

docker_fund.course_modules.order(:sequence_order).each do |original_module|
  new_module = bootcamp.course_modules.create!(
    title: original_module.title,
    slug: original_module.slug,
    description: original_module.description,
    sequence_order: original_module.sequence_order,
    estimated_minutes: original_module.estimated_minutes
  )
  
  # Copy ModuleItems (lessons, labs, quizzes)
  original_module.module_items.order(:sequence_order).each do |item|
    new_module.module_items.create!(
      item: item.item, # Reuse the same polymorphic item
      sequence_order: item.sequence_order
    )
    item_count += 1
  end
  
  # Copy ModuleInteractiveUnits
  original_module.module_interactive_units.order(:sequence_order).each do |unit|
    new_module.module_interactive_units.create!(
      interactive_learning_unit: unit.interactive_learning_unit, # Reuse the same unit
      sequence_order: unit.sequence_order
    )
    item_count += 1
  end
  
  module_count += 1
  total_items = new_module.module_items.count + new_module.module_interactive_units.count
  puts "  ✅ #{new_module.title} (#{total_items} items)"
end

puts "\n" + "=" * 60
puts "🎉 BOOTCAMP CREATED SUCCESSFULLY!"
puts "=" * 60
puts "Slug: docker-containers-bootcamp"
puts "Modules: #{module_count}"
puts "Total Items: #{item_count}"
puts "Access at: http://localhost:5002/docker-bootcamp"
puts "=" * 60