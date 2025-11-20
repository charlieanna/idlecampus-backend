# Lesson Review Inserter Service
# Identifies opportunities to insert stealth reviews into lesson flow
# and generates appropriate review prompts

class LessonReviewInserter
  attr_reader :user, :lesson, :module_context

  def initialize(user, lesson, module_context: nil)
    @user = user
    @lesson = lesson
    @module_context = module_context
  end

  # Get commands that need review for this user
  def commands_needing_review(limit: 3)
    masteries = UserCommandMastery.where(user: user)
                                   .where("last_used_at < ?", 1.day.ago)
                                   .order(Arel.sql("proficiency_score * (1.0 / GREATEST(EXTRACT(epoch FROM (NOW() - last_used_at)) / 86400.0, 1))"))
                                   .limit(limit)

    masteries.select do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score
      current_score < 80.0 # Below mastery threshold
    end
  end

  # Determine if this lesson is a good insertion point
  def should_insert_review?
    # Don't insert if too many recent reviews
    recent_reviews = StealthReview.where(user: user)
                                  .where("scheduled_for > ?", 1.hour.ago)
                                  .where(status: ['scheduled', 'completed'])
                                  .count

    return false if recent_reviews >= 2

    # Don't insert in first lesson of course
    return false if lesson_is_introduction?

    # Insert after user has seen some content
    user_progress = CourseEnrollment.find_by(user: user, course: lesson.course)
    return false unless user_progress&.completion_percentage.to_f > 5.0

    true
  end

  # Generate review insertion for this lesson
  def generate_review_insertion
    return nil unless should_insert_review?

    commands = commands_needing_review(limit: 3)
    return nil if commands.empty?

    # Choose insertion strategy based on lesson position
    strategy = determine_insertion_strategy

    # Generate review content
    {
      commands: commands.map(&:canonical_command),
      strategy: strategy,
      insertion_point: determine_insertion_point(strategy),
      content: generate_review_content(commands, strategy),
      priority: calculate_review_priority(commands)
    }
  end

  # Get all pending reviews for user that should appear in this lesson
  def pending_reviews_for_lesson
    StealthReview.where(user: user)
                 .where(status: 'scheduled')
                 .where("scheduled_for <= ?", Time.current)
                 .order(priority: :desc, scheduled_for: :asc)
                 .limit(2)
  end

  # Mark lesson as having been shown a review
  def mark_review_shown(review)
    review.update(
      status: 'in_progress',
      context_data: {
        lesson_id: lesson.id,
        shown_at: Time.current,
        lesson_title: lesson.title
      }.to_json
    )
  end

  private

  def lesson_is_introduction?
    lesson.title.downcase.include?('introduction') ||
    lesson.title.downcase.include?('getting started') ||
    lesson.title.downcase.include?('overview')
  end

  def determine_insertion_strategy
    # Analyze lesson structure to pick best strategy
    content_length = lesson.content&.length || 0

    if content_length < 500
      'lesson_opener'  # Short lesson, review at start
    elsif content_length < 2000
      'mid_lesson_break'  # Medium lesson, review in middle
    else
      'concept_transition'  # Long lesson, review at transitions
    end
  end

  def determine_insertion_point(strategy)
    case strategy
    when 'lesson_opener'
      { position: 'start', percentage: 0 }
    when 'mid_lesson_break'
      { position: 'middle', percentage: 50 }
    when 'concept_transition'
      { position: 'transition', percentage: 33 }
    when 'lesson_closer'
      { position: 'end', percentage: 90 }
    else
      { position: 'middle', percentage: 50 }
    end
  end

  def generate_review_content(commands, strategy)
    generator = StealthReviewGenerator.new(user_id: user.id)

    commands.first(2).map do |command_mastery|
      review_data = generator.generate_disguised_review(
        command_mastery.canonical_command,
        strategy
      )

      {
        canonical_command: command_mastery.canonical_command,
        display_command: review_data[:prompt],
        explanation: review_data[:context],
        hints: review_data[:hints],
        expected_output: review_data[:expected_result],
        validation: review_data[:validation],
        difficulty: calculate_difficulty(command_mastery)
      }
    end
  end

  def calculate_review_priority(commands)
    # Higher priority for more forgotten commands
    avg_decay = commands.map do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      100 - decay_service.current_decayed_score
    end.sum / commands.size.to_f

    case avg_decay
    when 0...20 then 3    # Minor review
    when 20...40 then 5   # Moderate review
    when 40...60 then 7   # Important review
    else 9                # Critical review
    end
  end

  def calculate_difficulty(command_mastery)
    current_score = MasteryDecayService.new(command_mastery).current_decayed_score

    case current_score
    when 0...50 then 'hard'
    when 50...70 then 'medium'
    else 'easy'
    end
  end

  def lesson_course
    # Get course from lesson's module
    lesson.course_modules.first&.course
  end

  class << self
    # Batch process: Schedule reviews for upcoming lessons
    def schedule_reviews_for_user(user, course: nil)
      scheduled_count = 0

      # Get commands needing review
      commands = UserCommandMastery.where(user: user)
                                   .select do |mastery|
        decay_service = MasteryDecayService.new(mastery)
        decay_service.current_decayed_score < 80.0
      end

      return 0 if commands.empty?

      # Get user's current position in course(s)
      enrollments = if course
                      [CourseEnrollment.find_by(user: user, course: course)]
                    else
                      CourseEnrollment.where(user: user).includes(:course)
                    end

      enrollments.compact.each do |enrollment|
        # Find next 3-5 lessons user will encounter
        upcoming_lessons = find_upcoming_lessons(enrollment)

        upcoming_lessons.each_with_index do |lesson, index|
          # Schedule 1-2 reviews per lesson
          commands_for_lesson = commands.shift(2)
          break if commands_for_lesson.empty?

          commands_for_lesson.each do |command_mastery|
            generator = StealthReviewGenerator.new(user_id: user.id)

            success = generator.queue_stealth_review(
              command_mastery.canonical_command,
              priority: 5 + (index * 2),  # Later lessons = higher priority
              strategy: determine_strategy_for_lesson(lesson),
              scheduled_for: Time.current + (index * 30).minutes
            )

            scheduled_count += 1 if success
          end
        end
      end

      scheduled_count
    end

    private

    def find_upcoming_lessons(enrollment)
      course = enrollment.course
      current_progress = enrollment.completion_percentage.to_f

      # Find modules user hasn't completed
      all_modules = course.course_modules.order(:sequence_order)

      upcoming_lessons = []
      all_modules.each do |course_module|
        module_progress = ModuleProgress.find_by(
          user: enrollment.user,
          course_module: course_module
        )

        # Skip completed modules
        next if module_progress&.status == 'completed'

        # Get lessons from this module
        items = course_module.module_items
                            .where(item_type: 'CourseLesson')
                            .order(:sequence_order)
                            .includes(:item)

        items.each do |module_item|
          lesson = module_item.item
          next if LessonCompletion.exists?(
            user: enrollment.user,
            course_lesson: lesson,
            completed: true
          )

          upcoming_lessons << lesson
          break if upcoming_lessons.size >= 5
        end

        break if upcoming_lessons.size >= 5
      end

      upcoming_lessons
    end

    def determine_strategy_for_lesson(lesson)
      content_length = lesson.content&.length || 0

      if content_length < 1000
        'lesson_opener'
      elsif content_length < 3000
        'mid_lesson_break'
      else
        'concept_transition'
      end
    end
  end
end
