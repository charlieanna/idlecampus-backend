# frozen_string_literal: true
#
# ⚠️  DEPRECATED: This controller uses database queries for courses!
#
# IMPORTANT: Courses should ONLY be fetched from YAML files using CourseFileReaderService.
# This controller currently queries the Course database model, which is INCORRECT.
#
# AWS course content is available at: /db/seeds/consolidated_courses/aws-cloud-fundamentals/
#
# TODO: Refactor to use CourseFileReaderService instead of database queries.
# See app/controllers/api/v1/courses_controller.rb for correct implementation.
#
module Api
  module V1
    module Aws
      class AwsCoursesController < GenericCoursesController
        # GET /api/v1/aws/courses
        def index
          courses = get_courses_by_pattern('aws')
          render json: { courses: courses.map { |c| course_summary(c) } }
        end

        # GET /api/v1/aws/courses/:slug
        def show
          course = Course.find_by!(slug: params[:id])
          render json: { course: course_detail(course) }
        end

        # GET /api/v1/aws/courses/:course_slug/modules
        def modules
          course = Course.find_by!(slug: params[:course_id])
          modules = course.course_modules.includes(:module_items).ordered
          render json: { modules: modules.map { |m| module_summary(m) } }
        end

        # GET /api/v1/aws/courses/:course_slug/modules/:id
        def module_show
          course = Course.find_by!(slug: params[:course_id])
          mod = course.course_modules.find(params[:id])
          render json: { module: module_detail(mod) }
        end

        # GET /api/v1/aws/labs
        def labs
          labs = get_labs_by_type('aws')
          render json: { labs: labs.map { |l| lab_summary(l) } }
        end

        # GET /api/v1/aws/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])
          render json: { lab: lab_detail(lab) }
        end
      end
    end
  end
end
