# frozen_string_literal: true

# YAML Course Loader
# Loads course definitions from YAML files in db/seeds/converted_microlessons/
# and db/seeds/networking_complete_enhanced/
#
# Usage:
#   load Rails.root.join('db/seeds/yaml_course_loader.rb')
#
# Directory structure expected:
#   db/seeds/converted_microlessons/
#     course-name/
#       manifest.yml          # Course and module metadata
#       microlessons/
#         lesson-1.yml        # Individual microlesson files
#         lesson-2.yml
#
puts "📚 Loading YAML-based courses..."

require_relative '../../lib/validators/course_yaml_validator'

class YamlCourseLoader
  def initialize(base_paths: nil, validate: true, verbose: true)
    @base_paths = base_paths || default_base_paths
    @validate = validate
    @verbose = verbose
    @validator = Validators::CourseYamlValidator.new if @validate
    @stats = {
      courses_created: 0,
      courses_updated: 0,
      modules_created: 0,
      modules_updated: 0,
      microlessons_created: 0,
      microlessons_updated: 0,
      exercises_created: 0,
      lessons_created: 0,
      labs_created: 0,
      quizzes_created: 0,
      errors: []
    }
  end

  def load_all
    @base_paths.each do |base_path|
      load_from_directory(base_path)
    end

    print_summary
    @stats
  end

  def load_from_directory(dir_path)
    unless Dir.exist?(dir_path)
      log_warning "Directory not found: #{dir_path}"
      return
    end

    manifest_files = Dir.glob(File.join(dir_path, '**/manifest.yml'))

    if manifest_files.empty?
      log_warning "No manifest.yml files found in #{dir_path}"
      return
    end

    log_info "\n📂 Found #{manifest_files.size} course(s) in #{File.basename(dir_path)}"

    manifest_files.each do |manifest_path|
      load_course_from_manifest(manifest_path)
    end
  end

  def load_course_from_manifest(manifest_path)
    course_dir = File.dirname(manifest_path)
    course_name = File.basename(course_dir)

    log_info "\n  📖 Loading: #{course_name}"

    # Validate manifest if validation is enabled
    if @validate
      result = @validator.validate_manifest(manifest_path)
      unless result[:valid]
        log_error "  ❌ Validation failed for #{course_name}"
        result[:errors].each { |err| log_error "     - #{err}" }
        @stats[:errors] << { course: course_name, file: manifest_path, errors: result[:errors] }
        return
      end

      if result[:warnings].any?
        result[:warnings].each { |warn| log_warning "     ⚠️  #{warn}" }
      end
    end

    # Load and parse manifest
    begin
      manifest = YAML.load_file(manifest_path)
    rescue => e
      log_error "  ❌ Failed to parse manifest: #{e.message}"
      @stats[:errors] << { course: course_name, file: manifest_path, error: e.message }
      return
    end

    # Create or update course
    course = create_or_update_course(manifest['course'])
    return unless course

    # Create or update modules
    manifest['modules']&.each_with_index do |module_data, index|
      create_or_update_module(course, module_data, index, course_dir)
    end
  end

  private

  def default_base_paths
    [
      Rails.root.join('db/seeds/converted_microlessons'),
      Rails.root.join('db/seeds/networking_complete_enhanced')
    ]
  end

  def create_or_update_course(course_data)
    slug = course_data['slug']

    course = Course.find_or_initialize_by(slug: slug)
    is_new = course.new_record?

    attributes = {
      title: course_data['title'],
      description: course_data['description'],
      estimated_hours: course_data['estimated_hours'],
      difficulty_level: map_level(course_data['level']),
      published: course_data.fetch('published', true),
      sequence_order: course_data['sequence_order'] || 0
    }

    # Remove nil values
    attributes.compact!

    if course.update(attributes)
      if is_new
        @stats[:courses_created] += 1
        log_success "     ✅ Course created: #{course.title}"
      else
        @stats[:courses_updated] += 1
        log_info "     ♻️  Course updated: #{course.title}"
      end
      course
    else
      log_error "     ❌ Failed to save course: #{course.errors.full_messages.join(', ')}"
      nil
    end
  rescue => e
    log_error "     ❌ Error creating course: #{e.message}"
    nil
  end

  def create_or_update_module(course, module_data, index, course_dir)
    slug = module_data['slug']

    mod = course.course_modules.find_or_initialize_by(slug: slug)
    is_new = mod.new_record?

    attributes = {
      title: module_data['title'],
      description: module_data['description'],
      sequence_order: module_data['sequence_order'] || index,
      estimated_minutes: module_data['estimated_minutes'],
      published: module_data.fetch('published', true),
      learning_objectives: module_data['learning_objectives']
    }

    # Remove nil values
    attributes.compact!

    if mod.update(attributes)
      if is_new
        @stats[:modules_created] += 1
        log_success "       ✅ Module created: #{mod.title}"
      else
        @stats[:modules_updated] += 1
        log_info "       ♻️  Module updated: #{mod.title}"
      end

      # Load microlessons for this module
      load_microlessons_for_module(mod, module_data['lessons'] || [], course_dir)

      # Load course lessons (if defined inline)
      load_course_lessons_for_module(mod, module_data['course_lessons'] || [])

      # Load labs
      load_labs_for_module(mod, module_data['labs'] || [])

      # Load quizzes
      load_quizzes_for_module(mod, module_data['quizzes'] || [])
    else
      log_error "       ❌ Failed to save module: #{mod.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "       ❌ Error creating module: #{e.message}"
  end

  def load_microlessons_for_module(mod, lesson_slugs, course_dir)
    microlessons_dir = File.join(course_dir, 'microlessons')

    unless Dir.exist?(microlessons_dir)
      log_warning "         ⚠️  No microlessons directory found"
      return
    end

    lesson_slugs.each_with_index do |lesson_slug, index|
      lesson_path = File.join(microlessons_dir, "#{lesson_slug}.yml")

      unless File.exist?(lesson_path)
        log_warning "         ⚠️  Lesson file not found: #{lesson_slug}.yml"
        next
      end

      load_microlesson(mod, lesson_path, index)
    end
  end

  def load_microlesson(mod, lesson_path, index)
    # Validate if enabled
    if @validate
      result = @validator.validate_microlesson(lesson_path)
      unless result[:valid]
        log_error "         ❌ Validation failed for #{File.basename(lesson_path)}"
        result[:errors].each { |err| log_error "            - #{err}" }
        return
      end
    end

    # Load lesson data
    begin
      lesson_data = YAML.load_file(lesson_path)
    rescue => e
      log_error "         ❌ Failed to parse: #{File.basename(lesson_path)} - #{e.message}"
      return
    end

    slug = lesson_data['slug']

    microlesson = mod.micro_lessons.find_or_initialize_by(slug: slug)
    is_new = microlesson.new_record?

    attributes = {
      title: lesson_data['title'],
      content: lesson_data['content_md'] || lesson_data['content'] || '',
      sequence_order: lesson_data['sequence_order'] || index,
      estimated_minutes: lesson_data['estimated_minutes'],
      difficulty: lesson_data['difficulty'],
      published: lesson_data.fetch('published', true),
      key_concepts: lesson_data['key_concepts'] || []
    }
    
    # Only set objectives if the column exists (check via model)
    if MicroLesson.column_names.include?('objectives')
      attributes[:objectives] = lesson_data['objectives']
    end
    
    # Only set prerequisite_ids if the column exists
    if MicroLesson.column_names.include?('prerequisite_ids')
      attributes[:prerequisite_ids] = lesson_data['prerequisite_ids'] || []
    end

    # Remove nil values (but keep empty arrays)
    attributes.reject! { |k, v| v.nil? }

    if microlesson.update(attributes)
      if is_new
        @stats[:microlessons_created] += 1
        log_success "         ✅ Microlesson: #{microlesson.title}"
      else
        @stats[:microlessons_updated] += 1
        log_info "         ♻️  Microlesson: #{microlesson.title}"
      end

      # Load exercises
      load_exercises_for_microlesson(microlesson, lesson_data['exercises'] || [])
    else
      log_error "         ❌ Failed to save microlesson: #{microlesson.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "         ❌ Error loading microlesson: #{e.message}"
    log_error "            Backtrace: #{e.backtrace.first(3).join("\n            ")}" if @verbose
  end

  def load_exercises_for_microlesson(microlesson, exercises_data)
    # Clear existing exercises to avoid duplicates during re-seeding
    microlesson.exercises.destroy_all if microlesson.exercises.any?

    exercises_data.each_with_index do |exercise_data, index|
      create_exercise(microlesson, exercise_data, index)
    end
  end

  def create_exercise(microlesson, exercise_data, index)
    exercise_type = map_exercise_type(exercise_data['type'])

    exercise = microlesson.exercises.build(
      exercise_type: exercise_type,
      sequence_order: exercise_data['sequence_order'] || (index + 1),
      exercise_data: build_exercise_data(exercise_data)
    )

    if exercise.save
      @stats[:exercises_created] += 1
    else
      log_error "           ❌ Failed to save exercise: #{exercise.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "           ❌ Error creating exercise: #{e.message}"
  end

  def build_exercise_data(exercise_data)
    base_data = {
      'description' => exercise_data['description'],
      'hints' => exercise_data['hints'] || [],
      'require_pass' => exercise_data['require_pass'] || false,
      'difficulty' => exercise_data['difficulty'] || 'medium'
    }

    case exercise_data['type']
    when 'terminal'
      base_data.merge(
        'command' => exercise_data['command'],
        'timeout_sec' => exercise_data['timeout_sec'] || 60,
        'validation' => exercise_data['validation'] || {}
      )
    when 'mcq'
      base_data.merge(
        'question' => exercise_data['question'],
        'options' => exercise_data['options'] || [],
        'correct_answer' => exercise_data['options']&.[](exercise_data['correct_answer_index']),
        'correct_answer_index' => exercise_data['correct_answer_index'],
        'explanation' => exercise_data['explanation']
      )
    when 'short_answer'
      base_data.merge(
        'question' => exercise_data['question'],
        'expected_answer' => exercise_data['expected_answer'],
        'validation_type' => exercise_data['validation_type'] || 'flexible'
      )
    when 'reflection', 'checkpoint'
      base_data.merge(
        'prompt' => exercise_data['prompt'],
        'slug' => exercise_data['slug']
      )
    when 'coding', 'code'
      base_data.merge(
        'question' => exercise_data['question'],
        'language' => exercise_data['language'] || 'python',
        'starter_code' => exercise_data['starter_code'],
        'solution_code' => exercise_data['solution_code'],
        'test_cases' => exercise_data['test_cases'] || []
      )
    when 'sql'
      base_data.merge(
        'question' => exercise_data['question'],
        'schema' => exercise_data['schema'],
        'expected_result' => exercise_data['expected_result']
      )
    else
      base_data
    end
  end

  def map_exercise_type(yaml_type)
    # Map YAML exercise types to database exercise types
    case yaml_type
    when 'terminal', 'mcq', 'code', 'short_answer', 'sandbox'
      yaml_type
    when 'coding'
      'code'
    when 'reflection', 'checkpoint', 'sql'
      'short_answer' # These could be treated as short answer for now
    else
      'short_answer' # Default fallback
    end
  end

  def load_course_lessons_for_module(mod, lessons_data)
    return if lessons_data.empty?

    lessons_data.each_with_index do |lesson_data, index|
      create_course_lesson(mod, lesson_data, index)
    end
  end

  def create_course_lesson(mod, lesson_data, index)
    lesson = CourseLesson.find_or_initialize_by(
      title: lesson_data['title']
    )

    lesson.assign_attributes(
      content: lesson_data['content'],
      reading_time_minutes: lesson_data['reading_time_minutes'],
      video_url: lesson_data['video_url']
    )

    if lesson.save
      # Create module_item link
      ModuleItem.find_or_create_by(
        course_module: mod,
        item: lesson
      ) do |item|
        item.sequence_order = lesson_data['sequence_order'] || (index + 1)
        item.required = lesson_data.fetch('required', true)
      end

      @stats[:lessons_created] += 1
      log_success "         ✅ Course Lesson: #{lesson.title}"
    else
      log_error "         ❌ Failed to save lesson: #{lesson.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "         ❌ Error creating lesson: #{e.message}"
  end

  def load_labs_for_module(mod, labs_data)
    return if labs_data.empty?

    labs_data.each_with_index do |lab_data, index|
      create_lab(mod, lab_data, index)
    end
  end

  def create_lab(mod, lab_data, index)
    lab = HandsOnLab.find_or_initialize_by(slug: lab_data['slug']) do |l|
      l.title = lab_data['title']
    end

    attributes = {
      difficulty: lab_data['difficulty'],
      lab_type: lab_data['lab_type'],
      lab_format: lab_data['lab_format'],
      estimated_minutes: lab_data['estimated_minutes'],
      description: lab_data['description'],
      instructions: lab_data['instructions'],
      success_criteria: lab_data['success_criteria'],
      steps: lab_data['tasks'] || lab_data['steps'] || [],
      max_attempts: lab_data['max_attempts'] || 3,
      points_reward: lab_data['points_reward'] || 10,
      is_active: lab_data.fetch('is_active', true),
      category: lab_data['category']
    }

    # Code editor specific fields
    if %w[code_editor hybrid].include?(lab_data['lab_format'])
      attributes.merge!(
        programming_language: lab_data['programming_language'],
        starter_code: lab_data['starter_code'],
        solution_code: lab_data['solution_code'],
        test_cases: lab_data['test_cases'] || []
      )
    end

    # Remove nil values
    attributes.compact!

    lab.assign_attributes(attributes)

    if lab.save
      # Create module_item link
      ModuleItem.find_or_create_by(
        course_module: mod,
        item: lab
      ) do |item|
        item.sequence_order = lab_data['sequence_order'] || (index + 1)
        item.required = lab_data.fetch('required', true)
      end

      @stats[:labs_created] += 1
      log_success "         ✅ Lab: #{lab.title}"
    else
      log_error "         ❌ Failed to save lab: #{lab.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "         ❌ Error creating lab: #{e.message}"
  end

  def load_quizzes_for_module(mod, quizzes_data)
    return if quizzes_data.empty?

    quizzes_data.each_with_index do |quiz_data, index|
      create_quiz(mod, quiz_data, index)
    end
  end

  def create_quiz(mod, quiz_data, index)
    quiz = Quiz.new(
      title: quiz_data['title'],
      passing_score: quiz_data.fetch('passing_score', 70),
      quiz_type: quiz_data['quiz_type'],
      time_limit_minutes: quiz_data['time_limit_minutes'],
      max_attempts: quiz_data['max_attempts'],
      shuffle_questions: quiz_data.fetch('shuffle_questions', false),
      show_correct_answers: quiz_data.fetch('show_correct_answers', true)
    )

    if quiz.save
      # Create module_item link
      ModuleItem.find_or_create_by(
        course_module: mod,
        item: quiz
      ) do |item|
        item.sequence_order = quiz_data['sequence_order'] || (index + 1)
        item.required = quiz_data.fetch('required', true)
      end

      # Create quiz questions
      create_quiz_questions(quiz, quiz_data['questions'] || [])

      @stats[:quizzes_created] += 1
      log_success "         ✅ Quiz: #{quiz.title}"
    else
      log_error "         ❌ Failed to save quiz: #{quiz.errors.full_messages.join(', ')}"
    end
  rescue => e
    log_error "         ❌ Error creating quiz: #{e.message}"
  end

  def create_quiz_questions(quiz, questions_data)
    questions_data.each_with_index do |question_data, index|
      question_type = case question_data['type']
                      when 'mcq', 'multiple_choice'
                        'multiple_choice'
                      when 'true_false'
                        'true_false'
                      when 'command'
                        'command'
                      else
                        'multiple_choice'
                      end

      question = quiz.quiz_questions.build(
        question_text: question_data['question'],
        question_type: question_type,
        sequence_order: question_data['sequence_order'] || (index + 1),
        points: question_data['points'] || 1,
        difficulty_level: question_data['difficulty'],
        explanation: question_data['explanation']
      )

      # Set type-specific fields
      case question_type
      when 'multiple_choice'
        question.options = question_data['options']
        question.correct_answer = question_data['options'][question_data['correct']]
      when 'true_false'
        question.correct_answer = question_data['correct'].to_s
      when 'command'
        question.expected_output = question_data['expected_output']
      end

      unless question.save
        log_error "           ❌ Failed to save question: #{question.errors.full_messages.join(', ')}"
      end
    end
  end

  def map_level(yaml_level)
    # Map YAML level to Course difficulty_level
    case yaml_level&.downcase
    when 'beginner', 'easy'
      'beginner'
    when 'intermediate', 'medium'
      'intermediate'
    when 'advanced', 'hard'
      'advanced'
    else
      'beginner' # Default
    end
  end

  def print_summary
    puts "\n" + "="*60
    puts "📊 YAML Course Loading Summary"
    puts "="*60
    puts "Courses:"
    puts "  ✅ Created: #{@stats[:courses_created]}"
    puts "  ♻️  Updated: #{@stats[:courses_updated]}"
    puts "\nModules:"
    puts "  ✅ Created: #{@stats[:modules_created]}"
    puts "  ♻️  Updated: #{@stats[:modules_updated]}"
    puts "\nMicrolessons:"
    puts "  ✅ Created: #{@stats[:microlessons_created]}"
    puts "  ♻️  Updated: #{@stats[:microlessons_updated]}"
    puts "\nExercises:"
    puts "  ✅ Created: #{@stats[:exercises_created]}"
    puts "\nCourse Lessons:"
    puts "  ✅ Created: #{@stats[:lessons_created]}"
    puts "\nLabs:"
    puts "  ✅ Created: #{@stats[:labs_created]}"
    puts "\nQuizzes:"
    puts "  ✅ Created: #{@stats[:quizzes_created]}"

    if @stats[:errors].any?
      puts "\n❌ Errors: #{@stats[:errors].size}"
      @stats[:errors].each do |error|
        puts "   - #{error[:course] || error[:file]}"
        if error[:errors]
          error[:errors].each { |e| puts "      #{e}" }
        elsif error[:error]
          puts "      #{error[:error]}"
        end
      end
    end

    puts "="*60
  end

  def log_info(message)
    puts message if @verbose
  end

  def log_success(message)
    puts message if @verbose
  end

  def log_warning(message)
    puts message if @verbose
  end

  def log_error(message)
    puts message # Always show errors
  end
end

# Run the loader
loader = YamlCourseLoader.new(validate: true, verbose: true)
loader.load_all

puts "\n✅ YAML course loading complete!"
