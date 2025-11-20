# frozen_string_literal: true

module Api
  module Upsc
    class UserAnswersController < BaseController
      before_action :require_user
      before_action :set_user_answer, only: [:show, :update, :destroy]

      # GET /api/upsc/user_answers
      def index
        @answers = current_user.upsc_user_answers.includes(:writing_question)

        # Filter by status
        @answers = @answers.where(status: params[:status]) if params[:status].present?

        # Filter by question
        @answers = @answers.where(upsc_writing_question_id: params[:question_id]) if params[:question_id].present?

        @answers = @answers.order(created_at: :desc)

        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        @answers = @answers.page(page).per(per_page)

        render_success({
          user_answers: @answers.as_json(
            include: {
              writing_question: { only: [:id, :question_text, :question_type, :word_limit] }
            }
          ),
          meta: pagination_meta(@answers)
        })
      end

      # GET /api/upsc/user_answers/:id
      def show
        render_success({
          user_answer: @user_answer.as_json(
            include: {
              writing_question: {
                only: [:id, :question_text, :question_type, :word_limit, :time_limit_minutes],
                methods: [:sample_answer_points, :evaluation_criteria]
              }
            }
          )
        })
      end

      # POST /api/upsc/user_answers
      def create
        @user_answer = current_user.upsc_user_answers.new(user_answer_params)
        @user_answer.submitted_at = Time.current

        if @user_answer.save
          # Trigger AI evaluation (async job in production)
          evaluate_with_ai(@user_answer) if params[:auto_evaluate] == 'true'

          render_success(
            { user_answer: @user_answer },
            'Answer submitted successfully',
            :created
          )
        else
          render_error('Failed to submit answer', @user_answer.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/user_answers/:id
      def update
        if @user_answer.update(user_answer_params)
          render_success({ user_answer: @user_answer }, 'Answer updated successfully')
        else
          render_error('Failed to update answer', @user_answer.errors.full_messages)
        end
      end

      # DELETE /api/upsc/user_answers/:id
      def destroy
        @user_answer.destroy
        render_success({}, 'Answer deleted successfully')
      end

      # POST /api/upsc/user_answers/:id/request_evaluation
      def request_evaluation
        @user_answer = current_user.upsc_user_answers.find(params[:id])

        if @user_answer.status == 'evaluated'
          return render_error('Answer already evaluated', [], :unprocessable_entity)
        end

        # Trigger AI evaluation
        result = evaluate_with_ai(@user_answer)

        if result[:success]
          render_success(
            { user_answer: @user_answer.reload },
            'Evaluation completed successfully'
          )
        else
          render_error('Evaluation failed', [result[:error]], :unprocessable_entity)
        end
      end

      # GET /api/upsc/user_answers/statistics
      def statistics
        total_answers = current_user.upsc_user_answers.count
        evaluated_answers = current_user.upsc_user_answers.where(status: 'evaluated').count
        average_score = current_user.upsc_user_answers.where(status: 'evaluated').average(:score)&.round(2)

        # Answer type breakdown
        answer_types = current_user.upsc_user_answers
          .joins(:writing_question)
          .group('upsc_writing_questions.question_type')
          .count

        render_success({
          statistics: {
            total_answers: total_answers,
            evaluated_answers: evaluated_answers,
            pending_evaluation: total_answers - evaluated_answers,
            average_score: average_score || 0,
            answer_type_breakdown: answer_types
          }
        })
      end

      private

      def set_user_answer
        @user_answer = current_user.upsc_user_answers.find(params[:id])
      end

      def user_answer_params
        params.require(:user_answer).permit(
          :upsc_writing_question_id, :answer_text, :word_count,
          :time_taken_minutes
        )
      end

      def require_user
        unless current_user
          render_error('Authentication required', [], :unauthorized)
        end
      end

      def evaluate_with_ai(user_answer)
        begin
          # Get the writing question with details
          question = user_answer.writing_question

          # Call Ollama service for evaluation
          evaluation_result = OllamaService.evaluate_answer(
            answer_text: user_answer.answer_text,
            question_text: question.question_text,
            word_limit: question.word_limit,
            evaluation_criteria: question.evaluation_criteria || [],
            sample_answer_points: question.sample_answer_points || []
          )

          # Add metadata
          evaluation_result['evaluated_at'] = Time.current
          evaluation_result['model_used'] = ENV.fetch('OLLAMA_MODEL', 'llama3.2')

          # Update user answer with evaluation
          user_answer.update(
            status: 'evaluated',
            score: evaluation_result['overall_score'],
            ai_evaluation: evaluation_result
          )

          { success: true, evaluation: evaluation_result }
        rescue OllamaService::OllamaError => e
          Rails.logger.error("Ollama evaluation failed: #{e.message}")

          # Fallback to mock evaluation if Ollama fails
          mock_evaluation = {
            overall_score: 70,
            content_coverage: 70,
            structure: 70,
            language_quality: 70,
            presentation: 70,
            strengths: ['Answer submitted successfully'],
            weaknesses: ['AI evaluation temporarily unavailable'],
            suggestions: ['Please retry evaluation later'],
            detailed_feedback: 'Ollama AI service is currently unavailable. Your answer has been saved and you can request evaluation later.',
            evaluated_at: Time.current,
            model_used: 'fallback'
          }

          user_answer.update(
            status: 'submitted', # Keep as submitted since evaluation failed
            ai_evaluation: mock_evaluation
          )

          { success: false, error: 'AI evaluation service unavailable. Answer saved for later evaluation.', fallback: true }
        rescue => e
          Rails.logger.error("Answer evaluation error: #{e.message}")
          { success: false, error: e.message }
        end
      end
    end
  end
end
