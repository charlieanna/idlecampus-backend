# frozen_string_literal: true

module Upsc
  class Revision < ApplicationRecord
    self.table_name = 'upsc_revisions'

    # Associations
    belongs_to :user
    belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id', optional: true

    # Validations
    validates :user, presence: true
    validates :scheduled_for, presence: true
    validates :revision_type, inclusion: { in: %w[scheduled manual triggered] }, allow_nil: true
    validates :status, inclusion: { in: %w[pending completed skipped] }
    validates :performance_rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

    # Scopes
    scope :scheduled, -> { where(revision_type: 'scheduled') }
    scope :pending, -> { where(status: 'pending') }
    scope :completed, -> { where(status: 'completed') }
    scope :due_today, -> { where(scheduled_for: Date.current, status: 'pending') }
    scope :overdue, -> { where('scheduled_for < ? AND status = ?', Date.current, 'pending') }

    # Spaced repetition intervals (in days)
    INTERVALS = [1, 3, 7, 14, 30, 60, 90].freeze

    # Class methods
    def self.schedule_next_revision(user, topic, performance_rating = 3)
      last_revision = where(user: user, upsc_topic_id: topic.id, status: 'completed').order(:completed_at).last

      interval_index = last_revision ? [last_revision.interval_index + 1, INTERVALS.length - 1].min : 0

      # Adjust interval based on performance
      interval_index -= 1 if performance_rating <= 2 && interval_index > 0
      interval_index = [interval_index, 0].max

      next_revision_date = Date.current + INTERVALS[interval_index].days

      create!(
        user: user,
        upsc_topic_id: topic.id,
        revision_type: 'scheduled',
        scheduled_for: next_revision_date,
        interval_index: interval_index,
        status: 'pending'
      )
    end

    # Instance methods
    def mark_complete(rating, time_spent = nil)
      self.status = 'completed'
      self.completed_at = Time.current
      self.performance_rating = rating
      self.time_spent_minutes = time_spent if time_spent
      save

      # Schedule next revision based on performance
      self.class.schedule_next_revision(user, topic, rating) if topic
    end

    def is_overdue?
      status == 'pending' && scheduled_for < Date.current
    end

    def next_interval_days
      return nil if interval_index >= INTERVALS.length - 1
      INTERVALS[interval_index + 1]
    end
  end
end
