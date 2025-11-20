# Link InteractiveLearningUnits to Container Basics module for progressive learning

puts "🔗 Linking progressive Docker learning units to Container Basics module..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Find Container Basics module
mod = course.course_modules.find_by(slug: 'container-basics')
unless mod
  puts "❌ Container Basics module not found!"
  exit
end

puts "\n📦 Found module: #{mod.title} (ID: #{mod.id})"

# InteractiveLearningUnits for progressive container learning
unit_slugs = [
  'running-first-container',  # docker run hello-world
  'listing-containers',        # docker ps
  'running-nginx-plain',       # docker run nginx
  'running-nginx-detached',    # docker run -d nginx
  'naming-containers',         # docker run -d --name my-nginx nginx
  'port-mapping',              # docker run -d -p 8080:80 nginx
  'container-logs',            # docker logs my-nginx
  'stopping-containers',       # docker stop my-nginx
  'removing-containers',       # docker rm my-nginx
  'docker-exec'                # docker exec -it my-nginx bash
]

units = InteractiveLearningUnit.where(slug: unit_slugs).order(:id)

if units.empty?
  puts "❌ No InteractiveLearningUnits found!"
  exit
end

puts "\nFound #{units.count} progressive learning units:"
units.each do |unit|
  puts "  - #{unit.slug}: #{unit.command_to_learn}"
end

# Get the current max sequence order
current_max = mod.module_items.maximum(:sequence_order) || 0
puts "\n📊 Current max sequence order: #{current_max}"

# Add units as ModuleItems
added_count = 0
units.each_with_index do |unit, index|
  # Check if already linked
  if mod.module_items.exists?(item_type: 'InteractiveLearningUnit', item_id: unit.id)
    puts "  ⏭️  Already linked: #{unit.slug}"
  else
    # Create ModuleItem
    mod.module_items.create!(
      item: unit,
      sequence_order: current_max + index + 1,
      required: true
    )
    added_count += 1
    puts "  ✅ Linked: #{unit.slug} (sequence: #{current_max + index + 1})"
  end
end

puts "\n" + "=" * 60
puts "✅ Added #{added_count} new progressive learning units!"
puts "\n📚 Final module structure:"
mod.module_items.order(:sequence_order).each do |item|
  puts "  #{item.sequence_order}. #{item.item_type}: #{item.item.title rescue item.item.slug rescue 'N/A'}"
end
