#!/usr/bin/env ruby
# Fix certification_track values to be valid or nil

puts "\n" + "="*80
puts "FIXING CERTIFICATION_TRACK VALUES"
puts "="*80 + "\n"

seed_files = [
  'python_course_enhanced.rb',
  'golang_course_enhanced.rb',
  'aws_course_complete.rb',
  'system_design_complete.rb',
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

  # Replace invalid certification_track values with nil
  # Valid values: docker, dca, cka, ckad, cks, kubernetes, none
  content.gsub!(/course\.certification_track\s*=\s*['"]python['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]golang['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]AWS Solutions Architect['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]system-design['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]postgresql['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]envoy['"]/, 'course.certification_track = nil')
  content.gsub!(/course\.certification_track\s*=\s*['"]networking['"]/, 'course.certification_track = nil')

  if content != original
    File.write(filepath, content)
    puts "  ✅ Fixed certification_track in #{filename}"
  else
    puts "  ℹ️  No changes needed for #{filename}"
  end
end

puts "\n" + "="*80
puts "CERTIFICATION_TRACK FIX COMPLETE"
puts "="*80 + "\n"
