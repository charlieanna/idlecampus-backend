# Simple service to read courses directly from YAML/JSON files
# No database required - perfect for MVP
class CourseFileReaderService
  CONSOLIDATED_DIR = Rails.root.join('db', 'seeds', 'consolidated_courses')
  CACHE_KEY = 'course_file_reader:all_courses'
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
  end

  private

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
          slug: mod['slug'],
          title: mod['title'],
          description: mod['description'],
          sequence_order: mod['order'] || idx + 1,
          estimated_hours: mod['estimated_hours'],
          estimated_minutes: (mod['estimated_hours'] || 0) * 60,
          learning_outcomes: mod['learning_outcomes'] || [],
          lessons: (mod['lessons'] || []).map.with_index do |lesson_slug, lesson_idx|
            {
              slug: lesson_slug,
              title: lesson_slug.gsub('-', ' ').titleize,
              sequence_order: lesson_idx + 1,
              type: 'lesson',
              duration_estimate: '10 min' # Default, can be customized
            }
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
