# frozen_string_literal: true

module Upsc
  class StudyPlan < ApplicationRecord
    self.table_name = 'upsc_study_plans'

    # Associations
    belongs_to :user
    has_many :daily_tasks, class_name: 'Upsc::DailyTask', foreign_key: 'upsc_study_plan_id', dependent: :destroy

    # Validations
    validates :user, presence: true
    validates :start_date, presence: true
    validates :target_exam_date, presence: true
    validate :target_date_after_start_date

    # Callbacks
    before_create :calculate_total_days
    before_create :generate_phases

    # Scopes
    scope :active, -> { where(is_active: true) }
    scope :by_user, ->(user_id) { where(user_id: user_id) }

    # Instance methods
    def days_remaining
      (target_exam_date - Date.current).to_i
    end

    def current_phase
      return 'completed' if days_remaining < 0
      return 'revision' if days_remaining < total_days * 0.25
      return 'practice' if days_remaining < total_days * 0.60
      'foundation'
    end

    def update_completion_percentage
      total_tasks = daily_tasks.count
      return 0 if total_tasks.zero?

      completed_tasks = daily_tasks.where(status: 'completed').count
      self.completion_percentage = (completed_tasks.to_f / total_tasks * 100).round
      save
    end

    def generate_tasks_for_week(week_start_date)
      # Will be implemented with study plan generator service
    end

    private

    def target_date_after_start_date
      if target_exam_date && start_date && target_exam_date <= start_date
        errors.add(:target_exam_date, "must be after start date")
      end
    end

    def calculate_total_days
      self.total_days = (target_exam_date - start_date).to_i if target_exam_date && start_date
    end

    def generate_phases
      return unless total_days

      self.phase_breakdown = {
        foundation: {
          days: (total_days * 0.4).to_i,
          start_date: start_date,
          end_date: start_date + (total_days * 0.4).days,
          objectives: ['Complete NCERT', 'Basic concepts', 'Start answer writing']
        },
        practice: {
          days: (total_days * 0.35).to_i,
          start_date: start_date + (total_days * 0.4).days,
          end_date: start_date + (total_days * 0.75).days,
          objectives: ['Practice questions', 'Mock tests', 'Current affairs integration']
        },
        revision: {
          days: (total_days * 0.25).to_i,
          start_date: start_date + (total_days * 0.75).days,
          end_date: target_exam_date,
          objectives: ['Comprehensive revision', 'Full mocks', 'Weak areas focus']
        }
      }
    end
  end
end
