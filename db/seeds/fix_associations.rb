#!/usr/bin/env ruby
# Script to fix course_module associations in seed files
# This transforms the pattern to use ModuleItem properly

puts "\n" + "="*80
puts "FIXING COURSE MODULE ASSOCIATIONS"
puts "="*80 + "\n"

def fix_seed_file(content)
  lines = content.split("\n")
  result = []
  i = 0
  sequence_order_tracker = Hash.new(0)  # Track sequence per module

  while i < lines.length
    line = lines[i]

    # Match lesson/quiz creation with course_module
    if line =~ /(lesson\w+|quiz\w+)\s*=\s*CourseLesson\.find_or_create_by!\(course_module:\s*(\w+),\s*(slug:[^\)]+)\)/
      var_name = $1
      module_var = $2
      slug_param = $3

      # Increment sequence for this module
      sequence_order_tracker[module_var] += 1
      seq_order = sequence_order_tracker[module_var]

      # Write the corrected lesson creation (without course_module)
      result << "#{var_name} = CourseLesson.find_or_create_by!(#{slug_param})"

      # Skip to the end of the block
      i += 1
      indent_level = line[/^\s*/].length
      while i < lines.length && (lines[i].strip.empty? || lines[i] =~ /^\s{#{indent_level + 1},}/ || lines[i] !~ /^end/)
        result << lines[i]
        i += 1
        break if lines[i - 1] =~ /^end$/
      end

      # Add ModuleItem linking
      result << ""
      result << "ModuleItem.find_or_create_by!("
      result << "  course_module: #{module_var},"
      result << "  item: #{var_name},"
      result << "  sequence_order: #{seq_order}"
      result << ")"

    elsif line =~ /(quiz\w+)\s*=\s*Quiz\.find_or_create_by!\(course_module:\s*(\w+),\s*(slug:[^\)]+)\)/
      var_name = $1
      module_var = $2
      slug_param = $3

      # Increment sequence for this module
      sequence_order_tracker[module_var] += 1
      seq_order = sequence_order_tracker[module_var]

      # Write the corrected quiz creation
      result << "#{var_name} = Quiz.find_or_create_by!(#{slug_param})"

      # Skip to the end of the block
      i += 1
      indent_level = line[/^\s*/].length
      while i < lines.length && (lines[i].strip.empty? || lines[i] =~ /^\s{#{indent_level + 1},}/ || lines[i] !~ /^end/)
        result << lines[i]
        i += 1
        break if lines[i - 1] =~ /^end$/
      end

      # Add ModuleItem linking
      result << ""
      result << "ModuleItem.find_or_create_by!("
      result << "  course_module: #{module_var},"
      result << "  item: #{var_name},"
      result << "  sequence_order: #{seq_order}"
      result << ")"

    else
      result << line
    end

    i += 1
  end

  result.join("\n")
end

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
  fixed = fix_seed_file(content)

  File.write(filepath + '.backup', content)  # Create backup
  File.write(filepath, fixed)

  puts "  ✅ Fixed #{filename} (backup created)"
end

puts "\n" + "="*80
puts "FIX COMPLETE - Backups created with .backup extension"
puts "="*80 + "\n"
