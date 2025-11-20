# Reorganize CodeSprout labs into a final capstone module

puts "🚀 Reorganizing CodeSprout labs into capstone module..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Find or create CodeSprout capstone module
capstone_module = course.course_modules.find_or_initialize_by(slug: 'codesprout-capstone')
if capstone_module.new_record?
  # Get max sequence order
  max_seq = course.course_modules.maximum(:sequence_order) || 0

  capstone_module.assign_attributes(
    title: 'CodeSprout Full Stack Project',
    description: 'Build and deploy a complete full-stack application using Docker. This capstone project ties together everything you\'ve learned throughout the course.',
    sequence_order: max_seq + 1,
    estimated_minutes: 180
  )
  capstone_module.save!
  puts "✅ Created new module: #{capstone_module.title} (sequence: #{capstone_module.sequence_order})"
else
  puts "📦 Using existing module: #{capstone_module.title}"
end

# CodeSprout labs in learning order
codesprout_labs = [
  { id: 40, title: 'CodeSprout Web Server Management' },
  { id: 41, title: 'CodeSprout App Image Build' },
  { id: 42, title: 'CodeSprout Persistent Database' },
  { id: 55, title: 'Deploy CodeSprout Frontend' },
  { id: 59, title: 'Manage and Scale CodeSprout' }
]

puts "\n🔧 Moving CodeSprout labs to capstone module..."

codesprout_labs.each_with_index do |lab_info, index|
  lab = HandsOnLab.find_by(id: lab_info[:id])
  unless lab
    puts "  ⚠️  Lab not found: #{lab_info[:title]} (ID: #{lab_info[:id]})"
    next
  end

  # Remove from any existing module
  existing_items = ModuleItem.where(item_type: 'HandsOnLab', item_id: lab.id)
  if existing_items.any?
    existing_items.each do |item|
      old_module = item.course_module
      puts "  📤 Removing from: #{old_module.title}"
      item.destroy
    end
  end

  # Add to capstone module
  capstone_module.module_items.create!(
    item: lab,
    sequence_order: index + 1,
    required: true
  )
  puts "  ✅ Added to capstone: #{lab.title} (sequence: #{index + 1})"
end

puts "\n" + "=" * 70
puts "✅ CodeSprout labs reorganization complete!"
puts "\n📚 Capstone Module Structure:"
capstone_module.module_items.order(:sequence_order).each do |item|
  puts "  #{item.sequence_order}. #{item.item.title}"
end

puts "\n📊 Updated module structure:"
course.course_modules.order(:sequence_order).each do |mod|
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  puts "  #{mod.sequence_order}. #{mod.title}: #{lab_count} labs"
end
