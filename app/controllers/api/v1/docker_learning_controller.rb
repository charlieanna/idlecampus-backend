module Api
  module V1
    class DockerLearningController < ApplicationController
      # Make API publicly readable; keep user-specific actions guarded
      skip_before_action :verify_authenticity_token
      skip_before_action :authenticate_user!, raise: false
      protect_from_forgery with: :null_session

      before_action :set_default_format
      before_action :set_cors_headers
      before_action :cors_preflight, if: -> { request.method == 'OPTIONS' }

      # GET /api/v1/docker_learning/next_command
      # Returns the next Docker command for the user to practice (requires user)
      def next_command
        return unauthorized unless current_user
        service = DockerLearningService.new(current_user)
        command = service.get_next_command
        
        if command
          render json: {
            success: true,
            command: command
          }, status: :ok
        else
          render json: {
            success: false,
            error: 'No commands available'
          }, status: :not_found
        end
      rescue => e
        render json: {
          success: false,
          error: "Failed to get next command: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/docker_learning/submit_practice
      # Records user's practice attempt for a command (requires user)
      # Params: command_id (integer), correct (boolean), time_taken (integer in seconds)
      def submit_practice
        return unauthorized unless current_user
        unless params[:command_id].present?
          return render json: {
            success: false,
            error: 'command_id is required'
          }, status: :bad_request
        end
        
        unless params.has_key?(:correct)
          return render json: {
            success: false,
            error: 'correct parameter is required'
          }, status: :bad_request
        end
        
        service = DockerLearningService.new(current_user)
        result = service.record_practice(
          params[:command_id].to_i,
          params[:correct].to_s == 'true',
          params[:time_taken]&.to_i || 0
        )
        
        render json: result, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Command not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to record practice: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/docker_learning/stats (requires user)
      # Returns user's learning statistics
      def stats
        return unauthorized unless current_user
        service = DockerLearningService.new(current_user)
        stats = service.get_stats
        
        render json: {
          success: true,
          stats: stats
        }, status: :ok
      rescue => e
        render json: {
          success: false,
          error: "Failed to get stats: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/docker_learning/recommendations
      # Returns recommended commands. If not logged in, fall back to popular items
      def recommendations
        limit = params[:limit]&.to_i || 5
        
        if current_user
          service = DockerLearningService.new(current_user)
          recs = service.get_recommendations(limit)
        else
          recs = DockerCommand.highly_successful.limit(limit).map do |cmd|
            {
              id: cmd.id,
              command: cmd.command,
              explanation: cmd.explanation,
              difficulty: cmd.difficulty,
              average_success_rate: cmd.average_success_rate
            }
          end
        end
        
        render json: {
          success: true,
          recommendations: recs
        }, status: :ok
      rescue => e
        render json: {
          success: false,
          error: "Failed to get recommendations: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/docker_learning/commands
      # Returns list of all Docker commands with filters (public)
      def commands
        commands = DockerCommand.active
        
        # Apply filters
        commands = commands.by_difficulty(params[:difficulty]) if params[:difficulty].present?
        commands = commands.by_category(params[:category]) if params[:category].present?
        commands = commands.exam_focused(params[:exam]) if params[:exam].present?
        commands = commands.high_frequency if params[:high_frequency] == 'true'
        
        # Pagination
        page = params[:page]&.to_i || 1
        per_page = params[:per_page]&.to_i || 20
        
        commands = commands.page(page).per(per_page)
        
        render json: {
          success: true,
          commands: commands.map { |cmd| format_command(cmd) },
          pagination: {
            current_page: page,
            per_page: per_page,
            total_pages: commands.total_pages,
            total_count: commands.total_count
          }
        }, status: :ok
      rescue => e
        render json: {
          success: false,
          error: "Failed to get commands: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/docker_learning/commands/:id (public)
      # Returns details of a specific command
      def command
        command = DockerCommand.find(params[:id])
        
        render json: {
          success: true,
          command: format_command_detailed_public(command)
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Command not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to get command: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/docker_learning/review_due (requires user)
      # Returns commands due for spaced repetition review
      def review_due
        return unauthorized unless current_user
        due_items = SpacedRepetitionItem
          .joins(:coding_problem)
          .where(user: current_user)
          .where('next_review_at <= ?', Time.current)
          .where('coding_problems.type': 'DockerCommand')
          .order(:next_review_at)
          .limit(20)
        
        commands = due_items.map do |item|
          {
            id: item.coding_problem.id,
            command: item.coding_problem.command,
            difficulty: item.coding_problem.difficulty,
            category: item.coding_problem.category,
            mastery_level: item.mastery_level,
            next_review_at: item.next_review_at,
            repetition_number: item.repetition_number,
            ease_factor: item.ease_factor
          }
        end
        
        render json: {
          success: true,
          due_count: due_items.count,
          commands: commands
        }, status: :ok
      rescue => e
        render json: {
          success: false,
          error: "Failed to get review items: #{e.message}"
        }, status: :internal_server_error
      end
      
      private
      
      def set_default_format
        request.format = :json
      end

      # CORS helpers
      def set_cors_headers
        headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
        headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
        headers['Vary'] = 'Origin'
      end

      def cors_preflight
        set_cors_headers
        headers['Access-Control-Max-Age'] = '1728000'
        head :ok
      end

      def unauthorized
        render json: { success: false, error: 'authentication required' }, status: :unauthorized
      end
      
      # Format command for list view
      def format_command(command)
        {
          id: command.id,
          command: command.command,
          explanation: command.explanation,
          difficulty: command.difficulty,
          category: command.category,
          exam_frequency: command.exam_frequency,
          certification_exam: command.certification_exam
        }
      end
      
      # Public detail formatter (no user-specific stats)
      def format_command_detailed_public(command)
        {
          id: command.id,
          command: command.command,
          explanation: command.explanation,
          difficulty: command.difficulty,
          category: command.category,
          exam_frequency: command.exam_frequency,
          certification_exam: command.certification_exam,
          variations: command.variations || [],
          flags: command.flags || {},
          common_options: command.common_options || {},
          use_cases: command.use_cases,
          gotchas: command.gotchas,
          docker_version_min: command.docker_version_min,
          times_practiced: command.times_practiced,
          average_success_rate: command.average_success_rate
        }
      end
    end
  end
end