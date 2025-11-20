# frozen_string_literal: true

module Upsc
  class Question < ApplicationRecord
    self.table_name = 'upsc_questions'

    # Associations
    belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id', optional: true
    belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id', optional: true
    belongs_to :created_by, class_name: 'User', optional: true

    has_many :test_questions, class_name: 'Upsc::TestQuestion', foreign_key: 'upsc_question_id', dependent: :destroy
    has_many :tests, through: :test_questions, class_name: 'Upsc::Test'

    # Validations
    validates :question_text, presence: true
    validates :question_type, presence: true, inclusion: { in: %w[mcq msq tf assertion_reason] }
    validates :correct_answer, presence: true
    validates :difficulty, inclusion: { in: %w[easy medium hard] }, allow_nil: true

    # Scopes
    scope :active, -> { where(status: 'active') }
    scope :by_difficulty, ->(level) { where(difficulty: level) }
    scope :pyqs, -> { where.not(pyq_year: nil) }
    scope :by_subject, ->(subject_id) { where(upsc_subject_id: subject_id) }
    scope :by_topic, ->(topic_id) { where(upsc_topic_id: topic_id) }
    scope :recent, -> { order(created_at: :desc) }

    # Instance methods
    def is_pyq?
      pyq_year.present?
    end

    def update_stats(is_correct, time_taken)
      increment!(:attempt_count)
      increment!(:correct_attempt_count) if is_correct

      # Update average time
      current_total = (average_time_taken_seconds || 0) * (attempt_count - 1)
      self.average_time_taken_seconds = ((current_total + time_taken) / attempt_count).round
      save
    end

    def accuracy_percentage
      return 0 if attempt_count.zero?
      (correct_attempt_count.to_f / attempt_count * 100).round(2)
    end

    def difficulty_score
      case difficulty
      when 'easy' then 1
      when 'medium' then 2
      when 'hard' then 3
      else 2
      end
    end
  end
end
