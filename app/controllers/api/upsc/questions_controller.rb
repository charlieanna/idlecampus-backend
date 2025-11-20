# frozen_string_literal: true

module Api
  module Upsc
    class QuestionsController < BaseController
      before_action :set_question, only: [:show, :update, :destroy]

      # GET /api/upsc/questions
      def index
        @questions = ::Upsc::Question.all

        # Filter by topic
        @questions = @questions.where(upsc_topic_id: params[:topic_id]) if params[:topic_id].present?

        # Filter by subject
        if params[:subject_id].present?
          topic_ids = ::Upsc::Topic.where(upsc_subject_id: params[:subject_id]).pluck(:id)
          @questions = @questions.where(upsc_topic_id: topic_ids)
        end

        # Filter by difficulty
        @questions = @questions.where(difficulty: params[:difficulty]) if params[:difficulty].present?

        # Filter by question type
        @questions = @questions.where(question_type: params[:question_type]) if params[:question_type].present?

        # Filter PYQs only
        @questions = @questions.previous_year_questions if params[:pyq_only] == 'true'

        # Filter by year
        @questions = @questions.where(pyq_year: params[:year]) if params[:year].present?

        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        @questions = @questions.page(page).per(per_page)

        render_success({
          questions: @questions.as_json(
            include: {
              topic: { only: [:id, :name, :slug] },
              subject: { only: [:id, :name, :code] }
            },
            except: [:correct_answer, :explanation]
          ),
          meta: pagination_meta(@questions)
        })
      end

      # GET /api/upsc/questions/:id
      def show
        render_success({
          question: @question.as_json(
            include: {
              topic: { only: [:id, :name, :slug] },
              subject: { only: [:id, :name, :code] }
            }
          )
        })
      end

      # POST /api/upsc/questions
      def create
        @question = ::Upsc::Question.new(question_params)

        if @question.save
          render_success({ question: @question }, 'Question created successfully', :created)
        else
          render_error('Failed to create question', @question.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/questions/:id
      def update
        if @question.update(question_params)
          render_success({ question: @question }, 'Question updated successfully')
        else
          render_error('Failed to update question', @question.errors.full_messages)
        end
      end

      # DELETE /api/upsc/questions/:id
      def destroy
        @question.destroy
        render_success({}, 'Question deleted successfully')
      end

      # POST /api/upsc/questions/:id/verify_answer
      def verify_answer
        @question = ::Upsc::Question.find(params[:id])
        user_answer = params[:answer]
        time_spent = params[:time_spent] || 0

        is_correct = @question.correct_answer == user_answer

        # Update question statistics
        @question.update_stats(is_correct, time_spent)

        render_success({
          is_correct: is_correct,
          correct_answer: @question.correct_answer,
          explanation: @question.explanation,
          statistics: {
            attempt_count: @question.attempt_count,
            accuracy: @question.accuracy_percentage,
            average_time: @question.average_time_taken_seconds
          }
        })
      end

      # GET /api/upsc/questions/random
      def random
        @questions = ::Upsc::Question.all

        # Apply filters
        @questions = @questions.where(upsc_topic_id: params[:topic_id]) if params[:topic_id].present?
        @questions = @questions.where(difficulty: params[:difficulty]) if params[:difficulty].present?

        # Get random questions
        count = params[:count]&.to_i || 10
        @questions = @questions.order('RANDOM()').limit(count)

        render_success({
          questions: @questions.as_json(
            include: { topic: { only: [:id, :name] } },
            except: [:correct_answer, :explanation]
          )
        })
      end

      private

      def set_question
        @question = ::Upsc::Question.find(params[:id])
      end

      def question_params
        params.require(:question).permit(
          :upsc_topic_id, :upsc_subject_id, :question_text, :question_type,
          :difficulty, :pyq_year, :pyq_paper, :time_limit_seconds,
          :question_image_url, :explanation, :correct_answer, :source,
          options: [], tags: []
        )
      end
    end
  end
end
