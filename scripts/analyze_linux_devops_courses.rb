#!/usr/bin/env ruby
require 'yaml'
require 'json'

# Read course catalog
catalog = JSON.parse(File.read('course_catalog.json'))

# Linux/DevOps patterns (excluding Docker/K8s which we already consolidated)
devops_patterns = [
  /linux|bash|shell|git|cicd|iac|aws|^network(?!.*docker)|tcp/i
]

devops_courses = catalog['courses'].select do |course|
  slug = course['slug']
  title = course['title']
  # Exclude docker/kubernetes courses
  next if slug.match?(/docker|kubernetes|kubectl|envoy/)

  devops_patterns.any? { |pattern| slug.match?(pattern) || title.match?(pattern) }
end

# Categorize
categories = {
  'Linux Fundamentals' => [],
  'Shell & Scripting' => [],
  'Networking' => [],
  'Version Control' => [],
  'CI/CD & Automation' => [],
  'Cloud (AWS)' => []
}

devops_courses.each do |course|
  slug = course['slug']

  case slug
  when /linux.*navigation|intro.*linux/i
    categories['Linux Fundamentals'] << course
  when /bash|shell.*script/i
    categories['Shell & Scripting'] << course
  when /network|tcp.*ip/i
    categories['Networking'] << course
  when /git/i
    categories['Version Control'] << course
  when /cicd|iac/i
    categories['CI/CD & Automation'] << course
  when /aws/i
    categories['Cloud (AWS)'] << course
  end
end

puts "=" * 100
puts "LINUX/DEVOPS/AWS COURSES ANALYSIS"
puts "=" * 100
puts
puts "Total Courses: #{devops_courses.count}"
puts "Total Lessons: #{devops_courses.sum { |c| c['actual_file_count'] }}"
puts

categories.each do |category, courses|
  next if courses.empty?

  total_lessons = courses.sum { |c| c['actual_file_count'] }
  puts "\n#{category} (#{courses.count} courses, #{total_lessons} lessons)"
  puts "-" * 100

  courses.sort_by { |c| c['slug'] }.each do |course|
    issues = course['has_issues'] ? " ⚠️" : ""
    puts "  #{course['title'].ljust(50)} #{course['actual_file_count'].to_s.rjust(3)} lessons#{issues}"

    if course['has_issues']
      if course['missing_files']&.any?
        puts "    Missing: #{course['missing_files'].count} files"
      end
    end
  end
end

puts "\n" + "=" * 100
puts "DETAILED COURSE BREAKDOWN"
puts "=" * 100

categories.each do |category, courses|
  next if courses.empty?

  puts "\n\n### #{category}"
  puts

  courses.sort_by { |c| c['slug'] }.each do |course|
    manifest_path = "db/seeds/converted_microlessons/#{course['slug']}/manifest.yml"

    if File.exist?(manifest_path)
      manifest = YAML.load_file(manifest_path)
      course_data = manifest['course']
      lessons = manifest['modules']&.first&.dig('lessons') || []

      puts "\n**#{course['title']}** (#{course['slug']})"
      puts "- Lessons: #{course['actual_file_count']}"
      puts "- Description: #{course_data['description'] || 'Not specified'}"
      puts "- Level: #{course_data['level'] || 'Not specified'}"
      puts "- Sample lessons: #{lessons.first(3).join(', ')}"

      if course['has_issues']
        puts "- ⚠️ Issues: #{course['missing_files']&.count || 0} missing files"
      end
    end
  end
end

# Export
output = {
  'total_courses' => devops_courses.count,
  'total_lessons' => devops_courses.sum { |c| c['actual_file_count'] },
  'categories' => categories.transform_values { |courses|
    courses.map { |c| {
      'slug' => c['slug'],
      'title' => c['title'],
      'lessons' => c['actual_file_count'],
      'has_issues' => c['has_issues']
    }}
  }
}

File.write('linux_devops_courses.json', JSON.pretty_generate(output))
puts "\n\nExported to linux_devops_courses.json"
