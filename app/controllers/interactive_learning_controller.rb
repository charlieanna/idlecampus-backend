class InteractiveLearningController < ApplicationController
  before_action :authenticate_user!
  before_action :set_unit, only: [:show, :start, :complete_explanation, :submit_practice, 
                                   :submit_quiz, :complete_scenario, :get_hint]
  before_action :set_progress, only: [:show, :start, :complete_explanation, :submit_practice,
                                       :submit_quiz, :complete_scenario, :get_hint]
  before_action :enforce_guided_progress, only: [:show, :start, :complete_explanation, :submit_practice,
                                                 :submit_quiz, :complete_scenario, :get_hint]
  
  # GET /interactive_learning/:slug
  def show
    @next_unit = @unit.next_unit
    @previous_unit = @unit.previous_unit
    @can_access = @unit.accessible_by?(current_user)
    
    unless @can_access
      flash[:warning] = "Please complete the prerequisite units first."
      redirect_to interactive_learning_index_path and return
    end
    
    # Track time started
    session[:unit_start_time] = Time.current.to_i
  end
  
  # POST /interactive_learning/:slug/start
  def start
    @progress.mark_explanation_read!
    
    render json: { 
      success: true, 
      progress: progress_data(@progress) 
    }
  end
  
  # POST /interactive_learning/:slug/complete_explanation
  def complete_explanation
    @progress.mark_explanation_read!
    track_time_spent
    
    render json: { 
      success: true, 
      progress: progress_data(@progress) 
    }
  end
  
  # POST /interactive_learning/:slug/submit_practice
  def submit_practice
    user_answer = params[:answer].to_s.strip
    is_correct = @unit.validate_practice_command(user_answer)
    
    @progress.record_practice_attempt(user_answer, is_correct)
    track_time_spent
    
    response_data = {
      success: true,
      correct: is_correct,
      progress: progress_data(@progress)
    }
    
    if is_correct
      response_data[:message] = "Excellent! That's the correct command."
      response_data[:xp_earned] = calculate_practice_xp
    else
      response_data[:message] = generate_practice_feedback(user_answer)
      
      # Provide hint after multiple attempts
      if @progress.practice_attempts >= 2
        response_data[:hint] = @unit.get_hint(@progress.practice_attempts)
      end
    end
    
    render json: response_data
  end
  
  # POST /interactive_learning/:slug/submit_quiz
  def submit_quiz
    user_answer = params[:answer]
    is_correct = @unit.validate_quiz_answer(user_answer)
    
    @progress.record_quiz_attempt(user_answer, is_correct)
    track_time_spent
    
    response_data = {
      success: true,
      correct: is_correct,
      explanation: @unit.quiz_explanation,
      progress: progress_data(@progress)
    }
    
    if is_correct
      response_data[:message] = "Correct!"
      response_data[:xp_earned] = calculate_quiz_xp
    else
      response_data[:message] = "Not quite right. Review the explanation and try again."
    end
    
    render json: response_data
  end
  
  # POST /interactive_learning/:slug/complete_scenario
  def complete_scenario
    @progress.mark_scenario_completed!
    track_time_spent
    
    # Check if unit is now fully completed
    if @progress.reload.completed?
      xp_earned = @unit.award_xp(current_user)
      advanced = false
      next_unit = nil
      
      # Advance only if passed (sufficient mastery)
      if @progress.passed? && @enrollment
        @enrollment.set_next_current_item!(@unit)
        advanced = true
        next_unit = @enrollment.current_item if @enrollment.current_item.is_a?(InteractiveLearningUnit)
      end
      
      render json: {
        success: true,
        completed: true,
        message: advanced ? "Great job! Moving you to the next unit." : "Unit completed. Improve mastery to advance.",
        xp_earned: xp_earned,
        mastery_score: @progress.mastery_score,
        progress: progress_data(@progress),
        progression: {
          advanced: advanced,
          next_unit_url: (next_unit ? interactive_learning_path(next_unit.slug) : nil)
        },
        next_unit: (next_unit ? { title: next_unit.title, slug: next_unit.slug, url: interactive_learning_path(next_unit.slug) } : nil)
      }
    else
      render json: {
        success: true,
        progress: progress_data(@progress)
      }
    end
  end
  
  # GET /interactive_learning/:slug/hint
  def get_hint
    hint = @unit.get_hint(@progress.practice_attempts + 1)
    
    render json: {
      success: true,
      hint: hint || "Try reviewing the concept explanation above."
    }
  end
  
  # GET /interactive_learning
  def index
    @units = InteractiveLearningUnit.published.ordered
    @user_progress = current_user.learning_unit_progresses.index_by(&:interactive_learning_unit_id)
    @current_unit_ids = current_user.course_enrollments
                                   .where.not(current_item_id: nil, current_item_type: nil)
                                   .pluck(:current_item_id)
  end
  
  # GET /interactive_learning/dashboard
  def dashboard
    @total_units = InteractiveLearningUnit.published.count
    @completed_units = current_user.learning_unit_progresses.completed.count
    @in_progress_units = current_user.learning_unit_progresses.in_progress.count
    @units_needing_review = current_user.learning_unit_progresses.needs_review.count
    
    @recent_progress = current_user.learning_unit_progresses
                                   .includes(:interactive_learning_unit)
                                   .order(updated_at: :desc)
                                   .limit(10)
    
    @recommended_units = recommend_next_units
  end
  
  private
  
  def set_unit
    @unit = InteractiveLearningUnit.find_by!(slug: params[:slug])
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Learning unit not found."
    redirect_to interactive_learning_index_path
  end
  
  def set_progress
    @progress = @unit.progress_for(current_user)
  end
  
  def track_time_spent
    start_time = session[:unit_start_time]
    if start_time
      elapsed = Time.current.to_i - start_time.to_i
      @progress.add_time_spent(elapsed) if elapsed > 0 && elapsed < 3600 # Cap at 1 hour
      session[:unit_start_time] = Time.current.to_i # Reset timer
    end
  end
  
  def progress_data(progress)
    {
      explanation_read: progress.explanation_read,
      practice_completed: progress.practice_completed,
      quiz_answered: progress.quiz_answered,
      scenario_completed: progress.scenario_completed,
      completed: progress.completed,
      completion_percentage: progress.completion_percentage,
      mastery_score: progress.mastery_score,
      practice_attempts: progress.practice_attempts,
      quiz_attempts: progress.quiz_attempts
    }
  end
  
  def next_unit_data
    next_unit = @enrollment&.next_interactive_unit_after(@unit)
    return nil unless next_unit
    
    {
      title: next_unit.title,
      slug: next_unit.slug,
      url: interactive_learning_path(next_unit.slug)
    }
  end
  
  def generate_practice_feedback(user_answer)
    correct_answer = @unit.command_to_learn
    
    # Check for common mistakes
    if user_answer.blank?
      "Please enter a command."
    elsif !user_answer.start_with?('docker') && correct_answer.start_with?('docker')
      "Docker commands start with 'docker'. Try again!"
    elsif user_answer.length < correct_answer.length / 2
      "Your command seems incomplete. Check the syntax and try again."
    else
      "Not quite right. Review the example and try again."
    end
  end
  
  def calculate_practice_xp
    base_xp = 10
    # Bonus for getting it right on first try
    attempts = @progress.practice_attempts
    bonus = attempts == 1 ? 5 : 0
    base_xp + bonus
  end
  
  def calculate_quiz_xp
    base_xp = 15
    # Bonus for getting it right on first try
    attempts = @progress.quiz_attempts
    bonus = attempts == 1 ? 10 : 0
    base_xp + bonus
  end
  
  def recommend_next_units
    # Find units user hasn't completed yet, prioritizing:
    # 1. Units with met prerequisites
    # 2. Matching user's skill level
    # 3. Sequential order
    
    completed_slugs = current_user.learning_unit_progresses
                                  .completed
                                  .joins(:interactive_learning_unit)
                                  .pluck('interactive_learning_units.slug')
    
    InteractiveLearningUnit.published
                          .where.not(slug: completed_slugs)
                          .select { |unit| unit.accessible_by?(current_user) }
                          .sort_by(&:sequence_order)
                          .first(5)
  end

  # Enforce guided sequential progression through units
  def enforce_guided_progress
    # Determine the course for this unit via its first course_module
    course_module = @unit.course_modules.published.ordered.first || @unit.course_modules.first
    @course = course_module&.course
    return unless @course
    
    @enrollment = @course.enrollment_for(current_user)
    
    # Auto-enroll if not enrolled
    unless @enrollment
      @enrollment = CourseEnrollment.create!(
        user: current_user,
        course: @course,
        status: 'enrolled'
      )
      @enrollment.set_initial_current_item!
    end
    
    # Initialize current item if not set
    if @enrollment.current_item.nil?
      @enrollment.set_initial_current_item!
    end
    
    # ENFORCE SEQUENTIAL ACCESS - users must complete units in order
    current_item = @enrollment.current_item
    
    # Check if user is trying to access a future unit
    if current_item && current_item != @unit
      # Allow access to current and previous units only
      current_unit_order = current_item.try(:sequence_order) || 0
      requested_unit_order = @unit.sequence_order || 0
      
      if requested_unit_order > current_unit_order
        flash[:alert] = "You must complete '#{current_item.title}' before accessing this unit."
        redirect_to interactive_learning_path(current_item.slug) and return
      end
    elsif current_item.nil?
      # No current item set, only allow first unit
      first_unit = InteractiveLearningUnit.published.ordered.first
      unless @unit == first_unit
        flash[:alert] = "Please start with the first unit: '#{first_unit.title}'"
        redirect_to interactive_learning_path(first_unit.slug) and return
      end
    end
  end
end

