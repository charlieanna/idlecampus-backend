# Unified Courses Controller
# Consolidates common logic from 13+ specialized course controllers
# Supports plugin hooks for course-specific behavior
# Used as base class or standalone for all courses

module Api
  module V1
    class UnifiedCoursesController < ApplicationController
      before_action :set_course, only: [:show, :modules, :module_details, :config]
      before_action :authenticate_user!, except: [:show, :modules, :config]

      # GET /api/v1/courses/:course_slug
      # Get course details
      def show
        course_data = serialize_course(@course)

        # Execute plugin hooks
        execute_plugin_hook(:on_course_show, @course, course_data)

        render json: {
          success: true,
          course: course_data
        }
      end

      # GET /api/v1/courses/:course_slug/modules
      # Get all modules for a course
      def modules
        modules_data = @course.course_modules
                              .includes(:module_items)
                              .order(:sequence_order)
                              .map { |mod| serialize_module(mod) }

        # Execute plugin hooks
        execute_plugin_hook(:on_modules_list, @course, modules_data)

        render json: {
          success: true,
          modules: modules_data,
          total_modules: modules_data.size
        }
      end

      # GET /api/v1/courses/:course_slug/modules/:module_slug
      # Get specific module with all items
      def module_details
        course_module = @course.course_modules.find_by!(slug: params[:module_slug])

        module_data = serialize_module_with_items(course_module)

        # Execute plugin hooks
        execute_plugin_hook(:on_module_show, @course, course_module, module_data)

        render json: {
          success: true,
          module: module_data
        }
      end

      # GET /api/v1/courses/:course_slug/config
      # Get course configuration (lab format, plugins, theme, features)
      def config
        config_data = {
          slug: @course.slug,
          title: @course.title,
          lab_format: determine_lab_format(@course),
          plugins: extract_plugins(@course),
          theme: extract_theme(@course),
          features: extract_features(@course),
          custom_config: @course.course_config || {}
        }

        # Execute plugin hooks
        execute_plugin_hook(:on_config_request, @course, config_data)

        render json: {
          success: true,
          config: config_data
        }
      end

      # POST /api/v1/courses/:course_slug/lessons/:lesson_id/complete
      # Mark lesson as completed
      def complete_lesson
        lesson = CourseLesson.find(params[:lesson_id])

        completion = LessonCompletion.find_or_create_by(
          user: current_user,
          course_lesson: lesson
        )

        completion.update!(
          completed: true,
          completed_at: Time.current
        )

        render json: {
          success: true,
          message: "Lesson marked as complete"
        }
      end

      # POST /api/v1/courses/:course_slug/quizzes/:quiz_id/submit
      # Submit quiz answers
      def submit_quiz
        quiz = Quiz.find(params[:quiz_id])
        answers = params[:answers] || {}

        # Calculate score
        score = calculate_quiz_score(quiz, answers)
        passed = score >= quiz.passing_score

        # Save attempt
        attempt = QuizAttempt.create!(
          user: current_user,
          quiz: quiz,
          answers: answers,
          score: score,
          passed: passed,
          submitted_at: Time.current
        )

        render json: {
          success: true,
          score: score,
          passing_score: quiz.passing_score,
          passed: passed,
          attempt_id: attempt.id
        }
      end

      # POST /api/v1/courses/:course_slug/labs/:lab_id/execute
      # Execute lab command/code
      def execute_lab
        lab = HandsOnLab.find(params[:lab_id])
        user_input = params[:input]
        step_index = params[:step_index]&.to_i || 0

        # Get executor class for lab format
        executor_class = LabExecutor::BaseExecutor.for_format(lab.lab_format)

        # Instantiate executor with lab and user
        executor = executor_class.new(lab, user: current_user)

        # Execute with user input
        result = executor.execute(user_input, step_index: step_index)

        render json: {
          success: result[:success],
          output: result[:output],
          error: result[:error],
          validation: result[:validation]
        }
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: "Lab not found"
        }, status: :not_found
      rescue => e
        Rails.logger.error "Lab execution error: #{e.message}"
        render json: {
          success: false,
          error: "Execution failed: #{e.message}"
        }, status: :internal_server_error
      end

      private

      def set_course
        @course = Course.find_by!(slug: params[:course_slug] || params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: "Course not found: #{params[:course_slug] || params[:id]}"
        }, status: :not_found
      end

      # Serialize course for JSON response
      def serialize_course(course)
        {
          id: course.id,
          slug: course.slug,
          title: course.title,
          description: course.description,
          difficulty_level: course.difficulty_level,
          estimated_hours: course.estimated_hours,
          certification_track: course.certification_track,
          published: course.published,
          created_at: course.created_at,
          updated_at: course.updated_at,
          modules_count: course.course_modules.count
        }
      end

      # Serialize module for JSON response
      def serialize_module(course_module)
        {
          id: course_module.id,
          slug: course_module.slug,
          title: course_module.title,
          description: course_module.description,
          sequence_order: course_module.sequence_order,
          estimated_minutes: course_module.estimated_minutes,
          learning_objectives: course_module.learning_objectives,
          items_count: course_module.module_items.count
        }
      end

      # Serialize module with all items
      def serialize_module_with_items(course_module)
        module_data = serialize_module(course_module)

        items = course_module.module_items
                            .includes(:item)
                            .order(:sequence_order)
                            .map { |module_item| serialize_module_item(module_item) }

        module_data.merge(items: items)
      end

      # Serialize module item (polymorphic)
      def serialize_module_item(module_item)
        item = module_item.item
        base_data = {
          id: module_item.id,
          type: module_item.item_type,
          sequence_order: module_item.sequence_order
        }

        case module_item.item_type
        when 'CourseLesson'
          base_data.merge(serialize_lesson(item))
        when 'Quiz'
          base_data.merge(serialize_quiz(item))
        when 'HandsOnLab'
          base_data.merge(serialize_lab(item))
        when 'InteractiveLearningUnit'
          base_data.merge(serialize_interactive_unit(item))
        else
          base_data
        end
      end

      def serialize_lesson(lesson)
        {
          lesson_id: lesson.id,
          title: lesson.title,
          content: lesson.content,
          reading_time_minutes: lesson.reading_time_minutes,
          key_concepts: lesson.key_concepts,
          key_commands: lesson.key_commands
        }
      end

      def serialize_quiz(quiz)
        {
          quiz_id: quiz.id,
          title: quiz.title,
          description: quiz.description,
          passing_score: quiz.passing_score,
          time_limit_minutes: quiz.time_limit_minutes,
          max_attempts: quiz.max_attempts,
          questions: quiz.questions
        }
      end

      def serialize_lab(lab)
        {
          lab_id: lab.id,
          title: lab.title,
          description: lab.description,
          lab_type: lab.lab_type,
          lab_format: lab.lab_format,
          difficulty: lab.difficulty,
          estimated_minutes: lab.estimated_minutes,
          steps: lab.steps,
          starter_code: lab.starter_code,
          solution_code: lab.solution_code,
          test_cases: lab.test_cases
        }
      end

      def serialize_interactive_unit(unit)
        {
          unit_id: unit.id,
          title: unit.title,
          content: unit.content,
          command: unit.command,
          expected_output: unit.expected_output,
          hints: unit.hints
        }
      end

      # Determine lab format for course (terminal, code_editor, sql_editor, hybrid)
      def determine_lab_format(course)
        # Check course config first
        return course.course_config['lab_format'] if course.course_config&.dig('lab_format')

        # Infer from first lab in course
        first_lab = course.course_modules
                          .joins(:module_items)
                          .merge(ModuleItem.where(item_type: 'HandsOnLab'))
                          .first
                          &.module_items
                          &.find_by(item_type: 'HandsOnLab')
                          &.item

        first_lab&.lab_format || 'terminal'
      end

      # Extract plugins from course config
      def extract_plugins(course)
        return [] unless course.course_config
        course.course_config['plugins'] || []
      end

      # Extract theme from course config
      def extract_theme(course)
        return 'default' unless course.course_config
        course.course_config.dig('custom_config', 'theme') || 'default'
      end

      # Extract features from course config
      def extract_features(course)
        return {} unless course.course_config
        course.course_config['custom_config'] || {}
      end

      # Execute plugin hooks for this course
      def execute_plugin_hook(hook_name, *args)
        return unless @course.respond_to?(:course_config) && @course.course_config

        begin
          require 'course_builder/plugins/plugin_registry'
          CourseBuilder::Plugins::PluginRegistry.instance.execute_hook(@course, hook_name, *args)
        rescue => e
          Rails.logger.error "Plugin hook error (#{hook_name}): #{e.message}"
        end
      end

      # Calculate quiz score
      def calculate_quiz_score(quiz, user_answers)
        return 0 unless quiz.questions.is_a?(Array)

        total_points = 0
        earned_points = 0

        quiz.questions.each_with_index do |question, index|
          points = question['points']&.to_i || 10
          total_points += points

          user_answer = user_answers[index.to_s] || user_answers[index]
          correct_answer = question['correct_answer']

          if user_answer.to_s.strip == correct_answer.to_s.strip
            earned_points += points
          end
        end

        return 0 if total_points == 0
        (earned_points.to_f / total_points * 100).round(2)
      end
    end
  end
end
