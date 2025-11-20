# frozen_string_literal: true

namespace :courses do
  namespace :yaml do
    desc "Validate all YAML course definitions"
    task validate: :environment do
      require_relative '../validators/course_yaml_validator'

      puts "🔍 Validating YAML course definitions..."
      puts "="*60

      validator = Validators::CourseYamlValidator.new

      # Directories to validate
      dirs = [
        Rails.root.join('db/seeds/converted_microlessons'),
        Rails.root.join('db/seeds/docker_complete_enhanced')
      ]

      all_results = []

      dirs.each do |dir|
        next unless Dir.exist?(dir)

        puts "\n📂 Validating: #{File.basename(dir)}"
        result = validator.validate_directory(dir)
        all_results << result

        if result[:valid]
          puts "   ✅ All files valid (#{result[:valid_files]}/#{result[:total_files]})"
        else
          puts "   ❌ Validation failed"
          puts "   Valid: #{result[:valid_files]}/#{result[:total_files]}"
          puts "   Invalid: #{result[:invalid_files]}"

          # Show details of failures
          result[:results].each do |file_result|
            next if file_result[:valid]

            puts "\n   ❌ #{file_result[:file]}"
            file_result[:errors].each do |error|
              puts "      - #{error}"
            end
          end
        end
      end

      puts "\n" + "="*60

      # Overall summary
      total_files = all_results.sum { |r| r[:total_files] }
      valid_files = all_results.sum { |r| r[:valid_files] }
      invalid_files = all_results.sum { |r| r[:invalid_files] }

      puts "Overall Results:"
      puts "  Total files: #{total_files}"
      puts "  ✅ Valid: #{valid_files}"
      puts "  ❌ Invalid: #{invalid_files}"

      if invalid_files > 0
        puts "\n❌ Validation failed. Please fix the errors above."
        exit 1
      else
        puts "\n✅ All YAML files are valid!"
      end
    end

    desc "Validate a specific YAML course"
    task :validate_course, [:course_name] => :environment do |t, args|
      require_relative '../validators/course_yaml_validator'

      unless args[:course_name]
        puts "❌ Usage: rake courses:yaml:validate_course[course-name]"
        exit 1
      end

      validator = Validators::CourseYamlValidator.new

      # Search for course in both directories
      dirs = [
        Rails.root.join('db/seeds/converted_microlessons'),
        Rails.root.join('db/seeds/docker_complete_enhanced')
      ]

      manifest_path = nil
      dirs.each do |dir|
        path = dir.join(args[:course_name], 'manifest.yml')
        if File.exist?(path)
          manifest_path = path
          break
        end
      end

      unless manifest_path
        puts "❌ Course not found: #{args[:course_name]}"
        puts "   Searched in:"
        dirs.each { |d| puts "   - #{d}" }
        exit 1
      end

      puts "🔍 Validating: #{args[:course_name]}"
      puts "="*60

      # Validate manifest
      result = validator.validate_manifest(manifest_path)

      if result[:valid]
        puts "✅ Manifest is valid"
      else
        puts "❌ Manifest validation failed:"
        result[:errors].each { |err| puts "   - #{err}" }
      end

      if result[:warnings].any?
        puts "\n⚠️  Warnings:"
        result[:warnings].each { |warn| puts "   - #{warn}" }
      end

      # Validate microlessons
      course_dir = File.dirname(manifest_path)
      microlessons_dir = File.join(course_dir, 'microlessons')

      if Dir.exist?(microlessons_dir)
        lesson_files = Dir.glob(File.join(microlessons_dir, '*.yml'))

        puts "\n📚 Validating #{lesson_files.size} microlessons..."

        valid_count = 0
        invalid_count = 0

        lesson_files.each do |lesson_file|
          lesson_result = validator.validate_microlesson(lesson_file)
          if lesson_result[:valid]
            valid_count += 1
          else
            invalid_count += 1
            puts "\n❌ #{File.basename(lesson_file)}:"
            lesson_result[:errors].each { |err| puts "   - #{err}" }
          end
        end

        puts "\n" + "="*60
        puts "Summary:"
        puts "  ✅ Valid: #{valid_count}"
        puts "  ❌ Invalid: #{invalid_count}"

        if invalid_count > 0
          puts "\n❌ Validation failed"
          exit 1
        else
          puts "\n✅ All files valid!"
        end
      end
    end

    desc "Import all YAML courses (supports --dry-run flag)"
    task import: :environment do
      dry_run = ENV['DRY_RUN'] == 'true'
      puts dry_run ? "🔍 DRY RUN: Previewing YAML course import..." : "📚 Importing YAML courses..."

      if dry_run
        # Preview mode - just validate and show what would be imported
        require_relative '../validators/course_yaml_validator'

        validator = Validators::CourseYamlValidator.new
        dirs = [
          Rails.root.join('db/seeds/converted_microlessons'),
          Rails.root.join('db/seeds/docker_complete_enhanced')
        ]

        total_courses = 0
        total_lessons = 0

        dirs.each do |dir|
          next unless Dir.exist?(dir)

          Dir.glob(File.join(dir, '**/manifest.yml')).each do |manifest_path|
            course_name = File.basename(File.dirname(manifest_path))
            manifest = YAML.load_file(manifest_path)

            total_courses += 1
            lesson_count = manifest['modules']&.sum { |m| (m['lessons']&.size || 0) + (m['course_lessons']&.size || 0) + (m['labs']&.size || 0) + (m['quizzes']&.size || 0) } || 0
            total_lessons += lesson_count

            puts "  ✓ Would import: #{course_name} (#{lesson_count} items)"
          end
        end

        puts "\n📊 Preview Summary:"
        puts "  Total courses: #{total_courses}"
        puts "  Total items: #{total_lessons}"
        puts "\n💡 Run without --dry-run to actually import"
      else
        # Actual import
        load Rails.root.join('db/seeds/yaml_course_loader.rb')
      end

      puts "\n✅ Import complete!"
    end

    desc "Import a specific YAML course"
    task :import_course, [:course_name] => :environment do |t, args|
      unless args[:course_name]
        puts "❌ Usage: rake courses:yaml:import_course[course-name]"
        exit 1
      end

      # Search for course in both directories
      dirs = [
        Rails.root.join('db/seeds/converted_microlessons'),
        Rails.root.join('db/seeds/docker_complete_enhanced')
      ]

      manifest_path = nil
      dirs.each do |dir|
        path = dir.join(args[:course_name], 'manifest.yml')
        if File.exist?(path)
          manifest_path = path
          break
        end
      end

      unless manifest_path
        puts "❌ Course not found: #{args[:course_name]}"
        puts "   Searched in:"
        dirs.each { |d| puts "   - #{d}" }
        exit 1
      end

      puts "📚 Importing: #{args[:course_name]}"

      # Load dependencies
      require_relative '../validators/course_yaml_validator'
      load Rails.root.join('db/seeds/yaml_course_loader.rb')

      # Create loader and import single course
      loader = YamlCourseLoader.new(validate: true, verbose: true)
      loader.load_course_from_manifest(manifest_path)

      puts "\n✅ Import complete!"
    end

    desc "List all YAML courses"
    task list: :environment do
      puts "📚 Available YAML Courses:"
      puts "="*60

      dirs = [
        { path: Rails.root.join('db/seeds/converted_microlessons'), name: 'Converted Microlessons' },
        { path: Rails.root.join('db/seeds/docker_complete_enhanced'), name: 'Docker Enhanced' }
      ]

      dirs.each do |dir_info|
        next unless Dir.exist?(dir_info[:path])

        puts "\n#{dir_info[:name]}:"

        Dir.glob(File.join(dir_info[:path], '**/manifest.yml')).each do |manifest_path|
          course_dir = File.dirname(manifest_path)
          course_name = File.basename(course_dir)

          begin
            manifest = YAML.load_file(manifest_path)
            title = manifest.dig('course', 'title') || 'Unknown'
            slug = manifest.dig('course', 'slug') || course_name
            module_count = manifest['modules']&.size || 0
            lesson_count = manifest['modules']&.sum { |m| m['lessons']&.size || 0 } || 0

            puts "  📖 #{course_name}"
            puts "     Title: #{title}"
            puts "     Slug: #{slug}"
            puts "     Modules: #{module_count}, Lessons: #{lesson_count}"
          rescue => e
            puts "  ❌ #{course_name} (error reading manifest: #{e.message})"
          end
        end
      end

      puts "\n" + "="*60
    end

    desc "Generate a YAML course template"
    task :generate_template, [:course_slug] => :environment do |t, args|
      unless args[:course_slug]
        puts "❌ Usage: rake courses:yaml:generate_template[my-course-slug]"
        exit 1
      end

      slug = args[:course_slug]
      dir_path = Rails.root.join('db/seeds/converted_microlessons', slug)

      if Dir.exist?(dir_path)
        puts "❌ Course directory already exists: #{dir_path}"
        exit 1
      end

      # Create directory structure
      FileUtils.mkdir_p(dir_path)
      FileUtils.mkdir_p(File.join(dir_path, 'microlessons'))

      # Generate manifest.yml
      manifest_content = <<~YAML
        course:
          slug: #{slug}
          title: #{slug.titleize}
          description: ''
          estimated_hours: null
          level: beginner  # beginner, intermediate, or advanced
        modules:
        - slug: module-1
          title: Module 1
          lessons:
          - lesson-1-slug
      YAML

      File.write(File.join(dir_path, 'manifest.yml'), manifest_content)

      # Generate sample microlesson
      lesson_content = <<~YAML
        slug: lesson-1-slug
        title: Lesson 1 Title
        sequence_order: 1
        estimated_minutes: 5
        difficulty: easy
        key_concepts:
        - concept-1
        content_md: |
          # Lesson Title

          ## What is this?

          Brief explanation of the concept.

          ## Key Points

          - Point 1
          - Point 2

        exercises:
        - type: mcq
          sequence_order: 1
          question: Sample multiple choice question?
          options:
          - Option A
          - Option B
          - Option C
          - Option D
          correct_answer_index: 0
          require_pass: true

        - type: terminal
          sequence_order: 2
          command: echo "Hello World"
          description: Practice a simple command
          hints:
          - Remember to use echo
          timeout_sec: 60
          require_pass: false

        objectives:
        - Understand the basic concept
        - Practice with hands-on exercises
      YAML

      File.write(File.join(dir_path, 'microlessons', 'lesson-1-slug.yml'), lesson_content)

      puts "✅ Template generated at: #{dir_path}"
      puts "\nNext steps:"
      puts "  1. Edit #{File.join(dir_path, 'manifest.yml')}"
      puts "  2. Add microlessons to #{File.join(dir_path, 'microlessons/')}"
      puts "  3. Validate: rake courses:yaml:validate_course[#{slug}]"
      puts "  4. Import: rake courses:yaml:import_course[#{slug}]"
    end

    desc "Generate TypeScript files for all YAML courses"
    task generate_typescript: :environment do
      require_relative '../generators/typescript_course_generator'

      output_dir = ENV['OUTPUT_DIR'] || Rails.root.join('frontend/src/data/courses')
      puts "📝 Generating TypeScript files to: #{output_dir}"

      generator = TypescriptCourseGenerator.new(output_dir: output_dir)
      generator.generate_all

      puts "\n✅ TypeScript generation complete!"
    end

    desc "Generate TypeScript for a specific course"
    task :generate_typescript_course, [:course_slug] => :environment do |t, args|
      require_relative '../generators/typescript_course_generator'

      unless args[:course_slug]
        puts "❌ Usage: rake courses:yaml:generate_typescript_course[course-slug]"
        exit 1
      end

      output_dir = ENV['OUTPUT_DIR'] || Rails.root.join('frontend/src/data/courses')
      puts "📝 Generating TypeScript for: #{args[:course_slug]}"

      generator = TypescriptCourseGenerator.new(output_dir: output_dir)
      generator.generate(args[:course_slug])

      puts "\n✅ TypeScript generation complete!"
    end
  end
end
