# frozen_string_literal: true

module Api
  module Upsc
    class DashboardController < BaseController
      before_action :require_user

      # GET /api/upsc/dashboard
      def index
        render_success({
          overview: overview_stats,
          today: today_stats,
          progress: progress_stats,
          recent_activity: recent_activity,
          upcoming: upcoming_items
        })
      end

      # GET /api/upsc/dashboard/overview
      def overview
        render_success({ overview: overview_stats })
      end

      # GET /api/upsc/dashboard/progress
      def progress
        render_success({ progress: progress_stats })
      end

      # GET /api/upsc/dashboard/analytics
      def analytics
        render_success({
          test_performance: test_performance_analytics,
          study_time: study_time_analytics,
          topic_coverage: topic_coverage_analytics,
          writing_practice: writing_practice_analytics
        })
      end

      private

      def overview_stats
        profile = current_user.upsc_student_profile
        active_study_plan = current_user.upsc_study_plans.find_by(is_active: true)

        {
          student_profile: profile&.as_json(only: [:target_exam_date, :attempt_number, :preparation_status]),
          active_study_plan: active_study_plan&.as_json(
            only: [:id, :name, :target_exam_date],
            methods: [:completion_percentage]
          ),
          days_to_exam: profile&.target_exam_date ? (profile.target_exam_date - Date.current).to_i : nil
        }
      end

      def today_stats
        today_tasks = current_user.upsc_daily_tasks.where(scheduled_for: Date.current)
        today_revisions = current_user.upsc_revisions.where(scheduled_for: Date.current)

        {
          tasks: {
            total: today_tasks.count,
            completed: today_tasks.where(status: 'completed').count,
            pending: today_tasks.where(status: 'pending').count,
            list: today_tasks.limit(5).as_json(
              only: [:id, :title, :task_type, :status, :priority],
              include: { topic: { only: [:name] } }
            )
          },
          revisions: {
            total: today_revisions.count,
            completed: today_revisions.where(status: 'completed').count,
            pending: today_revisions.where(status: 'pending').count,
            list: today_revisions.limit(5).as_json(
              only: [:id, :scheduled_for, :status],
              include: { topic: { only: [:name] } }
            )
          }
        }
      end

      def progress_stats
        total_topics = ::Upsc::Topic.count
        user_progress = current_user.upsc_user_progress

        completed_topics = user_progress.where(status: 'completed').count
        in_progress_topics = user_progress.where(status: 'in_progress').count

        # Subject-wise progress
        subject_progress = ::Upsc::Subject.all.map do |subject|
          subject_topics = subject.topics.pluck(:id)
          completed = user_progress.where(upsc_topic_id: subject_topics, status: 'completed').count
          total = subject_topics.count

          {
            subject_id: subject.id,
            subject_name: subject.name,
            total_topics: total,
            completed_topics: completed,
            completion_percentage: total > 0 ? ((completed.to_f / total) * 100).round(2) : 0
          }
        end

        {
          overall: {
            total_topics: total_topics,
            completed_topics: completed_topics,
            in_progress_topics: in_progress_topics,
            not_started_topics: total_topics - completed_topics - in_progress_topics,
            completion_percentage: total_topics > 0 ? ((completed_topics.to_f / total_topics) * 100).round(2) : 0
          },
          by_subject: subject_progress
        }
      end

      def recent_activity
        recent_tests = current_user.upsc_user_test_attempts
          .order(created_at: :desc)
          .limit(3)
          .as_json(
            only: [:id, :score, :percentage, :created_at, :status],
            include: { test: { only: [:id, :title, :test_type] } }
          )

        recent_answers = current_user.upsc_user_answers
          .order(created_at: :desc)
          .limit(3)
          .as_json(
            only: [:id, :score, :status, :created_at],
            include: { writing_question: { only: [:id, :question_text, :question_type] } }
          )

        {
          recent_tests: recent_tests,
          recent_answers: recent_answers
        }
      end

      def upcoming_items
        upcoming_tasks = current_user.upsc_daily_tasks
          .where('scheduled_for > ? AND scheduled_for <= ?', Date.current, 7.days.from_now)
          .where(status: 'pending')
          .order(scheduled_for: :asc)
          .limit(5)
          .as_json(
            only: [:id, :title, :scheduled_for, :priority],
            include: { topic: { only: [:name] } }
          )

        upcoming_revisions = current_user.upsc_revisions
          .where('scheduled_for > ? AND scheduled_for <= ?', Date.current, 7.days.from_now)
          .where(status: 'pending')
          .order(scheduled_for: :asc)
          .limit(5)
          .as_json(
            only: [:id, :scheduled_for],
            include: { topic: { only: [:name] } }
          )

        upcoming_tests = ::Upsc::Test.upcoming.limit(3).as_json(
          only: [:id, :title, :test_type, :scheduled_at, :duration_minutes]
        )

        {
          tasks: upcoming_tasks,
          revisions: upcoming_revisions,
          tests: upcoming_tests
        }
      end

      def test_performance_analytics
        attempts = current_user.upsc_user_test_attempts.where(status: 'submitted')

        total_attempts = attempts.count
        average_score = attempts.average(:score)&.round(2) || 0
        average_percentage = attempts.average(:percentage)&.round(2) || 0

        # Performance trend (last 10 tests)
        recent_attempts = attempts.order(created_at: :desc).limit(10).reverse
        trend = recent_attempts.map do |attempt|
          {
            date: attempt.created_at.to_date,
            score: attempt.score,
            percentage: attempt.percentage,
            test_name: attempt.test.title
          }
        end

        # Performance by test type
        by_test_type = attempts.joins(:test).group('upsc_tests.test_type').average(:percentage)

        {
          total_attempts: total_attempts,
          average_score: average_score,
          average_percentage: average_percentage,
          trend: trend,
          by_test_type: by_test_type
        }
      end

      def study_time_analytics
        # Calculate from completed tasks
        completed_tasks = current_user.upsc_daily_tasks.where(status: 'completed')

        total_study_minutes = completed_tasks.sum(:actual_duration_minutes) || 0
        total_study_hours = (total_study_minutes / 60.0).round(2)

        # Last 7 days
        last_week_tasks = completed_tasks.where('completed_at >= ?', 7.days.ago)
        last_week_minutes = last_week_tasks.sum(:actual_duration_minutes) || 0
        average_daily_hours = (last_week_minutes / 60.0 / 7).round(2)

        # Study time by task type
        by_task_type = completed_tasks.group(:task_type).sum(:actual_duration_minutes)
        by_task_type_hours = by_task_type.transform_values { |mins| (mins / 60.0).round(2) }

        {
          total_study_hours: total_study_hours,
          average_daily_hours: average_daily_hours,
          last_week_hours: (last_week_minutes / 60.0).round(2),
          by_task_type: by_task_type_hours
        }
      end

      def topic_coverage_analytics
        all_topics = ::Upsc::Topic.all.pluck(:id)
        user_progress = current_user.upsc_user_progress

        # Coverage by difficulty
        by_difficulty = ['easy', 'medium', 'hard'].map do |difficulty|
          difficulty_topics = ::Upsc::Topic.where(difficulty_level: difficulty).pluck(:id)
          completed = user_progress.where(upsc_topic_id: difficulty_topics, status: 'completed').count
          total = difficulty_topics.count

          {
            difficulty: difficulty,
            total: total,
            completed: completed,
            percentage: total > 0 ? ((completed.to_f / total) * 100).round(2) : 0
          }
        end

        # High-yield topics coverage
        high_yield_topics = ::Upsc::Topic.where(is_high_yield: true).pluck(:id)
        high_yield_completed = user_progress.where(upsc_topic_id: high_yield_topics, status: 'completed').count

        {
          by_difficulty: by_difficulty,
          high_yield: {
            total: high_yield_topics.count,
            completed: high_yield_completed,
            percentage: high_yield_topics.count > 0 ? ((high_yield_completed.to_f / high_yield_topics.count) * 100).round(2) : 0
          }
        }
      end

      def writing_practice_analytics
        answers = current_user.upsc_user_answers
        evaluated = answers.where(status: 'evaluated')

        total_answers = answers.count
        evaluated_count = evaluated.count
        average_score = evaluated.average(:score)&.round(2) || 0

        # By question type
        by_type = answers.joins(:writing_question)
          .group('upsc_writing_questions.question_type')
          .count

        # Score trend (last 10 answers)
        recent_answers = evaluated.order(created_at: :desc).limit(10).reverse
        trend = recent_answers.map do |answer|
          {
            date: answer.created_at.to_date,
            score: answer.score,
            question_type: answer.writing_question.question_type
          }
        end

        {
          total_answers: total_answers,
          evaluated_count: evaluated_count,
          pending_evaluation: total_answers - evaluated_count,
          average_score: average_score,
          by_type: by_type,
          trend: trend
        }
      end

      def require_user
        unless current_user
          render_error('Authentication required', [], :unauthorized)
        end
      end
    end
  end
end
