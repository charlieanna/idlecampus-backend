#!/usr/bin/env ruby
require 'yaml'

# List all courses that haven't been consolidated yet
# Usage: ruby scripts/list_unconsolidated_courses.rb

puts "📊 Analyzing course structure..."
puts ""

# Get all original courses
original_courses_dir = 'db/seeds/converted_microlessons'
original_courses = Dir.entries(original_courses_dir)
  .reject { |d| d.start_with?('.') }
  .sort

puts "Found #{original_courses.size} original courses in #{original_courses_dir}/"
puts ""

# Get all consolidated courses and their source mappings
consolidated_manifests = Dir.glob('db/seeds/consolidated_courses/*/manifest.yml')
puts "Found #{consolidated_manifests.size} consolidated courses"
puts ""

# Track which original courses are referenced
referenced_courses = Set.new

consolidated_manifests.each do |manifest_path|
  manifest = YAML.load_file(manifest_path)
  course_slug = manifest.dig('course', 'slug')

  manifest['modules'].each do |mod|
    # Try to find source_courses if it was documented
    # (Our generation scripts included this, but it may not always be present)
    if mod['source_courses']
      mod['source_courses'].each { |src| referenced_courses << src }
    end

    # Also try to infer from lesson file locations
    next unless mod['lessons']

    mod['lessons'].each do |lesson_slug|
      pattern = "db/seeds/converted_microlessons/*/microlessons/#{lesson_slug}.yml"
      matches = Dir.glob(pattern)

      matches.each do |match|
        # Extract original course slug from path
        # db/seeds/converted_microlessons/[COURSE_SLUG]/microlessons/lesson.yml
        if match =~ /converted_microlessons\/([^\/]+)\/microlessons/
          referenced_courses << $1
        end
      end
    end
  end
end

puts "📋 Referenced in consolidated courses: #{referenced_courses.size} original courses"
puts ""

# Find unconsolidated courses
unconsolidated = original_courses - referenced_courses.to_a

puts "═" * 80
puts "UNCONSOLIDATED COURSES (#{unconsolidated.size})"
puts "═" * 80
puts ""

if unconsolidated.empty?
  puts "✅ All courses have been consolidated!"
else
  # Group by category for better readability
  categories = {
    'Programming' => [],
    'Chemistry' => [],
    'Mathematics' => [],
    'System Design' => [],
    'Databases' => [],
    'Other' => []
  }

  unconsolidated.each do |course|
    case course
    when /^(go|python|rust|javascript|typescript|java|ruby)/i
      categories['Programming'] << course
    when /^(alcohols|aldehydes|amines|carboxylic|biomolecules|hydrocarbons|polymers)/i
      categories['Chemistry'] << course
    when /^(calculus|differentiation|quadratic|trigonometry|algebra)/i
      categories['Mathematics'] << course
    when /^(clean-code|complexity|concurrency|design-patterns|performance|testing)/i
      categories['System Design'] << course
    when /^(sql|database|nosql|redis)/i
      categories['Databases'] << course
    else
      categories['Other'] << course
    end
  end

  categories.each do |category, courses|
    next if courses.empty?

    puts "#{category} (#{courses.size}):"
    courses.sort.each do |course|
      # Get lesson count
      manifest_path = "#{original_courses_dir}/#{course}/manifest.yml"
      if File.exist?(manifest_path)
        manifest = YAML.load_file(manifest_path)
        lesson_count = manifest.dig('modules', 0, 'lessons')&.size || 0
        puts "  • #{course} (#{lesson_count} lessons)"
      else
        puts "  • #{course} (no manifest)"
      end
    end
    puts ""
  end
end

# Summary statistics
puts "═" * 80
puts "SUMMARY"
puts "═" * 80
puts ""
puts "Total original courses:        #{original_courses.size}"
puts "Consolidated courses created:  #{consolidated_manifests.size}"
puts "Original courses referenced:   #{referenced_courses.size}"
puts "Unconsolidated courses:        #{unconsolidated.size}"
puts ""

if unconsolidated.any?
  consolidation_rate = ((referenced_courses.size.to_f / original_courses.size) * 100).round(1)
  puts "Consolidation progress: #{consolidation_rate}%"
  puts ""

  # Recommendations
  puts "💡 RECOMMENDATIONS:"
  puts ""
  puts "1. Review unconsolidated courses:"
  puts "   - Can they be grouped into new consolidated courses?"
  puts "   - Are they still relevant/needed?"
  puts "   - Should they be standalone courses?"
  puts ""
  puts "2. Potential groupings:"
  puts "   - Programming Languages → 2-3 courses (Python/Go/Rust, JavaScript/TypeScript)"
  puts "   - Mathematics → 1 course (Calculus, Algebra, Trig fundamentals)"
  puts "   - System Design → 1-2 courses (Clean Code, Design Patterns, Performance)"
  puts "   - Remaining Chemistry → Review if needed (many already consolidated)"
  puts ""
  puts "3. Create consolidation plans:"
  puts "   - Similar to Docker/Kubernetes, Chemistry, DevOps consolidations"
  puts "   - Document in COURSE_GROUPING.md files"
  puts "   - Use generation scripts to create manifests"
  puts ""
end

# Check for potential duplicates or overlaps
puts "🔍 Checking for potential overlaps..."
puts ""

# Look for similar course names
similar_courses = {}
original_courses.each do |course1|
  original_courses.each do |course2|
    next if course1 == course2
    next if course1 > course2 # Avoid duplicates

    # Check if names are very similar
    words1 = course1.split(/[-_]/)
    words2 = course2.split(/[-_]/)
    common_words = words1 & words2

    if common_words.size >= 2
      key = common_words.join('-')
      similar_courses[key] ||= []
      similar_courses[key] << course1 unless similar_courses[key].include?(course1)
      similar_courses[key] << course2 unless similar_courses[key].include?(course2)
    end
  end
end

if similar_courses.any?
  puts "⚠️  Found #{similar_courses.size} groups of potentially related courses:"
  puts ""
  similar_courses.each do |key, courses|
    puts "   Related to '#{key}':"
    courses.each { |c| puts "     • #{c}" }
    puts ""
  end
  puts "   Consider consolidating these into single courses."
  puts ""
else
  puts "✓ No obvious overlaps detected"
  puts ""
end

puts "✅ Analysis complete"
