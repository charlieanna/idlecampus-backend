# frozen_string_literal: true

module Api
  module Upsc
    class TestsController < BaseController
      before_action :set_test, only: [:show, :start, :submit, :results]
      before_action :require_user, only: [:start, :submit, :my_attempts]

      # GET /api/upsc/tests
      def index
        @tests = ::Upsc::Test.all

        # Filter by type
        @tests = @tests.by_type(params[:test_type]) if params[:test_type].present?

        # Filter by status
        case params[:status]
        when 'live'
          @tests = @tests.live
        when 'upcoming'
          @tests = @tests.upcoming
        when 'ongoing'
          @tests = @tests.ongoing
        when 'completed'
          @tests = @tests.completed
        end

        # Filter by subject
        @tests = @tests.where(upsc_subject_id: params[:subject_id]) if params[:subject_id].present?

        @tests = @tests.order(scheduled_at: :desc)

        render_success({
          tests: @tests.as_json(
            include: { subject: { only: [:id, :name, :code] } },
            methods: [:is_ongoing?, :is_upcoming?, :questions_count, :total_attempts_count, :average_score]
          )
        })
      end

      # GET /api/upsc/tests/:id
      def show
        user_attempts = current_user ? @test.user_test_attempts.where(user: current_user).count : 0

        render_success({
          test: @test.as_json(
            include: {
              subject: { only: [:id, :name, :code] }
            },
            methods: [:questions_count, :average_score, :total_attempts_count]
          ),
          user_attempts: user_attempts,
          can_attempt: user_attempts < @test.max_attempts
        })
      end

      # POST /api/upsc/tests/:id/start
      def start
        # Check if user can attempt
        user_attempts = @test.user_test_attempts.where(user: current_user).count
        if user_attempts >= @test.max_attempts
          return render_error("Maximum attempts (#{@test.max_attempts}) reached", [], :forbidden)
        end

        # Check if test is ongoing
        unless @test.is_ongoing?
          return render_error('Test is not currently available', [], :forbidden)
        end

        # Create attempt
        @attempt = current_user.upsc_user_test_attempts.create!(
          upsc_test: @test,
          started_at: Time.current
        )

        # Get questions (shuffle if needed)
        questions = @test.test_questions.includes(:question).ordered
        questions = questions.shuffle if @test.shuffle_questions

        render_success({
          attempt_id: @attempt.id,
          test: @test.as_json(only: [:id, :title, :duration_minutes, :total_marks, :negative_marking_enabled]),
          questions: questions.map do |tq|
            question_json = tq.question.as_json(
              only: [:id, :question_text, :question_type, :question_image_url, :time_limit_seconds],
              include: { topic: { only: [:name] } }
            )
            question_json['options'] = @test.shuffle_options ? tq.question.options.shuffle : tq.question.options
            question_json['marks'] = tq.marks
            question_json['negative_marks'] = tq.negative_marks
            question_json['order'] = tq.order_index
            question_json
          end
        }, 'Test started successfully')
      end

      # POST /api/upsc/tests/attempts/:id/submit_answer
      def submit_answer
        @attempt = current_user.upsc_user_test_attempts.find(params[:attempt_id])

        unless @attempt.status == 'in_progress'
          return render_error('Test has already been submitted', [], :forbidden)
        end

        @attempt.submit_answer(
          params[:question_id],
          params[:answer],
          params[:time_spent]
        )

        render_success({ attempt: @attempt }, 'Answer saved')
      end

      # POST /api/upsc/tests/attempts/:id/submit
      def submit
        @attempt = current_user.upsc_user_test_attempts.find(params[:attempt_id])

        unless @attempt.status == 'in_progress'
          return render_error('Test has already been submitted', [], :forbidden)
        end

        @attempt.submit_test!

        # Calculate percentile
        percentile = @attempt.calculate_percentile
        @attempt.update(percentile: percentile)

        render_success({
          attempt: @attempt.as_json(
            include: { test: { only: [:id, :title, :total_marks] } }
          ),
          message: 'Test submitted successfully'
        })
      end

      # GET /api/upsc/tests/attempts/:id/results
      def results
        @attempt = ::Upsc::UserTestAttempt.find(params[:attempt_id])

        # Check authorization
        unless current_user && (@attempt.user_id == current_user.id || current_user.admin?)
          return render_error('Unauthorized', [], :unauthorized)
        end

        # Get detailed results
        questions_details = @attempt.test.test_questions.includes(:question).ordered.map do |tq|
          user_answer = @attempt.answers[tq.upsc_question_id.to_s]
          is_correct = tq.question.correct_answer == user_answer
          time_taken = @attempt.question_wise_time[tq.upsc_question_id.to_s]

          {
            question_id: tq.question.id,
            question_text: tq.question.question_text,
            options: tq.question.options,
            correct_answer: @attempt.test.show_answers_after_submit ? tq.question.correct_answer : nil,
            user_answer: user_answer,
            is_correct: is_correct,
            marks_awarded: is_correct ? tq.marks : -tq.negative_marks,
            time_taken: time_taken,
            explanation: @attempt.test.show_answers_after_submit ? tq.question.explanation : nil
          }
        end

        render_success({
          attempt: @attempt.as_json(
            include: { test: { only: [:id, :title, :total_marks, :duration_minutes] } }
          ),
          questions: questions_details,
          analysis: @attempt.analysis
        })
      end

      # GET /api/upsc/tests/my_attempts
      def my_attempts
        @attempts = current_user.upsc_user_test_attempts
          .includes(:test)
          .order(created_at: :desc)

        render_success({
          attempts: @attempts.as_json(
            include: {
              test: { only: [:id, :title, :test_type, :total_marks] }
            }
          )
        })
      end

      private

      def set_test
        @test = ::Upsc::Test.find(params[:id])
      end

      def require_user
        unless current_user
          render_error('Authentication required', [], :unauthorized)
        end
      end
    end
  end
end
