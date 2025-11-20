#!/usr/bin/env ruby
# Script to create all UPSC model files

require 'fileutils'

# Ensure directory exists
FileUtils.mkdir_p('app/models/upsc')

models = {
  'topic.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class Topic < ApplicationRecord
        self.table_name = 'upsc_topics'

        # Associations
        belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id'
        belongs_to :parent_topic, class_name: 'Upsc::Topic', optional: true
        belongs_to :course_lesson, class_name: 'CourseLesson', optional: true
        belongs_to :course_module, class_name: 'CourseModule', optional: true

        has_many :child_topics, class_name: 'Upsc::Topic', foreign_key: 'parent_topic_id', dependent: :destroy
        has_many :user_progress, class_name: 'Upsc::UserProgress', foreign_key: 'upsc_topic_id', dependent: :destroy
        has_many :questions, class_name: 'Upsc::Question', foreign_key: 'upsc_topic_id', dependent: :nullify
        has_many :writing_questions, class_name: 'Upsc::WritingQuestion', foreign_key: 'upsc_topic_id', dependent: :nullify
        has_many :revisions, class_name: 'Upsc::Revision', foreign_key: 'upsc_topic_id', dependent: :destroy
        has_many :daily_tasks, class_name: 'Upsc::DailyTask', foreign_key: 'upsc_topic_id', dependent: :nullify

        # Validations
        validates :name, presence: true
        validates :slug, presence: true, uniqueness: { scope: :upsc_subject_id }
        validates :difficulty_level, inclusion: { in: %w[beginner intermediate advanced] }, allow_nil: true

        # Callbacks
        before_validation :generate_slug, on: :create

        # Scopes
        scope :root_topics, -> { where(parent_topic_id: nil) }
        scope :high_yield, -> { where(is_high_yield: true) }
        scope :ordered, -> { order(:order_index) }
        scope :by_difficulty, ->(level) { where(difficulty_level: level) }

        # Instance methods
        def full_path
          path = [name]
          current = self
          while current.parent_topic
            current = current.parent_topic
            path.unshift(current.name)
          end
          path.join(' > ')
        end

        def prerequisite_topics
          return [] unless prerequisite_topic_ids.present?
          Upsc::Topic.where(id: prerequisite_topic_ids)
        end

        def completion_rate(user)
          progress = user_progress.find_by(user: user)
          progress&.completion_percentage || 0
        end

        private

        def generate_slug
          self.slug = name.parameterize if name.present? && slug.blank?
        end
      end
    end
  RUBY

  'student_profile.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class StudentProfile < ApplicationRecord
        self.table_name = 'upsc_student_profiles'

        # Associations
        belongs_to :user
        belongs_to :optional_subject, class_name: 'Upsc::Subject', optional: true

        # Validations
        validates :user, presence: true, uniqueness: true
        validates :attempt_number, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
        validates :medium_of_exam, inclusion: { in: %w[english hindi] }, allow_nil: true
        validates :study_hours_per_day, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 18 }, allow_nil: true

        # Callbacks
        before_create :set_defaults

        # Instance methods
        def days_until_exam
          return nil unless target_exam_date
          (target_exam_date - Date.current).to_i
        end

        def exam_phase
          days = days_until_exam
          return 'exam_passed' if days && days < 0
          return 'exam_imminent' if days && days <= 30
          return 'final_prep' if days && days <= 90
          return 'practice_phase' if days && days <= 180
          'foundation_phase'
        end

        def is_first_attempt?
          attempt_number == 1
        end

        def weak_areas
          weaknesses || []
        end

        def strong_areas
          strengths || []
        end

        private

        def set_defaults
          self.attempt_number ||= 1
          self.medium_of_exam ||= 'english'
          self.previous_attempt_details ||= {}
          self.daf_details ||= {}
          self.strengths ||= []
          self.weaknesses ||= []
        end
      end
    end
  RUBY

  'question.rb' => <<~RUBY,
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
  RUBY

  'test.rb' => <<~RUBY,
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
  RUBY

  'test_question.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class TestQuestion < ApplicationRecord
        self.table_name = 'upsc_test_questions'

        # Associations
        belongs_to :test, class_name: 'Upsc::Test', foreign_key: 'upsc_test_id'
        belongs_to :question, class_name: 'Upsc::Question', foreign_key: 'upsc_question_id'

        # Validations
        validates :marks, presence: true, numericality: { greater_than: 0 }
        validates :order_index, presence: true

        # Scopes
        scope :ordered, -> { order(:order_index) }
        scope :by_section, ->(section) { where(section: section) if section.present? }
      end
    end
  RUBY

  'user_test_attempt.rb' => <<~RUBY,
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
  RUBY
}

# Part 2 of models in next file...
puts "Creating UPSC model files (Part 1/2)..."

models.each do |filename, content|
  filepath = "app/models/upsc/#{filename}"
  puts "Creating #{filepath}..."
  File.write(filepath, content)
  puts "✅ Created #{filepath}"
end

puts "\n✅ Part 1 complete! (6 models created)"
puts "Run the second script for remaining models..."
