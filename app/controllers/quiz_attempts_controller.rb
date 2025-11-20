class QuizAttemptsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz_attempt, only: [:adaptive_retry]
  
  def adaptive_retry
    # Generate an adaptive retry quiz based on the failed attempt
    generator = AdaptiveRetryQuizGenerator.new(@quiz_attempt)
    
    # Get configuration from session if available
    config = session[:remediation_config] || {}
    focus_ratio = config[:focus_ratio] || 0.7
    difficulty_adjustment = config[:difficulty_adjustment] || 'maintain'
    
    # Generate the quiz
    @retry_quiz = generator.generate_retry_quiz(
      focus_ratio: focus_ratio,
      difficulty_adjustment: difficulty_adjustment
    )
    
    # Clear the session config
    session.delete(:remediation_config)
    
    # Track this event
    LearningEventTracker.quiz_started(
      user: current_user,
      quiz: @retry_quiz,
      context: {
        adaptive_retry: true,
        original_quiz_id: @quiz_attempt.quiz_id,
        original_attempt_id: @quiz_attempt.id
      }
    )
    
    # Redirect to the new quiz
    redirect_to start_quiz_path(@retry_quiz), notice: "Your focused practice quiz is ready! It targets the areas you struggled with."
  end
  
  private
  
  def set_quiz_attempt
    @quiz_attempt = QuizAttempt.find(params[:id])
    
    unless @quiz_attempt.user_id == current_user.id
      redirect_to root_path, alert: "You don't have access to this quiz attempt."
    end
  end
end

