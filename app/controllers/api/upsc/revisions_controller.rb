# frozen_string_literal: true

module Api
  module Upsc
    class RevisionsController < BaseController
      before_action :require_user
      before_action :set_revision, only: [:show, :update, :destroy, :mark_completed]

      # GET /api/upsc/revisions
      def index
        @revisions = current_user.upsc_revisions.includes(:topic)

        # Filter by status
        @revisions = @revisions.where(status: params[:status]) if params[:status].present?

        # Filter by date range
        if params[:from_date].present?
          @revisions = @revisions.where('scheduled_for >= ?', params[:from_date])
        end

        if params[:to_date].present?
          @revisions = @revisions.where('scheduled_for <= ?', params[:to_date])
        end

        # Filter by topic
        @revisions = @revisions.where(upsc_topic_id: params[:topic_id]) if params[:topic_id].present?

        # Today's revisions
        if params[:today] == 'true'
          @revisions = @revisions.where(scheduled_for: Date.current)
        end

        # Overdue revisions
        if params[:overdue] == 'true'
          @revisions = @revisions.where('scheduled_for < ? AND status != ?', Date.current, 'completed')
        end

        @revisions = @revisions.order(scheduled_for: :asc)

        render_success({
          revisions: @revisions.as_json(
            include: { topic: { only: [:id, :name, :slug] } }
          )
        })
      end

      # GET /api/upsc/revisions/:id
      def show
        render_success({
          revision: @revision.as_json(
            include: { topic: { only: [:id, :name, :slug, :description] } }
          )
        })
      end

      # POST /api/upsc/revisions
      def create
        @revision = current_user.upsc_revisions.new(revision_params)

        if @revision.save
          render_success(
            { revision: @revision },
            'Revision scheduled successfully',
            :created
          )
        else
          render_error('Failed to schedule revision', @revision.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/revisions/:id
      def update
        if @revision.update(revision_params)
          render_success({ revision: @revision }, 'Revision updated successfully')
        else
          render_error('Failed to update revision', @revision.errors.full_messages)
        end
      end

      # DELETE /api/upsc/revisions/:id
      def destroy
        @revision.destroy
        render_success({}, 'Revision deleted successfully')
      end

      # POST /api/upsc/revisions/:id/complete
      def mark_completed
        performance_rating = params[:performance_rating]&.to_i || 3

        @revision.update(
          status: 'completed',
          completed_at: Time.current,
          performance_rating: performance_rating,
          notes: params[:notes]
        )

        # Schedule next revision based on spaced repetition
        next_revision = ::Upsc::Revision.schedule_next_revision(
          current_user,
          @revision.topic,
          performance_rating
        )

        render_success({
          revision: @revision.reload,
          next_revision: next_revision
        }, 'Revision completed and next revision scheduled')
      end

      # GET /api/upsc/revisions/today
      def today
        @revisions = current_user.upsc_revisions
          .includes(:topic)
          .where(scheduled_for: Date.current)
          .order(created_at: :asc)

        completed = @revisions.where(status: 'completed').count
        total = @revisions.count

        render_success({
          revisions: @revisions.as_json(include: { topic: { only: [:id, :name] } }),
          statistics: {
            total: total,
            completed: completed,
            pending: total - completed
          }
        })
      end

      # GET /api/upsc/revisions/upcoming
      def upcoming
        @revisions = current_user.upsc_revisions
          .includes(:topic)
          .where('scheduled_for > ? AND scheduled_for <= ?', Date.current, 7.days.from_now)
          .where(status: 'pending')
          .order(scheduled_for: :asc)

        # Group by date
        revisions_by_date = @revisions.group_by(&:scheduled_for)

        render_success({
          revisions_by_date: revisions_by_date.transform_values do |revisions|
            revisions.as_json(include: { topic: { only: [:id, :name] } })
          end
        })
      end

      # POST /api/upsc/revisions/schedule_topic
      def schedule_topic
        topic = ::Upsc::Topic.find(params[:topic_id])
        performance_rating = params[:performance_rating]&.to_i || 3

        # Find last revision for this topic
        last_revision = current_user.upsc_revisions
          .where(upsc_topic_id: topic.id)
          .order(scheduled_for: :desc)
          .first

        # Calculate next interval
        interval_index = if last_revision
          [last_revision.interval_index + 1, ::Upsc::Revision::INTERVALS.length - 1].min
        else
          0
        end

        # Adjust for poor performance
        interval_index -= 1 if performance_rating <= 2 && interval_index > 0

        next_date = Date.current + ::Upsc::Revision::INTERVALS[interval_index].days

        @revision = current_user.upsc_revisions.create!(
          upsc_topic_id: topic.id,
          scheduled_for: next_date,
          interval_index: interval_index,
          notes: params[:notes]
        )

        render_success(
          { revision: @revision },
          "Revision scheduled for #{next_date.strftime('%B %d, %Y')}",
          :created
        )
      end

      # GET /api/upsc/revisions/statistics
      def statistics
        total_revisions = current_user.upsc_revisions.count
        completed_revisions = current_user.upsc_revisions.where(status: 'completed').count
        overdue_revisions = current_user.upsc_revisions.where('scheduled_for < ? AND status != ?', Date.current, 'completed').count

        # Average performance rating
        avg_performance = current_user.upsc_revisions
          .where(status: 'completed')
          .average(:performance_rating)&.round(2)

        # Revisions by interval
        revisions_by_interval = current_user.upsc_revisions
          .group(:interval_index)
          .count

        # Completion rate over last 30 days
        last_month_revisions = current_user.upsc_revisions.where('scheduled_for >= ?', 30.days.ago)
        last_month_completed = last_month_revisions.where(status: 'completed').count
        last_month_total = last_month_revisions.count

        render_success({
          statistics: {
            total_revisions: total_revisions,
            completed_revisions: completed_revisions,
            overdue_revisions: overdue_revisions,
            completion_rate: total_revisions > 0 ? ((completed_revisions.to_f / total_revisions) * 100).round(2) : 0,
            average_performance_rating: avg_performance || 0,
            revisions_by_interval: revisions_by_interval,
            last_month: {
              total: last_month_total,
              completed: last_month_completed,
              completion_rate: last_month_total > 0 ? ((last_month_completed.to_f / last_month_total) * 100).round(2) : 0
            }
          }
        })
      end

      private

      def set_revision
        @revision = current_user.upsc_revisions.find(params[:id])
      end

      def revision_params
        params.require(:revision).permit(
          :upsc_topic_id, :scheduled_for, :interval_index,
          :performance_rating, :notes
        )
      end

      def require_user
        unless current_user
          render_error('Authentication required', [], :unauthorized)
        end
      end
    end
  end
end
