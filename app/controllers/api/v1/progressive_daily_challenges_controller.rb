# frozen_string_literal: true

module Api
  module V1
    class ProgressiveDailyChallengesController < ProgressiveFlowController
      # GET /api/v1/progressive/daily-challenges
      # Returns today's daily challenges for the user
      def index
        today = Date.current
        
        # Get or create today's daily challenges
        daily_challenges = ProgressiveDailyChallenge
                             .where(user_id: current_user.id, date: today)
                             .includes(:challenge)

        # If no challenges exist for today, generate them
        if daily_challenges.empty?
          daily_challenges = ProgressiveDailyChallengeService.generate_daily_challenges(current_user, today)
        end

        challenges_data = daily_challenges.map do |dc|
          {
            id: dc.id,
            challenge_id: dc.challenge_id,
            challenge: {
              id: dc.challenge.id,
              title: dc.challenge.title,
              slug: dc.challenge.slug,
              difficulty: dc.challenge.difficulty,
              estimated_time: dc.challenge.estimated_time
            },
            xp_bonus: dc.xp_bonus,
            completed: dc.completed,
            completed_at: dc.completed_at,
            date: dc.date
          }
        end

        # Calculate daily streak
        streak = calculate_daily_streak

        render_success({
                         daily_challenges: challenges_data,
                         date: today,
                         completed_count: daily_challenges.count(&:completed),
                         total_count: daily_challenges.count,
                         daily_streak: streak,
                         bonus_multiplier: streak >= 7 ? 2.0 : 1.5
                       })
      end

      # POST /api/v1/progressive/daily-challenges/:id/complete
      # Mark a daily challenge as completed
      def complete
        daily_challenge = ProgressiveDailyChallenge.find(params[:id])

        unless daily_challenge.user_id == current_user.id
          return render_error('Unauthorized', :forbidden)
        end

        if daily_challenge.completed
          return render_error('Daily challenge already completed', :bad_request)
        end

        # Verify the challenge is actually completed
        progress = ProgressiveUserChallengeProgress.find_by(
          user_id: current_user.id,
          challenge_id: daily_challenge.challenge_id
        )

        unless progress&.status == 'completed'
          return render_error('Challenge not yet completed', :bad_request)
        end

        # Mark daily challenge as completed and award bonus XP
        daily_challenge.update!(
          completed: true,
          completed_at: Time.current
        )

        # Award bonus XP
        ProgressiveXpService.award_xp(
          current_user,
          daily_challenge.xp_bonus,
          'daily_challenge_bonus',
          { daily_challenge_id: daily_challenge.id }
        )

        # Check if all daily challenges are completed for additional bonus
        all_completed = ProgressiveDailyChallenge
                          .where(user_id: current_user.id, date: daily_challenge.date)
                          .all?(&:completed)

        if all_completed
          streak_bonus = calculate_daily_streak >= 7 ? 200 : 100
          ProgressiveXpService.award_xp(
            current_user,
            streak_bonus,
            'daily_challenge_streak',
            { date: daily_challenge.date }
          )
        end

        render_success({
                         daily_challenge: daily_challenge,
                         xp_earned: daily_challenge.xp_bonus,
                         all_completed: all_completed,
                         streak_bonus: all_completed ? streak_bonus : 0
                       })
      end

      # GET /api/v1/progressive/daily-challenges/history
      # Returns historical daily challenge completion
      def history
        history = ProgressiveDailyChallenge
                    .where(user_id: current_user.id)
                    .where('date >= ?', 30.days.ago)
                    .group(:date)
                    .select('date, COUNT(*) as total, COUNT(CASE WHEN completed THEN 1 END) as completed_count')
                    .order(date: :desc)

        history_data = history.map do |h|
          {
            date: h.date,
            total: h.total,
            completed: h.completed_count,
            completion_rate: (h.completed_count.to_f / h.total * 100).round
          }
        end

        render_success({
                         history: history_data,
                         total_days: history_data.length,
                         perfect_days: history_data.count { |h| h[:completed] == h[:total] },
                         current_streak: calculate_daily_streak
                       })
      end

      private

      def calculate_daily_streak
        # Count consecutive days with all daily challenges completed
        streak = 0
        date = Date.current

        loop do
          daily_challenges = ProgressiveDailyChallenge.where(user_id: current_user.id, date: date)
          
          break if daily_challenges.empty? || !daily_challenges.all?(&:completed)
          
          streak += 1
          date -= 1.day
        end

        streak
      end
    end
  end
end