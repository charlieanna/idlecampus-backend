#!/bin/bash

cat > entry-app/SOVisits/app/controllers/guided_learning_controller.rb << 'ENDOFFILE'
class GuidedLearningController < ApplicationController
  before_action :authenticate_user!
  
  # GET /start_learning
  def start
    # Find the user's current learning position
    @enrollments = current_user.course_enrollments.active.includes(:current_item, :course)
    
    # Get the current unit from any enrollment
    @current_unit = @enrollments.map(&:current_item).compact.find { |item| item.is_a?(InteractiveLearningUnit) }
    
    # If no current unit, find the first available unit and set it
    if @current_unit.nil?
      first_unit = InteractiveLearningUnit.published.ordered.first
      
      if first_unit
        # Find the course for this unit
        course_module = first_unit.course_modules.published.first
        if course_module && course_module.course
          enrollment = course_module.course.enrollment_for(current_user)
          
          # Create enrollment if not exists
          unless enrollment
            enrollment = CourseEnrollment.create!(
              user: current_user,
              course: course_module.course,
              status: 'enrolled'
            )
          end
          
          # Set the first unit as current
          enrollment.set_initial_current_item!
          @current_unit = enrollment.current_item
        end
      end
    end
    
    # Redirect to the current unit or show onboarding
    if @current_unit
      redirect_to interactive_learning_path(@current_unit.slug)
    else
      # Show onboarding/welcome page if no units available
      render :welcome
    end
  end
  
  # GET /guided_learning/progress
  def progress
    @enrollments = current_user.course_enrollments.active.includes(:course, :current_item)
    @total_units = InteractiveLearningUnit.published.count
    @completed_units = current_user.learning_unit_progresses.completed.count
    @completion_percentage = @total_units > 0 ? (@completed_units.to_f / @total_units * 100).round : 0
    
    # Get current unit
    @current_unit = @enrollments.map(&:current_item).compact.find { |item| item.is_a?(InteractiveLearningUnit) }
    
    # Calculate time spent
    @total_time_spent = current_user.learning_unit_progresses.sum(:time_spent)
    
    # Get recent activity
    @recent_progress = current_user.learning_unit_progresses
                                   .includes(:interactive_learning_unit)
                                   .order(updated_at: :desc)
                                   .limit(5)
  end
  
  # POST /guided_learning/reset
  def reset
    # Reset all enrollments to first unit
    current_user.course_enrollments.active.each do |enrollment|
      enrollment.set_initial_current_item!
    end
    
    redirect_to start_learning_path, notice: "Your learning progress has been reset. Start fresh!"
  end
end
ENDOFFILE

echo "Fixed GuidedLearningController"
