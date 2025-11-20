# Remove all Docker Swarm content
# Swarm is obsolete - transitioning to Kubernetes instead

puts "🗑️  Removing Docker Swarm content..."

course = Course.find_by(slug: 'docker-fundamentals')

# Find the Swarm module
swarm_module = course.course_modules.find_by(slug: 'exam-readiness-dca-mock-1')

if swarm_module
  puts "\n📦 Found module: #{swarm_module.title}"

  # Get all Swarm commands/lessons
  swarm_items = swarm_module.module_items.where(item_type: 'InteractiveLearningUnit')

  puts "  - #{swarm_items.count} Swarm commands to delete"

  # Delete all Swarm InteractiveLearningUnit records
  swarm_items.each do |module_item|
    unit = module_item.item
    if unit
      puts "    ✅ Deleting: #{unit.title}"
      unit.destroy
    end
    module_item.destroy
  end

  # Delete the module itself
  swarm_module.destroy
  puts "  ✅ Deleted module: Docker → Kubernetes Bridge I"
else
  puts "  ⚠️  Swarm module not found"
end

# Update module sequences (remove gap)
puts "\n🔄 Updating module sequences..."

course.course_modules.order(:sequence_order).each_with_index do |mod, index|
  mod.update!(sequence_order: index + 1)
  puts "  #{index + 1}. #{mod.title}"
end

puts "\n" + "=" * 70
puts "✅ SWARM CONTENT REMOVED"
puts "=" * 70

puts "\n📊 Final Course Structure:"
course.course_modules.order(:sequence_order).each do |mod|
  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  total = interactive_count + lab_count

  if total > 0
    parts = []
    parts << "#{interactive_count} commands" if interactive_count > 0
    parts << "#{lab_count} labs" if lab_count > 0
    puts "  #{mod.sequence_order}. #{mod.title}: #{parts.join(', ')}"
  end
end

puts "\n📊 Total InteractiveLearningUnits: #{InteractiveLearningUnit.count}"
puts "\n🎉 Course is now streamlined for Kubernetes transition!"
