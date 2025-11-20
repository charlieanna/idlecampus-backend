class AdaptivePracticeService
  # Heuristic adaptive question selection (fallback when Flask is unavailable)
  
  def initialize(user)
    @user = user
  end
  
  def select_next_question(context = {})
    """
    Select next question using heuristic rules
    
    Context:
      - skill_dimension: string
      - recent_topics: array
      - exclude_question_ids: array
      - target_difficulty: float (optional)
    
    Strategy:
      1. Filter by skill_dimension if provided
      2. Exclude recently seen topics
      3. Select difficulty based on recent performance
      4. Prefer questions user hasn't seen
    """
    
    # Get user's recent performance in this dimension
    recent_performance = calculate_recent_performance(context[:skill_dimension])
    
    # Determine target difficulty
    target_difficulty = determine_target_difficulty(recent_performance, context)
    
    # Build query
    questions = QuizQuestion.all
    
    # Filter by skill dimension
    if context[:skill_dimension].present?
      questions = questions.by_skill_dimension(context[:skill_dimension])
    end
    
    # Exclude recently seen topics
    if context[:recent_topics].present?
      questions = questions.where.not(topic: context[:recent_topics].last(3))
    end
    
    # Exclude specific questions
    if context[:exclude_question_ids].present?
      questions = questions.where.not(id: context[:exclude_question_ids])
    end
    
    # Filter by difficulty range (±0.5 around target)
    questions = questions.where(
      'difficulty BETWEEN ? AND ?',
      target_difficulty - 0.5,
      target_difficulty + 0.5
    )
    
    # Select question (prefer unseen by user)
    answered_ids = get_answered_question_ids
    unseen = questions.where.not(id: answered_ids)
    
    selected = if unseen.any?
                 unseen.order('RANDOM()').first
               else
                 questions.order('RANDOM()').first
               end
    
    {
      question: selected,
      reason: build_selection_reason(selected, target_difficulty),
      difficulty_match: selected ? calculate_difficulty_match(selected.difficulty, target_difficulty) : 0.0,
      using_fallback: true
    }
  end
  
  def submit_answer(question:, user_answer:, correct:, time_taken: nil)
    """
    Process answer submission and update user state
    
    Returns:
      {
        ability_update: { new_ability, confidence },
        feedback: hash,
        next_difficulty: float,
        analysis: hash (if wrong)
      }
    """
    
    # Record the answer
    record_answer(question, correct, time_taken)
    
    # Calculate new ability estimate (simple ELO-like)
    new_ability = update_ability_estimate(question, correct)
    
    # Generate feedback and analyze if wrong
    if correct
      feedback = generate_feedback(question, correct)
      analysis = nil
    else
      # Use WrongAnswerAnalyzer for detailed feedback
      analyzer = WrongAnswerAnalyzer.new(question, user_answer, question.formatted_correct_answer)
      analysis = analyzer.analyze
      feedback = analysis[:feedback]
    end
    
    # Determine next difficulty
    next_difficulty = calculate_next_difficulty(new_ability)
    
    result = {
      ability_update: {
        new_ability: new_ability,
        confidence: calculate_confidence
      },
      feedback: feedback,
      next_difficulty: next_difficulty,
      using_fallback: true
    }
    
    # Add detailed analysis if wrong
    result[:analysis] = analysis if analysis
    
    result
  end
  
  private
  
  def calculate_recent_performance(skill_dimension = nil)
    """Calculate average correctness from recent 10 answers"""
    
    events = LearningEvent
      .for_user(@user.id)
      .by_type('quiz_question_answered')
      .recent
      .limit(10)
    
    # Filter by skill dimension if provided
    if skill_dimension
      events = events.where("skill_dimensions LIKE ?", "%#{skill_dimension}%")
    end
    
    total = events.count
    return 0.5 if total == 0 # Neutral start
    
    correct_count = events.where('performance_score > 0').count
    correct_count.to_f / total
  end
  
  def determine_target_difficulty(recent_performance, context)
    """Determine target difficulty based on performance"""
    
    # Use explicit target if provided
    return context[:target_difficulty].to_f if context[:target_difficulty].present?
    
    # Heuristic mapping
    case recent_performance
    when 0.8..1.0
      1.0  # Hard
    when 0.6..0.8
      0.5  # Medium-Hard
    when 0.4..0.6
      0.0  # Medium
    when 0.2..0.4
      -0.5 # Easy-Medium
    else
      -1.0 # Easy
    end
  end
  
  def get_answered_question_ids
    """Get IDs of questions user has already answered"""
    
    LearningEvent
      .for_user(@user.id)
      .by_type('quiz_question_answered')
      .pluck("json_extract(event_data, '$.question_id')")
      .compact
      .uniq
  end
  
  def build_selection_reason(question, target_difficulty)
    return "No suitable questions found" unless question
    
    "Selected #{question.difficulty_level || 'medium'} question (difficulty: #{question.difficulty.round(2)}) " \
    "targeting ability around #{target_difficulty.round(2)}"
  end
  
  def calculate_difficulty_match(question_difficulty, target_difficulty)
    """Calculate how well question matches target (0-1 scale)"""
    distance = (question_difficulty - target_difficulty).abs
    [1.0 - (distance / 2.0), 0.0].max
  end
  
  def record_answer(question, correct, time_taken)
    """Record answer in learning events"""
    
    LearningEventTracker.quiz_question_answered(
      user: @user,
      question: question,
      answer: nil, # Not storing actual answer here
      correct: correct,
      time_taken: time_taken,
      context: { adaptive: true, fallback: true }
    )
  end
  
  def update_ability_estimate(question, correct)
    """Simple ELO-like ability update"""
    
    # Get or initialize ability
    dimension = UserSkillDimension.find_or_create_by(
      user: @user,
      dimension: question.skill_dimension || 'general'
    )
    
    current_ability = dimension.ability_estimate
    
    # Expected performance using simple logistic
    expected_correct = 1.0 / (1.0 + Math.exp(-(current_ability - question.difficulty)))
    
    # Update based on surprise
    k_factor = 0.3 # Learning rate
    surprise = (correct ? 1.0 : 0.0) - expected_correct
    new_ability = current_ability + (k_factor * surprise)
    
    # Update dimension
    dimension.update!(
      ability_estimate: new_ability,
      standard_error: [dimension.standard_error - 0.05, 0.3].max,
      n_observations: dimension.n_observations + 1,
      last_updated_at: Time.current
    )
    
    new_ability
  end
  
  def generate_feedback(question, correct)
    """Generate feedback based on correctness"""
    
    if correct
      {
        level_1: ['Great job!', 'Excellent!', 'Well done!', 'Correct!'].sample,
        explanation: question.explanation
      }
    else
      {
        level_1: 'Not quite right. Review the explanation below.',
        level_2: question.explanation&.split('.')&.first,
        level_3: question.explanation,
        solution: question.formatted_correct_answer
      }
    end
  end
  
  def calculate_next_difficulty(ability)
    """Recommend next question difficulty"""
    # Target slightly above current ability for optimal learning
    ability + 0.2
  end
  
  def calculate_confidence
    """Calculate confidence in ability estimate"""
    
    # More observations = higher confidence
    n = LearningEvent.for_user(@user.id).by_type('quiz_question_answered').count
    
    # Confidence increases with sample size, capped at 0.95
    [0.5 + (n.to_f / 40.0), 0.95].min
  end
end

