# API endpoint for importing courses from JSON/YAML definitions
# POST /api/v1/course_imports
#
# Accepts a course definition and creates the full course hierarchy:
# - Course
# - Modules
# - Items (Lessons, Quizzes, Labs, Interactive Units)
#
# Request body format:
# {
#   "course": {
#     "title": "Course Title",
#     "slug": "course-slug",
#     "description": "...",
#     "difficulty_level": "beginner",
#     ...
#   },
#   "modules": [
#     {
#       "title": "Module 1",
#       "items": [
#         { "type": "lesson", "title": "...", "content": "..." },
#         { "type": "quiz", "title": "...", "questions": [...] },
#         { "type": "lab", "title": "...", "steps": [...] }
#       ]
#     }
#   ]
# }

module Api
  module V1
    class CourseImportsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:create]

      def create
        import_data = course_import_params

        # Validate required fields
        unless import_data[:course] && import_data[:modules]
          return render json: {
            success: false,
            error: "Missing required fields: course and modules"
          }, status: :unprocessable_entity
        end

        result = import_course(import_data)

        if result[:success]
          render json: {
            success: true,
            message: "Course imported successfully",
            course: course_summary(result[:course]),
            stats: {
              modules: result[:modules].length,
              total_items: result[:modules].sum { |m| m.module_items.count }
            }
          }, status: :created
        else
          render json: {
            success: false,
            error: result[:error],
            details: result[:details]
          }, status: :unprocessable_entity
        end
      rescue => e
        render json: {
          success: false,
          error: "Import failed: #{e.message}",
          backtrace: Rails.env.development? ? e.backtrace.first(5) : nil
        }, status: :internal_server_error
      end

      private

      def course_import_params
        params.permit(
          course: [
            :title, :slug, :description, :difficulty_level, :estimated_hours,
            :certification_track, :published, :sequence_order,
            learning_objectives: [], prerequisites: []
          ],
          modules: [
            :title, :slug, :description, :sequence_order, :estimated_minutes, :published,
            learning_objectives: [],
            items: [
              :type, :title, :content, :description, :reading_time_minutes,
              :passing_score, :time_limit_minutes, :max_attempts, :quiz_type,
              :difficulty, :estimated_minutes, :lab_type, :lab_format, :category,
              :programming_language, :starter_code, :solution_code,
              :time_limit_seconds, :memory_limit_mb, :schema_setup, :sample_data,
              :environment_image, :points_reward,
              key_concepts: [], key_commands: [], required_tools: [],
              prerequisites: [], learning_objectives: [],
              questions: [:question_type, :question_text, :correct_answer, :explanation, :points, :difficulty_level, options: []],
              steps: [:step_number, :title, :instruction, :expected_command, :validation, :hint],
              test_cases: [:description, :input, :expected_output, :hidden, :points],
              validation_rules: {}
            ]
          ]
        ).to_h.deep_symbolize_keys
      end

      def import_course(data)
        ActiveRecord::Base.transaction do
          course = create_course(data[:course])
          modules = data[:modules].map { |mod_data| create_module(mod_data, course) }

          {
            success: true,
            course: course,
            modules: modules
          }
        end
      rescue => e
        {
          success: false,
          error: e.message,
          details: e.backtrace&.first(5)
        }
      end

      def create_course(course_data)
        # Handle JSON arrays
        attrs = course_data.dup
        attrs[:learning_objectives] = attrs[:learning_objectives].to_json if attrs[:learning_objectives]
        attrs[:prerequisites] = attrs[:prerequisites].to_json if attrs[:prerequisites]

        course = Course.find_or_initialize_by(slug: attrs[:slug])
        course.assign_attributes(attrs)
        course.save!
        course
      end

      def create_module(module_data, course)
        items_data = module_data.delete(:items) || []

        attrs = module_data.dup
        attrs[:learning_objectives] = attrs[:learning_objectives].to_json if attrs[:learning_objectives].is_a?(Array)

        course_module = course.course_modules.find_or_initialize_by(slug: attrs[:slug])
        course_module.assign_attributes(attrs)
        course_module.save!

        # Create items
        items_data.each_with_index do |item_data, idx|
          create_module_item(item_data, course_module, idx + 1)
        end

        course_module
      end

      def create_module_item(item_data, course_module, sequence_order)
        item_type = item_data[:type]&.to_sym

        case item_type
        when :lesson
          item = create_lesson(item_data)
        when :quiz
          item = create_quiz(item_data)
        when :lab
          item = create_lab(item_data)
        when :interactive_unit
          item = create_interactive_unit(item_data)
        else
          raise "Unknown item type: #{item_type}"
        end

        # Create association
        module_item = course_module.module_items.find_or_initialize_by(
          item_type: item.class.name,
          item_id: item.id
        )
        module_item.sequence_order = sequence_order
        module_item.required = true
        module_item.save!

        item
      end

      def create_lesson(data)
        attrs = data.except(:type)
        attrs[:key_concepts] = attrs[:key_concepts].to_json if attrs[:key_concepts].is_a?(Array)
        attrs[:key_commands] = attrs[:key_commands].to_json if attrs[:key_commands].is_a?(Array)

        lesson = CourseLesson.find_or_initialize_by(title: attrs[:title])
        lesson.assign_attributes(attrs)
        lesson.save!
        lesson
      end

      def create_quiz(data)
        questions_data = data.delete(:questions) || []
        attrs = data.except(:type)

        quiz = Quiz.find_or_initialize_by(title: attrs[:title])
        quiz.assign_attributes(attrs)
        quiz.save!

        # Create questions
        questions_data.each_with_index do |q_data, idx|
          q_attrs = q_data.dup
          q_attrs[:options] = q_attrs[:options].to_json if q_attrs[:options].is_a?(Array)

          question = quiz.quiz_questions.find_or_initialize_by(sequence_order: idx + 1)
          question.assign_attributes(q_attrs)
          question.save!
        end

        quiz
      end

      def create_lab(data)
        attrs = data.except(:type)
        attrs[:steps] = attrs[:steps].to_json if attrs[:steps].is_a?(Array)
        attrs[:validation_rules] = attrs[:validation_rules].to_json if attrs[:validation_rules].is_a?(Hash)
        attrs[:test_cases] = attrs[:test_cases].to_json if attrs[:test_cases].is_a?(Array)
        attrs[:required_tools] = attrs[:required_tools].to_json if attrs[:required_tools].is_a?(Array)
        attrs[:prerequisites] = attrs[:prerequisites].to_json if attrs[:prerequisites].is_a?(Array)

        lab = HandsOnLab.find_or_initialize_by(title: attrs[:title])
        lab.assign_attributes(attrs)
        lab.save!
        lab
      end

      def create_interactive_unit(data)
        attrs = data.except(:type)
        attrs[:command_variations] = attrs[:command_variations].to_json if attrs[:command_variations].is_a?(Array)
        attrs[:practice_hints] = attrs[:practice_hints].to_json if attrs[:practice_hints].is_a?(Array)
        attrs[:scenario_steps] = attrs[:scenario_steps].to_json if attrs[:scenario_steps].is_a?(Array)
        attrs[:learning_objectives] = attrs[:learning_objectives].to_json if attrs[:learning_objectives].is_a?(Array)
        attrs[:prerequisites] = attrs[:prerequisites].to_json if attrs[:prerequisites].is_a?(Array)
        attrs[:quiz_options] = attrs[:quiz_options].to_json if attrs[:quiz_options].is_a?(Array)

        unit = InteractiveLearningUnit.find_or_initialize_by(slug: attrs[:slug])
        unit.assign_attributes(attrs)
        unit.save!
        unit
      end

      def course_summary(course)
        {
          id: course.id,
          title: course.title,
          slug: course.slug,
          description: course.description,
          difficulty_level: course.difficulty_level,
          estimated_hours: course.estimated_hours
        }
      end
    end
  end
end
