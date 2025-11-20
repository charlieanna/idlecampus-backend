# Remove empty Docker Fundamentals modules
# These modules have no interactive units and no module items

puts "🔍 Finding empty Docker Fundamentals modules..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker Fundamentals course not found"
  exit
end

empty_modules = []
course.course_modules.each do |mod|
  units_count = mod.module_interactive_units.count
  items_count = mod.module_items.count
  
  if units_count == 0 && items_count == 0
    empty_modules << mod
  end
end

puts "📊 Found #{empty_modules.count} empty modules to remove:"
empty_modules.each do |mod|
  puts "  - #{mod.title} (sequence: #{mod.sequence_order})"
end

if empty_modules.any?
  puts "\n🗑️  Removing empty modules..."
  empty_modules.each do |mod|
    puts "  Removing: #{mod.title}"
    mod.destroy
  end
  
  puts "\n✅ Successfully removed #{empty_modules.count} empty modules"
  
  # Resequence remaining modules
  puts "\n🔢 Resequencing remaining modules..."
  remaining_modules = course.course_modules.order(:sequence_order)
  remaining_modules.each_with_index do |mod, index|
    mod.update(sequence_order: index + 1)
    puts "  #{index + 1}. #{mod.title}"
  end
  
  puts "\n✨ Module cleanup complete!"
else
  puts "\n✅ No empty modules found"
end

# Show final module list
puts "\n📋 Final module list:"
course.course_modules.order(:sequence_order).each do |mod|
  units_count = mod.module_interactive_units.count
  items_count = mod.module_items.count
  puts "  #{mod.sequence_order}. #{mod.title} - #{units_count} interactive units, #{items_count} module items"
end