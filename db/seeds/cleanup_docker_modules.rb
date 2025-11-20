# Cleanup Script - Remove unwanted Docker modules

puts "🧹 Cleaning up Docker course modules..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# IDs of modules to DELETE (Kubernetes content, duplicates, Docker Swarm)
modules_to_delete = [22, 8, 9, 24, 10, 11]

modules_to_delete.each do |module_id|
  mod = CourseModule.find_by(id: module_id, course_id: course.id)
  if mod
    puts "  🗑️  Deleting: #{mod.title} (#{mod.slug})"
    mod.destroy
  end
end

puts "\n✅ Cleanup complete!"
puts "\n📊 Remaining modules:"
course.course_modules.order(:sequence_order).each do |m|
  puts "  #{m.sequence_order}. #{m.title} (#{m.slug})"
end