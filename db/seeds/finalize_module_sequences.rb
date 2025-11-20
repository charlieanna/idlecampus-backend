# Finalize module sequence orders

course = Course.find_by(slug: 'docker-fundamentals')

# Fix the sequence order properly
course.course_modules.find_by(slug: 'security-best-practices')&.update!(sequence_order: 8)
course.course_modules.find_by(slug: 'registries-ci-cd')&.update!(sequence_order: 9)
course.course_modules.find_by(slug: 'exam-readiness-dca-mock-1')&.update!(sequence_order: 10)
course.course_modules.find_by(slug: 'codesprout-capstone')&.update!(sequence_order: 11)

puts '✅ Updated all module sequences'
puts ''
puts '📊 Final Structure:'
course.course_modules.order(:sequence_order).each do |m|
  count = m.module_items.where(item_type: 'InteractiveLearningUnit').count
  labs = m.module_items.where(item_type: 'HandsOnLab').count
  puts "  #{m.sequence_order}. #{m.title} (#{count} commands, #{labs} labs)"
end
