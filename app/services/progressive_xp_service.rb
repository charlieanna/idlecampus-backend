# frozen_string_literal: true

# Service for handling XP calculations and awards
class ProgressiveXpService
  # XP Constants from GAMIFICATION_FORMULAS.md
  BASE_XP_PER_LEVEL = {
    1 => 50,   # Connectivity
    2 => 75,   # Capacity
    3 => 100,  # Optimization
    4 => 150,  # Resilience
    5 => 200   # Excellence
  }.freeze

  DIFFICULTY_MULTIPLIERS = {
    'beginner' => 1.0,
    'intermediate' => 1.5,
    'advanced' => 2.0,
    'expert' => 3.0
  }.freeze

  BONUS_MULTIPLIERS = {
    first_attempt: 1.5,
    perfect_score: 1.2,
    speed_bonus: 1.1,
    daily_challenge: 1.5,
    streak_bonus: 1.3
  }.freeze

  class << self
    # Award XP to a user
    def award_xp(user, amount, source, metadata = {})
      ActiveRecord::Base.transaction do
        # Create XP transaction record
        transaction = ProgressiveXpTransaction.create!(
          user: user,
          amount: amount,
          source: source,
          metadata: metadata
        )

        # Update user stats
        stat = user.progressive_user_stat || user.create_progressive_user_stat!
        old_level = stat.level
        
        stat.total_xp += amount
        stat.level = calculate_level_from_xp(stat.total_xp)
        stat.last_activity_at = Time.current
        stat.save!

        # Check for level up
        if stat.level > old_level
          handle_level_up(user, old_level, stat.level)
        end

        transaction
      end
    end

    # Calculate XP for completing a challenge level
    def calculate_level_xp(challenge, level_number, attempt_data = {})
      base_xp = BASE_XP_PER_LEVEL[level_number] || 100
      difficulty_multiplier = DIFFICULTY_MULTIPLIERS[challenge.difficulty] || 1.0
      
      xp = base_xp * difficulty_multiplier

      # Apply bonuses
      xp *= BONUS_MULTIPLIERS[:first_attempt] if attempt_data[:first_attempt]
      xp *= BONUS_MULTIPLIERS[:perfect_score] if attempt_data[:perfect_score]
      xp *= BONUS_MULTIPLIERS[:speed_bonus] if attempt_data[:speed_bonus]

      xp.round
    end

    # Calculate XP required for a specific level
    def xp_for_level(level)
      # Formula: 1000 * (level - 1)^1.5
      # This creates a smooth progression curve
      (1000 * ((level - 1) ** 1.5)).round
    end

    # Calculate level from total XP
    def calculate_level_from_xp(total_xp)
      level = 1
      
      loop do
        xp_needed = xp_for_level(level + 1)
        break if total_xp < xp_needed
        level += 1
      end

      level
    end

    # Calculate XP progress within current level
    def xp_progress_in_level(total_xp, current_level)
      current_level_xp = xp_for_level(current_level)
      next_level_xp = xp_for_level(current_level + 1)
      
      xp_in_current_level = total_xp - current_level_xp
      xp_needed_for_next = next_level_xp - current_level_xp

      {
        current: xp_in_current_level,
        needed: xp_needed_for_next,
        percentage: (xp_in_current_level.to_f / xp_needed_for_next * 100).round(1)
      }
    end

    # Calculate streak bonus multiplier
    def streak_multiplier(streak_days)
      case streak_days
      when 0..2
        1.0
      when 3..6
        1.1
      when 7..13
        1.2
      when 14..29
        1.3
      else
        1.5 # 30+ days
      end
    end

    private

    def handle_level_up(user, old_level, new_level)
      # Create notification
      ProgressiveNotification.create!(
        user: user,
        notification_type: 'level_up',
        title: "Level Up!",
        message: "Congratulations! You've reached level #{new_level}",
        data: { old_level: old_level, new_level: new_level },
        read: false
      )

      # Check for level-based achievements
      ProgressiveAchievementService.check_level_achievements(user, new_level)
    end
  end
end