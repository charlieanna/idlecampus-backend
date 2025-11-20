# Service to calculate mastery boosts and penalties based on attempt context
# Implements progressive mastery tracking - not all successes are equal!
class MasteryCalculator
  # Calculate how much to boost mastery based on how user succeeded
  def self.calculate_boost(current_score, attempt_context)
    case
    when first_try_success?(attempt_context)
      # ✅ Correct on first try = perfect mastery!
      # If you got it right on attempt #1, you know it
      100 - current_score

    when saw_answer?(attempt_context)
      # 📖 User clicked "Show Answer"
      # Minimal learning - they saw it, didn't recall it
      boost = 15
      [[boost, 40 - current_score].max, 0].max

    when attempt_context[:previous_failures] >= 3
      # ❌❌❌✅ Multiple failures then success
      # They struggled significantly - small boost
      boost = 20
      [[boost, 50 - current_score].min, 0].max

    when attempt_context[:previous_failures] >= 2
      # ❌❌✅ Two failures then success
      # Moderate struggle - medium boost
      boost = 30
      [[boost, 65 - current_score].min, 0].max

    when attempt_context[:previous_failures] == 1
      # ❌✅ One mistake, then corrected
      # Good recovery - decent boost
      boost = 40
      [[boost, 75 - current_score].min, 0].max

    when attempt_context[:consecutive_successes] >= 3
      # ✅✅✅ Three+ successes in a row across time
      # Proven mastery - full boost
      100 - current_score

    when attempt_context[:consecutive_successes] == 2
      # ✅✅ Two in a row
      # Almost proven - large boost
      boost = 35
      [[boost, 90 - current_score].min, 0].max

    else
      # Default case
      boost = 50
      [[boost, 80 - current_score].min, 0].max
    end
  end

  # Calculate how much to penalize mastery on failure
  def self.calculate_penalty(consecutive_failures)
    case consecutive_failures
    when 1 then 0.10  # -10% on first failure
    when 2 then 0.20  # -20% on second
    when 3 then 0.35  # -35% on third
    else 0.50         # -50% on 4th+ failure
    end
  end

  # Update mastery record on successful attempt
  def self.update_on_success!(mastery, attempt_context)
    # Calculate boost based on context
    boost = calculate_boost(mastery.proficiency_score, attempt_context)

    # Update mastery score
    mastery.proficiency_score = [mastery.proficiency_score + boost, 100].min

    # Update consecutive tracking
    mastery.consecutive_successes += 1
    mastery.consecutive_failures = 0

    # Track this attempt's context
    mastery.saw_answer_last = attempt_context[:saw_answer] || false
    mastery.hints_used_last = attempt_context[:hints_used] || 0

    # Update FSRS stability (grows on success)
    if mastery.respond_to?(:stability)
      ease_factor = calculate_ease_factor(mastery, attempt_context)
      mastery.stability = [mastery.stability * ease_factor, 120].min
    end

    # Update timestamps
    mastery.last_used_at = Time.current
    if mastery.respond_to?(:last_correct_at)
      mastery.last_correct_at = Time.current
    end

    # Track mastery achievement position
    if mastery.proficiency_score >= 100 && mastery.respond_to?(:chapters_at_mastery) && mastery.chapters_at_mastery.nil?
      mastery.chapters_at_mastery = mastery.learning_path_position || 0
    end

    mastery.save!
  end

  # Update mastery record on failed attempt
  def self.update_on_failure!(mastery, attempt_context)
    # Calculate penalty
    penalty = calculate_penalty(mastery.consecutive_failures + 1)

    # Apply penalty to score
    new_score = mastery.proficiency_score * (1 - penalty)
    mastery.proficiency_score = [new_score, 5].max  # Floor at 5%

    # Update consecutive tracking
    mastery.consecutive_failures += 1
    mastery.consecutive_successes = 0

    # Update FSRS stability (decreases on failure)
    if mastery.respond_to?(:stability)
      mastery.stability = [mastery.stability * 0.5, 0.5].max
    end

    # Update timestamp
    mastery.last_used_at = Time.current

    mastery.save!
  end

  private

  # Perfect success: first try, no hints, fast
  def self.first_try_perfect?(ctx)
    ctx[:attempt_number] == 1 &&
    (ctx[:hints_used] || 0) == 0 &&
    (ctx[:time_taken] || Float::INFINITY) < 15
  end

  # Success on first try
  def self.first_try_success?(ctx)
    ctx[:attempt_number] == 1
  end

  # User clicked "Show Answer"
  def self.saw_answer?(ctx)
    ctx[:saw_answer] == true
  end

  # Calculate FSRS ease factor based on difficulty and context
  def self.calculate_ease_factor(mastery, attempt_context)
    difficulty = mastery.try(:difficulty) || 5.0

    # Base ease factor from difficulty
    base_ease = case difficulty
    when 0..3   then 2.5  # Easy commands grow stability fast
    when 4..6   then 2.0  # Medium
    when 7..10  then 1.6  # Hard commands grow stability slower
    else 2.0
    end

    # Modifier based on how well they did
    modifier = if first_try_perfect?(attempt_context)
      1.2  # Boost ease if perfect
    elsif saw_answer?(attempt_context)
      0.8  # Reduce ease if they needed answer
    else
      1.0
    end

    base_ease * modifier
  end
end
