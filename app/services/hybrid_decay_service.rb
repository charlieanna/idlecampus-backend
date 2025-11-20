class HybridDecayService
  include ActiveModel::Model

  # Configuration
  MUSCLE_MEMORY_FLOOR = 40.0
  DEFAULT_STABILITY = 7.0
  INTERFERENCE_RATE_PER_CHAPTER = 0.02  # 2% per chapter
  PROTECTED_RECENT_COUNT = 2
  MAX_INTERFERENCE_CHAPTERS = 20

  attr_accessor :user_command_mastery

  def initialize(user_command_mastery)
    @user_command_mastery = user_command_mastery
  end

  # Main method: Calculate current score with hybrid decay
  def current_decayed_score
    base_score = user_command_mastery.proficiency_score
    return base_score if just_mastered?

    # Component 1: FSRS time-based decay
    fsrs_retention = calculate_fsrs_retention

    # Component 2: Progress-based interference
    interference_factor = calculate_interference_factor

    # Combine both
    combined_score = base_score * fsrs_retention * interference_factor

    # Apply muscle memory floor
    final_score = [combined_score, MUSCLE_MEMORY_FLOOR].max

    Rails.logger.debug "Hybrid Decay: #{user_command_mastery.canonical_command} - " \
                       "Base: #{base_score}%, FSRS: #{(fsrs_retention * 100).round(1)}%, " \
                       "Interference: #{(interference_factor * 100).round(1)}%, " \
                       "Final: #{final_score.round(1)}%"

    final_score
  end

  # FSRS Component: Time-based forgetting
  def calculate_fsrs_retention
    return 1.0 unless user_command_mastery.last_used_at

    days_elapsed = days_since_last_use
    return 1.0 if days_elapsed <= 0

    stability = user_command_mastery.stability || DEFAULT_STABILITY

    # FSRS formula: R = e^(-t/S)
    Math.exp(-days_elapsed / stability)
  end

  # Progress Component: Interference from new chapters
  def calculate_interference_factor
    chapters_since = chapters_completed_since_mastery
    return 1.0 if chapters_since <= PROTECTED_RECENT_COUNT

    # Apply protection: subtract protected chapters
    effective_chapters = chapters_since - PROTECTED_RECENT_COUNT

    # Cap at max interference
    capped_chapters = [effective_chapters, MAX_INTERFERENCE_CHAPTERS].min

    # Calculate interference penalty
    penalty = capped_chapters * INTERFERENCE_RATE_PER_CHAPTER

    # Return factor (1.0 = no interference, 0.6 = 40% interference)
    1.0 - penalty
  end

  # Get chapters completed since this command was mastered
  def chapters_completed_since_mastery
    user_command_mastery.chapters_completed_since_mastery
  end

  # Determine if command was just mastered (no decay yet)
  def just_mastered?
    return false unless user_command_mastery.last_used_at

    # Within last hour = just completed
    (Time.current - user_command_mastery.last_used_at) < 1.hour
  end

  # Calculate days since last use
  def days_since_last_use
    return 0 unless user_command_mastery.last_used_at

    (Time.current - user_command_mastery.last_used_at) / 1.day
  end

  # Predict when score will drop below threshold
  def predict_threshold_breach(threshold = 70.0)
    current_score = current_decayed_score
    return 0 if current_score < threshold

    # Simulate future decay (check each day for next 30 days)
    (1..30).each do |days_ahead|
      # Estimate chapters ahead (assume 1 chapter every 3 days average)
      chapters_ahead = (days_ahead / 3.0).floor
      future_score = simulate_future_score(days_ahead, chapters_ahead)
      return days_ahead if future_score < threshold
    end

    nil  # Won't breach in next 30 days
  end

  # Simulate score at future date
  def simulate_future_score(days_ahead, chapters_ahead = 0)
    base_score = user_command_mastery.proficiency_score

    # FSRS decay at future time
    total_days = days_since_last_use + days_ahead
    stability = user_command_mastery.stability || DEFAULT_STABILITY
    fsrs_retention = Math.exp(-total_days / stability)

    # Progress interference with future chapters
    total_chapters = chapters_completed_since_mastery + chapters_ahead
    effective_chapters = [total_chapters - PROTECTED_RECENT_COUNT, 0].max
    capped_chapters = [effective_chapters, MAX_INTERFERENCE_CHAPTERS].min
    interference_factor = 1.0 - (capped_chapters * INTERFERENCE_RATE_PER_CHAPTER)

    # Combined
    score = base_score * fsrs_retention * interference_factor
    [score, MUSCLE_MEMORY_FLOOR].max
  end

  # Generate decay projection for visualization
  def generate_decay_projection(days_ahead: 30, chapters_ahead: 10)
    projection = []

    (0..days_ahead).each do |day|
      # Calculate chapters at this point (assume 1 chapter every 3 days)
      chapters = (day / 3.0).floor

      score = simulate_future_score(day, chapters)

      projection << {
        day: day,
        chapters: chapters_completed_since_mastery + chapters,
        score: score.round(1),
        fsrs_retention: calculate_future_fsrs_retention(day),
        interference_factor: calculate_future_interference(chapters),
        risk_level: determine_risk_level(score)
      }
    end

    projection
  end

  # Generate decay curve data for visualization
  def generate_decay_curve(days_ahead = 30)
    projection = generate_decay_projection(days_ahead: days_ahead)

    projection.map do |point|
      {
        day: point[:day],
        score: point[:score],
        is_projection: point[:day] > 0,
        risk_level: point[:risk_level]
      }
    end
  end

  # Get suggested review timing
  def suggest_review_timing
    current_score = current_decayed_score
    risk_level = determine_risk_level(current_score)

    case risk_level
    when 'critical'
      { urgency: 'immediate', days: 0, reason: 'Score below 60% - immediate review required' }
    when 'risk'
      { urgency: 'high', days: 1, reason: 'Score below 70% - review within 24 hours' }
    when 'watch'
      days_to_risk = predict_threshold_breach(70)
      { urgency: 'medium', days: [days_to_risk&./(2), 3].compact.min, reason: 'Preventive review recommended' }
    else
      days_to_risk = predict_threshold_breach(80)
      review_days = days_to_risk ? [days_to_risk * 0.7, 7].min.round : 7
      { urgency: 'low', days: review_days, reason: 'Maintenance review' }
    end
  end

  private

  def calculate_future_fsrs_retention(days_ahead)
    total_days = days_since_last_use + days_ahead
    stability = user_command_mastery.stability || DEFAULT_STABILITY
    (Math.exp(-total_days / stability) * 100).round(1)
  end

  def calculate_future_interference(chapters_ahead)
    total_chapters = chapters_completed_since_mastery + chapters_ahead
    effective_chapters = [total_chapters - PROTECTED_RECENT_COUNT, 0].max
    capped_chapters = [effective_chapters, MAX_INTERFERENCE_CHAPTERS].min
    factor = 1.0 - (capped_chapters * INTERFERENCE_RATE_PER_CHAPTER)
    (factor * 100).round(1)
  end

  def determine_risk_level(score)
    case score
    when 90..Float::INFINITY then 'safe'
    when 70...90 then 'watch'
    when 60...70 then 'risk'
    else 'critical'
    end
  end
end
