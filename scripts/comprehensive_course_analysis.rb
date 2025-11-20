#!/usr/bin/env ruby
require 'yaml'
require 'pathname'

MICROLESSONS_DIR = Pathname.new(__dir__).parent / 'db' / 'seeds' / 'converted_microlessons'

def analyze_all_courses
  courses = []
  total_lessons = 0
  issues = []

  Dir.glob("#{MICROLESSONS_DIR}/*").select { |f| File.directory?(f) }.sort.each do |course_dir|
    course_slug = File.basename(course_dir)
    manifest_path = File.join(course_dir, 'manifest.yml')
    microlessons_dir = File.join(course_dir, 'microlessons')

    # Skip if no manifest
    unless File.exist?(manifest_path)
      issues << "#{course_slug}: No manifest.yml found"
      next
    end

    # Parse manifest
    manifest = YAML.load_file(manifest_path)
    course_info = manifest['course']
    modules = manifest['modules'] || []

    # Count lessons in manifest
    manifest_lessons = modules.flat_map { |m| m['lessons'] || [] }.compact

    # Count actual YAML files
    actual_files = if Dir.exist?(microlessons_dir)
      Dir.glob("#{microlessons_dir}/*.yml").map { |f| File.basename(f, '.yml') }
    else
      []
    end

    # Find mismatches
    missing_files = manifest_lessons - actual_files
    extra_files = actual_files - manifest_lessons

    courses << {
      slug: course_slug,
      title: course_info['title'],
      description: course_info['description'],
      level: course_info['level'],
      estimated_hours: course_info['estimated_hours'],
      modules: modules.map { |m| { slug: m['slug'], title: m['title'], lesson_count: (m['lessons'] || []).count } },
      manifest_lesson_count: manifest_lessons.count,
      actual_file_count: actual_files.count,
      missing_files: missing_files,
      extra_files: extra_files,
      has_issues: missing_files.any? || extra_files.any?
    }

    total_lessons += actual_files.count
  end

  { courses: courses, total_lessons: total_lessons, issues: issues }
end

def categorize_courses(courses)
  categories = {
    'Chemistry' => [],
    'Docker/Kubernetes' => [],
    'Programming Languages' => [],
    'Web Development' => [],
    'Databases' => [],
    'Mathematics' => [],
    'System Design & Architecture' => [],
    'Linux & DevOps' => [],
    'Security' => [],
    'Data Science' => [],
    'Other' => []
  }

  courses.each do |course|
    slug = course[:slug]
    case slug
    when /chemistry|elements|compounds|organic|polymer|metallurgy|electro|redox|equilibrium|kinetics|stoichiometry|biomolecule|formula-drill/i
      categories['Chemistry'] << course
    when /docker|kubernetes|kubectl|envoy|swarm/i
      categories['Docker/Kubernetes'] << course
    when /python|golang|go-|rust|typescript|javascript/i
      categories['Programming Languages'] << course
    when /react|graphql|web-services/i
      categories['Web Development'] << course
    when /postgresql|redis|database/i
      categories['Databases'] << course
    when /calculus|quadratic|trig|differentiation/i
      categories['Mathematics'] << course
    when /system-design|microservices|message-queue|solid|clean-code|testing|performance|complexity/i
      categories['System Design & Architecture'] << course
    when /linux|bash|shell|git|cicd|iac|aws|network|tcp/i
      categories['Linux & DevOps'] << course
    when /cryptography|security/i
      categories['Security'] << course
    when /ml-|numpy|data/i
      categories['Data Science'] << course
    else
      categories['Other'] << course
    end
  end

  categories
end

def print_summary(data)
  puts "=" * 100
  puts "COMPREHENSIVE COURSE ANALYSIS"
  puts "=" * 100
  puts
  puts "Total Courses: #{data[:courses].count}"
  puts "Total Microlessons: #{data[:total_lessons]}"
  puts "Courses with Issues: #{data[:courses].count { |c| c[:has_issues] }}"
  puts

  puts "=" * 100
  puts "COURSES BY CATEGORY"
  puts "=" * 100

  categories = categorize_courses(data[:courses])
  categories.each do |category, course_list|
    next if course_list.empty?

    total_lessons = course_list.sum { |c| c[:actual_file_count] }
    puts "\n#{category} (#{course_list.count} courses, #{total_lessons} lessons)"
    puts "-" * 100

    course_list.sort_by { |c| c[:slug] }.each do |course|
      status = course[:has_issues] ? " ⚠️" : ""
      puts "  #{course[:title].ljust(50)} #{course[:actual_file_count].to_s.rjust(3)} lessons#{status}"

      if course[:has_issues]
        if course[:missing_files].any?
          puts "    Missing files: #{course[:missing_files].join(', ')}"
        end
        if course[:extra_files].any?
          puts "    Extra files: #{course[:extra_files].join(', ')}"
        end
      end
    end
  end

  puts "\n" + "=" * 100
  puts "DETAILED COURSE INFORMATION"
  puts "=" * 100

  data[:courses].each do |course|
    puts
    puts "#{course[:title]} (#{course[:slug]})"
    puts "-" * 100
    puts "  Microlessons: #{course[:actual_file_count]} (manifest references #{course[:manifest_lesson_count]})"
    puts "  Level: #{course[:level] || 'Not specified'}"
    puts "  Estimated Hours: #{course[:estimated_hours] || 'Not specified'}"
    puts "  Modules: #{course[:modules].count}"

    course[:modules].each do |mod|
      puts "    - #{mod[:title]} (#{mod[:lesson_count]} lessons)"
    end

    if course[:has_issues]
      puts "  ⚠️  ISSUES:"
      if course[:missing_files].any?
        puts "    Missing YAML files: #{course[:missing_files].count}"
        course[:missing_files].each { |f| puts "      - #{f}.yml" }
      end
      if course[:extra_files].any?
        puts "    Extra YAML files not in manifest: #{course[:extra_files].count}"
        course[:extra_files].each { |f| puts "      - #{f}.yml" }
      end
    end
  end
end

# Main execution
data = analyze_all_courses
print_summary(data)

# Export to JSON for frontend use
require 'json'
output_file = Pathname.new(__dir__).parent / 'course_catalog.json'
File.write(output_file, JSON.pretty_generate(data))
puts "\n" + "=" * 100
puts "Course catalog exported to: #{output_file}"
