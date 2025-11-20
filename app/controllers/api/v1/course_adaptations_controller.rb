module Api
  module V1
    class CourseAdaptationsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_adaptation, only: [:show, :approve, :dismiss, :implement]
      before_action :require_admin, only: [:approve, :dismiss, :implement, :auto_suggest]

      # GET /api/v1/course_adaptations
      # Get all course adaptations (pending by default)
      def index
        status = params[:status] || 'pending'
        severity = params[:severity]
        adaptable_type = params[:adaptable_type]

        adaptations = CourseAdaptation.all

        adaptations = adaptations.where(status: status) if status.present?
        adaptations = adaptations.where(severity: severity) if severity.present?
        adaptations = adaptations.where(adaptable_type: adaptable_type) if adaptable_type.present?

        # Group by severity if requested
        if params[:group_by] == 'severity'
          grouped = adaptations.by_severity.includes(:adaptable, :course_module)
                              .group_by(&:severity)

          render json: {
            success: true,
            grouped_adaptations: grouped.transform_values { |ads| ads.map { |a| adaptation_json(a) } },
            counts: grouped.transform_values(&:count)
          }
        else
          adaptations = adaptations.by_severity.recent
                                  .includes(:adaptable, :course_module)
                                  .page(params[:page] || 1)
                                  .per(params[:per_page] || 20)

          render json: {
            success: true,
            adaptations: adaptations.map { |a| adaptation_json(a) },
            pagination: pagination_json(adaptations)
          }
        end
      end

      # GET /api/v1/course_adaptations/summary
      # Get dashboard summary of adaptations
      def summary
        summary_data = CourseAdaptationService.adaptation_summary

        render json: {
          success: true,
          summary: summary_data
        }
      end

      # GET /api/v1/course_adaptations/:id
      # Get detailed information about a specific adaptation
      def show
        render json: {
          success: true,
          adaptation: detailed_adaptation_json(@adaptation)
        }
      end

      # GET /api/v1/course_adaptations/lab/:lab_id/analysis
      # Analyze struggles for a specific lab
      def lab_analysis
        lab_id = params[:lab_id]
        analysis = CourseAdaptationService.analyze_lab_struggles(lab_id)

        if analysis
          render json: {
            success: true,
            analysis: analysis
          }
        else
          render json: {
            success: false,
            message: 'No significant struggles detected for this lab'
          }, status: :not_found
        end
      end

      # GET /api/v1/course_adaptations/module/:module_id/analysis
      # Analyze struggles for a specific course module
      def module_analysis
        module_id = params[:module_id]
        analysis = CourseAdaptationService.analyze_module_struggles(module_id)

        if analysis
          render json: {
            success: true,
            analysis: analysis
          }
        else
          render json: {
            success: false,
            message: 'No significant struggles detected for this module'
          }, status: :not_found
        end
      end

      # POST /api/v1/course_adaptations/:id/approve
      # Approve an adaptation
      def approve
        @adaptation.approve!(current_user)

        render json: {
          success: true,
          message: 'Adaptation approved successfully',
          adaptation: adaptation_json(@adaptation)
        }
      end

      # POST /api/v1/course_adaptations/:id/dismiss
      # Dismiss an adaptation
      def dismiss
        reason = params[:reason] || 'Not applicable'
        @adaptation.dismiss!(current_user, reason)

        render json: {
          success: true,
          message: 'Adaptation dismissed',
          adaptation: adaptation_json(@adaptation)
        }
      end

      # POST /api/v1/course_adaptations/:id/implement
      # Mark adaptation as implemented
      def implement
        notes = params[:implementation_notes]
        @adaptation.implement!(notes)

        render json: {
          success: true,
          message: 'Adaptation marked as implemented',
          adaptation: adaptation_json(@adaptation)
        }
      end

      # POST /api/v1/course_adaptations/auto_suggest
      # Automatically suggest adaptations for all struggling content
      def auto_suggest
        adaptations = CourseAdaptationService.auto_suggest_adaptations

        render json: {
          success: true,
          message: "Created #{adaptations.count} adaptation suggestions",
          adaptations: adaptations.map { |a| adaptation_json(a) }
        }
      end

      # GET /api/v1/course_adaptations/pending_count
      # Get count of pending adaptations (for notifications)
      def pending_count
        counts = {
          total: CourseAdaptation.pending.count,
          critical: CourseAdaptation.critical.pending.count,
          high: CourseAdaptation.where(severity: 'high', status: 'pending').count
        }

        render json: {
          success: true,
          counts: counts
        }
      end

      private

      def set_adaptation
        @adaptation = CourseAdaptation.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: {
          success: false,
          error: 'Adaptation not found'
        }, status: :not_found
      end

      def require_admin
        unless current_user.admin? || current_user.instructor?
          render json: {
            success: false,
            error: 'Unauthorized. Admin or instructor access required.'
          }, status: :forbidden
        end
      end

      def adaptation_json(adaptation)
        {
          id: adaptation.id,
          adaptable_type: adaptation.adaptable_type,
          adaptable_id: adaptation.adaptable_id,
          adaptable_title: adaptation.adaptable&.title,
          adaptation_type: adaptation.adaptation_type,
          adaptation_type_label: adaptation.adaptation_type_label,
          severity: adaptation.severity,
          severity_label: adaptation.severity_label,
          status: adaptation.status,
          status_label: adaptation.status_label,
          reason: adaptation.reason,
          affected_users_count: adaptation.affected_users_count,
          average_struggle_score: adaptation.average_struggle_score,
          created_at: adaptation.created_at,
          reviewed_at: adaptation.reviewed_at,
          implemented_at: adaptation.implemented_at
        }
      end

      def detailed_adaptation_json(adaptation)
        adaptation_json(adaptation).merge(
          course_module: adaptation.course_module ? {
            id: adaptation.course_module.id,
            title: adaptation.course_module.title
          } : nil,
          struggle_metrics: adaptation.struggle_metrics,
          common_failure_points: adaptation.common_failure_points,
          common_errors: adaptation.common_errors,
          suggested_changes: adaptation.suggested_changes,
          recommended_resources: adaptation.recommended_resources,
          resolution_notes: adaptation.resolution_notes,
          reviewed_by: adaptation.reviewed_by ? {
            id: adaptation.reviewed_by.id,
            name: adaptation.reviewed_by.name
          } : nil
        )
      end

      def pagination_json(collection)
        {
          current_page: collection.current_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count,
          per_page: collection.limit_value
        }
      end
    end
  end
end
