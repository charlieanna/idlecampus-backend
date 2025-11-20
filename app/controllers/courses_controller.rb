class CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course, only: [:show, :enroll, :continue]
  
  def index
    @courses = Course.published.ordered.includes(:course_modules)
    @enrolled_courses = current_user.course_enrollments.active.includes(:course)
    @completed_courses = current_user.course_enrollments.completed.includes(:course)
    
    # Filter by difficulty if specified
    @courses = @courses.by_difficulty(params[:difficulty]) if params[:difficulty].present?
    
    # Filter by certification track if specified
    @courses = @courses.by_certification(params[:certification]) if params[:certification].present?
  end
  
  def show
    # Redirect to the stream immediately; no listing UI
    redirect_to start_course_path(@course) and return
  end
  
  def enroll
    if @course.enrolled?(current_user)
      redirect_to course_path(@course), alert: "You are already enrolled in this course."
      return
    end
    
    enrollment = CourseEnrollment.create(
      user: current_user,
      course: @course,
      status: 'enrolled'
    )
    
    if enrollment.persisted?
      # Initialize user stats if not exists
      current_user.user_stat || current_user.create_user_stat
      # Initialize guided learning current item
      enrollment.set_initial_current_item!
      
      redirect_to start_course_path(@course), notice: "Successfully enrolled in #{@course.title}!"
    else
      redirect_to courses_path, alert: "Failed to enroll in course."
    end
  end
  
  def continue
    enrollment = @course.enrollment_for(current_user)

    unless enrollment
      redirect_to course_path(@course), alert: "You need to enroll first."
      return
    end

    redirect_to start_course_path(@course)
  end

  private
  
  def set_course
    # Use params[:slug] since route uses param: :slug
    slug_param = params[:slug] || params[:id]
    @course = if slug_param.to_s.match?(/^\d+$/)
                Course.find(slug_param)
              else
                Course.find_by!(slug: slug_param)
              end
  end
end