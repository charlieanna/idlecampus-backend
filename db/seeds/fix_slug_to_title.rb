#!/usr/bin/env ruby
# Fix slug: to title: and use actual titles from the code

puts "\n" + "="*80
puts "FIXING SLUG TO TITLE"
puts "="*80 + "\n"

def fix_file_content(content)
  lines = content.split("\n")
  result = []
  i = 0

  while i < lines.length
    line = lines[i]

    # Match CourseLesson.find_or_create_by!(slug: 'xxx')
    if line =~ /^(\w+)\s*=\s*CourseLesson\.find_or_create_by!\(slug:\s*['"]([\w-]+)['"]\)\s*do\s*\|(\w+)\|/
      var_name = $1
      slug_value = $2
      block_var = $3

      # Look for lesson.title = "Actual Title" in next few lines
      j = i + 1
      title_value = nil
      title_line_idx = nil

      while j < [i + 10, lines.length].min
        if lines[j] =~ /^\s*#{block_var}\.title\s*=\s*['"](.*?)["']/
          title_value = $1
          title_line_idx = j
          break
        end
        j += 1
      end

      if title_value
        # Replace the line with title instead of slug
        result << "#{var_name} = CourseLesson.find_or_create_by!(title: \"#{title_value}\") do |#{block_var}|"
        i += 1

        # Skip and copy lines until we hit the title line
        while i < title_line_idx
          result << lines[i]
          i += 1
        end

        # Skip the title line (since it's now in find_or_create_by)
        i += 1
      else
        result << line
        i += 1
      end

    # Match Quiz.find_or_create_by!(slug: 'xxx')
    elsif line =~ /^(\w+)\s*=\s*Quiz\.find_or_create_by!\(slug:\s*['"]([\w-]+)['"]\)\s*do\s*\|(\w+)\|/
      var_name = $1
      slug_value = $2
      block_var = $3

      # Look for quiz.title = "Actual Title"
      j = i + 1
      title_value = nil
      title_line_idx = nil

      while j < [i + 10, lines.length].min
        if lines[j] =~ /^\s*#{block_var}\.title\s*=\s*['"](.*?)["']/
          title_value = $1
          title_line_idx = j
          break
        end
        j += 1
      end

      if title_value
        result << "#{var_name} = Quiz.find_or_create_by!(title: \"#{title_value}\") do |#{block_var}|"
        i += 1

        while i < title_line_idx
          result << lines[i]
          i += 1
        end

        i += 1
      else
        result << line
        i += 1
      end

    else
      result << line
      i += 1
    end
  end

  result.join("\n")
end

seed_files = [
  'envoy_course_complete.rb',
  'networking_course_complete.rb',
  'python_course_enhanced.rb',
  'golang_course_enhanced.rb',
  'system_design_complete.rb',
  'aws_course_complete.rb',
  'postgresql_course_complete.rb'
]

seed_files.each do |filename|
  filepath = File.join(__dir__, filename)

  unless File.exist?(filepath)
    puts "❌ File not found: #{filename}"
    next
  end

  puts "Processing #{filename}..."

  content = File.read(filepath)
  fixed = fix_file_content(content)

  File.write(filepath, fixed)
  puts "  ✅ Fixed #{filename}"
end

puts "\n" + "="*80
puts "SLUG TO TITLE FIX COMPLETE"
puts "="*80 + "\n"
