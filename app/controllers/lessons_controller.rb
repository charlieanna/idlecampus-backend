class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson
  before_action :find_course_context, only: [:show]
  
  def show
    # Find course context if lesson is part of a course module
    @module_item = @lesson.module_items.first
    
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
      
      # Check if already completed
      @completed = @lesson.completed_by?(current_user)
      
      # Get next item in module
      @next_item = find_next_item
    end
    
    # Track user activity
    user_stat = current_user.user_stat || current_user.create_user_stat
    user_stat.record_activity!(@lesson.reading_time_minutes || 5)
  end
  
  def complete
    completion = @lesson.mark_completed_by(current_user)
    
    if completion.persisted?
      # Update module progress
      module_item = @lesson.module_items.first
      if module_item
        course_module = module_item.course_module
        enrollment = course_module.course.enrollment_for(current_user)
        
        if enrollment
          progress = ModuleProgress.find_or_create_by(
            user: current_user,
            course_module: course_module,
            course_enrollment: enrollment
          )
          progress.calculate_completion!
        end
      end
      
      render json: { 
        success: true, 
        message: "Lesson completed!",
        next_url: next_item_url
      }
    else
      render json: { success: false, message: "Failed to mark as complete" }, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
  
  def find_course_context
    # Try to find course context from params or lesson associations
    if params[:course_id] && params[:module_id]
      @course = Course.find_by(slug: params[:course_id])
      @course_module = @course&.course_modules&.find_by(slug: params[:module_id])
    end
  end
  
  def find_next_item
    return nil unless @module_item
    
    current_position = @module_item.sequence_order
    next_module_item = @course_module.module_items.ordered.where('sequence_order > ?', current_position).first
    
    next_module_item
  end
  
  def next_item_url
    return nil unless @module_item && @course_module && @course
    
    next_item = find_next_item
    
    if next_item
      case next_item.item_type
      when 'Lesson'
        lesson_path(next_item.item_id, course_id: @course.slug, module_id: @course_module.slug)
      when 'Quiz'
        quiz_path(next_item.item_id, course_id: @course.slug, module_id: @course_module.slug)
      when 'HandsOnLab'
        hands_on_lab_path(next_item.item_id, course_id: @course.slug, module_id: @course_module.slug)
      end
    else
      course_module_path(@course, @course_module)
    end
  end
end