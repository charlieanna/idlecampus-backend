# frozen_string_literal: true

module Upsc
  class UserTestAttempt < ApplicationRecord
    self.table_name = 'upsc_user_test_attempts'

    # Associations
    belongs_to :user
    belongs_to :test, class_name: 'Upsc::Test', foreign_key: 'upsc_test_id'

    # Validations
    validates :attempt_number, presence: true
    validates :status, inclusion: { in: %w[in_progress submitted evaluated] }

    # Callbacks
    before_create :set_attempt_number
    before_create :initialize_answers

    # Scopes
    scope :submitted, -> { where(status: ['submitted', 'evaluated']) }
    scope :in_progress, -> { where(status: 'in_progress') }
    scope :recent, -> { order(created_at: :desc) }

    # Instance methods
    def submit_answer(question_id, selected_answer, time_spent)
      self.answers ||= {}
      self.question_wise_time ||= {}

      answers[question_id.to_s] = selected_answer
      question_wise_time[question_id.to_s] = time_spent
      save
    end

    def submit_test!
      return false if submitted_at.present?

      self.submitted_at = Time.current
      self.time_taken_minutes = ((submitted_at - started_at) / 60).round
      self.status = 'submitted'

      calculate_score
      save
    end

    def calculate_score
      total_score = 0
      correct = 0
      wrong = 0
      unanswered = 0

      test.test_questions.includes(:question).each do |tq|
        user_answer = answers[tq.upsc_question_id.to_s]

        if user_answer.blank?
          unanswered += 1
          next
        end

        if tq.question.correct_answer == user_answer
          total_score += tq.marks
          correct += 1
          tq.question.update_stats(true, question_wise_time[tq.upsc_question_id.to_s] || 0)
        else
          total_score -= tq.negative_marks if test.negative_marking_enabled
          wrong += 1
          tq.question.update_stats(false, question_wise_time[tq.upsc_question_id.to_s] || 0)
        end
      end

      self.score = [total_score, 0].max
      self.percentage = (score / test.total_marks * 100).round(2)
      self.total_questions = test.test_questions.count
      self.correct_answers = correct
      self.wrong_answers = wrong
      self.unanswered = unanswered

      calculate_analysis
    end

    def calculate_percentile
      better_scores = UserTestAttempt
        .where(upsc_test_id: upsc_test_id)
        .where('score > ?', score)
        .count

      total_attempts = UserTestAttempt.where(upsc_test_id: upsc_test_id).count
      return 100 if total_attempts <= 1

      ((total_attempts - better_scores - 1).to_f / (total_attempts - 1) * 100).round(2)
    end

    private

    def set_attempt_number
      last_attempt = user.upsc_user_test_attempts
        .where(upsc_test_id: upsc_test_id)
        .maximum(:attempt_number) || 0
      self.attempt_number = last_attempt + 1
    end

    def initialize_answers
      self.answers ||= {}
      self.question_wise_time ||= {}
      self.analysis ||= {}
    end

    def calculate_analysis
      self.analysis = {
        subject_wise: {},
        difficulty_wise: {
          easy: { correct: 0, total: 0 },
          medium: { correct: 0, total: 0 },
          hard: { correct: 0, total: 0 }
        }
      }

      test.test_questions.includes(:question).each do |tq|
        question = tq.question
        user_answer = answers[question.id.to_s]
        is_correct = question.correct_answer == user_answer

        # Subject-wise analysis
        if question.subject
          subject_name = question.subject.name
          analysis[:subject_wise][subject_name] ||= { correct: 0, total: 0 }
          analysis[:subject_wise][subject_name][:total] += 1
          analysis[:subject_wise][subject_name][:correct] += 1 if is_correct
        end

        # Difficulty-wise analysis
        if question.difficulty
          analysis[:difficulty_wise][question.difficulty.to_sym][:total] += 1
          analysis[:difficulty_wise][question.difficulty.to_sym][:correct] += 1 if is_correct
        end
      end
    end
  end
end
