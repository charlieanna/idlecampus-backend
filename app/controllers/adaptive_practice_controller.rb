require 'ostruct'

class AdaptivePracticeController < ApplicationController
  before_action :authenticate_user!
  
  def start
    """Start an adaptive practice session"""
    
    @skill_dimension = params[:skill_dimension] || 'general'
    @course_module = CourseModule.find(params[:module_id]) if params[:module_id]
    
    # A/B test: Assign to adaptive algorithm variant
    ab_service = AbTestingService.new
    algorithm_variant = ab_service.assign_variant(
      user_id: current_user.id,
      experiment: 'adaptive_algorithm'
    )
    
    # Initialize session state
    session[:adaptive_session] = {
      skill_dimension: @skill_dimension,
      module_id: @course_module&.id,
      questions_answered: 0,
      correct_count: 0,
      start_time: Time.current.to_i,
      question_ids: [],
      recent_topics: [],
      algorithm_variant: algorithm_variant
    }
    
    # Track event
    LearningEventTracker.quiz_started(
      user: current_user,
      quiz: OpenStruct.new(id: 'adaptive', title: 'Adaptive Practice', total_questions: 10),
      context: { adaptive: true, skill_dimension: @skill_dimension }
    )
    
    # Get first question
    redirect_to next_adaptive_question_path
  end
  
  def next_question
    """Get next adaptive question"""
    
    adaptive_session = session[:adaptive_session] || {}
    
    # Check if session should end
    if should_end_session?(adaptive_session)
      redirect_to adaptive_practice_complete_path
      return
    end
    
    # Try Flask service first, fallback to heuristic
    result = if FlaskClient.flask_available?
               get_question_from_flask(adaptive_session)
             else
               get_question_heuristic(adaptive_session)
             end
    
    if result[:question].nil?
      flash[:alert] = "No suitable questions found. Try a different topic or difficulty."
      redirect_to dashboard_path
      return
    end
    
    @question = result[:question]
    @reason = result[:reason]
    @difficulty_match = result[:difficulty_match]
    @using_fallback = result[:using_fallback]
    
    # Store question ID in session
    session[:current_question_id] = @question.id
    session[:question_start_time] = Time.current.to_i
  end
  
  def submit_answer
    """Submit answer and get feedback"""
    
    question = QuizQuestion.find(session[:current_question_id])
    user_answer = params[:answer]
    time_taken = Time.current.to_i - session[:question_start_time].to_i
    
    # Validate answer
    correct = question.correct_answer?(user_answer)
    
    # Update session stats
    adaptive_session = session[:adaptive_session] || {}
    adaptive_session[:questions_answered] = (adaptive_session[:questions_answered] || 0) + 1
    adaptive_session[:correct_count] = (adaptive_session[:correct_count] || 0) + (correct ? 1 : 0)
    adaptive_session[:question_ids] = (adaptive_session[:question_ids] || []) << question.id
    adaptive_session[:recent_topics] = (adaptive_session[:recent_topics] || []) << question.topic
    session[:adaptive_session] = adaptive_session
    
    # Process answer through service
    result = if FlaskClient.flask_available?
               submit_to_flask(question, user_answer, correct, time_taken)
             else
               submit_heuristic(question, user_answer, correct, time_taken)
             end
    
    # Award progress points
    activity_type = correct ? :question_correct : :question_answered
    ProgressTrackingService.record_for_user(
      current_user,
      activity_type,
      { difficulty: question.difficulty }
    )
    
    # Track event
    LearningEventTracker.quiz_question_answered(
      user: current_user,
      question: question,
      answer: user_answer,
      correct: correct,
      time_taken: time_taken,
      context: { 
        adaptive: true, 
        using_fallback: result[:using_fallback],
        new_ability: result.dig(:ability_update, :new_ability)
      }
    )
    
    response_data = {
      correct: correct,
      feedback: result[:feedback],
      ability_update: result[:ability_update],
      explanation: question.explanation,
      correct_answer: question.formatted_correct_answer,
      progress: {
        answered: adaptive_session[:questions_answered],
        correct: adaptive_session[:correct_count],
        accuracy: adaptive_session[:correct_count].to_f / adaptive_session[:questions_answered]
      }
    }
    
    # Add detailed analysis if wrong
    if result[:analysis]
      response_data[:analysis] = {
        error_type: result[:analysis][:error_type],
        hint: result[:analysis][:hint],
        remediation: result[:analysis][:remediation],
        similar_questions: result[:analysis][:similar_questions]
      }
    end
    
    render json: response_data
  end
  
  def complete
    """Complete adaptive practice session"""
    
    adaptive_session = session[:adaptive_session] || {}
    
    total_time = Time.current.to_i - adaptive_session[:start_time].to_i
    
    @summary = {
      questions_answered: adaptive_session[:questions_answered] || 0,
      correct_count: adaptive_session[:correct_count] || 0,
      accuracy: calculate_accuracy(adaptive_session),
      time_spent_minutes: (total_time / 60.0).round(1),
      skill_dimension: adaptive_session[:skill_dimension]
    }
    
    # Track A/B test metrics
    if adaptive_session[:algorithm_variant]
      ab_service = AbTestingService.new
      
      ab_service.track_metric(
        user_id: current_user.id,
        experiment: 'adaptive_algorithm',
        metric: 'accuracy',
        value: @summary[:accuracy] / 100.0
      )
      
      ab_service.track_metric(
        user_id: current_user.id,
        experiment: 'adaptive_algorithm',
        metric: 'time_per_question',
        value: total_time.to_f / @summary[:questions_answered]
      )
    end
    
    # Clear session
    session.delete(:adaptive_session)
    session.delete(:current_question_id)
    session.delete(:question_start_time)
  end
  
  private
  
  def should_end_session?(adaptive_session)
    """Determine if session should end"""
    
    questions_answered = adaptive_session[:questions_answered] || 0
    
    # End after 10 questions minimum, or if user has answered enough
    questions_answered >= 10
  end
  
  def get_question_from_flask(adaptive_session)
    """Get question from Flask adaptive service"""
    
    result = FlaskClient.get_next_question(
      user_id: current_user.id,
      context: {
        skill_dimension: adaptive_session[:skill_dimension],
        recent_topics: adaptive_session[:recent_topics] || [],
        module_id: adaptive_session[:module_id]
      }
    )
    
    if result[:error]
      # Fall back to heuristic
      get_question_heuristic(adaptive_session)
    else
      question = QuizQuestion.find_by(id: result.dig(:question, :id))
      {
        question: question,
        reason: result[:reason],
        difficulty_match: result[:difficulty_match],
        using_fallback: false
      }
    end
  end
  
  def get_question_heuristic(adaptive_session)
    """Get question using heuristic service"""
    
    service = AdaptivePracticeService.new(current_user)
    service.select_next_question({
      skill_dimension: adaptive_session[:skill_dimension],
      recent_topics: adaptive_session[:recent_topics] || [],
      exclude_question_ids: adaptive_session[:question_ids] || []
    })
  end
  
  def submit_to_flask(question, user_answer, correct, time_taken)
    """Submit to Flask service"""
    
    result = FlaskClient.submit_answer(
      user_id: current_user.id,
      question_id: question.id,
      answer: user_answer,
      correct: correct,
      time_taken: time_taken
    )
    
    if result[:error]
      submit_heuristic(question, correct, time_taken)
    else
      result.merge(using_fallback: false)
    end
  end
  
  def submit_heuristic(question, user_answer, correct, time_taken)
    """Submit using heuristic service"""
    
    service = AdaptivePracticeService.new(current_user)
    service.submit_answer(
      question: question,
      user_answer: user_answer,
      correct: correct,
      time_taken: time_taken
    )
  end
  
  def calculate_accuracy(adaptive_session)
    total = adaptive_session[:questions_answered] || 0
    return 0.0 if total == 0
    
    correct = adaptive_session[:correct_count] || 0
    ((correct.to_f / total) * 100).round(1)
  end
end

