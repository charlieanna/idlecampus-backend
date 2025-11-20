# Remove introductory lessons from Docker modules

puts "🗑️  Removing introductory lessons from Docker course..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Docker modules that have intro lessons
docker_modules = course.course_modules.where(slug: [
  'container-basics',
  'images-dockerfiles',
  'networking-and-ports',
  'volumes-and-storage',
  'docker-compose',
  'security-best-practices',
  'registries-ci-cd'
])

total_removed = 0

docker_modules.each do |mod|
  lesson_items = mod.module_items.where(item_type: 'CourseLesson')

  if lesson_items.any?
    puts "\n📦 #{mod.title}:"
    lesson_items.each do |item|
      lesson = item.item
      puts "  🗑️  Removing lesson: #{lesson.title}"
      item.destroy
      total_removed += 1
    end
  end
end

puts "\n" + "=" * 60
puts "✅ Removed #{total_removed} introductory lessons!"

puts "\n📊 Final module structure:"
course.course_modules.order(:sequence_order).each do |mod|
  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  total = interactive_count + lab_count

  if total > 0
    parts = []
    parts << "#{interactive_count} commands" if interactive_count > 0
    parts << "#{lab_count} labs" if lab_count > 0
    puts "  #{mod.title}: #{parts.join(', ')}"
  end
end
