# frozen_string_literal: true
#
# ⚠️  DEPRECATED: This controller uses database queries for courses!
#
# IMPORTANT: Courses should ONLY be fetched from YAML files using CourseFileReaderService.
# This controller currently queries the Course database model with certification_track filter,
# which is INCORRECT.
#
# Kubernetes course content is available at: /db/seeds/consolidated_courses/kubernetes-complete/
#
# TODO: Refactor to use CourseFileReaderService instead of database queries.
# See app/controllers/api/v1/courses_controller.rb for correct implementation.
#
module Api
  module V1
    module Kubernetes
      class KubernetesCoursesController < ApplicationController
        # Disable auth and CSRF for public API access
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!, raise: false if respond_to?(:skip_before_action)
        protect_from_forgery with: :null_session

        before_action :set_default_format
        before_action :set_cors_headers
        before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

        # GET /api/v1/kubernetes/courses
        def index
          courses = Course.where(certification_track: 'kubernetes')
                          .includes(course_modules: [:module_items])
                          .ordered

          render json: {
            courses: courses.map { |course| course_summary(course) }
          }
        end

        # GET /api/v1/kubernetes/courses/:slug
        def show
          course = Course.find_by!(slug: params[:id])

          render json: {
            course: course_detail(course)
          }
        end

        # GET /api/v1/kubernetes/courses/:course_slug/modules
        def modules
          course = Course.find_by!(slug: params[:course_id])
          modules = course.course_modules
                          .includes(:module_items)
                          .ordered

          render json: {
            modules: modules.map { |mod| module_detail(mod) }
          }
        end

        # GET /api/v1/kubernetes/courses/:course_slug/modules/:module_slug
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          mod = course.course_modules.find_by!(slug: params[:id])

          render json: {
            module: module_detail(mod)
          }
        end

        # GET /api/v1/kubernetes/labs
        def labs
          labs = HandsOnLab.kubernetes_labs.active.order(:sequence_order)

          render json: {
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/kubernetes/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])

          render json: {
            lab: lab_detail(lab)
          }
        end

        # Respond to OPTIONS preflight requests
        def cors_preflight
          headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
          headers['Access-Control-Max-Age'] = '1728000'
          headers['Vary'] = 'Origin'
          head :ok
        end

        private

        def set_default_format
          request.format = :json
        end

        def set_cors_headers
          headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
          headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
          headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
          headers['Vary'] = 'Origin'
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
            module_count: course.course_modules.count
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
            learning_objectives: [],
            prerequisites: [],
            modules: course.course_modules.ordered.map { |mod| module_summary(mod) }
          }
        end

        def module_summary(mod)
          {
            id: mod.id,
            slug: mod.slug,
            title: mod.title,
            description: mod.description,
            sequence_order: mod.sequence_order,
            estimated_minutes: mod.estimated_minutes,
            lesson_count: mod.lessons.count
          }
        end

        def module_detail(mod)
          # Get all module items (lessons and labs) ordered by sequence
          items = mod.module_items.includes(:item).order(:sequence_order).map do |module_item|
            if module_item.item_type == 'CourseLesson'
              lesson_data = lesson_detail(module_item.item)
              lesson_data&.merge(type: 'lesson', sequence_order: module_item.sequence_order)
            elsif module_item.item_type == 'HandsOnLab'
              lab_data = lab_summary(module_item.item)
              lab_data&.merge(type: 'lab', sequence_order: module_item.sequence_order)
            end
          end.compact

          {
            id: mod.id,
            slug: mod.slug,
            title: mod.title,
            description: mod.description,
            sequence_order: mod.sequence_order,
            estimated_minutes: mod.estimated_minutes,
            lessons: items.select { |item| item[:type] == 'lesson' },
            labs: items.select { |item| item[:type] == 'lab' },
            items: items  # All items in sequence order
          }
        end

        def lesson_detail(lesson)
          return nil unless lesson

          # Extract kubectl commands from content
          key_commands = []
          if lesson.content
            # Find all bash code blocks
            lesson.content.scan(/```bash\n(.*?)```/m) do |match|
              code_block = match[0]
              # Extract kubectl commands (lines starting with kubectl, not comments)
              code_block.scan(/^kubectl\s+[^\n]+/) do |cmd_line|
                # Clean up the command
                command = cmd_line.strip

                # Try to get description from preceding comment
                description = nil
                if code_block =~ /#\s*([^\n]+)\n#{Regexp.escape(command)}/
                  description = $1.strip
                end

                # Fallback: generate description from command
                unless description
                  parts = command.split
                  verb = parts[1] || "execute"
                  resource = parts[2] || "resource"
                  description = "#{verb.capitalize} #{resource}"
                end

                # Add to key_commands array in format: "command - description - example"
                key_commands << "#{command} - #{description} - #{command}"
              end
            end
          end

          {
            id: lesson.id,
            title: lesson.title,
            content: lesson.content,
            sequence_order: 0,
            estimated_minutes: (lesson.respond_to?(:reading_time_minutes) ? lesson.reading_time_minutes : nil),
            learning_objectives: [],
            key_commands: key_commands.uniq.first(10) # Return up to 10 unique commands
          }
        end

        def lab_summary(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            sequence_order: lab.respond_to?(:sequence_order) ? lab.sequence_order : 0,
            steps: lab.respond_to?(:steps) ? (lab.steps.is_a?(Array) ? lab.steps : []) : [],
            objectives: lab.respond_to?(:learning_objectives) ? [lab.learning_objectives].compact : [],
            hints: extract_hints(lab)
          }
        end

        def lab_detail(lab)
          {
            id: lab.id,
            title: lab.title,
            description: lab.description,
            difficulty: lab.difficulty,
            estimated_minutes: lab.estimated_minutes,
            objectives: lab.respond_to?(:learning_objectives) ? [lab.learning_objectives].compact : [],
            prerequisites: lab.respond_to?(:prerequisites) ? (lab.prerequisites.is_a?(Array) ? lab.prerequisites : []) : [],
            steps: lab.respond_to?(:steps) ? (lab.steps.is_a?(Array) ? lab.steps : []) : [],
            validation_commands: lab.respond_to?(:validation_rules) ? (lab.validation_rules || {}).values : [],
            hints: extract_hints(lab),
            solution: nil,
            sequence_order: lab.respond_to?(:sequence_order) ? lab.sequence_order : 0
          }
        end

        def extract_hints(lab)
          return [] unless lab.respond_to?(:steps) && lab.steps.is_a?(Array)
          lab.steps.map { |step| step['instruction'] || step['hint'] || '' }.compact
        end
      end
    end
  end
end
