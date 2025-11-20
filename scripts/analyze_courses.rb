#!/usr/bin/env ruby
require 'yaml'
require 'pathname'

MICROLESSONS_DIR = Pathname.new(__dir__).parent / 'db' / 'seeds' / 'converted_microlessons'

def analyze_courses
  courses = {}

  Dir.glob("#{MICROLESSONS_DIR}/*").select { |f| File.directory?(f) }.sort.each do |course_dir|
    course_name = File.basename(course_dir)
    yaml_files = Dir.glob("#{course_dir}/*.yml")

    courses[course_name] = {
      count: yaml_files.count,
      files: yaml_files.map { |f| File.basename(f) }.sort
    }
  end

  courses
end

def categorize_courses(courses)
  categories = {
    'Chemistry' => [],
    'Docker/Kubernetes' => [],
    'Programming' => [],
    'Mathematics' => [],
    'System Design/Architecture' => [],
    'Linux/DevOps' => [],
    'Other' => []
  }

  courses.each do |name, data|
    case name
    when /chemistry|elements|compounds|organic|polymer|metallurgy|electro|redox|equilibrium|kinetics|stoichiometry|biomolecule|formula-drill/i
      categories['Chemistry'] << { name: name, count: data[:count] }
    when /docker|kubernetes|kubectl|envoy/i
      categories['Docker/Kubernetes'] << { name: name, count: data[:count] }
    when /python|golang|go-|javascript|typescript|rust|react|graphql|redis|postgresql|numpy/i
      categories['Programming'] << { name: name, count: data[:count] }
    when /calculus|quadratic|trig|differentiation/i
      categories['Mathematics'] << { name: name, count: data[:count] }
    when /system-design|microservices|message-queue|solid|clean-code|testing|performance|complexity/i
      categories['System Design/Architecture'] << { name: name, count: data[:count] }
    when /linux|bash|shell|git|cicd|iac|aws|network|tcp/i
      categories['Linux/DevOps'] << { name: name, count: data[:count] }
    else
      categories['Other'] << { name: name, count: data[:count] }
    end
  end

  categories
end

# Main execution
puts "=" * 80
puts "COURSE ANALYSIS"
puts "=" * 80
puts

courses = analyze_courses
total_microlessons = courses.values.sum { |c| c[:count] }

puts "Total Courses: #{courses.count}"
puts "Total Microlessons: #{total_microlessons}"
puts

puts "=" * 80
puts "COURSES BY CATEGORY"
puts "=" * 80

categories = categorize_courses(courses)
categories.each do |category, course_list|
  next if course_list.empty?

  puts "\n#{category} (#{course_list.count} courses)"
  puts "-" * 80
  course_list.sort_by { |c| c[:name] }.each do |course|
    puts "  #{course[:name].ljust(50)} #{course[:count]} microlessons"
  end
  puts "  TOTAL: #{course_list.sum { |c| c[:count] }} microlessons"
end

puts "\n" + "=" * 80
puts "DETAILED COURSE LIST (All Courses)"
puts "=" * 80
courses.sort_by { |name, _| name }.each do |name, data|
  puts "\n#{name} (#{data[:count]} microlessons)"
  if data[:count] > 0
    puts "  Files:"
    data[:files].each { |f| puts "    - #{f}" }
  end
end
