# frozen_string_literal: true

module Api
  module Upsc
    class StudyPlansController < BaseController
      before_action :require_user
      before_action :set_study_plan, only: [:show, :update, :destroy, :activate]

      # GET /api/upsc/study_plans
      def index
        @study_plans = current_user.upsc_study_plans.order(created_at: :desc)

        render_success({
          study_plans: @study_plans.as_json(
            methods: [:total_weeks, :completion_percentage]
          )
        })
      end

      # GET /api/upsc/study_plans/:id
      def show
        render_success({
          study_plan: @study_plan.as_json(
            include: {
              phases: {
                include: {
                  subjects: { only: [:id, :name, :code] }
                }
              }
            },
            methods: [:total_weeks, :completion_percentage, :current_phase]
          )
        })
      end

      # POST /api/upsc/study_plans
      def create
        @study_plan = current_user.upsc_study_plans.new(study_plan_params)

        if @study_plan.save
          render_success(
            { study_plan: @study_plan },
            'Study plan created successfully',
            :created
          )
        else
          render_error('Failed to create study plan', @study_plan.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/study_plans/:id
      def update
        if @study_plan.update(study_plan_params)
          render_success({ study_plan: @study_plan }, 'Study plan updated successfully')
        else
          render_error('Failed to update study plan', @study_plan.errors.full_messages)
        end
      end

      # DELETE /api/upsc/study_plans/:id
      def destroy
        @study_plan.destroy
        render_success({}, 'Study plan deleted successfully')
      end

      # POST /api/upsc/study_plans/:id/activate
      def activate
        # Deactivate all other plans
        current_user.upsc_study_plans.update_all(is_active: false)

        # Activate this plan
        @study_plan.update(is_active: true)

        render_success({ study_plan: @study_plan }, 'Study plan activated successfully')
      end

      # GET /api/upsc/study_plans/active
      def active
        @study_plan = current_user.upsc_study_plans.find_by(is_active: true)

        if @study_plan
          render_success({
            study_plan: @study_plan.as_json(
              include: { phases: {} },
              methods: [:current_phase, :completion_percentage]
            )
          })
        else
          render_error('No active study plan found', [], :not_found)
        end
      end

      # POST /api/upsc/study_plans/generate
      def generate
        target_date = params[:target_date]&.to_date || 1.year.from_now.to_date
        attempt_number = params[:attempt_number]&.to_i || 1
        subjects = params[:subjects] || []

        # Generate personalized study plan
        @study_plan = generate_personalized_plan(target_date, attempt_number, subjects)

        if @study_plan.save
          render_success(
            { study_plan: @study_plan },
            'Study plan generated successfully',
            :created
          )
        else
          render_error('Failed to generate study plan', @study_plan.errors.full_messages)
        end
      end

      private

      def set_study_plan
        @study_plan = current_user.upsc_study_plans.find(params[:id])
      end

      def study_plan_params
        params.require(:study_plan).permit(
          :name, :target_exam_date, :total_study_hours_per_day,
          :is_active, :notes,
          phases: [:phase_name, :start_date, :end_date, :focus_areas, subject_ids: []]
        )
      end

      def require_user
        unless current_user
          render_error('Authentication required', [], :unauthorized)
        end
      end

      def generate_personalized_plan(target_date, attempt_number, subject_ids)
        # Calculate available days
        days_available = (target_date - Date.current).to_i
        weeks_available = days_available / 7

        # Create base study plan
        study_plan = current_user.upsc_study_plans.new(
          name: "UPSC Study Plan - #{target_date.year}",
          target_exam_date: target_date,
          total_study_hours_per_day: 8,
          is_active: true
        )

        # Define phases based on available time
        phases = []

        if weeks_available > 52
          # Full preparation (1+ year)
          phases = [
            {
              phase_name: 'Foundation Building',
              start_date: Date.current,
              end_date: Date.current + 20.weeks,
              focus_areas: ['NCERT completion', 'Basic concepts', 'Standard books'],
              subject_ids: subject_ids
            },
            {
              phase_name: 'In-depth Study',
              start_date: Date.current + 20.weeks,
              end_date: Date.current + 40.weeks,
              focus_areas: ['Advanced topics', 'Optional subject', 'Current affairs'],
              subject_ids: subject_ids
            },
            {
              phase_name: 'Revision & Practice',
              start_date: Date.current + 40.weeks,
              end_date: Date.current + 48.weeks,
              focus_areas: ['Mock tests', 'PYQ practice', 'Answer writing'],
              subject_ids: subject_ids
            },
            {
              phase_name: 'Final Revision',
              start_date: Date.current + 48.weeks,
              end_date: target_date,
              focus_areas: ['Quick revision', 'Test series', 'Weak areas'],
              subject_ids: subject_ids
            }
          ]
        elsif weeks_available > 26
          # Medium preparation (6-12 months)
          phases = [
            {
              phase_name: 'Intensive Study',
              start_date: Date.current,
              end_date: Date.current + (weeks_available * 0.6).to_i.weeks,
              focus_areas: ['Core concepts', 'Standard books', 'Current affairs'],
              subject_ids: subject_ids
            },
            {
              phase_name: 'Practice & Revision',
              start_date: Date.current + (weeks_available * 0.6).to_i.weeks,
              end_date: target_date,
              focus_areas: ['Mock tests', 'Answer writing', 'Revision'],
              subject_ids: subject_ids
            }
          ]
        else
          # Short preparation (<6 months)
          phases = [
            {
              phase_name: 'Focused Revision',
              start_date: Date.current,
              end_date: target_date,
              focus_areas: ['High-yield topics', 'PYQ practice', 'Current affairs'],
              subject_ids: subject_ids
            }
          ]
        end

        study_plan.phases = phases
        study_plan
      end
    end
  end
end
