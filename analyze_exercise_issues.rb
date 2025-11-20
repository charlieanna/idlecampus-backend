#!/usr/bin/env ruby
require 'yaml'
require 'find'

mcq_issues = []
code_terminal_issues = []

Find.find('db/seeds/converted_microlessons') do |path|
  next unless path.end_with?('.yml')

  begin
    data = YAML.load_file(path)
    next unless data && data['exercises']

    data['exercises'].each_with_index do |exercise, idx|
      next unless exercise

      case exercise['type']
      when 'mcq'
        issues = []
        issues << 'missing correct_answer' unless exercise['correct_answer']
        issues << 'missing options' unless exercise['options'] && exercise['options'].length > 0
        issues << 'missing explanation' unless exercise['explanation']
        issues << 'missing question' unless exercise['question']

        if issues.any?
          mcq_issues << {
            file: path.sub('db/seeds/converted_microlessons/', ''),
            exercise_num: idx + 1,
            issues: issues
          }
        end

      when 'code', 'terminal'
        issues = []
        issues << 'missing problem_statement' unless exercise['problem_statement']
        issues << 'missing language' if exercise['type'] == 'code' && !exercise['language']
        issues << 'missing starter_code' unless exercise['starter_code']

        if issues.any?
          code_terminal_issues << {
            file: path.sub('db/seeds/converted_microlessons/', ''),
            exercise_num: idx + 1,
            type: exercise['type'],
            issues: issues
          }
        end
      end
    end
  rescue => e
    # Skip problematic files
  end
end

puts "=" * 80
puts "EXERCISE ISSUES ANALYSIS"
puts "=" * 80
puts

puts "MCQ EXERCISES WITH MISSING FIELDS: #{mcq_issues.length}"
puts "-" * 80

if mcq_issues.length > 0
  # Group by course
  by_course = mcq_issues.group_by { |i| i[:file].split('/').first }

  by_course.sort_by { |course, issues| -issues.length }.take(10).each do |course, issues|
    puts "\n#{course}: #{issues.length} issues"
    issues.take(3).each do |issue|
      puts "  - #{issue[:file]} (exercise ##{issue[:exercise_num]}): #{issue[:issues].join(', ')}"
    end
    puts "  ..." if issues.length > 3
  end
end

puts "\n"
puts "=" * 80
puts "CODE/TERMINAL EXERCISES WITH MISSING FIELDS: #{code_terminal_issues.length}"
puts "-" * 80

if code_terminal_issues.length > 0
  # Group by course
  by_course = code_terminal_issues.group_by { |i| i[:file].split('/').first }

  by_course.sort_by { |course, issues| -issues.length }.take(10).each do |course, issues|
    puts "\n#{course}: #{issues.length} issues"
    issues.take(3).each do |issue|
      puts "  - #{issue[:file]} (#{issue[:type]} ##{issue[:exercise_num]}): #{issue[:issues].join(', ')}"
    end
    puts "  ..." if issues.length > 3
  end
end

puts "\n"
puts "=" * 80
puts "SUMMARY"
puts "=" * 80
puts "Total MCQ issues: #{mcq_issues.length}"
puts "Total Code/Terminal issues: #{code_terminal_issues.length}"
puts "Total exercise issues: #{mcq_issues.length + code_terminal_issues.length}"
