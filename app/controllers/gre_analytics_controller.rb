# GRE Analytics Controller
# Provides detailed analytics, weakness detection, and study recommendations for GRE prep

class GREAnalyticsController < ApplicationController
  before_action :authenticate_user!

  # Main GRE dashboard
  def dashboard
    @service = GREWeaknessDetectionService.new(current_user)

    # Overall scores
    @verbal_analysis = @service.detect_verbal_weaknesses
    @overall_readiness = @service.calculate_overall_readiness rescue nil

    # Past exam attempts
    @past_exams = current_user.exam_simulations
                              .where(certification_type: 'gre')
                              .order(created_at: :desc)
                              .limit(5)

    # Score history for chart
    @score_history = @past_exams.completed.map do |exam|
      {
        date: exam.created_at.strftime('%m/%d'),
        score: exam.score,
        passed: exam.passed?
      }
    end.reverse

    # Practice recommendations
    @recommendations = @service.get_practice_recommendations
  end

  # Detailed weakness analysis
  def weakness_analysis
    @service = GREWeaknessDetectionService.new(current_user)
    @weaknesses = @service.detect_verbal_weaknesses
  end

  # Study plan generator
  def study_plan
    @service = GREWeaknessDetectionService.new(current_user)

    target_score = params[:target_score]&.to_i || 160
    timeframe_weeks = params[:timeframe_weeks]&.to_i || 8

    @study_plan = @service.get_detailed_study_plan(
      target_score: target_score,
      timeframe_weeks: timeframe_weeks
    )
  end

  # Score calculator and target analysis
  def score_calculator
    if params[:current_score] && params[:target_score]
      current = params[:current_score].to_i
      target = params[:target_score].to_i

      @analysis = GREScoreScalingService.score_gap_analysis(current, target)
      @current_interpretation = GREScoreScalingService.interpret_score(current)
      @target_interpretation = GREScoreScalingService.interpret_score(target)
    end

    @target_scores = GREScoreScalingService.target_scores_by_program_tier
  end

  # Performance by question type
  def question_type_analysis
    @service = GREWeaknessDetectionService.new(current_user)
    @analysis = @service.analyze_by_question_type

    render json: @analysis
  end

  # Performance by difficulty
  def difficulty_analysis
    @service = GREWeaknessDetectionService.new(current_user)
    @analysis = @service.analyze_by_difficulty('gre_verbal')

    render json: @analysis
  end

  # Time management analysis
  def time_management
    @service = GREWeaknessDetectionService.new(current_user)
    @analysis = @service.analyze_time_management

    render json: @analysis
  end

  # Skill dimension progress
  def skill_progress
    dimensions = [
      'gre_reading_comprehension',
      'gre_text_completion',
      'gre_sentence_equivalence'
    ]

    @progress = dimensions.map do |dim|
      skill_dim = current_user.user_skill_dimensions.find_by(dimension: dim)

      if skill_dim
        {
          dimension: dim.gsub('gre_', '').titleize,
          ability: skill_dim.ability_estimate,
          gre_score: GREScoreScalingService.ability_to_gre_score(skill_dim.ability_estimate),
          confidence: skill_dim.high_confidence? ? 'High' : 'Medium',
          observations: skill_dim.n_observations
        }
      else
        {
          dimension: dim.gsub('gre_', '').titleize,
          ability: 0.0,
          gre_score: 150,
          confidence: 'None',
          observations: 0
        }
      end
    end

    render json: @progress
  end

  # Readiness assessment
  def readiness_assessment
    @service = GREWeaknessDetectionService.new(current_user)
    @readiness = @service.detect_verbal_weaknesses

    @assessment = {
      overall_score: @readiness[:overall_ability][:gre_score],
      percentile: @readiness[:overall_ability][:percentile],
      interpretation: @readiness[:overall_ability][:interpretation],
      by_question_type: @readiness[:by_question_type],
      recommendations: @readiness[:recommendations],
      ready_to_test: @readiness[:overall_ability][:gre_score] >= 150
    }

    render json: @assessment
  end

  # Get personalized practice questions
  def practice_recommendations
    @service = GREWeaknessDetectionService.new(current_user)
    @recommendations = @service.get_practice_recommendations

    render json: @recommendations
  end

  # Export study plan as PDF or JSON
  def export_study_plan
    @service = GREWeaknessDetectionService.new(current_user)

    target_score = params[:target_score]&.to_i || 160
    timeframe_weeks = params[:timeframe_weeks]&.to_i || 8

    @study_plan = @service.get_detailed_study_plan(
      target_score: target_score,
      timeframe_weeks: timeframe_weeks
    )

    respond_to do |format|
      format.json { render json: @study_plan }
      format.pdf do
        # Generate PDF (requires PDF generation gem like Prawn or WickedPDF)
        # For now, just return JSON
        render json: @study_plan
      end
    end
  end
end
