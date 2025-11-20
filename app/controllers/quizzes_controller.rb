class QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_quiz, except: [:practice, :generate_review_session, :generate_topic_deepdive, :generate_mastery_challenge]
  before_action :find_course_context, only: [:show, :start, :submit]
  before_action :check_attempt_limit, only: [:start]
  before_action :enforce_guided_progress, only: [:show, :start], if: -> { @enrollment.present? }
  
  def show
    # Show quiz details and previous attempts
    @attempts = @quiz.attempts_for(current_user)
    @best_attempt = @quiz.best_attempt_for(current_user)
    @can_attempt = @quiz.can_attempt?(current_user)
    @next_attempt_number = @quiz.next_attempt_number_for(current_user)
    
    # Find course context
    @module_item = @quiz.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
    end
  end
  
  def start
    # Create new quiz attempt
    @attempt = QuizAttempt.create(
      user: current_user,
      quiz: @quiz,
      course_enrollment: @enrollment # Can be nil for standalone quizzes
    )
    
    if @attempt.persisted?
      @attempt.start!
      @questions = @quiz.randomized_questions
      
      # Track event
      LearningEventTracker.quiz_started(
        user: current_user,
        quiz: @quiz,
        context: { 
          course_id: @course&.id,
          module_id: @course_module&.id,
          attempt_number: @quiz.next_attempt_number_for(current_user)
        }
      )
      
      render :take
    else
      redirect_to quiz_path(@quiz), alert: "Failed to start quiz."
    end
  end
  
  def submit
    @attempt = QuizAttempt.find(params[:attempt_id])
    
    unless @attempt.user == current_user
      redirect_to quiz_path(@quiz), alert: "Unauthorized"
      return
    end
    
    # Get answers from params
    answers = params[:answers] || {}
    
    # Submit attempt
    @attempt.submit!(answers)
    
    # Update user stats
    user_stat = current_user.user_stat || current_user.create_user_stat
    user_stat.record_activity!(@quiz.time_limit_minutes || 15)
    
    # Award progress points
    activity_type = @attempt.passed? ? :quiz_passed : :quiz_completed
    ProgressTrackingService.record_for_user(
      current_user,
      activity_type,
      { score: @attempt.score }
    )
    
    # Track completion event
    LearningEventTracker.quiz_completed(
      user: current_user,
      quiz: @quiz,
      attempt: @attempt,
      context: {
        course_id: @course&.id,
        module_id: @course_module&.id
      }
    )
    
    redirect_to result_quiz_path(@quiz, attempt_id: @attempt.id)
  end
  
  def result
    @attempt = QuizAttempt.find(params[:attempt_id])
    
    unless @attempt.user == current_user
      redirect_to quiz_path(@quiz), alert: "Unauthorized"
      return
    end
    
    @questions = @quiz.quiz_questions.ordered
    
    # Generate remediation data if quiz was failed
    if @attempt.failed?
      analyzer = EnhancedWrongAnswerAnalyzer.new(@attempt)
      @remediation_data = analyzer.analyze_and_recommend
      
      # Store config in session for adaptive retry
      session[:remediation_config] = @remediation_data[:adaptive_quiz_config]
    end
    @incorrect_questions = @attempt.incorrect_questions
    @correct_questions = @attempt.correct_questions
    
    # Find course context for navigation
    @module_item = @quiz.module_items.first
    if @module_item
      @course_module = @module_item.course_module
      @course = @course_module.course
      @enrollment = @course.enrollment_for(current_user)
      @next_item = find_next_item
    end
  end
  
  def validate_answer
    question = QuizQuestion.find(params[:question_id])
    user_answer = params[:answer]
    
    is_correct = question.correct_answer?(user_answer)
    
    render json: {
      correct: is_correct,
      feedback: is_correct ? "Correct!" : "Incorrect",
      explanation: question.explanation
    }
  end
  
  def adaptive_retry
    original_attempt = QuizAttempt.find(params[:attempt_id])

    unless original_attempt.user == current_user
      redirect_to quiz_path(@quiz), alert: "Unauthorized"
      return
    end

    # Generate adaptive retry quiz
    generator = AdaptiveRetryQuizGenerator.new(original_attempt)
    retry_quiz = generator.generate_retry_quiz

    # Redirect to start the retry quiz
    redirect_to start_quiz_path(retry_quiz),
                notice: "Generated a personalized practice quiz based on your performance!"
  end

  # Practice Quiz Dashboard - Show available practice quiz options
  def practice
    @generator = UnifiedQuizGenerator.new(current_user)

    # Count due review items
    @due_review_count = SpacedRepetitionItem
      .for_user(current_user.id)
      .due
      .count

    # Find commands in mastery challenge range (75-85%)
    @near_mastery_commands = UserCommandMastery
      .where(user: current_user)
      .where('proficiency_score >= ? AND proficiency_score < ?', 75, 85)
      .count

    # Get available topics for deep-dive
    @available_topics = QuizQuestion.distinct.pluck(:topic).compact.sort

    # Get recent practice quizzes
    @recent_quizzes = Quiz
      .practice_quizzes
      .joins(:quiz_attempts)
      .where(quiz_attempts: { user: current_user })
      .order('quiz_attempts.created_at DESC')
      .limit(5)
  end

  # Generate Review Session Quiz
  def generate_review_session
    generator = UnifiedQuizGenerator.new(current_user)
    quiz = generator.generate_review_session

    if quiz
      redirect_to start_quiz_path(quiz), notice: "Review session quiz created! #{quiz.total_questions} items to practice."
    else
      redirect_to practice_quizzes_path, alert: "No review items are due right now. Great job staying current!"
    end
  end

  # Generate Topic Deep-Dive Quiz
  def generate_topic_deepdive
    topic = params[:topic]

    if topic.blank?
      redirect_to practice_quizzes_path, alert: "Please select a topic."
      return
    end

    generator = UnifiedQuizGenerator.new(current_user)
    quiz = generator.generate_topic_deepdive(topic: topic)

    if quiz
      redirect_to start_quiz_path(quiz), notice: "Deep-dive quiz created for #{topic}!"
    else
      redirect_to practice_quizzes_path, alert: "No questions available for #{topic}. Try a different topic!"
    end
  end

  # Generate Mastery Challenge Quiz
  def generate_mastery_challenge
    generator = UnifiedQuizGenerator.new(current_user)
    quiz = generator.generate_mastery_challenge

    if quiz
      redirect_to start_quiz_path(quiz), notice: "🔥 Mastery Challenge started! You have #{quiz.time_limit_minutes} minutes."
    else
      redirect_to practice_quizzes_path, alert: "No commands ready for mastery challenge. Keep practicing!"
    end
  end

  private
  
  def set_quiz
    @quiz = Quiz.find(params[:id])
  end
  
  def find_course_context
    if params[:course_id] && params[:module_id]
      @course = Course.find_by(slug: params[:course_id])
      @course_module = @course&.course_modules&.find_by(slug: params[:module_id])
      @enrollment = @course&.enrollment_for(current_user) if @course
    else
      # Try to find from quiz associations
      module_item = @quiz.module_items.first
      if module_item
        @course_module = module_item.course_module
        @course = @course_module.course
        @enrollment = @course.enrollment_for(current_user)
      end
    end
  end
  
  def check_attempt_limit
    unless @quiz.can_attempt?(current_user)
      redirect_to quiz_path(@quiz), alert: "You have reached the maximum number of attempts for this quiz."
    end
  end
  
  def find_next_item
    return nil unless @module_item
    
    current_position = @module_item.sequence_order
    next_module_item = @course_module.module_items.ordered.where('sequence_order > ?', current_position).first
    
    next_module_item
  end

  def enforce_guided_progress
    return unless @enrollment && @course

    # If current item is set and it's not this quiz, redirect
    if @enrollment.current_item.present? && @enrollment.current_item != @quiz
      redirect_to course_path(@course), notice: "Continue your current learning item first." and return
    end
  end
end