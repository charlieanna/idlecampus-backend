# frozen_string_literal: true
#
# ⚠️  DEPRECATED: This controller uses database queries for courses!
#
# IMPORTANT: Courses should ONLY be fetched from YAML files using CourseFileReaderService.
# This controller currently queries the Course database model with certification_track filter,
# which is INCORRECT.
#
# TODO: Refactor to use CourseFileReaderService instead of database queries.
# See app/controllers/api/v1/courses_controller.rb for correct implementation.
#
module Api
  module V1
    module Security
      class SecurityCoursesController < ApplicationController
        # Disable auth and CSRF for public API access
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        # GET /api/v1/security/courses
        def index
          courses = Course.where(certification_track: 'security')
                          .includes(course_modules: [:module_items])
                          .ordered

          render json: {
            courses: courses.map { |course| course_summary(course) }
          }
        end

        # GET /api/v1/security/courses/:slug
        def show
          course = Course.find_by!(slug: params[:id])

          render json: {
            course: course_detail(course)
          }
        end

        # GET /api/v1/security/courses/:course_slug/modules
        def modules
          course = Course.find_by!(slug: params[:course_id])
          course_modules = course.course_modules
                                 .includes(module_items: [:item])
                                 .ordered

          render json: {
            modules: course_modules.map { |mod| module_summary(mod) }
          }
        end

        # GET /api/v1/security/courses/:course_slug/modules/:module_slug
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          course_module = course.course_modules.find_by!(slug: params[:id])

          render json: {
            module: module_detail(course_module)
          }
        end

        # GET /api/v1/security/labs
        def labs
          labs = HandsOnLab.all.order(:id)

          render json: {
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/security/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])

          render json: {
            lab: lab_detail(lab)
          }
        end

        private

        def lab_summary(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes
          }
        end

        def lab_detail(lab)
          lab_summary(lab).merge({
            objectives: parse_json_or_array(lab.objectives),
            prerequisites: parse_json_or_array(lab.prerequisites),
            steps: parse_json_or_array(lab.steps),
            validation_commands: parse_json_or_array(lab.validation_commands),
            hints: parse_json_or_array(lab.hints),
            solution: lab.solution
          })
        end

        def course_summary(course)
          {
            id: course.id,
            slug: course.slug,
            title: course.title,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: (course.estimated_duration.to_f / 60.0).round(1),
            certification_track: course.certification_track,
            module_count: course.course_modules.count,
            published: course.published
          }
        end

        def course_detail(course)
          {
            id: course.id,
            slug: course.slug,
            title: course.title,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: (course.estimated_duration.to_f / 60.0).round(1),
            certification_track: course.certification_track,
            learning_objectives: parse_json_or_array(course.learning_objectives),
            prerequisites: parse_json_or_array(course.prerequisites),
            modules: course.course_modules.ordered.map { |mod| module_summary(mod) }
          }
        end

        def module_summary(course_module)
          {
            id: course_module.id,
            slug: course_module.slug,
            title: course_module.title,
            description: course_module.description,
            sequence_order: course_module.sequence_order,
            estimated_minutes: course_module.estimated_minutes,
            published: course_module.published,
            item_count: course_module.module_items.count,
            lessons: lessons_for_module(course_module),
            labs: labs_for_module(course_module),
            quizzes: quizzes_for_module(course_module)
          }
        end

        def module_detail(course_module)
          module_summary(course_module).merge({
            learning_objectives: parse_json_or_array(course_module.learning_objectives)
          })
        end

        def lessons_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'CourseLesson')
                      .includes(:item)
                      .ordered
                      .map do |module_item|
            lesson = module_item.item
            {
              id: lesson.id,
              title: lesson.title,
              content: lesson.content,
              contentType: 'lesson',
              sequence_order: module_item.sequence_order,
              reading_time_minutes: lesson.reading_time_minutes,
              video_url: lesson.video_url,
              key_concepts: parse_json_or_array(lesson.key_concepts)
            }
          end
        end

        def labs_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'HandsOnLab')
                      .includes(:item)
                      .ordered
                      .map do |module_item|
            lab = module_item.item
            {
              id: lab.id,
              title: lab.title,
              description: lab.description,
              contentType: 'lab',
              difficulty: lab.difficulty,
              estimated_minutes: lab.estimated_minutes,
              sequence_order: module_item.sequence_order,
              objectives: parse_json_or_array(lab.objectives),
              prerequisites: parse_json_or_array(lab.prerequisites),
              steps: parse_json_or_array(lab.steps),
              hints: parse_json_or_array(lab.hints),
              solution: lab.solution
            }
          end
        end

        def quizzes_for_module(course_module)
          course_module.module_items
                      .where(item_type: 'Quiz')
                      .includes(item: :quiz_questions)
                      .ordered
                      .map do |module_item|
            quiz = module_item.item
            {
              id: quiz.id,
              title: quiz.title,
              description: quiz.description,
              contentType: 'quiz',
              sequence_order: module_item.sequence_order,
              time_limit_minutes: quiz.time_limit_minutes,
              passing_score: quiz.passing_score,
              questions: quiz.quiz_questions.ordered.map { |q| question_summary(q) }
            }
          end
        end

        def question_summary(question)
          base = {
            id: question.id,
            type: question.question_type,
            question: question.question_text,
            points: question.points,
            difficulty: question.difficulty_level,
            explanation: question.explanation
          }

          case question.question_type
          when 'mcq'
            base.merge({
              options: parse_json_or_array(question.options),
              correct_answer: question.options.is_a?(String) ?
                JSON.parse(question.options).find_index { |opt| opt['correct'] } : nil
            })
          when 'command', 'fill_blank'
            base.merge({
              correct_answer: question.correct_answer
            })
          when 'true_false'
            base.merge({
              correct_answer: question.correct_answer
            })
          else
            base
          end
        end

        def parse_json_or_array(value)
          return [] if value.nil?
          return value if value.is_a?(Array)

          begin
            JSON.parse(value)
          rescue JSON::ParserError
            []
          end
        end

        def set_default_format
          request.format = :json unless params[:format]
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
        end

        def cors_preflight
          head :ok
        end
      end
    end
  end
end
