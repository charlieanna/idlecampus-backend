# frozen_string_literal: true

module Upsc
  class DailyTask < ApplicationRecord
    self.table_name = 'upsc_daily_tasks'

    # Associations
    belongs_to :user
    belongs_to :study_plan, class_name: 'Upsc::StudyPlan', foreign_key: 'upsc_study_plan_id', optional: true
    belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id', optional: true

    # Validations
    validates :user, presence: true
    validates :task_date, presence: true
    validates :title, presence: true
    validates :task_type, inclusion: { in: %w[study practice test revision current_affairs answer_writing] }, allow_nil: true
    validates :priority, inclusion: { in: %w[low medium high] }
    validates :status, inclusion: { in: %w[pending in_progress completed skipped] }

    # Callbacks
    after_save :update_study_plan_completion, if: :status_changed?

    # Scopes
    scope :for_date, ->(date) { where(task_date: date) }
    scope :today, -> { where(task_date: Date.current) }
    scope :pending, -> { where(status: 'pending') }
    scope :completed, -> { where(status: 'completed') }
    scope :by_priority, ->(priority) { where(priority: priority) }
    scope :ordered, -> { order(priority: :desc, task_date: :asc) }

    # Class methods
    def self.today_summary(user)
      tasks = today.where(user: user)
      {
        total: tasks.count,
        completed: tasks.completed.count,
        pending: tasks.pending.count,
        estimated_time: tasks.sum(:estimated_minutes),
        actual_time: tasks.sum(:actual_minutes)
      }
    end

    # Instance methods
    def mark_complete(actual_time = nil)
      self.status = 'completed'
      self.completed_at = Time.current
      self.actual_minutes = actual_time if actual_time
      save
    end

    def is_overdue?
      status != 'completed' && task_date < Date.current
    end

    def time_variance
      return nil unless estimated_minutes && actual_minutes
      actual_minutes - estimated_minutes
    end

    private

    def update_study_plan_completion
      study_plan&.update_completion_percentage
    end
  end
end
