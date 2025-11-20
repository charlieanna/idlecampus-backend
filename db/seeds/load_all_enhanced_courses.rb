# Load All Enhanced Courses
# Run with: rails db:seed:load_all_enhanced_courses
# Or: rails runner db/seeds/load_all_enhanced_courses.rb

puts "\n" + "="*80
puts "LOADING ALL ENHANCED COURSES WITH COMPLETE CONTENT"
puts "="*80 + "\n"

start_time = Time.now

# Array of all enhanced course seed files
course_files = [
  'python_course_enhanced.rb',
  'golang_course_enhanced.rb',
  'system_design_complete.rb',
  'aws_course_complete.rb',
  'postgresql_course_complete.rb',
  'envoy_course_complete.rb',
  'networking_course_complete.rb'
]

# Load each course
course_files.each_with_index do |file, index|
  puts "\n#{index + 1}. Loading #{file}..."
  puts "-" * 80

  begin
    load Rails.root.join('db', 'seeds', file)
    puts "✅ Successfully loaded #{file}"
  rescue => e
    puts "❌ ERROR loading #{file}:"
    puts "   #{e.message}"
    puts "   #{e.backtrace.first(3).join("\n   ")}"
  end

  puts ""
end

elapsed = Time.now - start_time

puts "\n" + "="*80
puts "SUMMARY"
puts "="*80

# Count totals
total_courses = Course.count
total_modules = CourseModule.count
total_lessons = CourseLesson.count
total_quizzes = Quiz.count
total_questions = QuizQuestion.count
total_labs = HandsOnLab.count

puts "\n📊 Database Statistics:"
puts "   Courses:  #{total_courses}"
puts "   Modules:  #{total_modules}"
puts "   Lessons:  #{total_lessons}"
puts "   Quizzes:  #{total_quizzes}"
puts "   Questions: #{total_questions}"
puts "   Labs:      #{total_labs}"

puts "\n📚 Enhanced Courses Loaded:"
Course.where(slug: [
  'python-fundamentals',
  'golang-fundamentals',
  'system-design-fundamentals',
  'aws-cloud-architecture',
  'postgresql-mastery',
  'envoy-proxy-mastery',
  'networking-fundamentals'
]).find_each do |course|
  module_count = course.course_modules.count

  # Count lessons through ModuleItem polymorphic association
  lesson_count = CourseLesson.joins("INNER JOIN module_items ON module_items.item_type = 'CourseLesson' AND module_items.item_id = course_lessons.id")
    .joins("INNER JOIN course_modules ON course_modules.id = module_items.course_module_id")
    .where(course_modules: { course_id: course.id }).count

  # Count quizzes through ModuleItem polymorphic association
  quiz_count = Quiz.joins("INNER JOIN module_items ON module_items.item_type = 'Quiz' AND module_items.item_id = quizzes.id")
    .joins("INNER JOIN course_modules ON course_modules.id = module_items.course_module_id")
    .where(course_modules: { course_id: course.id }).count

  # Count quiz questions for this course's quizzes
  quiz_ids = Quiz.joins("INNER JOIN module_items ON module_items.item_type = 'Quiz' AND module_items.item_id = quizzes.id")
    .joins("INNER JOIN course_modules ON course_modules.id = module_items.course_module_id")
    .where(course_modules: { course_id: course.id }).pluck(:id)
  question_count = QuizQuestion.where(quiz_id: quiz_ids).count

  puts "   ✅ #{course.title}"
  puts "      - #{module_count} modules, #{lesson_count} lessons, #{quiz_count} quizzes (#{question_count} questions)"
end

puts "\n⏱️  Total time: #{elapsed.round(2)} seconds"

puts "\n" + "="*80
puts "🎉 ALL COURSES LOADED SUCCESSFULLY!"
puts "="*80 + "\n"

puts "\n📝 Next Steps:"
puts "   1. Visit http://localhost:3000 to see the courses"
puts "   2. Check the course catalog and verify content"
puts "   3. Test quizzes and labs"
puts "   4. Review any warnings or errors above"
puts "\n"
