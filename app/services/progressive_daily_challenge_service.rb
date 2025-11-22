# frozen_string_literal: true

# Service for generating and managing daily challenges
class ProgressiveDailyChallengeService
  DAILY_CHALLENGE_COUNT = 3

  class << self
    # Generate daily challenges for a user
    def generate_daily_challenges(user, date = Date.current)
      # Don't generate if already exist for this date
      existing = ProgressiveDailyChallenge.where(user_id: user.id, date: date)
      return existing if existing.any?

      challenges = select_daily_challenges(user)
      
      challenges.map do |challenge|
        ProgressiveDailyChallenge.create!(
          user: user,
          challenge: challenge,
          date: date,
          xp_bonus: calculate_bonus_xp(challenge),
          completed: false
        )
      end
    end

    # Select appropriate challenges for the user
    def select_daily_challenges(user)
      stat = user.progressive_user_stat
      user_level = stat&.level || 1

      # Get completed challenge IDs
      completed_ids = user.progressive_user_challenge_progresses
                          .where(status: 'completed')
                          .pluck(:challenge_id)

      # Get challenges in progress
      in_progress_ids = user.progressive_user_challenge_progresses
                            .where(status: 'in_progress')
                            .pluck(:challenge_id)

      # Strategy: Mix of difficulties based on user level
      challenges = []

      # 1. One challenge in progress (if any)
      if in_progress_ids.any?
        challenges << ProgressiveChallenge.find(in_progress_ids.sample)
      end

      # 2. One appropriate difficulty unlocked challenge
      unlocked = ProgressiveChallenge
                   .where.not(id: completed_ids)
                   .select { |c| c.unlocked_for?(user) }

      if unlocked.any?
        # Select based on user level
        difficulty = difficulty_for_level(user_level)
        appropriate = unlocked.select { |c| c.difficulty == difficulty }
        challenges << (appropriate.any? ? appropriate.sample : unlocked.sample)
      end

      # 3. Fill remaining slots with random appropriate challenges
      while challenges.length < DAILY_CHALLENGE_COUNT
        remaining = unlocked.reject { |c| challenges.map(&:id).include?(c.id) }
        break if remaining.empty?
        
        challenges << remaining.sample
      end

      # If we don't have enough challenges, include some completed ones for review
      if challenges.length < DAILY_CHALLENGE_COUNT && completed_ids.any?
        review_challenges = ProgressiveChallenge
                              .where(id: completed_ids)
                              .order('RANDOM()')
                              .limit(DAILY_CHALLENGE_COUNT - challenges.length)
        
        challenges.concat(review_challenges)
      end

      challenges.compact.uniq
    end

    # Calculate bonus XP for daily challenge
    def calculate_bonus_xp(challenge)
      base_bonus = 50
      
      multiplier = case challenge.difficulty
                   when 'beginner' then 1.0
                   when 'intermediate' then 1.5
                   when 'advanced' then 2.0
                   when 'expert' then 3.0
                   else 1.0
                   end

      (base_bonus * multiplier).round
    end

    # Calculate daily streak
    def calculate_daily_streak(user)
      streak = 0
      date = Date.current

      loop do
        daily_challenges = ProgressiveDailyChallenge.where(user_id: user.id, date: date)
        
        # If no challenges or not all completed, streak ends
        break if daily_challenges.empty? || !daily_challenges.all?(&:completed)
        
        streak += 1
        date -= 1.day

        # Don't go back more than 365 days
        break if streak > 365
      end

      streak
    end

    private

    def difficulty_for_level(level)
      case level
      when 1..5
        'beginner'
      when 6..15
        'intermediate'
      when 16..30
        'advanced'
      else
        'expert'
      end
    end
  end
end