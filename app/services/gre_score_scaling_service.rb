# GRE Score Scaling Service
# Converts IRT ability estimates (-3 to +3 logit scale) to GRE scaled scores (130-170)
# Also provides score interpretation and percentile estimates

class GREScoreScalingService
  # GRE Score Range: 130-170 per section (Verbal and Quantitative)
  GRE_MIN_SCORE = 130
  GRE_MAX_SCORE = 170
  GRE_SCORE_RANGE = GRE_MAX_SCORE - GRE_MIN_SCORE # 40 points

  # IRT ability typically ranges from -3 (very low) to +3 (very high)
  # We'll use -2.5 to +2.5 as the practical range for GRE
  IRT_MIN = -2.5
  IRT_MAX = 2.5
  IRT_RANGE = IRT_MAX - IRT_MIN # 5.0

  class << self
    # Convert IRT ability to GRE scaled score
    # ability: IRT ability estimate (typically -3 to +3)
    # Returns: GRE scaled score (130-170)
    def ability_to_gre_score(ability)
      # Clamp ability to reasonable bounds
      clamped_ability = [[ability, IRT_MIN].max, IRT_MAX].min

      # Linear transformation from IRT scale to GRE scale
      # Formula: score = 130 + (ability - (-2.5)) / 5.0 * 40
      normalized = (clamped_ability - IRT_MIN) / IRT_RANGE
      score = GRE_MIN_SCORE + (normalized * GRE_SCORE_RANGE)

      score.round
    end

    # Convert GRE scaled score back to IRT ability
    # score: GRE scaled score (130-170)
    # Returns: IRT ability estimate
    def gre_score_to_ability(score)
      # Clamp score to valid range
      clamped_score = [[score, GRE_MIN_SCORE].max, GRE_MAX_SCORE].min

      # Reverse transformation
      normalized = (clamped_score - GRE_MIN_SCORE).to_f / GRE_SCORE_RANGE
      ability = IRT_MIN + (normalized * IRT_RANGE)

      ability.round(2)
    end

    # Convert percentage correct to GRE scaled score
    # percentage: 0-100
    # difficulty_adjustment: Adjusts for exam difficulty (-1 to +1)
    def percentage_to_gre_score(percentage, difficulty_adjustment: 0.0)
      # Convert percentage to approximate IRT ability
      # 50% correct ≈ 0 ability
      # 90% correct ≈ +2.0 ability
      # 10% correct ≈ -2.0 ability

      if percentage >= 50
        # Above average: scale 50-100% to 0 to +2.5 ability
        ability = ((percentage - 50) / 50.0) * 2.5
      else
        # Below average: scale 0-50% to -2.5 to 0 ability
        ability = ((percentage - 50) / 50.0) * 2.5
      end

      # Apply difficulty adjustment
      ability += difficulty_adjustment

      ability_to_gre_score(ability)
    end

    # Get estimated percentile for a GRE score
    # Based on published GRE score distributions
    def score_to_percentile(score, section: :verbal)
      percentiles = if section == :verbal
        {
          130 => 1, 135 => 8, 140 => 16, 145 => 32, 150 => 49,
          155 => 70, 160 => 87, 165 => 96, 170 => 99
        }
      else # quantitative
        {
          130 => 1, 135 => 4, 140 => 12, 145 => 26, 150 => 42,
          155 => 62, 160 => 80, 165 => 92, 170 => 97
        }
      end

      # Find closest score
      closest = percentiles.keys.min_by { |s| (s - score).abs }
      percentiles[closest]
    end

    # Get score interpretation
    def interpret_score(score)
      case score
      when 160..170
        {
          level: 'Excellent',
          description: 'Competitive for top graduate programs',
          recommendation: 'Score is in the top 13% - excellent performance'
        }
      when 155..159
        {
          level: 'Very Good',
          description: 'Competitive for most graduate programs',
          recommendation: 'Score is in the top 30% - strong performance'
        }
      when 150..154
        {
          level: 'Good',
          description: 'Meets requirements for many programs',
          recommendation: 'Score is around 50th percentile - solid performance'
        }
      when 145..149
        {
          level: 'Fair',
          description: 'May need improvement for competitive programs',
          recommendation: 'Score is below average - consider additional preparation'
        }
      when 140..144
        {
          level: 'Below Average',
          description: 'Significant improvement recommended',
          recommendation: 'Focus on weak areas and retake exam'
        }
      else
        {
          level: 'Needs Improvement',
          description: 'Substantial preparation needed',
          recommendation: 'Comprehensive review of all topics strongly recommended'
        }
      end
    end

    # Calculate composite verbal score from sub-scores
    # reading: Reading Comprehension ability
    # text_completion: Text Completion ability
    # sentence_equiv: Sentence Equivalence ability
    # Returns: Combined GRE Verbal score
    def calculate_verbal_score(reading:, text_completion:, sentence_equiv:)
      # Weights based on GRE section composition
      # Reading Comp: ~50%, Text Completion: ~30%, Sentence Equiv: ~20%
      combined_ability = (reading * 0.5) + (text_completion * 0.3) + (sentence_equiv * 0.2)
      ability_to_gre_score(combined_ability)
    end

    # Calculate composite quantitative score from sub-scores
    # arithmetic: Arithmetic ability
    # algebra: Algebra ability
    # geometry: Geometry ability
    # data_analysis: Data Analysis ability
    # Returns: Combined GRE Quantitative score
    def calculate_quantitative_score(arithmetic:, algebra:, geometry:, data_analysis:)
      # Equal weighting for quantitative sections
      combined_ability = (arithmetic + algebra + geometry + data_analysis) / 4.0
      ability_to_gre_score(combined_ability)
    end

    # Get target score for different program tiers
    def target_scores_by_program_tier
      {
        'Top 10 Programs' => { verbal: 165, quantitative: 165, description: 'Harvard, MIT, Stanford level' },
        'Top 25 Programs' => { verbal: 160, quantitative: 160, description: 'Highly selective programs' },
        'Top 50 Programs' => { verbal: 155, quantitative: 155, description: 'Selective programs' },
        'Most Programs' => { verbal: 150, quantitative: 150, description: 'Competitive for many schools' },
        'Minimum Competitive' => { verbal: 145, quantitative: 145, description: 'Meets basic requirements' }
      }
    end

    # Calculate score improvement needed
    # current_score: Current GRE score
    # target_score: Desired GRE score
    # Returns: Analysis of improvement needed
    def score_gap_analysis(current_score, target_score)
      gap = target_score - current_score
      current_ability = gre_score_to_ability(current_score)
      target_ability = gre_score_to_ability(target_score)
      ability_gap = target_ability - current_ability

      {
        score_gap: gap,
        ability_gap: ability_gap.round(2),
        difficulty: difficulty_level(gap),
        estimated_study_time: estimate_study_time(gap),
        recommendations: gap_recommendations(gap, current_score)
      }
    end

    private

    def difficulty_level(gap)
      case gap
      when 0..3 then 'Easy - Minor fine-tuning needed'
      when 4..7 then 'Moderate - Focused practice required'
      when 8..12 then 'Challenging - Significant improvement needed'
      when 13..20 then 'Very Difficult - Major preparation required'
      else 'Extremely Difficult - Consider long-term study plan'
      end
    end

    def estimate_study_time(gap)
      # Rough estimate: 2-3 weeks of focused study per 5 point improvement
      weeks = (gap / 5.0 * 2.5).round
      {
        weeks: weeks,
        hours_per_week: 10,
        total_hours: weeks * 10,
        description: "Approximately #{weeks} weeks at 10 hours/week"
      }
    end

    def gap_recommendations(gap, current_score)
      if gap <= 3
        ['Focus on test-taking strategies', 'Review weak areas', 'Take 2-3 practice tests']
      elsif gap <= 7
        ['Systematic review of all topics', 'Daily practice with timed questions', 'Focus on accuracy first, then speed', 'Take weekly practice tests']
      elsif gap <= 12
        ['Comprehensive content review', 'Build vocabulary systematically', 'Master question types individually', 'Daily practice (1-2 hours)', 'Take practice tests every two weeks']
      else
        ['Start with fundamentals review', 'Consider GRE prep course or tutor', 'Build strong vocabulary foundation', 'Practice daily (2-3 hours)', 'Focus on gradual improvement over 3+ months']
      end
    end
  end
end
