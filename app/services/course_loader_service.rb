# ==================================================================================
# ⚠️  DEPRECATED SERVICE - DO NOT USE!
# ==================================================================================
#
# This service loads courses from YAML files INTO THE DATABASE, which is INCORRECT!
#
# IMPORTANT: Courses should ONLY be fetched from YAML files using CourseFileReaderService.
# The database should NEVER be used as the source of truth for course content.
#
# Why this service should NOT be used:
# - Creates database records from YAML (unnecessary duplication)
# - Can cause sync issues between YAML source and database
# - Makes it unclear whether YAML or DB is the source of truth
# - Requires migrations when course structure changes
#
# Instead, use CourseFileReaderService which:
# - Reads course data directly from YAML files
# - No database sync issues (single source of truth)
# - No migrations needed for course content changes
# - Version controlled in git
#
# Database should ONLY be used for user-specific data:
# - CourseEnrollment: User enrollments
# - ModuleProgress: User progress tracking
# - QuizAttempt: User quiz attempts
# - UserCourseAchievement: User badges/achievements
#
# TODO: Remove this service and all code that uses it.
# ==================================================================================
#
# LEGACY: Service to load courses from YAML manifests into the database (DEPRECATED)
class CourseLoaderService
  def initialize(manifest_path)
    @manifest_path = manifest_path
    @errors = []
  end

  def load!
    Rails.logger.info "Loading course from #{@manifest_path}"

    # Parse YAML manifest
    manifest = YAML.load_file(@manifest_path)
    course_data = manifest['course']
    modules_data = manifest['modules']

    # Create or update course
    course = Course.find_or_initialize_by(slug: course_data['slug'])
    course.assign_attributes(
      title: course_data['title'],
      description: course_data['description'],
      difficulty_level: course_data['level'] || 'beginner',
      estimated_hours: course_data['estimated_hours'],
      learning_objectives: course_data['learning_outcomes']&.join("\n"),
      prerequisites: course_data['prerequisites']&.join("\n"),
      published: true,
      sequence_order: 0
    )

    if course.save
      Rails.logger.info "✓ Course created/updated: #{course.title}"
      load_modules(course, modules_data)
      course
    else
      @errors << "Failed to create course: #{course.errors.full_messages.join(', ')}"
      Rails.logger.error @errors.last
      nil
    end
  rescue => e
    @errors << "Error loading course: #{e.message}"
    Rails.logger.error @errors.last
    Rails.logger.error e.backtrace.join("\n")
    nil
  end

  def errors
    @errors
  end

  private

  def load_modules(course, modules_data)
    return unless modules_data

    modules_data.each_with_index do |module_data, index|
      course_module = course.course_modules.find_or_initialize_by(slug: module_data['slug'])
      course_module.assign_attributes(
        title: module_data['title'],
        description: module_data['description'],
        sequence_order: module_data['order'] || index + 1,
        estimated_minutes: (module_data['estimated_hours'] || 0) * 60,
        learning_objectives: module_data['learning_outcomes']&.join("\n"),
        published: true
      )

      if course_module.save
        Rails.logger.info "  ✓ Module created/updated: #{course_module.title}"
        load_lessons(course_module, module_data['lessons'])
      else
        @errors << "Failed to create module #{module_data['slug']}: #{course_module.errors.full_messages.join(', ')}"
        Rails.logger.error @errors.last
      end
    end
  end

  def load_lessons(course_module, lesson_slugs)
    return unless lesson_slugs

    lesson_slugs.each_with_index do |lesson_slug, index|
      # Create a basic lesson (content can be loaded separately)
      lesson = CourseLesson.find_or_initialize_by(title: lesson_slug.titleize)
      lesson.content ||= "Content for #{lesson_slug}" # Placeholder content
      lesson.reading_time_minutes ||= 10

      if lesson.save
        # Link lesson to module via ModuleItem (polymorphic)
        module_item = course_module.module_items.find_or_initialize_by(
          item_type: 'CourseLesson',
          item_id: lesson.id
        )
        module_item.sequence_order = index + 1
        module_item.required = true

        if module_item.save
          Rails.logger.info "    ✓ Lesson linked: #{lesson.title}"
        else
          @errors << "Failed to link lesson #{lesson_slug}: #{module_item.errors.full_messages.join(', ')}"
          Rails.logger.error @errors.last
        end
      else
        @errors << "Failed to create lesson #{lesson_slug}: #{lesson.errors.full_messages.join(', ')}"
        Rails.logger.error @errors.last
      end
    end
  end
end
