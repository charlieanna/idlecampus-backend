module Api
  module V1
    class ProgressiveChallengesController < ProgressiveFlowController
      before_action :set_challenge, only: [:show, :check_unlock, :complete_level]
      
      # GET /api/v1/progressive/challenges
      def index
        challenges = ProgressiveChallenge.active.with_levels
        challenges = challenges.joins(:progressive_learning_track)
                              .where(progressive_learning_tracks: { id: params[:track_id] }) if params[:track_id]
        
        challenges_data = challenges.map do |challenge|
          {
            id: challenge.id,
            slug: challenge.slug,
            title: challenge.title,
            description: challenge.description,
            category: challenge.category,
            difficulty_base: challenge.difficulty_base,
            xp_base: challenge.xp_base,
            estimated_minutes: challenge.estimated_minutes,
            prerequisites: challenge.prerequisites,
            tags: challenge.tags,
            levels: challenge.progressive_challenge_levels.ordered.map do |level|
              {
                id: level.id,
                level_number: level.level_number,
                level_name: level.level_name,
                description: level.description,
                xp_reward: level.xp_reward,
                estimated_minutes: level.estimated_minutes
              }
            end,
            user_progress: @user ? challenge.user_progress_for(@user) : nil
          }
        end
        
        render_success(challenges_data)
      end
      
      # GET /api/v1/progressive/challenges/:id
      def show
        challenge_data = {
          id: @challenge.id,
          slug: @challenge.slug,
          title: @challenge.title,
          description: @challenge.description,
          category: @challenge.category,
          difficulty_base: @challenge.difficulty_base,
          xp_base: @challenge.xp_base,
          estimated_minutes: @challenge.estimated_minutes,
          prerequisites: @challenge.prerequisites,
          ddia_concepts: @challenge.ddia_concepts,
          tags: @challenge.tags,
          levels: @challenge.progressive_challenge_levels.ordered.map do |level|
            {
              id: level.id,
              level_number: level.level_number,
              level_name: level.level_name,
              description: level.description,
              requirements: level.requirements,
              test_cases: level.test_cases,
              passing_criteria: level.passing_criteria,
              xp_reward: level.xp_reward,
              hints: level.hints,
              solution_approach: level.solution_approach,
              estimated_minutes: level.estimated_minutes
            }
          end
        }
        
        render_success(challenge_data)
      end
      
      # GET /api/v1/progressive/challenges/:id/unlocked
      def check_unlock
        unlocked = @challenge.unlocked_for?(@user)
        missing_prerequisites = []
        
        unless unlocked
          completed_ids = @user.progressive_user_challenge_progresses
                              .where(status: 'completed')
                              .pluck(:progressive_challenge_id)
                              .map(&:to_s)
          missing_prerequisites = @challenge.prerequisites - completed_ids
        end
        
        render_success({
          unlocked: unlocked,
          missing_prerequisites: missing_prerequisites
        })
      end
      
      # POST /api/v1/progressive/challenges/:id/complete_level
      def complete_level
        service = ProgressiveFlowService.new(@user)
        result = service.complete_level(
          @challenge.id,
          params[:level],
          {
            score: params[:performance][:score],
            time_spent_minutes: params[:performance][:time_spent_minutes],
            hints_used: params[:performance][:hints_used],
            design_snapshot: params[:performance][:design_snapshot],
            test_results: params[:performance][:test_results]
          }
        )
        
        render_success(result)
      rescue => e
        render_error(e.message)
      end
      
      private
      
      def set_challenge
        @challenge = ProgressiveChallenge.find_by!(slug: params[:id]) || 
                    ProgressiveChallenge.find(params[:id])
      end
    end
  end
end