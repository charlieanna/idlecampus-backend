# frozen_string_literal: true

module Api
  module Upsc
    class DailyTasksController < BaseController
      before_action :require_user
      before_action :set_daily_task, only: [:show, :update, :destroy, :complete]

      # GET /api/upsc/daily_tasks
      def index
        @tasks = current_user.upsc_daily_tasks

        # Filter by date
        if params[:date].present?
          @tasks = @tasks.where(scheduled_for: params[:date])
        elsif params[:today] == 'true'
          @tasks = @tasks.where(scheduled_for: Date.current)
        elsif params[:overdue] == 'true'
          @tasks = @tasks.where('scheduled_for < ? AND status != ?', Date.current, 'completed')
        end

        # Filter by status
        @tasks = @tasks.where(status: params[:status]) if params[:status].present?

        # Filter by priority
        @tasks = @tasks.where(priority: params[:priority]) if params[:priority].present?

        # Filter by task type
        @tasks = @tasks.where(task_type: params[:task_type]) if params[:task_type].present?

        # Filter by subject
        if params[:subject_id].present?
          topic_ids = ::Upsc::Topic.where(upsc_subject_id: params[:subject_id]).pluck(:id)
          @tasks = @tasks.where(upsc_topic_id: topic_ids)
        end

        @tasks = @tasks.order(scheduled_for: :asc, priority: :desc)

        render_success({
          daily_tasks: @tasks.as_json(
            include: {
              topic: { only: [:id, :name, :slug] },
              study_plan: { only: [:id, :name] }
            }
          )
        })
      end

      # GET /api/upsc/daily_tasks/:id
      def show
        render_success({
          daily_task: @daily_task.as_json(
            include: {
              topic: { only: [:id, :name, :slug] },
              study_plan: { only: [:id, :name] }
            }
          )
        })
      end

      # POST /api/upsc/daily_tasks
      def create
        @daily_task = current_user.upsc_daily_tasks.new(daily_task_params)

        if @daily_task.save
          render_success(
            { daily_task: @daily_task },
            'Task created successfully',
            :created
          )
        else
          render_error('Failed to create task', @daily_task.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/daily_tasks/:id
      def update
        if @daily_task.update(daily_task_params)
          render_success({ daily_task: @daily_task }, 'Task updated successfully')
        else
          render_error('Failed to update task', @daily_task.errors.full_messages)
        end
      end

      # DELETE /api/upsc/daily_tasks/:id
      def destroy
        @daily_task.destroy
        render_success({}, 'Task deleted successfully')
      end

      # POST /api/upsc/daily_tasks/:id/complete
      def complete
        @daily_task.update(
          status: 'completed',
          completed_at: Time.current
        )

        render_success({ daily_task: @daily_task }, 'Task marked as complete')
      end

      # GET /api/upsc/daily_tasks/today
      def today
        @tasks = current_user.upsc_daily_tasks.where(scheduled_for: Date.current)
          .order(priority: :desc)

        completed = @tasks.where(status: 'completed').count
        total = @tasks.count

        render_success({
          daily_tasks: @tasks.as_json(include: { topic: { only: [:id, :name] } }),
          statistics: {
            total: total,
            completed: completed,
            pending: total - completed,
            completion_rate: total > 0 ? ((completed.to_f / total) * 100).round(2) : 0
          }
        })
      end

      # GET /api/upsc/daily_tasks/week
      def week
        start_date = Date.current.beginning_of_week
        end_date = Date.current.end_of_week

        @tasks = current_user.upsc_daily_tasks
          .where(scheduled_for: start_date..end_date)
          .order(scheduled_for: :asc, priority: :desc)

        # Group by date
        tasks_by_date = @tasks.group_by { |task| task.scheduled_for }

        render_success({
          tasks_by_date: tasks_by_date.transform_values do |tasks|
            tasks.as_json(include: { topic: { only: [:id, :name] } })
          end
        })
      end

      # POST /api/upsc/daily_tasks/bulk_create
      def bulk_create
        tasks_data = params[:tasks] || []
        created_tasks = []
        errors = []

        tasks_data.each do |task_data|
          task = current_user.upsc_daily_tasks.new(task_data.permit(
            :upsc_topic_id, :upsc_study_plan_id, :task_type, :title,
            :description, :scheduled_for, :estimated_duration_minutes,
            :priority, :notes
          ))

          if task.save
            created_tasks << task
          else
            errors << { task: task_data, errors: task.errors.full_messages }
          end
        end

        if errors.empty?
          render_success(
            { daily_tasks: created_tasks, count: created_tasks.length },
            "#{created_tasks.length} tasks created successfully",
            :created
          )
        else
          render_error(
            "Some tasks could not be created",
            errors,
            :unprocessable_entity
          )
        end
      end

      # GET /api/upsc/daily_tasks/statistics
      def statistics
        total_tasks = current_user.upsc_daily_tasks.count
        completed_tasks = current_user.upsc_daily_tasks.where(status: 'completed').count
        overdue_tasks = current_user.upsc_daily_tasks.where('scheduled_for < ? AND status != ?', Date.current, 'completed').count

        # Tasks by type
        tasks_by_type = current_user.upsc_daily_tasks.group(:task_type).count

        # Completion rate over last 7 days
        last_week_tasks = current_user.upsc_daily_tasks.where('scheduled_for >= ?', 7.days.ago)
        last_week_completed = last_week_tasks.where(status: 'completed').count
        last_week_total = last_week_tasks.count

        render_success({
          statistics: {
            total_tasks: total_tasks,
            completed_tasks: completed_tasks,
            overdue_tasks: overdue_tasks,
            completion_rate: total_tasks > 0 ? ((completed_tasks.to_f / total_tasks) * 100).round(2) : 0,
            tasks_by_type: tasks_by_type,
            last_week: {
              total: last_week_total,
              completed: last_week_completed,
              completion_rate: last_week_total > 0 ? ((last_week_completed.to_f / last_week_total) * 100).round(2) : 0
            }
          }
        })
      end

      private

      def set_daily_task
        @daily_task = current_user.upsc_daily_tasks.find(params[:id])
      end

      def daily_task_params
        params.require(:daily_task).permit(
          :upsc_topic_id, :upsc_study_plan_id, :task_type, :title,
          :description, :scheduled_for, :estimated_duration_minutes,
          :actual_duration_minutes, :priority, :status, :notes
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
