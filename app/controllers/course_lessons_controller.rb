class CourseLessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson
  before_action :find_course_context, only: [:show]
  before_action :enforce_guided_progress, only: [:show], if: -> { @enrollment.present? }
  
  def show
    # Find course context if lesson is part of a course module
    @module_item = @lesson.module_items.first
    
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user) if current_user
      
      # Check if already completed
      @completed = current_user ? @lesson.completed_by?(current_user) : false
      
      # Get next item in module
      @next_item = find_next_item
      
      # Track lesson started (if not already completed)
      unless @completed
        LearningEventTracker.lesson_started(
          user: current_user,
          lesson: @lesson,
          context: {
            course_id: @course&.id,
            module_id: @course_module&.id
          }
        )
        
        # Store start time for duration tracking
        session[:lesson_start_time] = Time.current.to_i
      end
    end
  end
  
  def complete
    unless current_user
      redirect_to new_session_path, alert: 'Please log in to complete lessons.'
      return
    end
    
    if @lesson.completed_by?(current_user)
      redirect_to @lesson, notice: 'Lesson already completed!'
      return
    end
    
    start_time = session[:lesson_start_time] || Time.current.to_i
    time_spent = Time.current.to_i - start_time
    
    # Mark lesson as completed
    @lesson.lesson_completions.create!(user: current_user)
    
    # Update module progress
    if @module_item
      @module_item.course_module.module_progresses
        .find_or_create_by(user: current_user)
        .calculate_completion!
    end
    
    # Award progress points
    ProgressTrackingService.record_for_user(
      current_user,
      :lesson_completed,
      { time_spent: time_spent }
    )
    
    # Track completion event
    LearningEventTracker.lesson_completed(
      user: current_user,
      lesson: @lesson,
      time_spent: time_spent,
      context: {
        course_id: @course&.id,
        module_id: @course_module&.id
      }
    )
    
    session.delete(:lesson_start_time)
    
    redirect_to @lesson, notice: 'Lesson completed successfully!'
  end
  
  private
  
  def set_lesson
    @lesson = CourseLesson.find(params[:id])
  end
  
  def find_course_context
    @module_item = @lesson.module_items.first
    return unless @module_item
    
    @course_module = @module_item.course_module
    @course = @course_module.course
    @enrollment = @course.enrollment_for(current_user)
  end
  
  def find_next_item
    return unless @module_item
    
    next_item = @course_module.module_items
      .where('sequence_order > ?', @module_item.sequence_order)
      .order(:sequence_order)
      .first
    
    next_item&.item
  end

  def enforce_guided_progress
    return unless @enrollment && @course

    # If current item is set and it's not this lesson, redirect
    if @enrollment.current_item.present? && @enrollment.current_item != @lesson
      redirect_to course_path(@course), notice: "Continue your current learning item first." and return
    end
  end
end
