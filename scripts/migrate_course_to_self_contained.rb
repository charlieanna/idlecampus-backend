#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

# Migrate a course from reference-based to self-contained structure
# Usage: ruby scripts/migrate_course_to_self_contained.rb <course-slug> [--dry-run]

course_slug = ARGV[0]
dry_run = ARGV.include?('--dry-run')

if course_slug.nil? || course_slug.empty?
  puts "Usage: #{$0} <course-slug> [--dry-run]"
  puts ""
  puts "Migrates a course from consolidated_courses/ to courses/ (self-contained structure)"
  puts ""
  puts "Options:"
  puts "  --dry-run    Show what would be done without making changes"
  puts ""
  puts "Example:"
  puts "  #{$0} devops-essentials --dry-run"
  puts "  #{$0} devops-essentials"
  exit 1
end

puts "🔄 Migrating course: #{course_slug}"
puts "   Mode: #{dry_run ? 'DRY RUN (no changes)' : 'LIVE (will make changes)'}"
puts ""

# Source: consolidated_courses
source_manifest_path = "db/seeds/consolidated_courses/#{course_slug}/manifest.yml"
unless File.exist?(source_manifest_path)
  puts "❌ Error: Source manifest not found: #{source_manifest_path}"
  exit 1
end

# Load manifest
manifest = YAML.load_file(source_manifest_path)
course_title = manifest.dig('course', 'title') || course_slug

puts "📋 Course: #{course_title}"
puts "   Source: #{source_manifest_path}"

# Destination: courses (new structure)
dest_course_dir = "db/seeds/courses/#{course_slug}"
dest_manifest_path = "#{dest_course_dir}/manifest.yml"
dest_lessons_dir = "#{dest_course_dir}/microlessons"

# Check if destination already exists
if File.exist?(dest_manifest_path)
  puts ""
  puts "❌ Error: Destination already exists: #{dest_manifest_path}"
  puts "   Course may already be migrated."
  exit 1
end

# Collect all lesson files to copy
lessons_to_copy = []
missing_lessons = []

manifest['modules'].each do |mod|
  next unless mod['lessons']

  mod['lessons'].each do |lesson_slug|
    # Search for lesson in converted_microlessons
    pattern = "db/seeds/converted_microlessons/*/microlessons/#{lesson_slug}.yml"
    matches = Dir.glob(pattern)

    if matches.empty?
      missing_lessons << lesson_slug
    else
      source_path = matches.first
      dest_path = "#{dest_lessons_dir}/#{lesson_slug}.yml"
      lessons_to_copy << {
        slug: lesson_slug,
        source: source_path,
        dest: dest_path
      }
    end
  end
end

# Report findings
total_lessons = lessons_to_copy.size + missing_lessons.size
puts "   Modules: #{manifest['modules'].size}"
puts "   Lessons: #{total_lessons} (#{lessons_to_copy.size} found, #{missing_lessons.size} missing)"
puts ""

if missing_lessons.any?
  puts "⚠️  WARNING: #{missing_lessons.size} lessons not found:"
  missing_lessons.each { |slug| puts "   • #{slug}" }
  puts ""
end

# Show what will be done
puts "📦 Migration Plan:"
puts "   1. Create directory: #{dest_course_dir}"
puts "   2. Create directory: #{dest_lessons_dir}"
puts "   3. Copy manifest: #{source_manifest_path} → #{dest_manifest_path}"
puts "   4. Copy #{lessons_to_copy.size} lesson files"
puts ""

unless dry_run
  print "Continue with migration? [y/N] "
  response = gets.chomp
  unless response.downcase == 'y'
    puts "❌ Migration cancelled"
    exit 0
  end
  puts ""
end

if dry_run
  puts "🔍 DRY RUN - Files that would be copied:"
  puts ""
  lessons_to_copy.each do |lesson|
    puts "   #{File.basename(lesson[:source])}"
    puts "      from: #{lesson[:source]}"
    puts "      to:   #{lesson[:dest]}"
    puts ""
  end
  puts "✅ Dry run complete. Use without --dry-run to perform migration."
  exit 0
end

# Perform migration
puts "🚀 Starting migration..."
puts ""

begin
  # Create directories
  FileUtils.mkdir_p(dest_lessons_dir)
  puts "✓ Created #{dest_course_dir}"
  puts "✓ Created #{dest_lessons_dir}"

  # Copy manifest
  FileUtils.cp(source_manifest_path, dest_manifest_path)
  puts "✓ Copied manifest"

  # Copy lesson files
  copied_count = 0
  lessons_to_copy.each do |lesson|
    FileUtils.cp(lesson[:source], lesson[:dest])
    copied_count += 1
    puts "✓ Copied #{lesson[:slug]}.yml (#{copied_count}/#{lessons_to_copy.size})"
  end

  puts ""
  puts "═" * 60
  puts "✅ MIGRATION COMPLETE"
  puts "═" * 60
  puts ""
  puts "New course location: #{dest_course_dir}"
  puts ""
  puts "📋 Next Steps:"
  puts ""
  puts "1. Validate the migrated course:"
  puts "   ruby scripts/validate_course.rb #{course_slug}"
  puts ""
  puts "2. Review the migrated files:"
  puts "   ls -la #{dest_course_dir}"
  puts "   ls -la #{dest_lessons_dir}"
  puts ""
  puts "3. Test loading the course (if you have a loader):"
  puts "   # Ensure course loader checks db/seeds/courses/ first"
  puts ""
  puts "4. Commit the changes:"
  puts "   git add #{dest_course_dir}"
  puts "   git commit -m \"migrate(#{course_slug}): move to self-contained structure\""
  puts ""
  puts "5. After successful testing, mark old location as deprecated:"
  puts "   echo 'DEPRECATED: Migrated to db/seeds/courses/#{course_slug}' > \\"
  puts "     #{source_manifest_path.sub('manifest.yml', 'DEPRECATED.txt')}"
  puts "   git add #{source_manifest_path.sub('manifest.yml', 'DEPRECATED.txt')}"
  puts "   git commit -m \"chore(#{course_slug}): mark consolidated location as deprecated\""
  puts ""
  puts "6. Eventually remove old manifest (after course loader updated):"
  puts "   # Wait 1-2 weeks, ensure production works with new structure"
  puts "   # git rm #{source_manifest_path}"
  puts ""

  if missing_lessons.any?
    puts "⚠️  IMPORTANT: #{missing_lessons.size} lessons were not found and not copied!"
    puts "   These lessons are referenced in the manifest but don't exist:"
    missing_lessons.each { |slug| puts "   • #{slug}" }
    puts ""
    puts "   You may need to:"
    puts "   - Create these lessons"
    puts "   - Remove references from manifest if they're obsolete"
    puts ""
  end

rescue StandardError => e
  puts ""
  puts "❌ Migration failed: #{e.message}"
  puts ""
  puts "Rolling back..."
  FileUtils.rm_rf(dest_course_dir) if File.exist?(dest_course_dir)
  puts "✓ Removed #{dest_course_dir}"
  exit 1
end
