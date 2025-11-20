class CourseModulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course
  before_action :set_module
  before_action :check_enrollment
  
  def show
    @enrollment = @course.enrollment_for(current_user)
    @module_items = @module.module_items.ordered.includes(:item)
    @interactive_units = @module.module_interactive_units.ordered.includes(:interactive_learning_unit)
    @progress = @module.progress_for(current_user)
    
    # Create or update progress record
    unless @progress
      @progress = ModuleProgress.create(
        user: current_user,
        course_module: @module,
        course_enrollment: @enrollment
      )
    end
    
    # Mark as started if not already
    @progress.start! if @progress.status == 'not_started'
    
    # Get completion status for each item
    @item_completions = {}
    @module_items.each do |module_item|
      @item_completions[module_item.id] = module_item.completed_by?(current_user)
    end
    
    # Get interactive unit progress
    @unit_progresses = {}
    @interactive_units.each do |module_unit|
      unit = module_unit.interactive_learning_unit
      progress = unit.progress_for(current_user)
      @unit_progresses[unit.id] = progress
    end
    
    # Find next uncompleted item
    @next_item = @module.next_item_for(current_user)
    
    # Get all modules for navigation
    @all_modules = @course.course_modules.published.ordered
    @module_progresses = ModuleProgress.where(
      user: current_user,
      course_module_id: @all_modules.pluck(:id)
    ).index_by(&:course_module_id)
  end
  
  private
  
  def set_course
    # Handle both slug and ID
    course_param = params[:course_id] || params[:course_slug] || params[:id]
    @course = if course_param.to_s.match?(/^\d+$/)
                Course.find(course_param)
              else
                Course.find_by!(slug: course_param)
              end
  end
  
  def set_module
    # Handle both slug and ID
    module_param = params[:id] || params[:slug] || params[:module_slug]
    @module = if module_param.to_s.match?(/^\d+$/)
                @course.course_modules.find(module_param)
              else
                @course.course_modules.find_by!(slug: module_param)
              end
  end
  
  def check_enrollment
    unless @course.enrolled?(current_user)
      redirect_to course_path(@course), alert: "You must enroll in this course first."
    end
  end
end