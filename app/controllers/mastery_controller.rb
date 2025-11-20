# API Controller for command mastery operations
class MasteryController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tracking_service
  
  # GET /api/mastery/stats
  # Get user's overall mastery statistics
  def stats
    category = params[:category]
    stats = @tracking_service.mastery_stats(category: category)
    
    render json: {
      success: true,
      stats: stats
    }
  end
  
  # POST /api/mastery/record_attempt
  # Record a command attempt
  def record_attempt
    command = params[:command]
    success = params[:success] == 'true' || params[:success] == true
    context = params[:context] || 'practice'
    
    if command.blank?
      render json: { 
        success: false, 
        error: 'Command is required' 
      }, status: :unprocessable_entity
      return
    end
    
    mastery = @tracking_service.record_attempt(
      command: command,
      success: success,
      context: context
    )
    
    if mastery
      render json: {
        success: true,
        mastery: mastery_json(mastery),
        message: mastery.mastered? ? 'Command mastered! 🎉' : nil
      }
    else
      render json: {
        success: false,
        errors: @tracking_service.errors
      }, status: :unprocessable_entity
    end
  end
  
  # GET /api/mastery/remedial_gate/:unit_slug
  # Check if user can proceed to Apply step
  def remedial_gate
    unit_slug = params[:unit_slug]
    unit = InteractiveLearningUnit.find_by(slug: unit_slug)
    
    if unit.nil?
      render json: { 
        success: false, 
        error: 'Unit not found' 
      }, status: :not_found
      return
    end
    
    gate_status = @tracking_service.check_remedial_gate(unit)
    
    render json: {
      success: true,
      gate_status: gate_status,
      can_proceed: gate_status[:status] == 'ok'
    }
  end
  
  # POST /api/mastery/remedial_drill
  # Create a remedial drill for blocked commands
  def create_remedial_drill
    commands = params[:commands] || []
    
    if commands.empty?
      render json: { 
        success: false, 
        error: 'No commands specified' 
      }, status: :unprocessable_entity
      return
    end
    
    drill = @tracking_service.create_remedial_drill(commands)
    
    render json: {
      success: true,
      drill: drill
    }
  end
  
  # POST /api/mastery/complete_remedial
  # Record completion of remedial drill
  def complete_remedial_drill
    drill_results = params[:drill_results] || []
    
    if drill_results.empty?
      render json: { 
        success: false, 
        error: 'No drill results provided' 
      }, status: :unprocessable_entity
      return
    end
    
    gate_passed = @tracking_service.complete_remedial_drill(drill_results)
    
    render json: {
      success: true,
      gate_passed: gate_passed,
      message: gate_passed ? 'All commands mastered! You may proceed.' : 'Keep practicing! Some commands still need work.'
    }
  end
  
  # GET /api/mastery/review_needed
  # Get commands that need review due to decay
  def review_needed
    limit = params[:limit]&.to_i || 5
    commands = @tracking_service.commands_needing_review(limit: limit)
    
    render json: {
      success: true,
      commands: commands,
      count: commands.length
    }
  end
  
  # GET /api/mastery/command/:canonical_command
  # Get detailed mastery info for a specific command
  def command_details
    canonical_command = params[:canonical_command]
    mastery = current_user.user_command_masteries.find_by(
      canonical_command: canonical_command
    )
    
    if mastery
      render json: {
        success: true,
        mastery: detailed_mastery_json(mastery)
      }
    else
      render json: {
        success: true,
        mastery: nil,
        message: 'No mastery record found for this command'
      }
    end
  end
  
  # GET /api/mastery/leaderboard
  # Get leaderboard for command mastery
  def leaderboard
    category = params[:category]
    limit = params[:limit]&.to_i || 10
    
    scope = UserCommandMastery.joins(:user)
    scope = scope.by_category(category) if category
    
    # Get top users by mastered commands count
    top_users = scope
      .mastered
      .group('users.id', 'users.name')
      .count
      .sort_by { |_, count| -count }
      .first(limit)
      .map do |(user_id, user_name), count|
        {
          user_id: user_id,
          user_name: user_name,
          mastered_commands: count,
          shields: User.find(user_id).user_command_masteries.mastered.map(&:shield_level).compact.tally
        }
      end
    
    render json: {
      success: true,
      leaderboard: top_users,
      category: category
    }
  end
  
  private
  
  def set_tracking_service
    @tracking_service = MasteryTrackingService.new(current_user)
  end
  
  def mastery_json(mastery)
    {
      canonical_command: mastery.canonical_command,
      label: CommandCanonicalizer.label(mastery.canonical_command),
      category: mastery.command_category,
      proficiency_score: mastery.proficiency_score,
      mastered: mastery.mastered?,
      total_attempts: mastery.total_attempts,
      successful_attempts: mastery.successful_attempts,
      last_used_at: mastery.last_used_at,
      shield_level: mastery.shield_level
    }
  end
  
  def detailed_mastery_json(mastery)
    base = mastery_json(mastery)
    base.merge({
      context_performance: mastery.context_performance,
      first_mastered_at: mastery.first_mastered_at,
      last_correct_at: mastery.last_correct_at,
      decay_rate: mastery.decay_rate,
      current_decay: mastery.calculate_decay,
      examples: CommandCanonicalizer.examples(mastery.canonical_command),
      performance_by_context: UserCommandMastery::CONTEXT_TYPES.map do |context|
        { 
          context: context, 
          **mastery.performance_in_context(context) 
        }
      end
    })
  end
end