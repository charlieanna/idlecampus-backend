# frozen_string_literal: true

module Api
  module Upsc
    class SubjectsController < BaseController
      before_action :set_subject, only: [:show, :update, :destroy]

      # GET /api/upsc/subjects
      def index
        @subjects = ::Upsc::Subject.active.ordered

        # Filter by exam type if provided
        @subjects = @subjects.where(exam_type: params[:exam_type]) if params[:exam_type].present?

        # Filter optional/mandatory
        @subjects = @subjects.where(is_optional: params[:optional]) if params[:optional].present?

        render_success({
          subjects: @subjects.as_json(
            include: {
              topics: {
                only: [:id, :name, :slug, :difficulty_level, :is_high_yield],
                methods: [:full_path]
              }
            },
            methods: [:total_topics_count, :high_yield_topics_count]
          )
        })
      end

      # GET /api/upsc/subjects/:id
      def show
        render_success({
          subject: @subject.as_json(
            include: {
              topics: {
                only: [:id, :name, :slug, :description, :difficulty_level, :estimated_hours, :is_high_yield, :pyq_frequency, :order_index],
                methods: [:full_path]
              }
            },
            methods: [:total_topics_count, :high_yield_topics_count]
          )
        })
      end

      # POST /api/upsc/subjects
      def create
        @subject = ::Upsc::Subject.new(subject_params)

        if @subject.save
          render_success({ subject: @subject }, 'Subject created successfully', :created)
        else
          render_error('Failed to create subject', @subject.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/subjects/:id
      def update
        if @subject.update(subject_params)
          render_success({ subject: @subject }, 'Subject updated successfully')
        else
          render_error('Failed to update subject', @subject.errors.full_messages)
        end
      end

      # DELETE /api/upsc/subjects/:id
      def destroy
        @subject.destroy
        render_success({}, 'Subject deleted successfully')
      end

      # GET /api/upsc/subjects/prelims
      def prelims
        @subjects = ::Upsc::Subject.prelims.active.ordered
        render_success({ subjects: @subjects })
      end

      # GET /api/upsc/subjects/mains
      def mains
        @subjects = ::Upsc::Subject.mains.active.ordered
        render_success({ subjects: @subjects })
      end

      # GET /api/upsc/subjects/optional
      def optional
        @subjects = ::Upsc::Subject.optional.active.ordered
        render_success({ subjects: @subjects })
      end

      private

      def set_subject
        @subject = ::Upsc::Subject.find(params[:id])
      end

      def subject_params
        params.require(:subject).permit(
          :name, :code, :exam_type, :paper_number, :total_marks,
          :duration_minutes, :description, :syllabus_pdf_url,
          :is_optional, :is_active, :order_index, :icon_url, :color_code
        )
      end
    end
  end
end
