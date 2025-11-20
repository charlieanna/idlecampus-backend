# GRE Weakness Detection Service
# Analyzes user performance on GRE Verbal Reasoning to identify specific weaknesses
# by question type, difficulty, and topic

class GREWeaknessDetectionService
  # GRE Verbal question types
  VERBAL_QUESTION_TYPES = {
    'reading_comprehension' => 'Reading Comprehension',
    'text_completion' => 'Text Completion',
    'sentence_equivalence' => 'Sentence Equivalence'
  }.freeze

  # GRE Quantitative question types (for future use)
  QUANT_QUESTION_TYPES = {
    'arithmetic' => 'Arithmetic',
    'algebra' => 'Algebra',
    'geometry' => 'Geometry',
    'data_analysis' => 'Data Analysis'
  }.freeze

  def initialize(user)
    @user = user
  end

  # Main method to detect all GRE weaknesses
  def detect_weaknesses(section: :verbal)
    case section
    when :verbal
      detect_verbal_weaknesses
    when :quantitative
      detect_quantitative_weaknesses
    else
      detect_all_weaknesses
    end
  end

  # Detect weaknesses in GRE Verbal section
  def detect_verbal_weaknesses
    {
      overall_ability: calculate_overall_verbal_ability,
      by_question_type: analyze_by_question_type,
      by_difficulty: analyze_by_difficulty('gre_verbal'),
      time_management: analyze_time_management,
      recommendations: generate_recommendations(:verbal),
      study_plan: generate_study_plan(:verbal)
    }
  end

  # Detect weaknesses in GRE Quantitative section
  def detect_quantitative_weaknesses
    {
      overall_ability: calculate_overall_quantitative_ability,
      by_topic: analyze_by_topic('gre_quant'),
      by_difficulty: analyze_by_difficulty('gre_quant'),
      recommendations: generate_recommendations(:quantitative),
      study_plan: generate_study_plan(:quantitative)
    }
  end

  # Comprehensive analysis across all GRE content
  def detect_all_weaknesses
    {
      verbal: detect_verbal_weaknesses,
      quantitative: detect_quantitative_weaknesses,
      overall_readiness: calculate_overall_readiness
    }
  end

  # Get personalized practice recommendations
  def get_practice_recommendations
    weaknesses = detect_verbal_weaknesses

    recommendations = []

    # Analyze each question type
    weaknesses[:by_question_type].each do |type, stats|
      next if stats[:accuracy] >= 80 # Skip if doing well

      severity = calculate_severity(stats[:accuracy])

      recommendations << {
        area: VERBAL_QUESTION_TYPES[type],
        severity: severity,
        current_accuracy: stats[:accuracy],
        target_accuracy: 85,
        gap: 85 - stats[:accuracy],
        practice_needed: estimate_practice_needed(stats[:accuracy], 85),
        specific_recommendations: type_specific_recommendations(type, stats)
      }
    end

    # Sort by severity
    recommendations.sort_by { |r| -r[:severity] }
  end

  # Get study plan with time estimates
  def get_detailed_study_plan(target_score:, timeframe_weeks:)
    current_verbal = calculate_overall_verbal_ability[:gre_score]
    score_gap = target_score - current_verbal

    {
      current_score: current_verbal,
      target_score: target_score,
      score_gap: score_gap,
      timeframe_weeks: timeframe_weeks,
      hours_per_week: calculate_hours_per_week(score_gap, timeframe_weeks),
      weekly_breakdown: generate_weekly_breakdown(timeframe_weeks),
      priority_topics: get_priority_topics,
      milestone_schedule: generate_milestones(target_score, timeframe_weeks)
    }
  end

  private

  # Calculate overall verbal ability from sub-dimensions
  def calculate_overall_verbal_ability
    dimensions = [
      'gre_reading_comprehension',
      'gre_text_completion',
      'gre_sentence_equivalence'
    ]

    abilities = dimensions.map do |dim|
      skill_dim = @user.user_skill_dimensions.find_by(dimension: dim)
      skill_dim&.ability_estimate || 0.0
    end

    # Weighted average: Reading 50%, Text Completion 30%, Sentence Equiv 20%
    weighted_ability = (abilities[0] * 0.5) + (abilities[1] * 0.3) + (abilities[2] * 0.2)
    gre_score = GREScoreScalingService.ability_to_gre_score(weighted_ability)

    {
      ability_estimate: weighted_ability.round(2),
      gre_score: gre_score,
      percentile: GREScoreScalingService.score_to_percentile(gre_score, section: :verbal),
      interpretation: GREScoreScalingService.interpret_score(gre_score),
      confidence: calculate_confidence(dimensions)
    }
  end

  # Calculate overall quantitative ability
  def calculate_overall_quantitative_ability
    dimensions = [
      'gre_quantitative_arithmetic',
      'gre_quantitative_algebra',
      'gre_quantitative_geometry',
      'gre_quantitative_data_analysis'
    ]

    abilities = dimensions.map do |dim|
      skill_dim = @user.user_skill_dimensions.find_by(dimension: dim)
      skill_dim&.ability_estimate || 0.0
    end

    # Equal weighting for quant sections
    avg_ability = abilities.sum / abilities.size.to_f
    gre_score = GREScoreScalingService.ability_to_gre_score(avg_ability)

    {
      ability_estimate: avg_ability.round(2),
      gre_score: gre_score,
      percentile: GREScoreScalingService.score_to_percentile(gre_score, section: :quantitative),
      interpretation: GREScoreScalingService.interpret_score(gre_score),
      confidence: calculate_confidence(dimensions)
    }
  end

  # Analyze performance by question type
  def analyze_by_question_type
    course = Course.find_by(slug: 'gre-verbal-reasoning')
    return {} unless course

    results = {}

    # Group modules by question type
    type_mappings = {
      'reading-comprehension' => 'reading_comprehension',
      'text-completion' => 'text_completion',
      'sentence-equivalence' => 'sentence_equivalence'
    }

    type_mappings.each do |module_slug, type_key|
      module_data = course.course_modules.find_by(slug: module_slug)
      next unless module_data

      quiz = module_data.quiz
      next unless quiz

      attempts = @user.quiz_attempts.where(quiz: quiz).completed
      next if attempts.empty?

      total_questions = 0
      correct_questions = 0
      total_time = 0

      attempts.each do |attempt|
        total_questions += attempt.total_questions || 0
        correct_questions += attempt.correct_count || 0
        total_time += attempt.time_taken || 0
      end

      accuracy = total_questions > 0 ? (correct_questions.to_f / total_questions * 100).round(1) : 0
      avg_time_per_question = total_questions > 0 ? (total_time.to_f / total_questions).round(1) : 0

      results[type_key] = {
        attempts: attempts.count,
        total_questions: total_questions,
        correct: correct_questions,
        incorrect: total_questions - correct_questions,
        accuracy: accuracy,
        avg_time_per_question: avg_time_per_question,
        status: performance_status(accuracy)
      }
    end

    results
  end

  # Analyze performance by difficulty level
  def analyze_by_difficulty(prefix)
    quiz_attempts = @user.quiz_attempts.completed.joins(:quiz)
      .where("quizzes.title LIKE ?", "%#{prefix.upcase}%")

    by_difficulty = Hash.new { |h, k| h[k] = { correct: 0, total: 0 } }

    quiz_attempts.each do |attempt|
      attempt.quiz.quiz_questions.each do |question|
        difficulty_level = categorize_difficulty(question.difficulty)

        by_difficulty[difficulty_level][:total] += 1

        answer_data = attempt.answers&.dig(question.id.to_s)
        is_correct = question.correct_answer?(answer_data)
        by_difficulty[difficulty_level][:correct] += 1 if is_correct
      end
    end

    # Calculate percentages
    by_difficulty.transform_values do |data|
      accuracy = data[:total] > 0 ? (data[:correct].to_f / data[:total] * 100).round(1) : 0
      {
        correct: data[:correct],
        total: data[:total],
        accuracy: accuracy,
        status: performance_status(accuracy)
      }
    end
  end

  # Analyze time management
  def analyze_time_management
    recent_attempts = @user.quiz_attempts.completed
      .where('created_at > ?', 30.days.ago)
      .joins(:quiz)
      .where("quizzes.title LIKE ?", "%GRE%")
      .limit(10)

    return {} if recent_attempts.empty?

    total_questions = 0
    total_time = 0
    timed_out = 0

    recent_attempts.each do |attempt|
      total_questions += attempt.total_questions || 0
      total_time += attempt.time_taken || 0
      timed_out += 1 if attempt.time_taken && attempt.time_taken >= (attempt.quiz.time_limit_minutes * 60)
    end

    avg_time = total_questions > 0 ? (total_time.to_f / total_questions).round(1) : 0

    {
      avg_time_per_question: avg_time,
      total_attempts: recent_attempts.count,
      timed_out_count: timed_out,
      time_management_status: time_status(avg_time, timed_out, recent_attempts.count)
    }
  end

  # Analyze by specific topics
  def analyze_by_topic(prefix)
    # This would analyze performance by specific topics within modules
    # For now, return empty hash (can be expanded later)
    {}
  end

  # Generate personalized recommendations
  def generate_recommendations(section)
    if section == :verbal
      weaknesses = analyze_by_question_type
      recommendations = []

      weaknesses.each do |type, stats|
        next if stats[:accuracy] >= 80

        recommendations << {
          focus_area: VERBAL_QUESTION_TYPES[type],
          current_performance: "#{stats[:accuracy]}% accuracy",
          goal: "Reach 85% accuracy",
          action_items: type_specific_recommendations(type, stats)
        }
      end

      recommendations
    else
      []
    end
  end

  # Generate study plan
  def generate_study_plan(section)
    weaknesses = section == :verbal ? analyze_by_question_type : {}

    return [] if weaknesses.empty?

    # Sort by worst performance first
    sorted_areas = weaknesses.sort_by { |_type, stats| stats[:accuracy] }

    plan = []
    week = 1

    sorted_areas.each do |type, stats|
      next if stats[:accuracy] >= 85 # Already proficient

      improvement_needed = 85 - stats[:accuracy]
      weeks_needed = (improvement_needed / 10.0).ceil # Roughly 10% improvement per week

      plan << {
        weeks: (week..(week + weeks_needed - 1)).to_a,
        focus_area: VERBAL_QUESTION_TYPES[type] || type,
        current_accuracy: stats[:accuracy],
        target_accuracy: 85,
        estimated_weeks: weeks_needed,
        daily_practice: "30-45 minutes",
        specific_tasks: weekly_tasks(type)
      }

      week += weeks_needed
    end

    plan
  end

  # Calculate overall readiness
  def calculate_overall_readiness
    verbal = calculate_overall_verbal_ability
    quant = calculate_overall_quantitative_ability rescue { gre_score: 150 }

    combined_score = ((verbal[:gre_score] + quant[:gre_score]) / 2.0).round

    {
      verbal_score: verbal[:gre_score],
      quantitative_score: quant[:gre_score],
      combined_score: combined_score,
      readiness_level: readiness_level(combined_score),
      recommendation: readiness_recommendation(combined_score)
    }
  end

  # Helper methods

  def categorize_difficulty(difficulty_value)
    case difficulty_value
    when -Float::INFINITY...-0.5 then 'easy'
    when -0.5...0.5 then 'medium'
    else 'hard'
    end
  end

  def performance_status(accuracy)
    case accuracy
    when 90..100 then 'Excellent'
    when 80...90 then 'Good'
    when 70...80 then 'Fair'
    when 60...70 then 'Needs Improvement'
    else 'Significant Improvement Needed'
    end
  end

  def time_status(avg_time, timed_out, total_attempts)
    timeout_rate = (timed_out.to_f / total_attempts * 100).round(1)

    if timeout_rate > 30
      'Time management issues - too slow'
    elsif avg_time < 30
      'May be rushing - check accuracy'
    else
      'Good time management'
    end
  end

  def calculate_confidence(dimensions)
    skill_dims = dimensions.map { |d| @user.user_skill_dimensions.find_by(dimension: d) }.compact
    return 'Low' if skill_dims.empty?

    avg_observations = skill_dims.sum(&:n_observations) / skill_dims.size.to_f
    avg_std_error = skill_dims.sum(&:standard_error) / skill_dims.size.to_f

    if avg_observations >= 10 && avg_std_error < 0.5
      'High'
    elsif avg_observations >= 5
      'Medium'
    else
      'Low'
    end
  end

  def calculate_severity(accuracy)
    case accuracy
    when 0...40 then 1.0 # Critical
    when 40...55 then 0.8 # High
    when 55...70 then 0.6 # Medium
    when 70...80 then 0.4 # Low
    else 0.2 # Minor
    end
  end

  def estimate_practice_needed(current_accuracy, target_accuracy)
    gap = target_accuracy - current_accuracy
    questions_needed = (gap * 5).to_i # Roughly 5 questions per 1% improvement

    {
      questions: questions_needed,
      hours: (questions_needed / 10.0).ceil, # 10 questions per hour
      days: (questions_needed / 20.0).ceil # 20 questions per day
    }
  end

  def type_specific_recommendations(type, stats)
    case type
    when 'reading_comprehension'
      [
        'Practice active reading strategies',
        'Focus on identifying main ideas quickly',
        'Work on inference questions',
        'Time yourself on passages (3-4 minutes per passage)'
      ]
    when 'text_completion'
      [
        'Build vocabulary systematically',
        'Practice using context clues',
        'Work on double-blank and triple-blank questions',
        'Review word roots and prefixes'
      ]
    when 'sentence_equivalence'
      [
        'Study synonym pairs',
        'Focus on connotation differences',
        'Practice identifying true synonyms vs. related words',
        'Review high-frequency GRE vocabulary'
      ]
    else
      ['Practice regularly', 'Review mistakes carefully', 'Focus on weak areas']
    end
  end

  def weekly_tasks(type)
    case type
    when 'reading_comprehension'
      ['Mon-Fri: 1 passage per day', 'Weekend: 2 full practice sets', 'Review all mistakes']
    when 'text_completion'
      ['Daily: 10 single-blank questions', 'Every other day: 5 double-blank questions', 'Weekly: 20 new vocabulary words']
    when 'sentence_equivalence'
      ['Daily: 10 sentence equivalence questions', 'Study 15 synonym pairs', 'Review 30 vocabulary words']
    else
      ['Daily practice', 'Weekly review']
    end
  end

  def calculate_hours_per_week(score_gap, timeframe_weeks)
    # Rough estimate: need more hours for larger gaps
    if score_gap <= 5
      5 # Light practice
    elsif score_gap <= 10
      10 # Moderate practice
    elsif score_gap <= 15
      15 # Intensive practice
    else
      20 # Very intensive practice
    end
  end

  def generate_weekly_breakdown(timeframe_weeks)
    # Generate a sample breakdown
    (1..timeframe_weeks).map do |week|
      {
        week: week,
        focus: week <= (timeframe_weeks / 2) ? 'Content mastery' : 'Practice & review',
        hours: 10,
        activities: [
          'Lessons: 3-4 hours',
          'Practice questions: 4-5 hours',
          'Practice test: 2-3 hours (every other week)'
        ]
      }
    end
  end

  def get_priority_topics
    weaknesses = analyze_by_question_type
    weaknesses.select { |_type, stats| stats[:accuracy] < 75 }
      .sort_by { |_type, stats| stats[:accuracy] }
      .map { |type, stats|
        {
          topic: VERBAL_QUESTION_TYPES[type],
          accuracy: stats[:accuracy],
          priority: 'High'
        }
      }
  end

  def generate_milestones(target_score, timeframe_weeks)
    current_score = calculate_overall_verbal_ability[:gre_score]
    score_gap = target_score - current_score
    improvement_per_milestone = score_gap / 4.0

    (1..4).map do |milestone|
      week = (timeframe_weeks * milestone / 4.0).round
      milestone_score = current_score + (improvement_per_milestone * milestone)

      {
        milestone: milestone,
        target_week: week,
        target_score: milestone_score.round,
        description: "Milestone #{milestone}: Reach #{milestone_score.round} by week #{week}"
      }
    end
  end

  def readiness_level(combined_score)
    case combined_score
    when 160..170 then 'Excellent - Ready for top programs'
    when 155..159 then 'Very Good - Ready for most programs'
    when 150..154 then 'Good - Competitive for many programs'
    when 145..149 then 'Fair - Consider more practice'
    else 'Needs Improvement - Extensive practice recommended'
    end
  end

  def readiness_recommendation(combined_score)
    if combined_score >= 155
      'You are ready to take the GRE. Consider taking a final practice exam.'
    elsif combined_score >= 150
      'You are close to ready. Focus on weak areas for 2-3 more weeks.'
    elsif combined_score >= 145
      'Continue practicing. Aim for 4-6 more weeks of focused study.'
    else
      'Significant preparation needed. Consider a 2-3 month study plan.'
    end
  end
end
