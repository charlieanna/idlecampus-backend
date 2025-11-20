#!/usr/bin/env ruby
require 'yaml'

# List of files with short content to fix
SHORT_FILES = [
  'db/seeds/converted_microlessons/docker-swarm/microlessons/lesson-1.yml',
  'db/seeds/converted_microlessons/python-basics/microlessons/lesson-11.yml',
  'db/seeds/converted_microlessons/python-basics/microlessons/lesson-32.yml',
  'db/seeds/converted_microlessons/networking/microlessons/removing-containers.yml',
  'db/seeds/converted_microlessons/networking/microlessons/stopping-containers.yml',
  'db/seeds/converted_microlessons/networking/microlessons/naming-your-containers.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-17.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-79.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-10.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-11.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-72.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-73.yml',
  'db/seeds/converted_microlessons/module-01-thermodynamics-part1/microlessons/lesson-13-thermochemistry-and-hess.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-20.yml',
  'db/seeds/converted_microlessons/kubernetes-certification-courses/microlessons/lesson-82.yml',
  'db/seeds/converted_microlessons/module-01-thermodynamics-part1/microlessons/lesson-12-first-law-of-thermodynamics.yml'
]

puts "Found #{SHORT_FILES.length} files to fix"
puts "\nProcessing..."

SHORT_FILES.each do |file_path|
  course_name = file_path.split('/')[3]
  file_name = File.basename(file_path, '.yml')

  puts "\nFile: #{file_path}"
  puts "Course: #{course_name}"
  puts "Lesson: #{file_name}"
  puts "Status: Needs content generation"
end

puts "\n✓ Analysis complete. Files identified for manual fixing."
puts "These files contain only placeholder templates and need domain-specific content."
