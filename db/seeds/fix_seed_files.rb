#!/usr/bin/env ruby
# Script to fix systematic errors in all enhanced course seed files
# Run with: ruby db/seeds/fix_seed_files.rb

puts "\n" + "="*80
puts "FIXING SEED FILES - SYSTEMATIC ERROR CORRECTION"
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

# Certification track fixes
cert_track_fixes = {
  "certification_track: 'python'" => "certification_track: nil",
  "certification_track: 'golang'" => "certification_track: nil",
  "certification_track: 'AWS Solutions Architect'" => "certification_track: nil",
  'certification_track: "python"' => "certification_track: nil",
  'certification_track: "golang"' => "certification_track: nil",
  'certification_track: "AWS Solutions Architect"' => "certification_track: nil"
}

seed_files.each do |filename|
  filepath = File.join(__dir__, filename)

  unless File.exist?(filepath)
    puts "❌ File not found: #{filename}"
    next
  end

  puts "Processing #{filename}..."

  content = File.read(filepath)
  original_content = content.dup

  # Fix 1: Change Lesson to CourseLesson
  content.gsub!(/\bLesson\./, 'CourseLesson.')

  # Fix 2: Fix syntax error (colon instead of equals) - specific to envoy file
  content.gsub!(/(\w+)\.(estimated_minutes|estimated_time|duration):\s*(\d+)/, '\1.\2 = \3')

  # Fix 3: Fix certification track values
  cert_track_fixes.each do |wrong, correct|
    content.gsub!(wrong, correct)
  end

  # Fix 4: Pattern to fix lesson/quiz creation with course_module
  # This is more complex - we need to refactor the pattern

  # Pattern for lessons: lesson = Lesson.find_or_create_by!(course_module: moduleX, ...)
  # We need to transform this to use ModuleItem

  # First, let's handle the simple Lesson model name change
  # The ModuleItem pattern will need more sophisticated handling

  # Count changes
  changes_made = original_content != content

  if changes_made
    File.write(filepath, content)
    puts "  ✅ Fixed #{filename}"
  else
    puts "  ℹ️  No changes needed for #{filename}"
  end
end

puts "\n" + "="*80
puts "PHASE 1 COMPLETE - Basic fixes applied"
puts "="*80 + "\n"

puts "\n⚠️  IMPORTANT: The course_module association pattern still needs manual review."
puts "The seed files currently use: Lesson.find_or_create_by!(course_module: module1, ...)"
puts "This pattern needs to be changed to use the ModuleItem polymorphic association."
puts "\nHowever, let me check if the existing pattern actually works with Rails polymorphic setup...\n"
