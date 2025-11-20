class AdaptiveRetryQuizGenerator
  def initialize(original_quiz_attempt)
    @original_attempt = original_quiz_attempt
    @original_quiz = original_quiz_attempt.quiz
    @user = original_quiz_attempt.user
  end
  
  def generate_retry_quiz(focus_ratio: 0.7)
    analyzer = EnhancedWrongAnswerAnalyzer.new(@original_attempt)
    config = analyzer.analyze_and_recommend[:adaptive_quiz_config]
    
    total_questions = @original_quiz.quiz_questions.count
    focused_count = (total_questions * config[:focus_ratio]).round
    general_count = total_questions - focused_count
    
    # Select questions
    focused_questions = select_focused_questions(
      config[:target_topics],
      config[:target_skills],
      focused_count,
      config[:difficulty_adjustment]
    )
    
    general_questions = select_confidence_questions(general_count)
    
    # Combine and shuffle
    all_questions = (focused_questions + general_questions).shuffle
    
    # Create dynamic quiz
    create_dynamic_quiz(all_questions, config)
  end
  
  private
  
  def select_focused_questions(target_topics, target_skills, count, difficulty_adjustment)
    # Get user's ability estimate
    ability = AbilityCacheService.get(@user.id) || 0.0
    adjusted_ability = ability + difficulty_adjustment
    
    # Get course_id through the quiz's course_modules
    course_id = @original_quiz.course&.id
    
    # Build query for questions matching weak topics/skills
    questions = if course_id
      QuizQuestion.joins(quiz: { course_modules: :course })
        .where(courses: { id: course_id })
        .where.not(id: already_seen_question_ids)
    else
      QuizQuestion.where.not(id: already_seen_question_ids)
    end
    
    # Filter by topics if available
    if target_topics.any?
      questions = questions.where(topic: target_topics)
    end
    
    # Filter by skills if available
    if target_skills.any?
      questions = questions.where(skill_dimension: target_skills)
    end
    
    # Match difficulty to adjusted ability
    questions = questions.where(
      'difficulty BETWEEN ? AND ?',
      adjusted_ability - 1.0,
      adjusted_ability + 1.0
    )
    
    # Randomize and limit
    questions.order('RANDOM()').limit(count).to_a
  end
  
  def select_confidence_questions(count)
    # Select questions from topics user did well on
    correct_topics = get_correct_answer_topics
    
    return [] if correct_topics.empty? || count.zero?
    
    ability = AbilityCacheService.get(@user.id) || 0.0
    course_id = @original_quiz.course&.id
    
    questions = if course_id
      QuizQuestion.joins(quiz: { course_modules: :course })
        .where(courses: { id: course_id })
        .where(topic: correct_topics)
        .where.not(id: already_seen_question_ids)
    else
      QuizQuestion.where(topic: correct_topics)
        .where.not(id: already_seen_question_ids)
    end
    
    questions.where('difficulty BETWEEN ? AND ?', ability - 0.5, ability + 0.5)
      .order('RANDOM()')
      .limit(count)
      .to_a
  end
  
  def create_dynamic_quiz(questions, config)
    # Create a new quiz record for this adaptive retry
    quiz = Quiz.create!(
      title: "Adaptive Retry: #{@original_quiz.title}",
      description: "Focused practice quiz based on your performance",
      passing_score: @original_quiz.passing_score,
      time_limit_minutes: @original_quiz.time_limit_minutes,
      metadata: {
        adaptive_retry: true,
        parent_quiz_id: @original_quiz.id
      }
    )
    
    # Add questions to the quiz
    questions.each_with_index do |question, index|
      # Clone the question for this quiz
      new_question = question.dup
      new_question.quiz_id = quiz.id
      new_question.sequence_order = index + 1
      new_question.save!
    end
    
    # Store metadata about the adaptive config
    quiz.update(
      metadata: quiz.metadata.merge({
        original_attempt_id: @original_attempt.id,
        focus_ratio: config[:focus_ratio],
        target_topics: config[:target_topics],
        target_skills: config[:target_skills],
        difficulty_adjustment: config[:difficulty_adjustment],
        generated_at: Time.current.to_s
      })
    )
    
    quiz
  end
  
  def already_seen_question_ids
    # Get all question IDs the user has seen in this quiz and recent attempts
    recent_attempts = QuizAttempt.where(
      user_id: @user.id,
      quiz_id: @original_quiz.id
    ).where('created_at > ?', 1.week.ago)
    
    seen_ids = []
    recent_attempts.each do |attempt|
      seen_ids += attempt.answers.keys.map(&:to_i) if attempt.answers.is_a?(Hash)
    end
    
    seen_ids.uniq
  end
  
  def get_correct_answer_topics
    return [] unless @original_attempt.answers.is_a?(Hash)
    
    correct_topics = []
    @original_attempt.answers.each do |question_id, user_answer|
      question = QuizQuestion.find_by(id: question_id)
      next unless question
      
      if question.correct_answer?(user_answer)
        correct_topics << question.topic
      end
    end
    
    correct_topics.compact.uniq
  end
end
