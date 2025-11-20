#!/usr/bin/env ruby
require 'yaml'
require 'json'

# Read course catalog
catalog = JSON.parse(File.read('course_catalog.json'))

# Chemistry-related patterns
chemistry_patterns = [
  # General chemistry
  /chemistry|chemical|element|compound|periodic|atomic|quantum/i,
  # Organic chemistry
  /organic|alcohol|phenol|ether|aldehyde|ketone|amine|carboxylic|haloalkane|haloarene|biomolecule|polymer|stereochemistry|aromatic/i,
  # Inorganic chemistry
  /inorganic|d-block|f-block|s-block|p-block|coordination|hydrogen|transition/i,
  # Physical chemistry
  /thermodynamic|equilibrium|kinetic|electro|redox|mole|stoichiometry|solution|colligative|state.*matter|solid.*state|surface/i,
  # Analytical/practical
  /qualitative.*analysis|metallurgy|formula.*drill|practical.*organic/i
]

chemistry_courses = catalog['courses'].select do |course|
  slug = course['slug']
  title = course['title']
  chemistry_patterns.any? { |pattern| slug.match?(pattern) || title.match?(pattern) }
end

# Categorize by chemistry subdiscipline
categories = {
  'General Chemistry' => [],
  'Organic Chemistry' => [],
  'Inorganic Chemistry' => [],
  'Physical Chemistry' => [],
  'Analytical/Practical' => []
}

chemistry_courses.each do |course|
  slug = course['slug']

  case slug
  when /organic|alcohol|phenol|ether|aldehyde|ketone|amine|carboxylic|haloalkane|haloarene|biomolecule|polymer|stereochemistry|aromatic/i
    categories['Organic Chemistry'] << course
  when /d-block|f-block|s-block|p-block|coordination|hydrogen|transition/i
    categories['Inorganic Chemistry'] << course
  when /thermodynamic|equilibrium|kinetic|electro|redox|solution|colligative|state.*matter|solid.*state|surface/i
    categories['Physical Chemistry'] << course
  when /qualitative|metallurgy|practical/i
    categories['Analytical/Practical'] << course
  else
    categories['General Chemistry'] << course
  end
end

puts "=" * 100
puts "CHEMISTRY COURSES ANALYSIS"
puts "=" * 100
puts
puts "Total Chemistry Courses: #{chemistry_courses.count}"
puts "Total Chemistry Lessons: #{chemistry_courses.sum { |c| c['actual_file_count'] }}"
puts

categories.each do |category, courses|
  next if courses.empty?

  total_lessons = courses.sum { |c| c['actual_file_count'] }
  puts "\n#{category} (#{courses.count} courses, #{total_lessons} lessons)"
  puts "-" * 100

  courses.sort_by { |c| c['slug'] }.each do |course|
    puts "  #{course['title'].ljust(50)} #{course['actual_file_count'].to_s.rjust(3)} lessons"
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
      lessons = manifest['modules']&.first&.dig('lessons') || []

      puts "\n**#{course['title']}** (#{course['slug']})"
      puts "- Lessons: #{course['actual_file_count']}"
      puts "- Lesson examples: #{lessons.first(3).join(', ')}"
    end
  end
end

# Export chemistry courses
output = {
  'total_courses' => chemistry_courses.count,
  'total_lessons' => chemistry_courses.sum { |c| c['actual_file_count'] },
  'categories' => categories.transform_values { |courses|
    courses.map { |c| {
      'slug' => c['slug'],
      'title' => c['title'],
      'lessons' => c['actual_file_count']
    }}
  }
}

File.write('chemistry_courses.json', JSON.pretty_generate(output))
puts "\n\nExported to chemistry_courses.json"
