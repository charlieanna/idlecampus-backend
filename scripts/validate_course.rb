#!/usr/bin/env ruby
require 'yaml'

# Validate a course manifest and its lessons
# Usage: ruby scripts/validate_course.rb <course-slug>

course_slug = ARGV[0]

if course_slug.nil? || course_slug.empty?
  puts "Usage: #{$0} <course-slug>"
  puts ""
  puts "Example:"
  puts "  #{$0} devops-essentials"
  exit 1
end

# Try both locations (consolidated and new structure)
manifest_paths = [
  "db/seeds/courses/#{course_slug}/manifest.yml",
  "db/seeds/consolidated_courses/#{course_slug}/manifest.yml"
]

manifest_path = manifest_paths.find { |path| File.exist?(path) }

unless manifest_path
  puts "❌ Error: Course manifest not found for '#{course_slug}'"
  puts ""
  puts "Searched:"
  manifest_paths.each { |path| puts "  - #{path}" }
  exit 1
end

puts "📋 Validating course: #{course_slug}"
puts "   Manifest: #{manifest_path}"
puts ""

# Load and parse manifest
begin
  manifest = YAML.load_file(manifest_path)
rescue StandardError => e
  puts "❌ Error: Failed to parse YAML: #{e.message}"
  exit 1
end

errors = []
warnings = []

# Validate course metadata
course = manifest['course']
unless course
  errors << "Missing 'course' key in manifest"
else
  # Required fields
  errors << "Missing course.slug" unless course['slug']
  errors << "Missing course.title" unless course['title']
  errors << "Missing course.description" unless course['description']
  errors << "Missing course.estimated_hours" unless course['estimated_hours']
  errors << "Missing course.level" unless course['level']
  errors << "Missing course.tags" unless course['tags']

  # Validate level
  valid_levels = ['beginner', 'intermediate', 'advanced']
  if course['level'] && !valid_levels.include?(course['level'])
    errors << "Invalid course.level: '#{course['level']}' (must be: #{valid_levels.join(', ')})"
  end

  # Warnings for optional but recommended fields
  warnings << "Missing course.prerequisites (recommended)" unless course['prerequisites']
  warnings << "Missing course.learning_outcomes (recommended)" unless course['learning_outcomes']
  warnings << "Missing course.related_courses (recommended)" unless course['related_courses']
end

# Validate modules
modules = manifest['modules']
unless modules
  errors << "Missing 'modules' array in manifest"
else
  if modules.empty?
    errors << "Course has no modules"
  end

  modules.each_with_index do |mod, idx|
    mod_id = mod['slug'] || "Module ##{idx + 1}"

    # Required module fields
    errors << "Module '#{mod_id}' missing slug" unless mod['slug']
    errors << "Module '#{mod_id}' missing title" unless mod['title']
    errors << "Module '#{mod_id}' missing description" unless mod['description']
    errors << "Module '#{mod_id}' missing order" unless mod['order']
    errors << "Module '#{mod_id}' missing lessons array" unless mod['lessons']

    # Validate lessons array
    if mod['lessons']
      if mod['lessons'].empty?
        warnings << "Module '#{mod_id}' has no lessons"
      end

      # Check if lesson files exist
      mod['lessons'].each do |lesson_slug|
        # Try multiple locations
        lesson_paths = [
          # New structure (self-contained)
          "db/seeds/courses/#{course_slug}/microlessons/#{lesson_slug}.yml",
          # Old structure (search all directories)
          *Dir.glob("db/seeds/converted_microlessons/*/microlessons/#{lesson_slug}.yml")
        ]

        lesson_path = lesson_paths.find { |path| File.exist?(path) }

        unless lesson_path
          errors << "Lesson file not found: #{lesson_slug} (referenced in module '#{mod_id}')"
        else
          # Validate lesson YAML
          begin
            lesson = YAML.load_file(lesson_path)
            unless lesson['slug'] == lesson_slug
              warnings << "Lesson #{lesson_slug}: slug in file '#{lesson['slug']}' doesn't match filename"
            end
            warnings << "Lesson #{lesson_slug}: missing title" unless lesson['title']
            warnings << "Lesson #{lesson_slug}: missing content_md" unless lesson['content_md']
          rescue StandardError => e
            errors << "Lesson #{lesson_slug}: YAML parse error: #{e.message}"
          end
        end
      end
    end
  end

  # Check for duplicate module orders
  orders = modules.map { |m| m['order'] }.compact
  if orders.length != orders.uniq.length
    warnings << "Duplicate module order values found"
  end
end

# Print results
puts "═" * 60
puts "VALIDATION RESULTS"
puts "═" * 60
puts ""

if errors.any?
  puts "❌ ERRORS (#{errors.size}):"
  errors.each { |e| puts "   • #{e}" }
  puts ""
end

if warnings.any?
  puts "⚠️  WARNINGS (#{warnings.size}):"
  warnings.each { |w| puts "   • #{w}" }
  puts ""
end

if errors.empty? && warnings.empty?
  puts "✅ Course is valid! No errors or warnings."
  puts ""
end

# Summary statistics
if errors.empty?
  total_lessons = modules.sum { |m| m['lessons']&.size || 0 }
  puts "📊 SUMMARY:"
  puts "   Course: #{course['title']}"
  puts "   Level: #{course['level']}"
  puts "   Modules: #{modules.size}"
  puts "   Lessons: #{total_lessons}"
  puts "   Estimated Hours: #{course['estimated_hours']}"
  puts ""
end

# Exit with appropriate code
if errors.any?
  puts "❌ Validation failed"
  exit 1
else
  puts "✅ Validation passed"
  exit 0
end
