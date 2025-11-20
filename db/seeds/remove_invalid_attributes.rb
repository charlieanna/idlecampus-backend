#!/usr/bin/env ruby
# Remove invalid attributes from CourseLesson and Quiz that don't exist in schema

puts "\n" + "="*80
puts "REMOVING INVALID ATTRIBUTES"
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

  # Remove lesson.difficulty_level = 'xxx'
  content.gsub!(/^\s*lesson\.difficulty_level\s*=\s*['"]\w+['"]\s*$\n?/, '')

  # Remove lesson.published = true/false
  content.gsub!(/^\s*lesson\.published\s*=\s*(true|false)\s*$\n?/, '')

  # Remove quiz.published = true/false
  content.gsub!(/^\s*quiz\.published\s*=\s*(true|false)\s*$\n?/, '')

  if content != original
    File.write(filepath, content)
    puts "  ✅ Cleaned #{filename}"
  else
    puts "  ℹ️  No changes needed for #{filename}"
  end
end

puts "\n" + "="*80
puts "ATTRIBUTE CLEANUP COMPLETE"
puts "="*80 + "\n"
