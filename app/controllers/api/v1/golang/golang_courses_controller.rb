module Api
  module V1
    module Golang
      class GolangCoursesController < Api::V1::GenericCoursesController
        # GET /api/v1/golang/courses
        def index
          courses = get_courses_by_pattern('golang')
          render json: {
            success: true,
            courses: courses.map { |c| course_summary(c) }
          }
        end

        # GET /api/v1/golang/courses/:slug
        def show
          course = Course.find_by!(slug: params[:slug])
          render json: {
            success: true,
            course: course_detail(course)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Course not found' }, status: :not_found
        end

        # GET /api/v1/golang/courses/:slug/modules
        def modules
          course = Course.find_by!(slug: params[:slug])
          modules = course.course_modules.ordered
          render json: {
            success: true,
            modules: modules.map { |mod| module_summary(mod) }
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Course not found' }, status: :not_found
        end

        # GET /api/v1/golang/courses/:course_slug/modules/:module_slug
        def show_module
          course = Course.find_by!(slug: params[:course_slug])
          mod = course.course_modules.find_by!(slug: params[:module_slug])

          render json: {
            success: true,
            course: { id: course.id, title: course.title, slug: course.slug },
            module: module_detail(mod)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Module not found' }, status: :not_found
        end

        # GET /api/v1/golang/labs
        def labs
          labs = get_labs_by_type('golang')
          render json: {
            success: true,
            labs: labs.map { |lab| lab_summary(lab) }
          }
        end

        # GET /api/v1/golang/labs/:id
        def lab_show
          lab = HandsOnLab.find(params[:id])
          render json: {
            success: true,
            lab: lab_detail(lab)
          }
        rescue ActiveRecord::RecordNotFound
          render json: { success: false, error: 'Lab not found' }, status: :not_found
        end
      end
    end
  end
end
