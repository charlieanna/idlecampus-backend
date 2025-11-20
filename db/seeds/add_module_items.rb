#!/usr/bin/env ruby
# Add ModuleItem linking code to seed files

puts "\n" + "="*80
puts "ADDING MODULE ITEM LINKING CODE"
puts "="*80 + "\n"

def add_module_item_links(content)
  lines = content.split("\n")
  result = []
  current_module = nil
  lesson_quiz_map = []  # [{var: 'lesson1_1', module: 'module1', type: 'CourseLesson'}]

  lines.each_with_index do |line, idx|
    result << line

    # Track current module
    if line =~ /^(module\d+)\s*=\s*CourseModule\.find_or_create_by!/
      current_module = $1
    end

    # Track lesson/quiz creation and add ModuleItem linking right after
    if current_module && line =~ /^(lesson\w+|quiz\w+)\s*=\s*(CourseLesson|Quiz)\.find_or_create_by!/
      var_name = $1
      item_type = $2
      lesson_quiz_map << {var: var_name, module: current_module, type: item_type}

      # Find the end of this block (next 'end' statement at same or less indentation)
      block_end_idx = idx + 1
      indent = line[/^\s*/].length
      while block_end_idx < lines.length
        next_line = lines[block_end_idx]
        if next_line =~ /^end\s*$/ || (next_line =~ /^\S/ && block_end_idx > idx + 1)
          break
        end
        block_end_idx += 1
      end

      # Skip ahead and add ModuleItem after the 'end'
      while result.length <= block_end_idx
        result << lines[result.length]
      end

      # Add ModuleItem linking
      seq_order = lesson_quiz_map.count {|item| item[:module] == current_module}
      result << ""
      result << "ModuleItem.find_or_create_by!("
      result << "  course_module: #{current_module},"
      result << "  item: #{var_name},"
      result << "  sequence_order: #{seq_order}"
      result << ")"
    end
  end

  result.join("\n")
end

seed_files = [
  'envoy_course_complete.rb',  # Start with the smallest one
]

seed_files.each do |filename|
  filepath = File.join(__dir__, filename)

  unless File.exist?(filepath)
    puts "❌ File not found: #{filename}"
    next
  end

  puts "Processing #{filename}..."

  content = File.read(filepath)
  modified = add_module_item_links(content)

  File.write(filepath, modified)
  puts "  ✅ Added ModuleItem links to #{filename}"
end

puts "\n" + "="*80
puts "MODULE ITEM LINKING ADDED"
puts "="*80 + "\n"
