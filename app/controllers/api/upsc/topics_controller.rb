# frozen_string_literal: true

module Api
  module Upsc
    class TopicsController < BaseController
      before_action :set_topic, only: [:show, :update, :destroy, :start_learning, :mark_complete]
      before_action :set_subject, only: [:index, :create]

      # GET /api/upsc/topics or /api/upsc/subjects/:subject_id/topics
      def index
        @topics = @subject ? @subject.topics : ::Upsc::Topic.all

        # Filter by difficulty
        @topics = @topics.where(difficulty_level: params[:difficulty]) if params[:difficulty].present?

        # Only root topics
        @topics = @topics.root_topics if params[:root_only] == 'true'

        # Only high-yield
        @topics = @topics.high_yield if params[:high_yield] == 'true'

        @topics = @topics.ordered

        render_success({
          topics: @topics.as_json(
            include: {
              child_topics: {
                only: [:id, :name, :slug, :difficulty_level, :is_high_yield]
              }
            },
            methods: [:full_path]
          )
        })
      end

      # GET /api/upsc/topics/:id
      def show
        # Get user's progress on this topic
        progress = current_user&.upsc_user_progress&.find_by(upsc_topic_id: @topic.id)

        render_success({
          topic: @topic.as_json(
            include: {
              subject: { only: [:id, :name, :code] },
              parent_topic: { only: [:id, :name, :slug] },
              child_topics: {
                only: [:id, :name, :slug, :difficulty_level, :estimated_hours, :is_high_yield]
              },
              questions: {
                only: [:id, :question_text, :difficulty, :pyq_year]
              }
            },
            methods: [:full_path]
          ),
          user_progress: progress&.as_json(only: [:status, :completion_percentage, :confidence_level, :last_accessed_at])
        })
      end

      # POST /api/upsc/topics
      def create
        @topic = @subject.topics.new(topic_params)

        if @topic.save
          render_success({ topic: @topic }, 'Topic created successfully', :created)
        else
          render_error('Failed to create topic', @topic.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/topics/:id
      def update
        if @topic.update(topic_params)
          render_success({ topic: @topic }, 'Topic updated successfully')
        else
          render_error('Failed to update topic', @topic.errors.full_messages)
        end
      end

      # DELETE /api/upsc/topics/:id
      def destroy
        @topic.destroy
        render_success({}, 'Topic deleted successfully')
      end

      # POST /api/upsc/topics/:id/start
      def start_learning
        return render_error('User not authenticated', [], :unauthorized) unless current_user

        progress = current_user.upsc_user_progress.find_or_initialize_by(upsc_topic_id: @topic.id)
        progress.start!

        render_success({
          topic: @topic,
          progress: progress
        }, 'Learning session started')
      end

      # POST /api/upsc/topics/:id/complete
      def mark_complete
        return render_error('User not authenticated', [], :unauthorized) unless current_user

        progress = current_user.upsc_user_progress.find_or_initialize_by(upsc_topic_id: @topic.id)
        progress.mark_complete!

        render_success({
          topic: @topic,
          progress: progress
        }, 'Topic marked as complete')
      end

      # GET /api/upsc/topics/high_yield
      def high_yield
        @topics = ::Upsc::Topic.high_yield.ordered
        render_success({ topics: @topics })
      end

      private

      def set_topic
        @topic = ::Upsc::Topic.find(params[:id])
      end

      def set_subject
        @subject = ::Upsc::Subject.find(params[:subject_id]) if params[:subject_id]
      end

      def topic_params
        params.require(:topic).permit(
          :name, :slug, :description, :difficulty_level, :estimated_hours,
          :order_index, :is_high_yield, :pyq_frequency, :parent_topic_id,
          :course_lesson_id, :course_module_id,
          tags: [], learning_objectives: [], prerequisite_topic_ids: []
        )
      end
    end
  end
end
