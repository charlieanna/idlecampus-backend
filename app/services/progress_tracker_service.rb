class ProgressTrackerService
  def initialize(user, course_or_enrollment)
    @user = user
    @enrollment = if course_or_enrollment.is_a?(CourseEnrollment)
                    course_or_enrollment
                  else
                    CourseEnrollment.find_by(user: user, course: course_or_enrollment)
                  end
  end

  # Track that user is accessing the course
  def track_access!
    return unless @enrollment

    @enrollment.touch_access!
    @enrollment.check_review_needed!
  end

  # Track that user completed an item
  def track_completion!(item)
    return unless @enrollment

    @enrollment.record_item_completion!(item)
    @enrollment.set_next_current_item!(item)
  end

  # Get the current resume point for the user
  def get_resume_point
    return nil unless @enrollment

    # Check if review is needed first
    @enrollment.check_review_needed!

    @enrollment.resume_point
  end

  # Get detailed progress information
  def get_progress_details
    return nil unless @enrollment

    {
      enrollment: {
        status: @enrollment.status,
        completion_percentage: @enrollment.completion_percentage,
        total_points: @enrollment.total_points,
        days_enrolled: @enrollment.days_enrolled,
        last_accessed_at: @enrollment.last_accessed_at,
        time_away_days: @enrollment.calculate_time_away
      },
      current_position: {
        current_item: serialize_item(@enrollment.current_item),
        last_completed_item: serialize_item(@enrollment.last_completed_item),
        current_module: serialize_module(@enrollment.current_module)
      },
      review_status: {
        needs_review: @enrollment.check_review_needed!,
        review_type: @enrollment.review_type_needed,
        message: @enrollment.review_message
      },
      resume_point: @enrollment.resume_point,
      modules: module_progress_summary,
      recent_activity: recent_activity_summary
    }
  end

  # Check if user should see a review module
  def should_show_review?
    return false unless @enrollment

    @enrollment.check_review_needed!
  end

  # Create a review session if needed
  def create_review_session_if_needed
    return nil unless should_show_review?

    days_away = @enrollment.calculate_time_away

    ReviewSession.create!(
      user: @user,
      course_enrollment: @enrollment,
      course: @enrollment.course,
      days_since_last_visit: days_away,
      review_type: @enrollment.review_type_needed
    )
  end

  private

  def serialize_item(item)
    return nil unless item

    {
      type: item.class.name,
      id: item.id,
      title: item.respond_to?(:title) ? item.title : nil,
      slug: item.respond_to?(:slug) ? item.slug : nil
    }
  end

  def serialize_module(mod)
    return nil unless mod

    progress = @enrollment.module_progresses.find_by(course_module: mod)

    {
      id: mod.id,
      title: mod.title,
      slug: mod.slug,
      sequence_order: mod.sequence_order,
      progress: progress ? {
        status: progress.status,
        completion_percentage: progress.completion_percentage,
        items_completed: progress.items_completed,
        total_items: progress.total_items
      } : nil
    }
  end

  def module_progress_summary
    @enrollment.course.course_modules.published.ordered.map do |mod|
      progress = @enrollment.module_progresses.find_by(course_module: mod)

      {
        id: mod.id,
        title: mod.title,
        sequence_order: mod.sequence_order,
        status: progress&.status || 'not_started',
        completion_percentage: progress&.completion_percentage || 0
      }
    end
  end

  def recent_activity_summary
    {
      last_module_progress: @enrollment.module_progresses.order(updated_at: :desc).first&.then do |mp|
        {
          module_title: mp.course_module.title,
          status: mp.status,
          updated_at: mp.updated_at
        }
      end,
      recent_completions: @user.lesson_completions
                                .joins(:course_lesson)
                                .where('lesson_completions.created_at > ?', 7.days.ago)
                                .order(completed_at: :desc)
                                .limit(5)
                                .pluck('course_lessons.title', 'lesson_completions.completed_at')
    }
  end
end
