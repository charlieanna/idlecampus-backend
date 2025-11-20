# frozen_string_literal: true

module Upsc
  class Test < ApplicationRecord
    self.table_name = 'upsc_tests'

    # Associations
    belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id', optional: true
    belongs_to :created_by, class_name: 'User', optional: true

    has_many :test_questions, -> { order(:order_index) }, class_name: 'Upsc::TestQuestion', foreign_key: 'upsc_test_id', dependent: :destroy
    has_many :questions, through: :test_questions, class_name: 'Upsc::Question'
    has_many :user_test_attempts, class_name: 'Upsc::UserTestAttempt', foreign_key: 'upsc_test_id', dependent: :destroy

    # Validations
    validates :title, presence: true
    validates :test_type, presence: true
    validates :duration_minutes, presence: true, numericality: { greater_than: 0 }
    validates :total_marks, presence: true, numericality: { greater_than: 0 }

    # Scopes
    scope :live, -> { where(is_live: true) }
    scope :upcoming, -> { where('starts_at > ?', Time.current) }
    scope :ongoing, -> { where('starts_at <= ? AND ends_at >= ?', Time.current, Time.current) }
    scope :completed, -> { where('ends_at < ?', Time.current) }
    scope :by_type, ->(type) { where(test_type: type) }

    # Instance methods
    def add_questions(question_ids, marks_per_question = nil)
      question_ids.each_with_index do |question_id, index|
        question = Upsc::Question.find(question_id)
        marks = marks_per_question || question.marks

        test_questions.create!(
          upsc_question_id: question_id,
          marks: marks,
          negative_marks: negative_marking_enabled ? marks * negative_marking_ratio : 0,
          order_index: index + 1
        )
      end
    end

    def is_ongoing?
      return false unless starts_at && ends_at
      Time.current.between?(starts_at, ends_at)
    end

    def is_upcoming?
      starts_at && starts_at > Time.current
    end

    def is_completed?
      ends_at && ends_at < Time.current
    end

    def average_score
      user_test_attempts.where(status: 'submitted').average(:score) || 0
    end

    def total_attempts_count
      user_test_attempts.where(status: 'submitted').count
    end

    def questions_count
      test_questions.count
    end
  end
end
