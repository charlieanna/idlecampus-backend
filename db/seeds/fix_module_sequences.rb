# Fix module sequence orders to ensure all modules are properly ordered

course = Course.find_by(slug: 'docker-fundamentals')

# Update the missing module
bridge_module = course.course_modules.find_by(slug: 'docker-kubernetes-bridge-1')
if bridge_module
  bridge_module.update!(sequence_order: 10)
  puts "✅ Updated Docker → Kubernetes Bridge I to sequence 10"
end

# Verify final structure
puts "\n📊 Final Module Structure:"
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
