# frozen_string_literal: true

module Api
  module V1
    module SystemDesign
      class SystemDesignCoursesController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        # GET /api/v1/system_design/courses
        def index
          courses = Course.where("slug LIKE ?", "%system-design%")
                          .includes(course_modules: [:module_items])
                          .ordered

          render json: {
            courses: courses.map { |course| course_summary(course) }
          }
        end

        # GET /api/v1/system_design/courses/:slug
        def show
          course = Course.find_by!(slug: params[:id])

          render json: {
            course: course_detail(course)
          }
        end

        # GET /api/v1/system_design/courses/:course_slug/modules
        def modules
          course = Course.find_by!(slug: params[:course_id])
          modules = course.course_modules.includes(:module_items).ordered

          render json: {
            modules: modules.map { |mod| module_summary(mod) }
          }
        end

        # GET /api/v1/system_design/courses/:course_slug/modules/:id
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          mod = course.course_modules.find(params[:id])

          render json: {
            module: module_detail(mod)
          }
        end

        # GET /api/v1/system_design/labs
        def labs
          labs = HandsOnLab.where(lab_type: 'system-design', is_active: true)

          # Filter by difficulty if provided
          labs = labs.where(difficulty: params[:difficulty]) if params[:difficulty].present?

          render json: {
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/system_design/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])

          render json: {
            lab: lab_detail(lab)
          }
        end

        private

        def set_default_format
          request.format = :json unless params[:format]
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
          headers['Access-Control-Max-Age'] = '3600'
        end

        def cors_preflight
          head :ok
        end

        def course_summary(course)
          {
            id: course.id,
            title: course.title,
            slug: course.slug,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: course.estimated_hours,
            module_count: course.course_modules.count
          }
        end

        def course_detail(course)
          {
            id: course.id,
            title: course.title,
            slug: course.slug,
            description: course.description,
            difficulty_level: course.difficulty_level,
            estimated_hours: course.estimated_hours,
            learning_objectives: JSON.parse(course.learning_objectives || '[]'),
            prerequisites: JSON.parse(course.prerequisites || '[]'),
            modules: course.course_modules.ordered.map { |mod| module_summary(mod) }
          }
        end

        def module_summary(mod)
          {
            id: mod.id,
            title: mod.title,
            slug: mod.slug,
            description: mod.description,
            sequence_order: mod.sequence_order,
            estimated_minutes: mod.estimated_minutes,
            item_count: mod.module_items.count
          }
        end

        def module_detail(mod)
          {
            id: mod.id,
            title: mod.title,
            slug: mod.slug,
            description: mod.description,
            sequence_order: mod.sequence_order,
            estimated_minutes: mod.estimated_minutes,
            learning_objectives: JSON.parse(mod.learning_objectives || '[]'),
            items: mod.module_items.ordered.map { |item| item_summary(item) }
          }
        end

        def item_summary(item)
          {
            id: item.id,
            type: item.item_type,
            sequence_order: item.sequence_order,
            required: item.required,
            content: item_content(item)
          }
        end

        def item_content(item)
          case item.item_type
          when 'CourseLesson'
            {
              id: item.item.id,
              title: item.item.title,
              content: item.item.content,
              reading_time_minutes: item.item.reading_time_minutes
            }
          when 'Quiz'
            {
              id: item.item.id,
              title: item.item.title,
              description: item.item.description,
              time_limit_minutes: item.item.time_limit_minutes
            }
          when 'HandsOnLab'
            lab_summary(item.item)
          end
        end

        def lab_summary(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            category: lab.category,
            points_reward: lab.points_reward
          }
        end

        def lab_detail(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            category: lab.category,
            learning_objectives: lab.learning_objectives,
            prerequisites: lab.prerequisites,
            steps: lab.steps,
            points_reward: lab.points_reward,
            environment_image: lab.environment_image,
            required_tools: lab.required_tools
          }
        end
      end
    end
  end
end
