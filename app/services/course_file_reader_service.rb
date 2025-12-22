# ==================================================================================
# CourseFileReaderService - PRIMARY SERVICE FOR FETCHING COURSE CONTENT
# ==================================================================================
#
# IMPORTANT: This is the ONLY service that should be used to fetch course content.
# All course data (titles, descriptions, modules, lessons) comes from YAML files,
# NOT from the database.
#
# Why YAML-only?
# - Single source of truth: No database sync issues
# - Version control: Course changes tracked in git
# - Easy editing: No database migrations needed
# - Portability: Courses can be easily shared
#
# Database is ONLY used for user-specific data:
# - CourseEnrollment: User enrollments
# - ModuleProgress: User progress tracking
# - QuizAttempt: User quiz attempts
# - UserCourseAchievement: User badges/achievements
#
# Usage:
#   CourseFileReaderService.all_courses              # Get all courses
#   CourseFileReaderService.find_course('slug')      # Get specific course
#   CourseFileReaderService.course_with_modules()    # Get course with modules
#
# ==================================================================================
class CourseFileReaderService
  CONSOLIDATED_DIR = Rails.root.join('db', 'seeds', 'consolidated_courses')
  # Only scan Linux-related directories to avoid slow loading from unrelated courses
  MICROLESSONS_DIRS = [
    Rails.root.join('db', 'seeds', 'converted_microlessons', 'linux-basics-navigation'),
    Rails.root.join('db', 'seeds', 'converted_microlessons', 'intro-linux-shell'),
    Rails.root.join('db', 'seeds', 'converted_microlessons', 'bash-basics'),
    Rails.root.join('db', 'seeds', 'linux_complete_enhanced')
  ].freeze
  CACHE_KEY = 'course_file_reader:all_courses'
  LESSON_CACHE_KEY = 'course_file_reader:lesson_index'
  CACHE_DURATION = 1.hour # Cache for 1 hour in development, can be longer in production

  # Get all courses from YAML manifests (cached)
  def self.all_courses
    Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_DURATION) do
      load_all_courses
    end
  end

  # Find a specific course by slug
  def self.find_course(slug)
    all_courses.find { |c| c[:slug] == slug }
  end

  # Get course with full module details
  def self.course_with_modules(slug)
    find_course(slug) # Modules are already included
  end

  # Clear cache (useful for development when YAML files change)
  def self.clear_cache!
    Rails.cache.delete(CACHE_KEY)
    Rails.cache.delete(LESSON_CACHE_KEY)
  end

  # Find a specific lesson by slug with full content
  def self.find_lesson(slug)
    lesson_index[slug]
  end

  # Get lesson index (maps slug -> lesson data with content)
  def self.lesson_index
    Rails.cache.fetch(LESSON_CACHE_KEY, expires_in: CACHE_DURATION) do
      build_lesson_index
    end
  end

  private

  # Build an index of all microlessons for quick lookup
  def self.build_lesson_index
    index = {}

    MICROLESSONS_DIRS.each do |base_dir|
      next unless Dir.exist?(base_dir)

      # Find all microlesson YAML files
      Dir.glob(base_dir.join('**', 'microlessons', '*.yml')).each do |file_path|
        lesson_data = load_microlesson(file_path)
        next unless lesson_data

        slug = lesson_data[:slug]
        index[slug] = lesson_data if slug.present?
      end
    end

    index
  end

  # Load a single microlesson YAML file
  def self.load_microlesson(file_path)
    yaml = YAML.load_file(file_path)

    {
      slug: yaml['slug'],
      title: yaml['title'],
      content: yaml['content_md'] || yaml['content'] || '',
      difficulty: yaml['difficulty'] || 'medium',
      estimated_minutes: yaml['estimated_minutes'] || 10,
      key_concepts: yaml['key_concepts'] || [],
      prerequisites: yaml['prerequisites'] || [],
      exercises: yaml['exercises'] || []
    }
  rescue => e
    Rails.logger.error "Error loading microlesson #{file_path}: #{e.message}"
    nil
  end

  def self.load_all_courses
    manifest_files = Dir.glob(CONSOLIDATED_DIR.join('**', 'manifest.yml'))

    manifest_files.map do |manifest_path|
      parse_course_manifest(manifest_path)
    end.compact.sort_by { |c| c[:title] }
  end

  def self.parse_course_manifest(manifest_path)
    manifest = YAML.load_file(manifest_path)
    course_data = manifest['course']
    modules_data = manifest['modules'] || []

    # Calculate total lessons across all modules
    total_lessons = modules_data.sum { |m| (m['lessons'] || []).count }

    {
      slug: course_data['slug'],
      title: course_data['title'],
      description: course_data['description'],
      difficulty_level: course_data['level'] || 'beginner',
      estimated_hours: course_data['estimated_hours'],
      learning_objectives: course_data['learning_outcomes'] || [],
      prerequisites: course_data['prerequisites'] || [],
      tags: course_data['tags'] || [],
      related_courses: course_data['related_courses'] || [],
      recommended_next: course_data['recommended_next'],
      modules_count: modules_data.count,
      total_lessons: total_lessons,
      modules: modules_data.map.with_index do |mod, idx|
        {
          id: mod['slug'],  # Use slug as id for frontend compatibility
          slug: mod['slug'],
          title: mod['title'],
          description: mod['description'],
          sequence_order: mod['order'] || idx + 1,
          estimated_hours: mod['estimated_hours'],
          estimated_minutes: (mod['estimated_hours'] || 0) * 60,
          learning_outcomes: mod['learning_outcomes'] || [],
          lessons: (mod['lessons'] || []).map.with_index do |lesson_slug, lesson_idx|
            # Try to load full lesson content from microlesson files
            lesson_data = find_lesson(lesson_slug)

            if lesson_data
              {
                id: lesson_slug,  # Use slug as id for frontend compatibility
                slug: lesson_slug,
                title: lesson_data[:title] || lesson_slug.gsub('-', ' ').titleize,
                content: lesson_data[:content],
                sequence_order: lesson_idx + 1,
                type: 'lesson',
                difficulty: lesson_data[:difficulty],
                estimated_minutes: lesson_data[:estimated_minutes],
                duration_estimate: "#{lesson_data[:estimated_minutes] || 10} min",
                key_concepts: lesson_data[:key_concepts],
                exercises: lesson_data[:exercises]
              }
            else
              # Fallback if microlesson not found
              {
                id: lesson_slug,  # Use slug as id for frontend compatibility
                slug: lesson_slug,
                title: lesson_slug.gsub('-', ' ').titleize,
                content: nil,
                sequence_order: lesson_idx + 1,
                type: 'lesson',
                duration_estimate: '10 min'
              }
            end
          end,
          lessons_count: (mod['lessons'] || []).count
        }
      end
    }
  rescue => e
    Rails.logger.error "Error parsing manifest #{manifest_path}: #{e.message}"
    nil
  end
end
