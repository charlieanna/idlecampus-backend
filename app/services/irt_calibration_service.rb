class IRTCalibrationService
  """
  IRT (Item Response Theory) parameter calibration
  Calibrates question difficulty and discrimination from response data
  """
  
  def calibrate_all_questions
    """
    Calibrate IRT parameters for all questions with sufficient response data
    Run as background job weekly
    """
    
    calibrated = 0
    skipped = 0
    
    QuizQuestion.find_each do |question|
      # Need at least 30 responses for reliable calibration
      responses = get_question_responses(question)
      
      if responses.count >= 30
        calibrate_question(question, responses)
        calibrated += 1
        print '.' if calibrated % 10 == 0
      else
        skipped += 1
      end
    end
    
    puts "\n✅ IRT Calibration complete!"
    puts "   Calibrated: #{calibrated} questions"
    puts "   Skipped: #{skipped} questions (insufficient data)"
    
    # Update calibration timestamp
    Rails.cache.write('irt:last_calibration', Time.current, expires_in: 7.days)
    
    {
      calibrated: calibrated,
      skipped: skipped,
      timestamp: Time.current
    }
  end
  
  def calibrate_question(question, responses)
    """
    Calibrate single question using Maximum Likelihood Estimation
    
    Uses 2-parameter logistic model (2PL):
    P(correct) = 1 / (1 + exp(-a * (θ - b)))
    where:
      a = discrimination (how well question differentiates ability)
      b = difficulty (ability level where P(correct) = 0.5)
      θ = user ability
    """
    
    # Extract ability and correctness data
    abilities = responses.map { |r| r[:ability] }
    correct = responses.map { |r| r[:correct] ? 1 : 0 }
    
    # Initial estimates
    difficulty_est = estimate_difficulty(abilities, correct)
    discrimination_est = estimate_discrimination(abilities, correct, difficulty_est)
    
    # Refine using Newton-Raphson (simplified)
    5.times do
      difficulty_est, discrimination_est = refine_estimates(
        abilities, correct, difficulty_est, discrimination_est
      )
    end
    
    # Update question
    question.update!(
      difficulty: difficulty_est.clamp(-3.0, 3.0),
      discrimination: discrimination_est.clamp(0.1, 3.0),
      guessing: estimate_guessing(question, correct) # Update if MCQ
    )
    
    StructuredLogger.log_event(
      category: 'irt',
      action: 'question_calibrated',
      context: {
        question_id: question.id,
        responses: responses.count,
        difficulty: difficulty_est.round(2),
        discrimination: discrimination_est.round(2)
      }
    )
  end
  
  private
  
  def get_question_responses(question)
    """Get all responses to this question with user abilities"""
    
    # Get learning events for this question
    events = LearningEvent
      .by_type('quiz_question_answered')
      .where("json_extract(event_data, '$.question_id') = ?", question.id)
      .limit(200) # Cap at 200 most recent responses
    
    responses = []
    
    events.each do |event|
      user_id = event.user_id
      correct = event.performance_score > 0
      
      # Get user's ability at the time (or current)
      ability = get_user_ability_at_time(user_id, event.created_at, question.skill_dimension)
      
      responses << {
        user_id: user_id,
        ability: ability,
        correct: correct,
        time_taken: event.time_spent_seconds
      }
    end
    
    responses
  end
  
  def get_user_ability_at_time(user_id, timestamp, dimension)
    """Get user ability at specific time (or current if recent)"""
    
    # Use current ability if within 7 days
    if timestamp > 7.days.ago
      skill_dim = UserSkillDimension.find_by(user_id: user_id, dimension: dimension)
      return skill_dim&.ability_estimate || 0.0
    end
    
    # Otherwise use 0.0 (neutral)
    0.0
  end
  
  def estimate_difficulty(abilities, correct)
    """
    Estimate difficulty as ability level where ~50% get it right
    Uses median ability of users split by correctness
    """
    
    correct_abilities = abilities.zip(correct).select { |_, c| c == 1 }.map(&:first)
    incorrect_abilities = abilities.zip(correct).select { |_, c| c == 0 }.map(&:first)
    
    return 0.0 if correct_abilities.empty? || incorrect_abilities.empty?
    
    # Difficulty is between median of correct and incorrect groups
    median_correct = median(correct_abilities)
    median_incorrect = median(incorrect_abilities)
    
    (median_correct + median_incorrect) / 2.0
  end
  
  def estimate_discrimination(abilities, correct, difficulty)
    """
    Estimate discrimination (slope at difficulty point)
    Higher discrimination = better at separating high/low ability
    """
    
    # Calculate variance of correct/incorrect abilities around difficulty
    correct_abilities = abilities.zip(correct).select { |_, c| c == 1 }.map(&:first)
    incorrect_abilities = abilities.zip(correct).select { |_, c| c == 0 }.map(&:first)
    
    return 1.0 if correct_abilities.empty? || incorrect_abilities.empty?
    
    # Discrimination is inversely related to overlap
    variance = calculate_variance(correct_abilities + incorrect_abilities)
    
    # Higher variance = lower discrimination
    discrimination = 2.0 / (1.0 + variance)
    
    discrimination.clamp(0.1, 3.0)
  end
  
  def refine_estimates(abilities, correct, difficulty, discrimination)
    """Refine estimates using gradient descent step"""
    
    # Calculate log-likelihood gradient
    gradient_difficulty = 0.0
    gradient_discrimination = 0.0
    
    abilities.zip(correct).each do |ability, is_correct|
      p_correct = irt_probability(ability, difficulty, discrimination)
      
      error = is_correct - p_correct
      
      # Gradient for difficulty
      gradient_difficulty += error * discrimination * p_correct * (1 - p_correct)
      
      # Gradient for discrimination  
      gradient_discrimination += error * (ability - difficulty) * p_correct * (1 - p_correct)
    end
    
    # Update estimates (learning rate = 0.01)
    learning_rate = 0.01
    new_difficulty = difficulty + (learning_rate * gradient_difficulty)
    new_discrimination = discrimination + (learning_rate * gradient_discrimination)
    
    [new_difficulty, new_discrimination]
  end
  
  def irt_probability(ability, difficulty, discrimination)
    """Calculate probability of correct response using 2PL IRT"""
    
    1.0 / (1.0 + Math.exp(-discrimination * (ability - difficulty)))
  end
  
  def estimate_guessing(question, correct_responses)
    """Estimate guessing parameter for MCQ"""
    
    return 0.0 unless question.question_type == 'mcq'
    
    # For MCQ, guessing is approximately 1 / number_of_options
    options_count = question.options&.count || 4
    
    # Use empirical floor from very low ability responses
    empirical_floor = correct_responses.min || 0
    
    # Take higher of theoretical (1/n) or empirical
    [1.0 / options_count, empirical_floor, 0.5].min
  end
  
  def median(array)
    """Calculate median of array"""
    return 0.0 if array.empty?
    
    sorted = array.sort
    len = sorted.length
    
    if len.odd?
      sorted[len / 2]
    else
      (sorted[len / 2 - 1] + sorted[len / 2]) / 2.0
    end
  end
  
  def calculate_variance(array)
    """Calculate variance"""
    return 0.0 if array.empty?
    
    mean = array.sum.to_f / array.length
    sum_squared_diff = array.map { |x| (x - mean) ** 2 }.sum
    
    sum_squared_diff / array.length
  end
end

