module Api
  module V1
    module Coding
      class CodingCoursesController < ApplicationController
        # Public JSON API
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        def set_default_format
          request.format = :json unless params[:format]
        end

        def index
          # Surface key coding courses for the frontend. We include Coding Interview and Go Fundamentals if present.
          slugs = ['coding-interview-mastery', 'golang-fundamentals']
          courses = slugs.map { |s| find_course(s, auto_seed: true) || Course.find_by(slug: s) }.compact

          render json: {
            courses: courses.map { |course|
              {
                id: course.id,
                title: course.title,
                slug: course.slug,
                description: course.description,
                difficulty_level: course.difficulty_level,
                estimated_hours: course.estimated_hours,
                learning_objectives: course.learning_objectives,
                modules_count: course.course_modules.published.count,
                created_at: course.created_at,
                updated_at: course.updated_at
              }
            }
          }
        end

        def show
          course = find_course(params[:id], auto_seed: true)
          raise ActiveRecord::RecordNotFound unless course

          render json: {
            course: {
              id: course.id,
              title: course.title,
              slug: course.slug,
              description: course.description,
              difficulty_level: course.difficulty_level,
              estimated_hours: course.estimated_hours,
              learning_objectives: course.learning_objectives,
              modules: course.course_modules.published.order(:sequence_order).map { |mod|
                {
                  id: mod.id,
                  title: mod.title,
                  slug: mod.slug,
                  description: mod.description,
                  sequence_order: mod.sequence_order,
                  estimated_minutes: mod.estimated_minutes,
                  items_count: mod.module_items.count
                }
              }
            }
          }
        end

        def modules
          course = find_course(params[:course_id], auto_seed: true)
          raise ActiveRecord::RecordNotFound unless course
          modules = course.course_modules.published.order(:sequence_order)

          render json: {
            modules: modules.map { |mod|
              items = []

              # ModuleItems (lessons/quizzes/labs)
              items += mod.module_items.order(:sequence_order).map { |item| serialize_module_item(item) }

              # InteractiveLearningUnits
              items += mod.module_interactive_units.includes(:interactive_learning_unit).order(:sequence_order).map do |miu|
                serialize_interactive_unit(miu)
              end

              {
                id: mod.id,
                title: mod.title,
                slug: mod.slug,
                description: mod.description,
                sequence_order: mod.sequence_order,
                estimated_minutes: mod.estimated_minutes,
                items: items.sort_by { |it| it[:sequence_order] || 0 }
              }
            }
          }
        end

        def module_show
          course = find_course(params[:course_id], auto_seed: true)
          raise ActiveRecord::RecordNotFound unless course
          course_module = course.course_modules.find_by!(slug: params[:id])

          render json: {
            module: {
              id: course_module.id,
              title: course_module.title,
              slug: course_module.slug,
              description: course_module.description,
              sequence_order: course_module.sequence_order,
              estimated_minutes: course_module.estimated_minutes,
              items: (
                course_module.module_items.order(:sequence_order).map { |item| serialize_module_item(item) } +
                course_module.module_interactive_units.includes(:interactive_learning_unit).order(:sequence_order).map { |miu| serialize_interactive_unit(miu) }
              ).sort_by { |it| it[:sequence_order] || 0 }
            }
          }
        end

        def cors_preflight
          set_cors_headers
          head :ok
        end

        private

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD'
          headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
          headers['Access-Control-Max-Age'] = '86400'
        end

        def find_course(slug, auto_seed: false)
          return nil if slug.blank?

          Course.find_by(slug: slug) || (auto_seed && seed_course_if_missing(slug))
        end

        def seed_course_if_missing(slug)
          return nil unless Rails.env.development?

          seed_map = {
            'coding-interview-mastery' => ['coding_interview_course.rb'],
            'golang-fundamentals' => ['golang_course_enhanced.rb', 'golang_concurrency_units.rb']
          }
          files = seed_map[slug]
          return nil unless files

          Rails.logger.info("[CodingCoursesController] Auto-seeding #{slug} from: #{files.join(', ')}")

          ActiveRecord::Base.transaction do
            files.each do |fname|
              seed_file = Rails.root.join('db', 'seeds', fname)
              next unless seed_file.exist?
              load seed_file
            end
          end

          Course.find_by(slug: slug)
        rescue => e
          Rails.logger.error("Failed to auto-seed #{slug}: #{e.class} - #{e.message}")
          nil
        end

        def serialize_module_item(item)
          base = {
            id: item.item_id,
            module_item_id: item.id,
            sequence_order: item.sequence_order,
            item_type: item.item_type,
            required: item.required
          }

          case item.item_type
          when 'CourseLesson'
            lesson = item.item
            base.merge!(
              lesson_id: lesson.id,
              title: lesson.title,
              content: lesson.content,
              reading_time_minutes: lesson.reading_time_minutes,
              key_concepts: lesson.key_concepts
            )
          when 'Quiz'
            quiz = item.item
            base.merge!(
              quiz_id: quiz.id,
              title: quiz.title,
              description: quiz.description,
              time_limit_minutes: quiz.time_limit_minutes,
              passing_score: quiz.passing_score,
              quiz_type: quiz.quiz_type,
              max_attempts: quiz.max_attempts,
              questions: quiz.quiz_questions.order(:sequence_order).map { |q|
                {
                  id: q.id,
                  question_text: q.question_text,
                  question_type: q.question_type,
                  options: q.options,
                  points: q.points,
                  difficulty: q.difficulty,
                  discrimination: q.discrimination,
                  skill_dimension: q.skill_dimension,
                  topic: q.topic
                }
              }
            )
          when 'HandsOnLab'
            lab = item.item
            base.merge!(
              lab_id: lab.id,
              title: lab.title,
              description: lab.description,
              lab_type: lab.lab_type,
              lab_format: lab.lab_format,
              programming_language: lab.programming_language,
              difficulty: lab.difficulty,
              starter_code: lab.starter_code,
              solution_code: lab.solution_code,
              test_cases: lab.test_cases,
              allowed_imports: lab.allowed_imports,
              steps: lab.steps,
              hints: lab.hints,
              estimated_minutes: lab.estimated_minutes,
              points_reward: lab.points_reward,
              learning_objectives: lab.learning_objectives,
              prerequisites: lab.prerequisites,
              max_attempts: lab.max_attempts,
              time_limit_seconds: lab.time_limit_seconds,
              memory_limit_mb: lab.memory_limit_mb
            )
          end

          base
        end

        def serialize_interactive_unit(miu)
          unit = miu.interactive_learning_unit
          {
            id: unit.id,
            module_interactive_unit_id: miu.id,
            sequence_order: miu.sequence_order,
            item_type: 'InteractiveLearningUnit',
            required: miu.required,
            title: unit.title,
            slug: unit.slug,
            content: unit.concept_explanation || unit.scenario_narrative,
            estimated_minutes: unit.estimated_minutes,
            difficulty: unit.difficulty_level,
            command_to_learn: unit.command_to_learn,
            practice_hints: unit.practice_hints,
            concept_tags: unit.concept_tags,
            quiz: (unit.quiz_question_text.present? ? {
              question: unit.quiz_question_text,
              type: unit.quiz_question_type,
              options: unit.quiz_options,
              correct_answer: unit.quiz_correct_answer,
              explanation: unit.quiz_explanation
            } : nil)
          }
        end
      end
    end
  end
end
