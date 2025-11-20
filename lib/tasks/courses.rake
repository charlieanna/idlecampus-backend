namespace :courses do
  desc "Clear course cache (run after editing YAML files)"
  task clear_cache: :environment do
    CourseFileReaderService.clear_cache!
    puts "✅ Course cache cleared!"
    puts "Next API request will reload courses from YAML files."
  end

  desc "Load consolidated courses from YAML manifests into the database"
  task load_consolidated: :environment do
    puts "=" * 80
    puts "Loading Consolidated Courses from YAML Manifests"
    puts "=" * 80
    puts

    # Path to consolidated courses directory
    consolidated_dir = Rails.root.join('db', 'seeds', 'consolidated_courses')

    unless Dir.exist?(consolidated_dir)
      puts "❌ Error: Consolidated courses directory not found at #{consolidated_dir}"
      exit 1
    end

    # Find all manifest.yml files
    manifest_files = Dir.glob(consolidated_dir.join('**', 'manifest.yml'))

    if manifest_files.empty?
      puts "❌ No manifest files found in #{consolidated_dir}"
      exit 1
    end

    puts "Found #{manifest_files.count} course manifests to load:"
    manifest_files.each { |f| puts "  - #{File.dirname(f).split('/').last}" }
    puts

    # Load each course
    loaded_courses = []
    failed_courses = []

    manifest_files.each do |manifest_path|
      course_name = File.dirname(manifest_path).split('/').last
      puts "\n" + "-" * 80
      puts "Loading: #{course_name}"
      puts "-" * 80

      loader = CourseLoaderService.new(manifest_path)
      course = loader.load!

      if course
        loaded_courses << course
        puts "✅ Successfully loaded: #{course.title} (#{course.course_modules.count} modules, #{course.total_items} items)"
      else
        failed_courses << course_name
        puts "❌ Failed to load: #{course_name}"
        loader.errors.each { |error| puts "   Error: #{error}" }
      end
    end

    # Summary
    puts "\n" + "=" * 80
    puts "SUMMARY"
    puts "=" * 80
    puts "Total manifests found: #{manifest_files.count}"
    puts "Successfully loaded: #{loaded_courses.count}"
    puts "Failed: #{failed_courses.count}"

    if loaded_courses.any?
      puts "\n✅ Loaded Courses:"
      loaded_courses.each do |course|
        puts "  - #{course.title} (#{course.slug})"
        puts "    Modules: #{course.course_modules.count}"
        puts "    Total Items: #{course.total_items}"
        puts "    Estimated Hours: #{course.estimated_hours}"
      end
    end

    if failed_courses.any?
      puts "\n❌ Failed Courses:"
      failed_courses.each { |name| puts "  - #{name}" }
    end

    puts "\n" + "=" * 80
    puts "Total courses in database: #{Course.count}"
    puts "Total modules in database: #{CourseModule.count}"
    puts "Total lessons in database: #{CourseLesson.count}"
    puts "=" * 80
  end

  desc "Clear all courses from the database"
  task clear: :environment do
    puts "Clearing all courses from the database..."

    print "Are you sure? This will delete all courses, modules, and related data. (yes/no): "
    confirmation = STDIN.gets.chomp

    if confirmation.downcase == 'yes'
      Course.destroy_all
      CourseModule.destroy_all
      ModuleItem.destroy_all
      CourseLesson.destroy_all
      puts "✅ All courses cleared!"
    else
      puts "❌ Cancelled"
    end
  end

  desc "List all courses in the database"
  task list: :environment do
    puts "=" * 80
    puts "COURSES IN DATABASE"
    puts "=" * 80

    if Course.count.zero?
      puts "No courses found in the database."
      puts "Run 'rake courses:load_consolidated' to load courses."
    else
      Course.ordered.each do |course|
        puts "\n#{course.title} (#{course.slug})"
        puts "  Level: #{course.difficulty_level}"
        puts "  Hours: #{course.estimated_hours}"
        puts "  Modules: #{course.course_modules.count}"
        puts "  Items: #{course.total_items}"
        puts "  Published: #{course.published? ? '✓' : '✗'}"
      end

      puts "\n" + "=" * 80
      puts "Total: #{Course.count} courses"
      puts "=" * 80
    end
  end

  desc "Show statistics about courses"
  task stats: :environment do
    puts "=" * 80
    puts "COURSE STATISTICS"
    puts "=" * 80
    puts
    puts "Courses: #{Course.count}"
    puts "  - Published: #{Course.published.count}"
    puts "  - Beginner: #{Course.by_difficulty('beginner').count}"
    puts "  - Intermediate: #{Course.by_difficulty('intermediate').count}"
    puts "  - Advanced: #{Course.by_difficulty('advanced').count}"
    puts
    puts "Modules: #{CourseModule.count}"
    puts "  - Published: #{CourseModule.published.count}"
    puts
    puts "Lessons: #{CourseLesson.count}"
    puts "Module Items: #{ModuleItem.count}"
    puts "Enrollments: #{CourseEnrollment.count}"
    puts "=" * 80
  end
end
