# frozen_string_literal: true

module Api
  module V1
    module Envoy
      class EnvoyCoursesController < GenericCoursesController
        # GET /api/v1/envoy/courses
        def index
          courses = get_courses_by_pattern('envoy')
          render json: { courses: courses.map { |c| course_summary(c) } }
        end

        # GET /api/v1/envoy/courses/:slug
        def show
          course = Course.find_by!(slug: params[:id])
          render json: { course: course_detail(course) }
        end

        # GET /api/v1/envoy/courses/:course_slug/modules
        def modules
          course = Course.find_by!(slug: params[:course_id])
          modules = course.course_modules.includes(:module_items).ordered
          render json: { modules: modules.map { |m| module_summary(m) } }
        end

        # GET /api/v1/envoy/courses/:course_slug/modules/:id
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          mod = course.course_modules.find(params[:id])
          render json: { module: module_detail(mod) }
        end

        # GET /api/v1/envoy/labs
        def labs
          labs = get_labs_by_type('envoy')
          render json: { labs: labs.map { |l| lab_summary(l) } }
        end

        # GET /api/v1/envoy/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])
          render json: { lab: lab_detail(lab) }
        end
      end
    end
  end
end
