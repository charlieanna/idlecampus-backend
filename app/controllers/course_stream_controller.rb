class CourseStreamController < ApplicationController
  before_action :authenticate_user!
  before_action :set_course

  def show
    @enrollment = @course.enrollment_for(current_user)
    
    # Auto-enroll if not enrolled
    unless @enrollment
      @enrollment = CourseEnrollment.create!(
        user: current_user,
        course: @course,
        status: 'enrolled'
      )
    end

    # Initialize current item if needed
    items = @enrollment.ordered_course_items
    if items.blank?
      redirect_to courses_path, notice: 'Course content is not available yet.' and return
    end
    
    # If unit_slug param is provided, set that as current item
    if params[:unit_slug].present?
      unit = InteractiveLearningUnit.find_by(slug: params[:unit_slug])
      if unit
        # Check if unit belongs to any module in this course
        course_module_ids = @course.course_modules.pluck(:id)
        unit_module_ids = unit.course_modules.pluck(:id)
        if (course_module_ids & unit_module_ids).any?
          @enrollment.update(current_item: unit)
          @enrollment.reload
          # Force reload the association
          @enrollment.association(:current_item).reload
        end
      end
    end
    
    # Initialize current item if still nil
    if @enrollment.current_item.nil?
      @enrollment.set_initial_current_item!
      @enrollment.reload
    end
    
    # Reload to ensure current_item is fresh
    @enrollment.reload
    current = @enrollment.current_item || items.first
    
    # Double-check current is loaded
    unless current
      redirect_to courses_path, notice: 'Unable to determine current learning item.' and return
    end

    # Always prefer InteractiveLearningUnit for the stream
    # Skip lessons and go straight to interactive units
    unless current.is_a?(InteractiveLearningUnit) || current.is_a?(HandsOnLab) || current.is_a?(Quiz)
      preferred = items.find { |item| item.is_a?(InteractiveLearningUnit) } ||
                  items.find { |item| item.is_a?(HandsOnLab) } ||
                  items.find { |item| item.is_a?(Quiz) }
      if preferred
        current = preferred
        @enrollment.update(current_item: current)
      else
        redirect_to courses_path, notice: 'No interactive content available yet.' and return
      end
    end

    case current
    when InteractiveLearningUnit
      @unit = current
      
      # Debug: Ensure unit is properly loaded
      unless @unit
        redirect_to courses_path, notice: 'Unit not found.' and return
      end
      
      @quiz_options = normalize_json(@unit.quiz_options)
      @scenario_steps = normalize_json(@unit.scenario_steps)
      @code_examples = normalize_json(@unit.code_examples)
      @progress = @unit.progress_for(current_user)
      unless @progress
        @progress = @unit.learning_unit_progresses.create!(
          user: current_user,
          explanation_read: false,
          practice_completed: false,
          quiz_answered: false,
          scenario_completed: false,
          completed: false,
          completion_percentage: 0,
          mastery_score: 0.0,
          practice_attempts: 0,
          quiz_attempts: 0
        )
      end
      # Build sidebar stream items (ALL UNLOCKED - user can access everything)
      @stream_items = items.map.with_index do |item, index|
        if item.is_a?(InteractiveLearningUnit)
          prog = item.progress_for(current_user)
          is_current = (item == @enrollment.current_item)
          is_completed = prog&.completed? || false
          # UNLOCK ALL: no locking logic, everything is accessible
          
          {
            type: 'unit',
            title: item.title,
            slug: item.slug,
            category: item.respond_to?(:category) ? item.category : nil,
            current: is_current,
            completed: is_completed,
            locked: false, # Always unlocked
            progress: prog ? {
              completion_percentage: prog.completion_percentage,
              mastery_score: prog.mastery_score
            } : nil
          }
        elsif item.is_a?(HandsOnLab)
          session = LabSession.where(user: current_user, hands_on_lab: item, status: 'completed').first
          is_current = (item == @enrollment.current_item)
          is_completed = !!session
          # UNLOCK ALL: no locking logic, everything is accessible
          
          {
            type: 'lab',
            title: item.title,
            id: item.id,
            slug: nil,
            category: item.respond_to?(:category) ? item.category : nil,
            current: is_current,
            completed: is_completed,
            locked: false # Always unlocked
          }
        else
          nil
        end
      end.compact
      render 'course_stream/show_unit'
    when HandsOnLab
      lab = current
      @lab = lab
      @session = LabSession.where(user: current_user, hands_on_lab: lab, status: ['active', 'paused']).first

      unless @session
        existing_attempts = lab.lab_sessions.where(user: current_user).count
        if lab.max_attempts.present? && existing_attempts >= lab.max_attempts
          redirect_to courses_path, alert: 'No attempts remaining for this lab.' and return
        end

        @session = LabSession.create!(
          user: current_user,
          hands_on_lab: lab,
          status: 'active',
          current_step: 0,
          steps_completed: 0,
          completion_percentage: 0,
          time_spent_seconds: 0
        )
        @session.start!

        LearningEventTracker.lab_started(
          user: current_user,
          lab: lab,
          session: @session,
          context: {
            course_id: @course.id,
            module_id: lab.module_items.first&.course_module_id
          }
        ) if defined?(LearningEventTracker)
      end

      @steps = lab.steps.is_a?(Array) ? lab.steps : []
      @current_step_index = @session.current_step
      @current_step = @steps[@current_step_index] if @current_step_index < @steps.length

      begin
        lab_tags = (lab.respond_to?(:concept_tags) && lab.concept_tags.is_a?(Array)) ? lab.concept_tags : []
        @refresher_units = if lab_tags.any?
          InteractiveLearningUnit.published
            .where("concept_tags \@> ?", [lab_tags.first].to_json)
            .order(sequence_order: :asc)
            .limit(3)
        else
          []
        end
      rescue
        @refresher_units = []
      end

      @module_item = lab.module_items.first
      if @module_item
        @course_module = @module_item.course_module
        @course = @course_module.course
        @enrollment = @course.enrollment_for(current_user)
      end

      render 'course_stream/show_lab'
    when CourseLesson
      # Skip lessons in the stream - find next interactive item
      next_item = items.drop_while { |item| item != current }.drop(1).find do |item|
        item.is_a?(InteractiveLearningUnit) || item.is_a?(HandsOnLab) || item.is_a?(Quiz)
      end
      
      if next_item
        @enrollment.update(current_item: next_item)
        redirect_to start_course_path(@course) and return
      else
        redirect_to courses_path, notice: 'No more interactive content available.'
      end
    when Quiz
      @quiz = current
      redirect_to quiz_path(@quiz)
    else
      redirect_to courses_path, notice: 'Unable to determine next learning item.'
    end
  end

  private

  def set_course
    slug_param = params[:slug] || params[:course_id] || params[:id]
    @course = if slug_param.to_s.match?(/^\d+$/)
                Course.find(slug_param)
              else
                Course.find_by!(slug: slug_param)
              end
  end

  def normalize_json(value)
    case value
    when String
      JSON.parse(value) rescue []
    when Array
      value
    when nil
      []
    else
      value.respond_to?(:as_json) ? value.as_json : []
    end
  end

end


