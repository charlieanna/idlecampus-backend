class HandsOnLabsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_lab, only: [:show, :start, :lab_session]
  before_action :find_course_context, only: [:show]
  before_action :enforce_guided_progress, only: [:show, :start], if: -> { @enrollment.present? }
  
  def index
    @labs = HandsOnLab.active
    
    # Apply filters
    @labs = @labs.by_difficulty(params[:difficulty]) if params[:difficulty].present?
    @labs = @labs.by_category(params[:category]) if params[:category].present?
    @labs = @labs.by_type(params[:lab_type]) if params[:lab_type].present?
    
    # Get user's lab sessions for progress tracking (only if user is logged in)
    @user_sessions = if current_user
                       current_user.lab_sessions.includes(:hands_on_lab)
                                   .group_by(&:hands_on_lab_id)
                     else
                       {}
                     end
  end
  
  def show
    @active_session = LabSession.where(
      user: current_user,
      hands_on_lab: @lab,
      status: ['active', 'paused']
    ).first
    
    @previous_attempts = @lab.lab_sessions
                             .where(user: current_user)
                             .completed
                             .order(completed_at: :desc)
                             .limit(5)
    
    @best_attempt = @previous_attempts.max_by(&:score)
    @can_attempt = @lab.lab_sessions.where(user: current_user).count < @lab.max_attempts
  end
  
  def start
    # Check for existing active session
    active_session = LabSession.where(
      user: current_user,
      hands_on_lab: @lab,
      status: ['active', 'paused']
    ).first
    
    if active_session
      redirect_to lab_session_hands_on_lab_path(@lab, session_id: active_session.id)
      return
    end
    
    # Check attempt limit
    unless @lab.lab_sessions.where(user: current_user).count < @lab.max_attempts
      redirect_to hands_on_lab_path(@lab), alert: "You have reached the maximum number of attempts for this lab."
      return
    end
    
    # Create new session
    @session = LabSession.create!(
      user: current_user,
      hands_on_lab: @lab,
      status: 'active',
      current_step: 0,
      steps_completed: 0,
      completion_percentage: 0,
      time_spent_seconds: 0
    )
    
    @session.start!
    
    # Track lab started event
    LearningEventTracker.lab_started(
      user: current_user,
      lab: @lab,
      session: @session,
      context: {
        course_id: @course&.id,
        module_id: @course_module&.id
      }
    )
    
    redirect_to lab_session_hands_on_lab_path(@lab, session_id: @session.id)
  end
  
  def lab_session
    @session = LabSession.find(params[:session_id])
    
    unless @session.user_id == current_user.id
      redirect_to hands_on_labs_path, alert: "Unauthorized access to lab session."
      return
    end
    
    @steps = @lab.steps.is_a?(Array) ? @lab.steps : []
    @current_step_index = @session.current_step
    @current_step = @steps[@current_step_index] if @current_step_index < @steps.length
    
    # Quick Refresher recommendations based on lab concept tags
    begin
      lab_tags = (@lab.respond_to?(:concept_tags) && @lab.concept_tags.is_a?(Array)) ? @lab.concept_tags : []
      @refresher_units = if lab_tags.any?
        InteractiveLearningUnit.published
          .where("concept_tags \@> ?", [lab_tags.first].to_json)
          .order(sequence_order: :asc)
          .limit(3)
      else
        []
      end
    rescue => e
      @refresher_units = []
    end
    
    # Find course context for navigation
    @module_item = @lab.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
    end
  end
  
  def validate_step
    @session = LabSession.find(params[:session_id])
    @lab = @session.hands_on_lab
    
    unless @session.user_id == current_user.id
      render json: { success: false, error: "Unauthorized" }, status: :forbidden
      return
    end
    
    step_number = params[:step_number].to_i
    user_command = params[:user_command]
    
    steps = @lab.steps.is_a?(Array) ? @lab.steps : []
    step = steps[step_number]
    
    if step.nil?
      render json: { success: false, error: "Invalid step number" }
      return
    end
    
    # Simple validation - check if command matches expected command
    expected_command = step['command']
    is_correct = validate_command(user_command, expected_command)
    
    if is_correct
      # Mark step as completed
      @session.record_step_completion(step_number)
      @session.update(current_step: step_number + 1)
      
      # Track step completion
      LearningEventTracker.lab_step_completed(
        user: current_user,
        lab: @lab,
        session: @session,
        step_number: step_number,
        context: { command: user_command }
      )
      
      # Check if lab is complete
      if step_number + 1 >= steps.length
        @session.complete!
        
        # Update user stats
        user_stat = current_user.user_stat || current_user.create_user_stat
        user_stat.increment!(:labs_completed)
        user_stat.record_activity!(@lab.estimated_minutes)
        
        # Track lab completion
        LearningEventTracker.lab_completed(
          user: current_user,
          lab: @lab,
          session: @session,
          context: { final_score: @session.score }
        )
        
        render json: {
          success: true,
          correct: true,
          completed: true,
          message: "Congratulations! Lab completed!",
          score: @session.score,
          next_step: nil
        }
      else
        render json: {
          success: true,
          correct: true,
          completed: false,
          message: "Correct! Moving to next step.",
          next_step: step_number + 1
        }
      end
    else
      @session.use_attempt!
      
      render json: {
        success: true,
        correct: false,
        message: "Command doesn't match expected output. Try again!",
        hint: step['hint'],
        expected: expected_command
      }
    end
  end
  
  def request_hint
    @session = LabSession.find(params[:session_id])
    
    unless @session.user_id == current_user.id
      render json: { success: false, error: "Unauthorized" }, status: :forbidden
      return
    end
    
    unless @session.use_hint!
      render json: { success: false, error: "No hints remaining" }
      return
    end
    
    step_number = params[:step_number].to_i
    steps = @session.hands_on_lab.steps
    step = steps[step_number]
    
    # Track hint usage
    LearningEventTracker.lab_hint_used(
      user: current_user,
      lab: @session.hands_on_lab,
      session: @session,
      step_number: step_number
    )
    
    render json: {
      success: true,
      hint: step['hint'] || "No hint available for this step"
    }
  end
  
  def pause
    @session = LabSession.find(params[:session_id])
    
    unless @session.user_id == current_user.id
      render json: { success: false, error: "Unauthorized" }, status: :forbidden
      return
    end
    
    if @session.pause!
      render json: { success: true, message: "Session paused" }
    else
      render json: { success: false, error: "Failed to pause session" }
    end
  end
  
  def resume
    @session = LabSession.find(params[:session_id])
    
    unless @session.user_id == current_user.id
      render json: { success: false, error: "Unauthorized" }, status: :forbidden
      return
    end
    
    if @session.resume!
      render json: { success: true, message: "Session resumed" }
    else
      render json: { success: false, error: "Failed to resume session" }
    end
  end
  
  def complete
    @session = LabSession.find(params[:session_id])
    @lab = @session.hands_on_lab
    
    unless @session.user_id == current_user.id
      redirect_to hands_on_labs_path, alert: "Unauthorized"
      return
    end
    
    @session.complete!
    
    # Find next item in module
    @module_item = @lab.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
      
      current_position = @module_item.sequence_order
      @next_item = @course_module.module_items.ordered
                                  .where('sequence_order > ?', current_position)
                                  .first
    end
    
    # If lab belongs to a course, move stream forward and return to stream
    @module_item = @lab.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      enrollment = @course.enrollment_for(current_user)
      if enrollment
        enrollment.set_next_current_item!(@lab)
        redirect_to start_course_path(@course) and return
      end
    end
    redirect_to lab_result_path(@lab, session_id: @session.id)
  end
  
  def result
    @lab = HandsOnLab.find(params[:id])
    @session = LabSession.find(params[:session_id])
    
    unless @session.user_id == current_user.id
      redirect_to hands_on_labs_path, alert: "Unauthorized"
      return
    end
    
    # Find course context
    @module_item = @lab.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
      
      current_position = @module_item.sequence_order
      @next_item = @course_module.module_items.ordered
                                  .where('sequence_order > ?', current_position)
                                  .first
    end
  end
  
  private
  
  def set_lab
    @lab = HandsOnLab.find(params[:id])
  end
  
  def find_course_context
    @module_item = @lab.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user) if current_user
    end
  end
  
  def validate_command(user_command, expected_command)
    # Remove extra whitespace and compare
    user_cmd = user_command.to_s.strip.gsub(/\s+/, ' ')
    expected_cmd = expected_command.to_s.strip.gsub(/\s+/, ' ')
    
    # Allow flexible matching
    user_cmd == expected_cmd || user_cmd.include?(expected_cmd)
  end

  def enforce_guided_progress
    return unless @enrollment && @course

    # If current item is set and it's not this lab, redirect
    if @enrollment.current_item.present? && @enrollment.current_item != @lab
      redirect_to course_path(@course), notice: "Continue your current learning item first." and return
    end
  end
end