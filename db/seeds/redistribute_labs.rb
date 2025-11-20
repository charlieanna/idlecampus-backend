# Redistribute labs between Container Basics and Container Management

course = Course.find_by(slug: 'docker-fundamentals')
container_basics = course.course_modules.find_by(slug: 'container-basics')
container_mgmt = course.course_modules.find_by(slug: 'container-management')

puts "🔧 Redistributing labs between Container Basics and Container Management..."

# Labs to move to Container Management (intermediate level)
labs_to_move = [
  'Environment Variables and Configuration',
  'Container Lifecycle Mastery'
]

moved_count = 0

labs_to_move.each do |lab_title|
  # Find the lab by title
  lab_item = container_basics.module_items
    .joins("INNER JOIN hands_on_labs ON hands_on_labs.id = module_items.item_id")
    .where("module_items.item_type = 'HandsOnLab'")
    .where("hands_on_labs.title = ?", lab_title)
    .first

  if lab_item
    lab_item.update!(course_module: container_mgmt)
    moved_count += 1
    puts "  ✅ Moved to Container Management: #{lab_title}"
  else
    puts "  ⚠️  Lab not found: #{lab_title}"
  end
end

puts "\n✅ Redistributed #{moved_count} labs"

# Resequence items in both modules
puts "\n🔄 Resequencing module items..."

[container_basics, container_mgmt].each do |mod|
  items = mod.module_items.order(:sequence_order)
  items.each_with_index do |item, index|
    item.update!(sequence_order: index + 1)
  end

  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count

  puts "  ✅ #{mod.title}: #{interactive_count} commands, #{lab_count} labs"
end

puts "\n🎉 Lab redistribution complete!"
