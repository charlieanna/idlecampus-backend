#!/usr/bin/env ruby
# Simple fix: Remove course_module parameter from find_or_create_by
# and add explicit ModuleItem creation at the end

puts "\n" + "="*80
puts "SIMPLE FIX: Remove course_module from find_or_create_by"
puts "="*80 + "\n"

seed_files = [
  'python_course_enhanced.rb',
  'golang_course_enhanced.rb',
  'system_design_complete.rb',
  'aws_course_complete.rb',
  'postgresql_course_complete.rb',
  'envoy_course_complete.rb',
  'networking_course_complete.rb'
]

seed_files.each do |filename|
  filepath = File.join(__dir__, filename)

  unless File.exist?(filepath)
    puts "❌ File not found: #{filename}"
    next
  end

  puts "Processing #{filename}..."

  content = File.read(filepath)
  original = content.dup

  # Simple regex: Remove "course_module: moduleX, " from CourseLesson.find_or_create_by!
  content.gsub!(/CourseLesson\.find_or_create_by!\(course_module:\s*\w+,\s+/, 'CourseLesson.find_or_create_by!(')

  # Same for Quiz
  content.gsub!(/Quiz\.find_or_create_by!\(course_module:\s*\w+,\s+/, 'Quiz.find_or_create_by!(')

  if content != original
    File.write(filepath, content)
    puts "  ✅ Fixed #{filename}"
  else
    puts "  ℹ️  No changes needed for #{filename}"
  end
end

puts "\n" + "="*80
puts "PHASE 1 COMPLETE"
puts "="*80 + "\n"
puts "\nNOTE: Lessons and quizzes are now created without course_module."
puts "You'll need to link them to modules using ModuleItem after creation.\n"
