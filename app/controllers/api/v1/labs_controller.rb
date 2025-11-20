module Api
  module V1
    class LabsController < ApplicationController
      before_action :authenticate_user!
      
      # GET /api/v1/labs
      # Returns list of available hands-on labs with filtering
      def index
        labs = HandsOnLab.active
        
        # Apply filters
        labs = labs.by_difficulty(params[:difficulty]) if params[:difficulty].present?
        labs = labs.by_category(params[:category]) if params[:category].present?
        labs = labs.where(requires_docker: true) if params[:requires_docker] == 'true'
        labs = labs.where(requires_kubernetes: true) if params[:requires_kubernetes] == 'true'
        
        # Sorting
        case params[:sort_by]
        when 'difficulty'
          labs = labs.order(:difficulty_score)
        when 'duration'
          labs = labs.order(:estimated_duration_minutes)
        when 'popularity'
          labs = labs.order(completion_count: :desc)
        else
          labs = labs.order(:sequence_order)
        end
        
        # Include user progress if requested
        if params[:include_progress] == 'true'
          labs_with_progress = labs.map do |lab|
            format_lab_with_progress(lab)
          end
          
          render json: {
            success: true,
            labs: labs_with_progress,
            total_count: labs.count
          }, status: :ok
        else
          render json: {
            success: true,
            labs: labs.map { |lab| format_lab(lab) },
            total_count: labs.count
          }, status: :ok
        end
      rescue => e
        render json: {
          success: false,
          error: "Failed to get labs: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/labs/:id
      # Returns detailed information about a specific lab
      def show
        lab = HandsOnLab.find(params[:id])
        
        render json: {
          success: true,
          lab: format_lab_detailed(lab)
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Lab not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to get lab: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/:id/start
      # Starts a new lab session for the user
      # Params: spin_up_container (boolean, optional)
      def start
        lab = HandsOnLab.find(params[:id])
        
        # Check if user has an active session for this lab
        active_session = LabSession.where(
          user: current_user,
          hands_on_lab: lab,
          status: ['active', 'paused']
        ).first
        
        if active_session
          return render json: {
            success: false,
            error: 'You already have an active session for this lab',
            session_id: active_session.id
          }, status: :conflict
        end
        
        # Start the lab
        orchestrator = LabOrchestratorService.new(current_user)
        spin_up = params[:spin_up_container].to_s == 'true'
        
        result = orchestrator.start_lab(lab.id, spin_up_container: spin_up)
        
        if result[:success]
          render json: {
            success: true,
            session: format_session(result[:session]),
            message: result[:message]
          }, status: :created
        else
          render json: {
            success: false,
            error: result[:error]
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Lab not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to start lab: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/labs/sessions/:id
      # Returns current state of a lab session
      def session_status
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        render json: {
          success: true,
          session: format_session_detailed(session)
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to get session: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/sessions/:id/validate_step
      # Validates a step completion in the lab
      # Params: step_number (integer), user_command (string)
      def validate_step
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        # Validate required parameters
        unless params[:step_number].present? && params[:user_command].present?
          return render json: {
            success: false,
            error: 'step_number and user_command are required'
          }, status: :bad_request
        end
        
        orchestrator = LabOrchestratorService.new(current_user)
        result = orchestrator.validate_step(
          session.id,
          params[:step_number].to_i,
          params[:user_command]
        )
        
        render json: result, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to validate step: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/sessions/:id/request_hint
      # Requests a hint for the current step
      # Params: step_number (integer)
      def request_hint
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        unless params[:step_number].present?
          return render json: {
            success: false,
            error: 'step_number is required'
          }, status: :bad_request
        end
        
        orchestrator = LabOrchestratorService.new(current_user)
        result = orchestrator.provide_hint(session.id, params[:step_number].to_i)
        
        render json: result, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to get hint: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/sessions/:id/pause
      # Pauses an active lab session
      def pause
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        if session.pause!
          render json: {
            success: true,
            message: 'Session paused successfully',
            session: format_session(session)
          }, status: :ok
        else
          render json: {
            success: false,
            error: 'Failed to pause session'
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to pause session: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/sessions/:id/resume
      # Resumes a paused lab session
      def resume
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        if session.resume!
          render json: {
            success: true,
            message: 'Session resumed successfully',
            session: format_session(session)
          }, status: :ok
        else
          render json: {
            success: false,
            error: 'Failed to resume session'
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to resume session: #{e.message}"
        }, status: :internal_server_error
      end
      
      # POST /api/v1/labs/sessions/:id/complete
      # Marks a lab session as completed
      def complete
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        orchestrator = LabOrchestratorService.new(current_user)
        result = orchestrator.complete_lab(session.id)
        
        render json: result, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to complete session: #{e.message}"
        }, status: :internal_server_error
      end
      
      # DELETE /api/v1/labs/sessions/:id
      # Cancels and cleans up a lab session
      def destroy_session
        session = LabSession.find(params[:id])
        
        # Verify ownership
        unless session.user_id == current_user.id
          return render json: {
            success: false,
            error: 'Unauthorized access to session'
          }, status: :forbidden
        end
        
        orchestrator = LabOrchestratorService.new(current_user)
        orchestrator.cleanup_container(session.container_id) if session.container_id.present?
        
        session.update(status: 'failed', ended_at: Time.current)
        
        render json: {
          success: true,
          message: 'Session cancelled successfully'
        }, status: :ok
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Session not found'
        }, status: :not_found
      rescue => e
        render json: {
          success: false,
          error: "Failed to cancel session: #{e.message}"
        }, status: :internal_server_error
      end
      
      # GET /api/v1/labs/sessions
      # Returns user's lab sessions with filtering
      def sessions
        sessions = LabSession.where(user: current_user)
        
        # Apply filters
        sessions = sessions.where(status: params[:status]) if params[:status].present?
        sessions = sessions.where(hands_on_lab_id: params[:lab_id]) if params[:lab_id].present?
        
        # Sorting
        sessions = sessions.order(created_at: :desc)
        
        # Pagination
        page = params[:page]&.to_i || 1
        per_page = params[:per_page]&.to_i || 20
        
        sessions = sessions.page(page).per(per_page)
        
        render json: {
          success: true,
          sessions: sessions.map { |s| format_session(s) },
          pagination: {
            current_page: page,
            per_page: per_page,
            total_pages: sessions.total_pages,
            total_count: sessions.total_count
          }
        }, status: :ok
      rescue => e
        render json: {
          success: false,
          error: "Failed to get sessions: #{e.message}"
        }, status: :internal_server_error
      end
      
      private
      
      # Format lab for list view
      def format_lab(lab)
        {
          id: lab.id,
          title: lab.title,
          difficulty: lab.difficulty,
          category: lab.category,
          estimated_duration_minutes: lab.estimated_duration_minutes,
          requires_docker: lab.requires_docker,
          requires_kubernetes: lab.requires_kubernetes,
          sequence_order: lab.sequence_order,
          completion_count: lab.completion_count,
          average_score: lab.average_score
        }
      end
      
      # Format lab with user progress
      def format_lab_with_progress(lab)
        user_sessions = LabSession.where(user: current_user, hands_on_lab: lab)
        completed_sessions = user_sessions.where(status: 'completed')
        
        best_session = completed_sessions.order(final_score: :desc).first
        
        format_lab(lab).merge(
          user_progress: {
            attempts: user_sessions.count,
            completed: completed_sessions.count,
            best_score: best_session&.final_score,
            last_attempted_at: user_sessions.maximum(:created_at)
          }
        )
      end
      
      # Format lab for detailed view
      def format_lab_detailed(lab)
        format_lab_with_progress(lab).merge(
          description: lab.description,
          learning_objectives: lab.learning_objectives,
          prerequisites: lab.prerequisites,
          steps: lab.steps,
          success_criteria: lab.success_criteria,
          docker_image: lab.docker_image,
          docker_version_min: lab.docker_version_min,
          kubernetes_version_min: lab.kubernetes_version_min,
          verification_commands: lab.verification_commands
        )
      end
      
      # Format session for response
      def format_session(session)
        {
          id: session.id,
          lab_id: session.hands_on_lab_id,
          lab_title: session.hands_on_lab.title,
          status: session.status,
          current_step: session.current_step,
          total_steps: session.total_steps,
          progress_percentage: session.progress_percentage,
          started_at: session.started_at,
          ended_at: session.ended_at,
          final_score: session.final_score
        }
      end
      
      # Format session with detailed information
      def format_session_detailed(session)
        format_session(session).merge(
          steps_completed: session.steps_completed,
          hints_used: session.hints_used,
          attempts_per_step: session.attempts_per_step,
          time_per_step: session.time_per_step,
          container_id: session.container_id,
          container_status: session.container_status,
          validation_errors: session.validation_errors,
          achievements_earned: session.achievements_earned
        )
      end
    end
  end
end