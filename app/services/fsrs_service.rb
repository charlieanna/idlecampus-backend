# Local-only FSRS-inspired scheduler used by Rails models.
class FsrsService
  DEFAULT_DIFFICULTY = 5.0
  DEFAULT_STABILITY  = 2.4
  MIN_STABILITY      = 0.8
  MAX_STABILITY      = 90.0
  MIN_INTERVAL_DAYS  = 0.5

  private_constant :DEFAULT_DIFFICULTY, :DEFAULT_STABILITY,
                   :MIN_STABILITY, :MAX_STABILITY, :MIN_INTERVAL_DAYS

  class << self
    # Schedule a review for an item using a simplified FSRS heuristic.
    # Returns hash with next_review_at, interval, difficulty, stability, etc.
    def schedule_review(user_id:, item_id:, grade:, item_state: nil)
      state = normalize_state(item_state)
      difficulty = adjust_difficulty(state[:difficulty], grade)
      stability  = adjust_stability(state[:stability], grade)
      interval   = calculate_interval(stability, grade)
      reps       = state[:reps] + 1
      lapses     = state[:lapses] + (grade <= 2 ? 1 : 0)
      now        = Time.current

      {
        'difficulty' => difficulty.round(2),
        'stability' => stability.round(2),
        'interval' => interval.round,
        'next_review_at' => (now + interval.days).iso8601,
        'reps' => reps,
        'lapses' => lapses,
        'last_review_at' => now.iso8601,
        'last_grade' => grade,
        'retention_probability' => retention_probability(stability, interval)
      }
    rescue => e
      Rails.logger.error("FSRS Service error: #{e.message}")
      fallback_schedule(grade)
    end

    private

    def normalize_state(item_state)
      data = (item_state || {}).each_with_object({}) do |(key, value), memo|
        memo[key.to_s] = value
      end
      {
        difficulty: (data['difficulty'] || DEFAULT_DIFFICULTY).to_f,
        stability:  (data['stability']  || DEFAULT_STABILITY).to_f,
        reps:       (data['reps']       || 0).to_i,
        lapses:     (data['lapses']     || 0).to_i
      }
    end

    def adjust_difficulty(current, grade)
      delta = case grade
              when 4 then -0.4
              when 3 then -0.2
              when 2 then 0.2
              else 0.5
              end
      (current + delta).clamp(1.0, 10.0)
    end

    def adjust_stability(current, grade)
      factor = case grade
               when 4 then 1.5
               when 3 then 1.2
               when 2 then 0.85
               else 0.6
               end
      (current * factor).clamp(MIN_STABILITY, MAX_STABILITY)
    end

    def calculate_interval(stability, grade)
      scaling = case grade
                when 4 then 2.5
                when 3 then 1.6
                when 2 then 0.9
                else 0.5
                end
      [stability * scaling, MIN_INTERVAL_DAYS].max
    end

    def retention_probability(stability, interval)
      decay = interval / [stability, 0.01].max
      Math.exp(-decay).round(3)
    end

    def fallback_schedule(grade)
      interval_days = case grade
                      when 1 then 0.1
                      when 2 then 1
                      when 3 then 3
                      when 4 then 7
                      else 1
                      end

      {
        'difficulty' => DEFAULT_DIFFICULTY,
        'stability' => DEFAULT_STABILITY,
        'interval' => interval_days.round,
        'next_review_at' => (Time.current + interval_days.days).iso8601,
        'reps' => 1,
        'lapses' => grade == 1 ? 1 : 0,
        'last_review_at' => Time.current.iso8601,
        'last_grade' => grade,
        'retention_probability' => 0.9
      }
    end
  end
end
