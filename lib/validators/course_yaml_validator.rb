# frozen_string_literal: true

# Validates YAML course definitions and microlessons
# Usage:
#   validator = CourseYamlValidator.new
#   result = validator.validate_manifest('/path/to/manifest.yml')
#   result = validator.validate_microlesson('/path/to/lesson.yml')
#
module Validators
  class CourseYamlValidator
    class ValidationError < StandardError; end

    VALID_DIFFICULTIES = %w[easy medium hard beginner intermediate advanced].freeze
    VALID_LEVELS = %w[beginner intermediate advanced].freeze
    VALID_EXERCISE_TYPES = %w[terminal mcq short_answer reflection checkpoint coding sql].freeze
    VALID_LAB_TYPES = %w[docker kubernetes docker-compose helm python golang javascript ruby postgresql networking linux security].freeze
    VALID_LAB_FORMATS = %w[terminal code_editor hybrid].freeze
    VALID_PROGRAMMING_LANGUAGES = %w[python golang javascript ruby java sql].freeze
    VALID_QUIZ_TYPES = %w[standard review_session topic_deepdive mastery_challenge].freeze

    def initialize
      @errors = []
      @warnings = []
    end

    # Validate a manifest.yml file
    def validate_manifest(file_path)
      reset_errors

      unless File.exist?(file_path)
        add_error("File not found: #{file_path}")
        return validation_result
      end

      begin
        data = YAML.load_file(file_path)
      rescue Psych::SyntaxError => e
        add_error("YAML syntax error: #{e.message}")
        return validation_result
      end

      validate_manifest_structure(data, file_path)
      validation_result
    end

    # Validate a microlesson YAML file
    def validate_microlesson(file_path)
      reset_errors

      unless File.exist?(file_path)
        add_error("File not found: #{file_path}")
        return validation_result
      end

      begin
        data = YAML.load_file(file_path)
      rescue Psych::SyntaxError => e
        add_error("YAML syntax error: #{e.message}")
        return validation_result
      end

      validate_microlesson_structure(data, file_path)
      validation_result
    end

    # Validate all YAML courses in a directory
    def validate_directory(dir_path)
      reset_errors

      unless Dir.exist?(dir_path)
        add_error("Directory not found: #{dir_path}")
        return validation_result
      end

      manifest_files = Dir.glob(File.join(dir_path, '**/manifest.yml'))

      if manifest_files.empty?
        add_warning("No manifest.yml files found in #{dir_path}")
        return validation_result
      end

      results = []
      manifest_files.each do |manifest_path|
        course_dir = File.dirname(manifest_path)
        course_name = File.basename(course_dir)

        # Validate manifest
        manifest_result = validate_manifest(manifest_path)
        results << {
          type: 'manifest',
          course: course_name,
          file: manifest_path,
          valid: manifest_result[:valid],
          errors: manifest_result[:errors],
          warnings: manifest_result[:warnings]
        }

        # Validate microlessons
        microlesson_dir = File.join(course_dir, 'microlessons')
        if Dir.exist?(microlesson_dir)
          Dir.glob(File.join(microlesson_dir, '*.yml')).each do |lesson_path|
            reset_errors
            lesson_result = validate_microlesson(lesson_path)
            results << {
              type: 'microlesson',
              course: course_name,
              file: lesson_path,
              valid: lesson_result[:valid],
              errors: lesson_result[:errors],
              warnings: lesson_result[:warnings]
            }
          end
        end
      end

      {
        valid: results.all? { |r| r[:valid] },
        total_files: results.size,
        valid_files: results.count { |r| r[:valid] },
        invalid_files: results.count { |r| !r[:valid] },
        results: results
      }
    end

    private

    def reset_errors
      @errors = []
      @warnings = []
    end

    def add_error(message)
      @errors << message
    end

    def add_warning(message)
      @warnings << message
    end

    def validation_result
      {
        valid: @errors.empty?,
        errors: @errors,
        warnings: @warnings
      }
    end

    def validate_manifest_structure(data, file_path)
      # Validate top-level structure
      unless data.is_a?(Hash)
        add_error("Manifest must be a hash/object")
        return
      end

      # Validate course section
      unless data['course']
        add_error("Missing required 'course' section")
        return
      end

      validate_course_metadata(data['course'])

      # Validate modules section
      unless data['modules']
        add_error("Missing required 'modules' section")
        return
      end

      unless data['modules'].is_a?(Array)
        add_error("'modules' must be an array")
        return
      end

      if data['modules'].empty?
        add_warning("No modules defined in manifest")
      end

      data['modules'].each_with_index do |mod, idx|
        validate_module(mod, idx)
      end
    end

    def validate_course_metadata(course)
      # Required fields
      required_fields = %w[slug title]
      required_fields.each do |field|
        unless course[field].present?
          add_error("Course missing required field: #{field}")
        end
      end

      # Validate slug format
      if course['slug'] && !valid_slug?(course['slug'])
        add_error("Invalid slug format: '#{course['slug']}' (use lowercase, hyphens only)")
      end

      # Validate level if present
      if course['level'] && !VALID_LEVELS.include?(course['level'])
        add_error("Invalid level: '#{course['level']}'. Must be one of: #{VALID_LEVELS.join(', ')}")
      end

      # Validate estimated_hours if present
      if course['estimated_hours'] && !course['estimated_hours'].is_a?(Numeric)
        add_warning("estimated_hours should be a number, got: #{course['estimated_hours'].class}")
      end
    end

    def validate_module(mod, index)
      unless mod.is_a?(Hash)
        add_error("Module at index #{index} must be a hash")
        return
      end

      # Required fields
      unless mod['slug'].present?
        add_error("Module at index #{index} missing required field: slug")
      end

      unless mod['title'].present?
        add_error("Module at index #{index} missing required field: title")
      end

      # Validate slug format
      if mod['slug'] && !valid_slug?(mod['slug'])
        add_error("Invalid module slug format: '#{mod['slug']}'")
      end

      # Validate lessons array (microlesson slugs)
      if mod['lessons']
        unless mod['lessons'].is_a?(Array)
          add_error("Module '#{mod['slug']}' lessons must be an array")
        else
          mod['lessons'].each do |lesson_slug|
            unless lesson_slug.is_a?(String) && valid_slug?(lesson_slug)
              add_error("Invalid lesson slug in module '#{mod['slug']}': '#{lesson_slug}'")
            end
          end
        end
      else
        add_warning("Module '#{mod['slug']}' has no lessons defined")
      end

      # Validate course_lessons array (full lesson definitions)
      if mod['course_lessons']
        unless mod['course_lessons'].is_a?(Array)
          add_error("Module '#{mod['slug']}' course_lessons must be an array")
        else
          mod['course_lessons'].each_with_index do |lesson, idx|
            validate_course_lesson(lesson, idx, mod['slug'])
          end
        end
      end

      # Validate labs array
      if mod['labs']
        unless mod['labs'].is_a?(Array)
          add_error("Module '#{mod['slug']}' labs must be an array")
        else
          mod['labs'].each_with_index do |lab, idx|
            validate_lab(lab, idx, mod['slug'])
          end
        end
      end

      # Validate quizzes array
      if mod['quizzes']
        unless mod['quizzes'].is_a?(Array)
          add_error("Module '#{mod['slug']}' quizzes must be an array")
        else
          mod['quizzes'].each_with_index do |quiz, idx|
            validate_quiz(quiz, idx, mod['slug'])
          end
        end
      end
    end

    def validate_course_lesson(lesson, index, module_slug)
      unless lesson.is_a?(Hash)
        add_error("Course lesson at index #{index} in module '#{module_slug}' must be a hash")
        return
      end

      # Required fields
      unless lesson['title'].present?
        add_error("Course lesson at index #{index} in module '#{module_slug}' missing title")
      end

      unless lesson['content'].present?
        add_warning("Course lesson at index #{index} in module '#{module_slug}' has no content")
      end

      # Optional fields validation
      if lesson['reading_time_minutes'] && !lesson['reading_time_minutes'].is_a?(Numeric)
        add_error("Course lesson reading_time_minutes must be a number")
      end

      if lesson['video_url'] && !lesson['video_url'].match?(/\Ahttps?:\/\//)
        add_warning("Course lesson video_url should start with http:// or https://")
      end
    end

    def validate_lab(lab, index, module_slug)
      unless lab.is_a?(Hash)
        add_error("Lab at index #{index} in module '#{module_slug}' must be a hash")
        return
      end

      # Required fields
      required_fields = %w[slug title difficulty lab_type lab_format estimated_minutes]
      required_fields.each do |field|
        unless lab[field].present?
          add_error("Lab at index #{index} in module '#{module_slug}' missing required field: #{field}")
        end
      end

      # Validate difficulty
      if lab['difficulty'] && !VALID_DIFFICULTIES.include?(lab['difficulty'])
        add_error("Lab difficulty must be one of: #{VALID_DIFFICULTIES.join(', ')}")
      end

      # Validate lab_type
      if lab['lab_type'] && !VALID_LAB_TYPES.include?(lab['lab_type'])
        add_error("Lab type must be one of: #{VALID_LAB_TYPES.join(', ')}")
      end

      # Validate lab_format
      if lab['lab_format'] && !VALID_LAB_FORMATS.include?(lab['lab_format'])
        add_error("Lab format must be one of: #{VALID_LAB_FORMATS.join(', ')}")
      end

      # Code editor specific validations
      if %w[code_editor hybrid].include?(lab['lab_format'])
        unless lab['programming_language'].present?
          add_error("Lab at index #{index} requires programming_language for code_editor format")
        end

        unless lab['starter_code'].present?
          add_warning("Lab at index #{index} has no starter_code")
        end

        if lab['programming_language'] && !VALID_PROGRAMMING_LANGUAGES.include?(lab['programming_language'])
          add_error("Programming language must be one of: #{VALID_PROGRAMMING_LANGUAGES.join(', ')}")
        end
      end

      # Validate task structure
      if lab['tasks']
        unless lab['tasks'].is_a?(Array)
          add_error("Lab tasks must be an array")
        else
          lab['tasks'].each_with_index do |task, task_idx|
            validate_lab_task(task, task_idx)
          end
        end
      end
    end

    def validate_lab_task(task, index)
      unless task.is_a?(Hash)
        add_error("Lab task at index #{index} must be a hash")
        return
      end

      unless task['instruction'].present?
        add_error("Lab task at index #{index} missing instruction")
      end

      # Optional but recommended
      unless task['validation'].present?
        add_warning("Lab task at index #{index} has no validation command")
      end
    end

    def validate_quiz(quiz, index, module_slug)
      unless quiz.is_a?(Hash)
        add_error("Quiz at index #{index} in module '#{module_slug}' must be a hash")
        return
      end

      # Required fields
      unless quiz['title'].present?
        add_error("Quiz at index #{index} in module '#{module_slug}' missing title")
      end

      unless quiz.key?('passing_score')
        add_warning("Quiz at index #{index} has no passing_score (will default to 70)")
      elsif quiz['passing_score'] < 0 || quiz['passing_score'] > 100
        add_error("Quiz passing_score must be between 0 and 100")
      end

      # Validate quiz_type if present
      if quiz['quiz_type'] && !VALID_QUIZ_TYPES.include?(quiz['quiz_type'])
        add_error("Quiz type must be one of: #{VALID_QUIZ_TYPES.join(', ')}")
      end

      # Validate questions
      if quiz['questions']
        unless quiz['questions'].is_a?(Array)
          add_error("Quiz questions must be an array")
        else
          if quiz['questions'].empty?
            add_error("Quiz must have at least one question")
          else
            quiz['questions'].each_with_index do |question, q_idx|
              validate_quiz_question(question, q_idx)
            end
          end
        end
      else
        add_error("Quiz at index #{index} has no questions")
      end
    end

    def validate_quiz_question(question, index)
      unless question.is_a?(Hash)
        add_error("Quiz question at index #{index} must be a hash")
        return
      end

      # Required fields
      unless question['type'].present?
        add_error("Quiz question at index #{index} missing type")
      end

      unless question['question'].present?
        add_error("Quiz question at index #{index} missing question text")
      end

      # Type-specific validation
      case question['type']
      when 'mcq', 'multiple_choice'
        validate_mcq_quiz_question(question, index)
      when 'true_false'
        validate_true_false_question(question, index)
      when 'command'
        validate_command_question(question, index)
      end
    end

    def validate_mcq_quiz_question(question, index)
      unless question['options'].is_a?(Array) && question['options'].size >= 2
        add_error("MCQ question at index #{index} must have at least 2 options")
      end

      unless question.key?('correct')
        add_error("MCQ question at index #{index} missing correct answer index")
      elsif !question['correct'].is_a?(Numeric)
        add_error("MCQ correct answer must be a number (index)")
      elsif question['options']
        max_index = question['options'].size - 1
        if question['correct'] < 0 || question['correct'] > max_index
          add_error("MCQ correct answer index out of range (0-#{max_index})")
        end
      end
    end

    def validate_true_false_question(question, index)
      unless [true, false].include?(question['correct'])
        add_error("True/false question at index #{index} correct answer must be true or false")
      end
    end

    def validate_command_question(question, index)
      unless question['expected_output'].present?
        add_warning("Command question at index #{index} has no expected_output for validation")
      end
    end

    def validate_microlesson_structure(data, file_path)
      unless data.is_a?(Hash)
        add_error("Microlesson must be a hash/object")
        return
      end

      # Required fields
      required_fields = %w[slug title]
      required_fields.each do |field|
        unless data[field].present?
          add_error("Microlesson missing required field: #{field}")
        end
      end

      # Validate slug
      if data['slug'] && !valid_slug?(data['slug'])
        add_error("Invalid slug format: '#{data['slug']}'")
      end

      # Validate difficulty
      if data['difficulty'] && !VALID_DIFFICULTIES.include?(data['difficulty'])
        add_error("Invalid difficulty: '#{data['difficulty']}'. Must be one of: #{VALID_DIFFICULTIES.join(', ')}")
      end

      # Validate estimated_minutes
      if data['estimated_minutes']
        unless data['estimated_minutes'].is_a?(Numeric) && data['estimated_minutes'] > 0
          add_error("estimated_minutes must be a positive number")
        end
      end

      # Validate sequence_order
      if data['sequence_order']
        unless data['sequence_order'].is_a?(Numeric)
          add_error("sequence_order must be a number")
        end
      end

      # Validate content_md
      unless data['content_md'].present?
        add_warning("Microlesson has no content_md")
      end

      # Validate exercises
      if data['exercises']
        unless data['exercises'].is_a?(Array)
          add_error("exercises must be an array")
        else
          data['exercises'].each_with_index do |exercise, idx|
            validate_exercise(exercise, idx)
          end
        end
      end

      # Validate objectives
      if data['objectives'] && !data['objectives'].is_a?(Array)
        add_error("objectives must be an array")
      end

      # Validate key_concepts
      if data['key_concepts'] && !data['key_concepts'].is_a?(Array)
        add_error("key_concepts must be an array")
      end

      # Validate prerequisites
      if data['prerequisites'] && !data['prerequisites'].is_a?(Array)
        add_error("prerequisites must be an array")
      end

      # Validate next_recommended
      if data['next_recommended'] && !data['next_recommended'].is_a?(Array)
        add_error("next_recommended must be an array")
      end
    end

    def validate_exercise(exercise, index)
      unless exercise.is_a?(Hash)
        add_error("Exercise at index #{index} must be a hash")
        return
      end

      # Required field: type
      unless exercise['type'].present?
        add_error("Exercise at index #{index} missing required field: type")
        return
      end

      # Validate type
      unless VALID_EXERCISE_TYPES.include?(exercise['type'])
        add_error("Exercise at index #{index} has invalid type: '#{exercise['type']}'. Must be one of: #{VALID_EXERCISE_TYPES.join(', ')}")
      end

      # Type-specific validation
      case exercise['type']
      when 'terminal'
        validate_terminal_exercise(exercise, index)
      when 'mcq'
        validate_mcq_exercise(exercise, index)
      when 'short_answer'
        validate_short_answer_exercise(exercise, index)
      when 'coding'
        validate_coding_exercise(exercise, index)
      when 'sql'
        validate_sql_exercise(exercise, index)
      when 'reflection', 'checkpoint'
        validate_text_exercise(exercise, index)
      end

      # Validate sequence_order
      if exercise['sequence_order'] && !exercise['sequence_order'].is_a?(Numeric)
        add_error("Exercise at index #{index} sequence_order must be a number")
      end

      # Validate require_pass
      if exercise.key?('require_pass') && ![true, false].include?(exercise['require_pass'])
        add_warning("Exercise at index #{index} require_pass should be boolean (true/false)")
      end
    end

    def validate_terminal_exercise(exercise, index)
      unless exercise['command'].present?
        add_error("Terminal exercise at index #{index} missing required field: command")
      end

      if exercise['timeout_sec'] && !exercise['timeout_sec'].is_a?(Numeric)
        add_error("Terminal exercise at index #{index} timeout_sec must be a number")
      end
    end

    def validate_mcq_exercise(exercise, index)
      unless exercise['question'].present?
        add_error("MCQ exercise at index #{index} missing required field: question")
      end

      unless exercise['options'].is_a?(Array)
        add_error("MCQ exercise at index #{index} missing or invalid field: options (must be array)")
      else
        if exercise['options'].empty?
          add_error("MCQ exercise at index #{index} must have at least one option")
        end
      end

      unless exercise.key?('correct_answer_index')
        add_error("MCQ exercise at index #{index} missing required field: correct_answer_index")
      else
        unless exercise['correct_answer_index'].is_a?(Numeric)
          add_error("MCQ exercise at index #{index} correct_answer_index must be a number")
        else
          max_index = exercise['options']&.length.to_i - 1
          if exercise['correct_answer_index'] < 0 || exercise['correct_answer_index'] > max_index
            add_error("MCQ exercise at index #{index} correct_answer_index out of range (0-#{max_index})")
          end
        end
      end
    end

    def validate_short_answer_exercise(exercise, index)
      unless exercise['question'].present?
        add_error("Short answer exercise at index #{index} missing required field: question")
      end
    end

    def validate_coding_exercise(exercise, index)
      unless exercise['question'].present?
        add_error("Coding exercise at index #{index} missing required field: question")
      end

      if exercise['starter_code'].blank?
        add_warning("Coding exercise at index #{index} has no starter_code")
      end
    end

    def validate_sql_exercise(exercise, index)
      unless exercise['question'].present?
        add_error("SQL exercise at index #{index} missing required field: question")
      end
    end

    def validate_text_exercise(exercise, index)
      unless exercise['prompt'].present?
        add_error("#{exercise['type'].capitalize} exercise at index #{index} missing required field: prompt")
      end

      unless exercise['slug'].present?
        add_error("#{exercise['type'].capitalize} exercise at index #{index} missing required field: slug")
      end
    end

    def valid_slug?(slug)
      slug.is_a?(String) && slug.match?(/\A[a-z0-9]+(-[a-z0-9]+)*\z/)
    end
  end
end
