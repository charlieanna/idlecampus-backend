#!/usr/bin/env ruby
require 'yaml'
require 'json'

class MicrolessonAnalyzer
  attr_reader :issues, :stats

  def initialize
    @issues = []
    @stats = {
      total_files: 0,
      total_courses: 0,
      files_with_issues: 0,
      empty_content: 0,
      no_exercises: 0,
      malformed_yaml: 0,
      short_content: 0,
      exercise_issues: 0,
      missing_fields: 0
    }
  end

  def analyze_all
    base_path = 'db/seeds/converted_microlessons'
    courses = Dir.glob("#{base_path}/*").select { |f| File.directory?(f) }

    @stats[:total_courses] = courses.length

    courses.each do |course_dir|
      course_name = File.basename(course_dir)
      microlessons_dir = File.join(course_dir, 'microlessons')

      next unless Dir.exist?(microlessons_dir)

      Dir.glob("#{microlessons_dir}/*.yml").each do |file_path|
        @stats[:total_files] += 1
        analyze_file(file_path, course_name)
      end
    end

    generate_report
  end

  def analyze_file(file_path, course_name)
    file_name = File.basename(file_path)
    file_issues = []

    begin
      content = File.read(file_path)
      data = YAML.load(content)

      # Check for missing or empty content
      if data['content_md'].nil? || data['content_md'].to_s.strip.empty?
        file_issues << "Empty or missing content_md"
        @stats[:empty_content] += 1
      elsif data['content_md'].to_s.strip.length < 100
        file_issues << "Very short content (#{data['content_md'].to_s.strip.length} chars)"
        @stats[:short_content] += 1
      end

      # Check for missing exercises
      if data['exercises'].nil? || data['exercises'].empty?
        file_issues << "No exercises defined"
        @stats[:no_exercises] += 1
      else
        # Analyze exercises
        exercise_issues = analyze_exercises(data['exercises'])
        file_issues.concat(exercise_issues) unless exercise_issues.empty?
      end

      # Check for missing required fields
      required_fields = ['slug', 'title', 'difficulty', 'estimated_minutes']
      missing = required_fields.select { |f| data[f].nil? || data[f].to_s.strip.empty? }
      unless missing.empty?
        file_issues << "Missing required fields: #{missing.join(', ')}"
        @stats[:missing_fields] += 1
      end

      # Check for placeholder or generic content
      if data['content_md'] && data['content_md'].match?(/TODO|PLACEHOLDER|FIX ?ME|TBD/i)
        file_issues << "Contains placeholder text (TODO/PLACEHOLDER/FIXME/TBD)"
      end

    rescue Psych::SyntaxError => e
      file_issues << "YAML syntax error: #{e.message}"
      @stats[:malformed_yaml] += 1
    rescue => e
      file_issues << "Error reading file: #{e.message}"
    end

    unless file_issues.empty?
      @stats[:files_with_issues] += 1
      @issues << {
        course: course_name,
        file: file_name,
        path: file_path,
        issues: file_issues
      }
    end
  end

  def analyze_exercises(exercises)
    issues = []

    exercises.each_with_index do |exercise, idx|
      exercise_num = idx + 1

      # Check exercise type
      unless exercise['type']
        issues << "Exercise #{exercise_num}: Missing 'type' field"
        @stats[:exercise_issues] += 1
        next
      end

      case exercise['type']
      when 'mcq'
        if !exercise['question'] || exercise['question'].to_s.strip.empty?
          issues << "Exercise #{exercise_num} (MCQ): Missing question"
          @stats[:exercise_issues] += 1
        end

        if !exercise['options'] || exercise['options'].empty?
          issues << "Exercise #{exercise_num} (MCQ): Missing or empty options"
          @stats[:exercise_issues] += 1
        elsif exercise['options'].length < 2
          issues << "Exercise #{exercise_num} (MCQ): Less than 2 options"
          @stats[:exercise_issues] += 1
        end

        if !exercise['correct_answer']
          issues << "Exercise #{exercise_num} (MCQ): Missing correct_answer"
          @stats[:exercise_issues] += 1
        end

      when 'code', 'terminal'
        if !exercise['problem_statement'] || exercise['problem_statement'].to_s.strip.empty?
          issues << "Exercise #{exercise_num} (#{exercise['type']}): Missing problem_statement"
          @stats[:exercise_issues] += 1
        end

        if exercise['type'] == 'code'
          if !exercise['test_cases'] || exercise['test_cases'].empty?
            issues << "Exercise #{exercise_num} (code): Missing test_cases"
            @stats[:exercise_issues] += 1
          end

          if !exercise['language']
            issues << "Exercise #{exercise_num} (code): Missing language"
            @stats[:exercise_issues] += 1
          end
        end

      when 'short_answer'
        if !exercise['question'] || exercise['question'].to_s.strip.empty?
          issues << "Exercise #{exercise_num} (short_answer): Missing question"
          @stats[:exercise_issues] += 1
        end

        if !exercise['expected_answer'] || exercise['expected_answer'].to_s.strip.empty?
          issues << "Exercise #{exercise_num} (short_answer): Missing expected_answer"
          @stats[:exercise_issues] += 1
        end

      when 'sandbox'
        if !exercise['description'] || exercise['description'].to_s.strip.empty?
          issues << "Exercise #{exercise_num} (sandbox): Missing description"
          @stats[:exercise_issues] += 1
        end
      end
    end

    issues
  end

  def generate_report
    puts "\n" + "="*80
    puts "MICROLESSON REVIEW REPORT"
    puts "="*80

    puts "\n📊 OVERALL STATISTICS:"
    puts "-" * 80
    puts "Total Courses: #{@stats[:total_courses]}"
    puts "Total Microlesson Files: #{@stats[:total_files]}"
    puts "Files with Issues: #{@stats[:files_with_issues]} (#{percentage(@stats[:files_with_issues], @stats[:total_files])}%)"
    puts "Files without Issues: #{@stats[:total_files] - @stats[:files_with_issues]} (#{percentage(@stats[:total_files] - @stats[:files_with_issues], @stats[:total_files])}%)"

    puts "\n🔍 ISSUE BREAKDOWN:"
    puts "-" * 80
    puts "Empty or Missing Content: #{@stats[:empty_content]}"
    puts "Very Short Content (<100 chars): #{@stats[:short_content]}"
    puts "No Exercises: #{@stats[:no_exercises]}"
    puts "Exercise-related Issues: #{@stats[:exercise_issues]}"
    puts "Missing Required Fields: #{@stats[:missing_fields]}"
    puts "Malformed YAML: #{@stats[:malformed_yaml]}"

    # Group issues by course
    issues_by_course = @issues.group_by { |i| i[:course] }

    puts "\n📚 ISSUES BY COURSE:"
    puts "-" * 80
    issues_by_course.sort_by { |course, issues| -issues.length }.each do |course, course_issues|
      puts "\n#{course} (#{course_issues.length} files with issues):"
      course_issues.first(5).each do |issue|
        puts "  • #{issue[:file]}"
        issue[:issues].each do |msg|
          puts "    - #{msg}"
        end
      end
      if course_issues.length > 5
        puts "  ... and #{course_issues.length - 5} more files"
      end
    end

    # Top 10 most problematic files
    puts "\n⚠️  TOP 20 MOST PROBLEMATIC FILES:"
    puts "-" * 80
    top_issues = @issues.sort_by { |i| -i[:issues].length }.first(20)
    top_issues.each_with_index do |issue, idx|
      puts "\n#{idx + 1}. #{issue[:course]}/#{issue[:file]}"
      puts "   Path: #{issue[:path]}"
      puts "   Issues (#{issue[:issues].length}):"
      issue[:issues].each do |msg|
        puts "     • #{msg}"
      end
    end

    puts "\n" + "="*80
    puts "END OF REPORT"
    puts "="*80
  end

  private

  def percentage(part, whole)
    return 0 if whole == 0
    ((part.to_f / whole) * 100).round(1)
  end
end

# Run the analyzer
analyzer = MicrolessonAnalyzer.new
analyzer.analyze_all
