# Remove quizzes from Docker course modules

puts "🗑️  Removing quizzes from Docker course..."

course = Course.find_by(slug: 'docker-fundamentals')
unless course
  puts "❌ Docker course not found!"
  exit
end

# Get all modules (excluding Kubernetes bridge modules which have substantial quizzes)
docker_modules = course.course_modules.where.not(
  slug: [
    'docker-kubernetes-bridge-1',
    'docker-kubernetes-bridge-2',
    'kubernetes-readiness-ckad',
    'kubernetes-readiness-cka'
  ]
)

total_removed = 0

docker_modules.each do |mod|
  quiz_items = mod.module_items.where(item_type: 'Quiz')

  if quiz_items.any?
    puts "\n📦 #{mod.title}:"
    quiz_items.each do |item|
      quiz = item.item
      q_count = quiz.quiz_questions.count
      puts "  🗑️  Removing quiz: #{quiz.title} (#{q_count} questions)"
      item.destroy
      total_removed += 1
    end
  end
end

puts "\n" + "=" * 60
puts "✅ Removed #{total_removed} quizzes from Docker modules!"

puts "\n📊 Updated module structure:"
course.course_modules.order(:sequence_order).each do |mod|
  lesson_count = mod.module_items.where(item_type: 'CourseLesson').count
  interactive_count = mod.module_items.where(item_type: 'InteractiveLearningUnit').count
  lab_count = mod.module_items.where(item_type: 'HandsOnLab').count
  quiz_count = mod.module_items.where(item_type: 'Quiz').count

  parts = []
  parts << "#{lesson_count} lessons" if lesson_count > 0
  parts << "#{interactive_count} interactive" if interactive_count > 0
  parts << "#{lab_count} labs" if lab_count > 0
  parts << "#{quiz_count} quizzes" if quiz_count > 0

  puts "  #{mod.title}: #{parts.join(', ')}"
end
