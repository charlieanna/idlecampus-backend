# Course Migration Rake Tasks
# Tasks for converting database courses to template DSL format
#
# Usage:
#   rake courses:migrate:single[docker-fundamentals]
#   rake courses:migrate:all
#   rake courses:migrate:batch1    # Migrate K8s, Linux, Python, PostgreSQL
#   rake courses:list              # List all courses
#   rake courses:validate[docker-fundamentals]  # Validate generated template

# Require the migrator
require_relative '../course_builder/migrator'

namespace :courses do
  desc 'List all courses in the database'
  task list: :environment do
    courses = Course.order(:slug)

    puts "\n📚 Courses in Database (#{courses.count} total)\n"
    puts "=" * 80

    courses.each do |course|
      modules = course.course_modules.count

      # Count lessons through module_items
      lesson_ids = ModuleItem.where(
        course_module_id: course.course_modules.pluck(:id),
        item_type: 'CourseLesson'
      ).pluck(:item_id)
      lessons = lesson_ids.count

      # Count labs through module_items
      lab_ids = ModuleItem.where(
        course_module_id: course.course_modules.pluck(:id),
        item_type: ['HandsOnLab', 'InteractiveLearningUnit']
      ).pluck(:item_id)
      labs = lab_ids.count

      printf "%-30s | %2d modules | %3d lessons | %3d labs\n",
             course.slug,
             modules,
             lessons,
             labs
    end

    puts "=" * 80
    puts ""
  end

  namespace :migrate do
    desc 'Migrate a single course to template format'
    task :single, [:course_slug] => :environment do |t, args|
      unless args[:course_slug]
        puts "❌ Error: Course slug required"
        puts "Usage: rake courses:migrate:single[docker-fundamentals]"
        exit 1
      end

      begin
        CourseBuilder::Migrator.migrate_course(args[:course_slug])
        puts "\n✅ Migration complete!"
      rescue ActiveRecord::RecordNotFound
        puts "❌ Error: Course '#{args[:course_slug]}' not found"
        exit 1
      rescue => e
        puts "❌ Error: #{e.message}"
        puts e.backtrace.first(5)
        exit 1
      end
    end

    desc 'Migrate all courses to template format'
    task all: :environment do
      puts "\n🚀 Starting migration of all courses...\n"

      output_dir = Rails.root.join('lib', 'course_templates')
      FileUtils.mkdir_p(output_dir)

      results = CourseBuilder::Migrator.migrate_all_courses(output_dir: output_dir)

      puts "\n✅ Migration complete!"
      puts "📁 Templates saved to: #{output_dir}"
    end

    desc 'Migrate high-priority batch 1 courses (K8s, Linux, Python, PostgreSQL)'
    task batch1: :environment do
      courses = ['kubernetes', 'linux', 'python', 'postgresql']

      puts "\n🚀 Migrating Batch 1 Courses\n"
      puts "=" * 60
      puts "Courses: #{courses.join(', ')}"
      puts "=" * 60
      puts ""

      output_dir = Rails.root.join('lib', 'course_templates')
      FileUtils.mkdir_p(output_dir)

      results = []

      courses.each do |slug|
        begin
          puts "\n📦 Migrating: #{slug}"
          filepath = CourseBuilder::Migrator.migrate_course(slug, output_dir: output_dir)
          results << { course: slug, status: :success, file: filepath }
          puts "✅ Success: #{filepath}"
        rescue ActiveRecord::RecordNotFound
          puts "⚠️  Warning: Course '#{slug}' not found in database"
          results << { course: slug, status: :not_found }
        rescue => e
          puts "❌ Error: #{e.message}"
          results << { course: slug, status: :error, error: e.message }
        end
      end

      puts "\n" + "=" * 60
      puts "Batch 1 Migration Summary"
      puts "=" * 60

      successful = results.count { |r| r[:status] == :success }
      not_found = results.count { |r| r[:status] == :not_found }
      failed = results.count { |r| r[:status] == :error }

      puts "✅ Successful: #{successful}"
      puts "⚠️  Not found: #{not_found}"
      puts "❌ Failed: #{failed}"

      if not_found > 0
        puts "\nCourses not found:"
        results.select { |r| r[:status] == :not_found }.each do |r|
          puts "  - #{r[:course]}"
        end
      end

      if failed > 0
        puts "\nFailed migrations:"
        results.select { |r| r[:status] == :error }.each do |r|
          puts "  - #{r[:course]}: #{r[:error]}"
        end
      end

      puts ""
    end
  end

  desc 'Validate a generated template'
  task :validate, [:course_slug] => :environment do |t, args|
    unless args[:course_slug]
      puts "❌ Error: Course slug required"
      puts "Usage: rake courses:validate[docker-fundamentals]"
      exit 1
    end

    template_file = Rails.root.join(
      'lib',
      'course_templates',
      "#{args[:course_slug].underscore}.rb"
    )

    unless File.exist?(template_file)
      puts "❌ Error: Template file not found: #{template_file}"
      exit 1
    end

    puts "\n🔍 Validating template: #{args[:course_slug]}\n"
    puts "=" * 60

    begin
      # Load DSL first
      require_relative '../course_builder/dsl'

      # Load and parse the template
      load template_file

      puts "✅ Syntax: Valid Ruby code"

      # Try to build the course
      course_data = CourseBuilder::DSL.definitions[args[:course_slug]]

      if course_data
        puts "✅ DSL: Course definition found"
        puts "✅ Title: #{course_data[:title]}"
        puts "✅ Modules: #{course_data[:modules].count}"

        total_items = course_data[:modules].sum { |m| (m[:items] || m[:lessons] || []).count }
        puts "✅ Items: #{total_items}"

        if course_data[:plugins] && course_data[:plugins].any?
          puts "✅ Plugins: #{course_data[:plugins].join(', ')}"
        end

        puts "\n✅ Template is valid!"
      else
        puts "❌ Error: Course definition not found after loading template"
        exit 1
      end

    rescue SyntaxError => e
      puts "❌ Syntax Error: #{e.message}"
      exit 1
    rescue => e
      puts "❌ Error: #{e.message}"
      puts e.backtrace.first(5)
      exit 1
    end

    puts ""
  end

  desc 'Compare database course with generated template'
  task :compare, [:course_slug] => :environment do |t, args|
    unless args[:course_slug]
      puts "❌ Error: Course slug required"
      puts "Usage: rake courses:compare[docker-fundamentals]"
      exit 1
    end

    # Get database course
    begin
      db_course = Course.find_by!(slug: args[:course_slug])
    rescue ActiveRecord::RecordNotFound
      puts "❌ Error: Course '#{args[:course_slug]}' not found in database"
      exit 1
    end

    # Load template
    template_file = Rails.root.join(
      'lib',
      'course_templates',
      "#{args[:course_slug].underscore}.rb"
    )

    unless File.exist?(template_file)
      puts "❌ Error: Template file not found. Run migration first:"
      puts "   rake courses:migrate:single[#{args[:course_slug]}]"
      exit 1
    end

    load template_file
    template_data = CourseBuilder::DSL.definitions[args[:course_slug]]

    unless template_data
      puts "❌ Error: Template definition not found"
      exit 1
    end

    puts "\n📊 Comparing Database vs Template\n"
    puts "=" * 60

    # Compare basic info
    puts "Title:"
    puts "  DB:       #{db_course.title}"
    puts "  Template: #{template_data[:title]}"
    puts "  Match: #{db_course.title == template_data[:title] ? '✅' : '❌'}"
    puts ""

    # Compare module count
    db_modules = db_course.course_modules.count
    template_modules = template_data[:modules].count
    puts "Modules:"
    puts "  DB:       #{db_modules}"
    puts "  Template: #{template_modules}"
    puts "  Match: #{db_modules == template_modules ? '✅' : '❌'}"
    puts ""

    # Compare lesson count
    db_lesson_ids = ModuleItem.where(
      course_module_id: db_course.course_modules.pluck(:id),
      item_type: 'CourseLesson'
    ).pluck(:item_id)
    db_lessons = db_lesson_ids.count

    template_lessons = template_data[:modules].sum do |mod|
      mod[:lessons].count { |l| l[:type] == 'content' }
    end
    puts "Lessons:"
    puts "  DB:       #{db_lessons}"
    puts "  Template: #{template_lessons}"
    puts "  Match: #{db_lessons == template_lessons ? '✅' : '❌'}"
    puts ""

    # Compare lab count
    db_lab_ids = ModuleItem.where(
      course_module_id: db_course.course_modules.pluck(:id),
      item_type: ['HandsOnLab', 'InteractiveLearningUnit']
    ).pluck(:item_id)
    db_labs = db_lab_ids.count
    template_labs = template_data[:modules].sum do |mod|
      mod[:lessons].count { |l| l[:type] == 'lab' }
    end
    puts "Labs:"
    puts "  DB:       #{db_labs}"
    puts "  Template: #{template_labs}"
    puts "  Match: #{db_labs == template_labs ? '✅' : '❌'}"
    puts ""

    # Summary
    all_match = (
      db_course.title == template_data[:title] &&
      db_modules == template_modules &&
      db_lessons == template_lessons &&
      db_labs == template_labs
    )

    if all_match
      puts "✅ Database and template match perfectly!"
    else
      puts "⚠️  Some differences found between database and template"
    end

    puts "=" * 60
    puts ""
  end
end
