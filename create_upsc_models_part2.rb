#!/usr/bin/env ruby
# Script to create remaining UPSC model files (Part 2)

require 'fileutils'

models = {
  'writing_question.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class WritingQuestion < ApplicationRecord
        self.table_name = 'upsc_writing_questions'

        # Associations
        belongs_to :subject, class_name: 'Upsc::Subject', foreign_key: 'upsc_subject_id', optional: true
        belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id', optional: true
        belongs_to :created_by, class_name: 'User', optional: true

        has_many :user_answers, class_name: 'Upsc::UserAnswer', foreign_key: 'upsc_writing_question_id', dependent: :destroy

        # Validations
        validates :question_text, presence: true
        validates :question_type, inclusion: { in: %w[essay case_study general analytical] }, allow_nil: true

        # Scopes
        scope :recent, -> { order(created_at: :desc) }
        scope :pyqs, -> { where.not(pyq_year: nil) }
        scope :by_type, ->(type) { where(question_type: type) }
        scope :for_date, ->(date) { where(current_affairs_date: date) }
        scope :high_relevance, -> { where('relevance_score >= ?', 70) }

        # Instance methods
        def is_pyq?
          pyq_year.present?
        end

        def is_current_affairs?
          current_affairs_date.present?
        end

        def daily_question?
          current_affairs_date == Date.current
        end

        def average_score
          user_answers.where.not(final_score: nil).average(:final_score) || 0
        end

        def total_submissions
          user_answers.count
        end
      end
    end
  RUBY

  'user_answer.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class UserAnswer < ApplicationRecord
        self.table_name = 'upsc_user_answers'

        # Associations
        belongs_to :user
        belongs_to :writing_question, class_name: 'Upsc::WritingQuestion', foreign_key: 'upsc_writing_question_id'
        belongs_to :evaluator, class_name: 'User', optional: true
        belongs_to :original_answer, class_name: 'Upsc::UserAnswer', optional: true

        has_many :revisions, class_name: 'Upsc::UserAnswer', foreign_key: 'original_answer_id', dependent: :nullify

        # Validations
        validates :answer_text, presence: true, unless: :file_url?
        validates :submission_type, inclusion: { in: %w[typed uploaded] }
        validates :status, inclusion: { in: %w[submitted ai_evaluated mentor_review completed] }

        # Callbacks
        before_create :calculate_word_count
        after_create :enqueue_ai_evaluation

        # Scopes
        scope :pending_evaluation, -> { where(status: ['submitted', 'ai_evaluated']) }
        scope :evaluated, -> { where(status: ['mentor_review', 'completed']) }
        scope :recent, -> { order(submitted_at: :desc) }
        scope :public_answers, -> { where(is_public: true) }

        # Instance methods
        def evaluate_with_ai
          # Will be implemented with AI service
          # AiAnswerEvaluationService.new(self).evaluate
        end

        def evaluate_by_mentor(mentor, evaluation_data)
          self.evaluator = mentor
          self.mentor_evaluation = evaluation_data
          self.mentor_score = evaluation_data['total_score']
          self.mentor_evaluated_at = Time.current
          self.final_score = mentor_score
          self.status = 'completed'
          save
        end

        def is_revision?
          original_answer_id.present?
        end

        def improvement_percentage
          return nil unless is_revision? && original_answer
          return nil unless final_score && original_answer.final_score

          ((final_score - original_answer.final_score) / original_answer.final_score * 100).round(2)
        end

        private

        def calculate_word_count
          self.word_count = answer_text.split.size if answer_text.present?
        end

        def enqueue_ai_evaluation
          # Will be implemented later
          # AiEvaluationJob.perform_later(id)
        end
      end
    end
  RUBY

  'news_article.rb' => <<~RUBY,
    # frozen_string_literal: true

    module Upsc
      class NewsArticle < ApplicationRecord
        self.table_name = 'upsc_news_articles'

        # Associations
        belongs_to :created_by, class_name: 'User', optional: true

        # Validations
        validates :title, presence: true
        validates :slug, presence: true, uniqueness: true
        validates :full_content, presence: true
        validates :published_date, presence: true
        validates :importance_level, inclusion: { in: %w[low medium high critical] }, allow_nil: true

        # Callbacks
        before_validation :generate_slug, on: :create

        # Scopes
        scope :published, -> { where(status: 'published') }
        scope :featured, -> { where(is_featured: true) }
        scope :recent, -> { order(published_date: :desc) }
        scope :by_category, ->(category) { where('? = ANY(categories)', category) }
        scope :by_date_range, ->(start_date, end_date) { where(published_date: start_date..end_date) }
        scope :high_relevance, -> { where('relevance_score >= ?', 70) }

        # Class methods
        def self.daily_news(date = Date.current)
          where(published_date: date).published.order(relevance_score: :desc)
        end

        def self.weekly_roundup(weeks_ago = 0)
          start_date = weeks_ago.weeks.ago.beginning_of_week
          end_date = weeks_ago.weeks.ago.end_of_week
          by_date_range(start_date, end_date).published.order(relevance_score: :desc)
        end

        # Instance methods
        def related_topics
          return [] unless related_topic_ids.present?
          Upsc::Topic.where(id: related_topic_ids)
        end

        def related_subjects
          return [] unless related_subject_ids.present?
          Upsc::Subject.where(id: related_subject_ids)
        end

        def increment_view_count
          increment!(:view_count)
        end

        def increment_like_count
          increment!(:like_count)
        end

        private

        def generate_slug
          self.slug = title.parameterize if title.present? && slug.blank?
        end
      end
    end
  RUBY

  'study_plan.rb' => <<~RUBY,
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
  RUBY

  'daily_task.rb' => <<~RUBY,
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
  RUBY

  'revision.rb' => <<~RUBY,
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
  RUBY

  'user_progress.rb' => <<~RUBY
    # frozen_string_literal: true

    module Upsc
      class UserProgress < ApplicationRecord
        self.table_name = 'upsc_user_progress'

        # Associations
        belongs_to :user
        belongs_to :topic, class_name: 'Upsc::Topic', foreign_key: 'upsc_topic_id'

        # Validations
        validates :user, presence: true
        validates :topic, presence: true
        validates :status, inclusion: { in: %w[not_started in_progress completed mastered] }
        validates :completion_percentage, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
        validates :confidence_level, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, allow_nil: true

        # Scopes
        scope :in_progress, -> { where(status: 'in_progress') }
        scope :completed, -> { where(status: ['completed', 'mastered']) }
        scope :recently_accessed, -> { order(last_accessed_at: :desc) }
        scope :bookmarked, -> { where(bookmarked: true) }
        scope :needs_revision, -> { where('last_revised_at IS NULL OR last_revised_at < ?', 7.days.ago) }

        # Instance methods
        def start!
          self.status = 'in_progress'
          self.first_started_at ||= Time.current
          self.last_accessed_at = Time.current
          save
        end

        def mark_complete!
          self.status = 'completed'
          self.completion_percentage = 100
          self.completed_at = Time.current
          save

          # Schedule first revision
          Upsc::Revision.schedule_next_revision(user, topic) if topic
        end

        def mark_mastered!
          self.status = 'mastered'
          self.mastered_at = Time.current
          save
        end

        def update_progress(percentage)
          self.completion_percentage = [percentage, 100].min
          self.status = 'completed' if completion_percentage >= 100
          self.last_accessed_at = Time.current
          save
        end

        def record_revision
          self.revision_count += 1
          self.last_revised_at = Time.current
          save
        end

        def time_since_last_access
          return nil unless last_accessed_at
          ((Time.current - last_accessed_at) / 1.day).round
        end

        def needs_revision?
          return true if last_revised_at.nil?
          last_revised_at < 7.days.ago
        end
      end
    end
  RUBY
}

puts "Creating UPSC model files (Part 2/2)..."

models.each do |filename, content|
  filepath = "app/models/upsc/#{filename}"
  puts "Creating #{filepath}..."
  File.write(filepath, content)
  puts "✅ Created #{filepath}"
end

puts "\n✅ All UPSC models created successfully!"
puts "Total models: 13"
puts "\nNext steps:"
puts "1. Run: rails db:migrate"
puts "2. Create seed data"
puts "3. Test models in rails console"
