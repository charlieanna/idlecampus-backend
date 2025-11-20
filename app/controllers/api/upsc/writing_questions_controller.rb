# frozen_string_literal: true

module Api
  module Upsc
    class WritingQuestionsController < BaseController
      before_action :set_writing_question, only: [:show, :update, :destroy]

      # GET /api/upsc/writing_questions
      def index
        @questions = ::Upsc::WritingQuestion.all

        # Filter by type
        @questions = @questions.where(question_type: params[:question_type]) if params[:question_type].present?

        # Filter by topic
        @questions = @questions.where(upsc_topic_id: params[:topic_id]) if params[:topic_id].present?

        # Filter by difficulty
        @questions = @questions.where(difficulty_level: params[:difficulty]) if params[:difficulty].present?

        # Daily question
        if params[:daily] == 'true'
          @questions = @questions.where('DATE(created_at) = ?', Date.current)
        end

        @questions = @questions.order(created_at: :desc)

        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 10
        @questions = @questions.page(page).per(per_page)

        render_success({
          writing_questions: @questions.as_json(
            include: {
              topic: { only: [:id, :name, :slug] }
            }
          ),
          meta: pagination_meta(@questions)
        })
      end

      # GET /api/upsc/writing_questions/:id
      def show
        # Get user's answers for this question
        user_answers = current_user ? @writing_question.user_answers.where(user: current_user) : []

        render_success({
          writing_question: @writing_question.as_json(
            include: { topic: { only: [:id, :name] } }
          ),
          user_answers: user_answers.as_json(only: [:id, :created_at, :score, :status])
        })
      end

      # POST /api/upsc/writing_questions
      def create
        @writing_question = ::Upsc::WritingQuestion.new(writing_question_params)

        if @writing_question.save
          render_success({ writing_question: @writing_question }, 'Writing question created successfully', :created)
        else
          render_error('Failed to create writing question', @writing_question.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/writing_questions/:id
      def update
        if @writing_question.update(writing_question_params)
          render_success({ writing_question: @writing_question }, 'Writing question updated successfully')
        else
          render_error('Failed to update writing question', @writing_question.errors.full_messages)
        end
      end

      # DELETE /api/upsc/writing_questions/:id
      def destroy
        @writing_question.destroy
        render_success({}, 'Writing question deleted successfully')
      end

      # GET /api/upsc/writing_questions/daily
      def daily
        @question = ::Upsc::WritingQuestion.where('DATE(created_at) = ?', Date.current).first

        if @question
          render_success({ writing_question: @question })
        else
          render_error('No daily question available', [], :not_found)
        end
      end

      private

      def set_writing_question
        @writing_question = ::Upsc::WritingQuestion.find(params[:id])
      end

      def writing_question_params
        params.require(:writing_question).permit(
          :upsc_topic_id, :question_text, :question_type, :word_limit,
          :time_limit_minutes, :difficulty_level, :is_pyq, :pyq_year,
          :ideal_structure, :key_points_to_cover,
          sample_answer_points: [], evaluation_criteria: []
        )
      end
    end
  end
end
