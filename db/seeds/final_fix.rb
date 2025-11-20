#!/usr/bin/env ruby
# Final comprehensive fix for all seed files

puts "\n" + "="*80
puts "FINAL COMPREHENSIVE FIX"
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

  # Fix 1: Change slug: to title: for CourseLesson
  content.gsub!(/CourseLesson\.find_or_create_by!\(slug:/, 'CourseLesson.find_or_create_by!(title:')

  # Fix 2: Change slug: to title: for Quiz
  content.gsub!(/Quiz\.find_or_create_by!\(slug:/, 'Quiz.find_or_create_by!(title:')

  # Fix 3: Now extract the title value from the lesson.title = line and use it in find_or_create_by
  # This is complex - need to match pattern and rewrite
  # Pattern: CourseLesson.find_or_create_by!(title: 'slug-value') do |lesson|\n  lesson.title = "Actual Title"
  # We need to swap these

  if content != original
    File.write(filepath, content)
    puts "  ✅ Fixed #{filename}"
  else
    puts "  ℹ️  No changes needed for #{filename}"
  end
end

puts "\n⚠️  IMPORTANT: The slug values in find_or_create_by! need to be replaced with actual titles."
puts "This requires manual editing or a more sophisticated script.\n"
