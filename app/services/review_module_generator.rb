class ReviewModuleGenerator
  attr_reader :enrollment, :review_type

  def initialize(enrollment, review_type = nil)
    @enrollment = enrollment
    @review_type = review_type || enrollment.review_type_needed
  end

  def generate
    {
      items: collect_items_for_review,
      modules: generate_review_modules
    }
  end

  private

  def collect_items_for_review
    items = []

    # Get all modules that have been started or completed
    completed_modules = @enrollment.module_progresses
                                   .where(status: ['in_progress', 'completed'])
                                   .order(:created_at)

    completed_modules.each do |mod_progress|
      module_items = collect_module_items(mod_progress)
      items.concat(module_items)
    end

    # Limit items based on review type
    limit_items_by_review_type(items)
  end

  def collect_module_items(mod_progress)
    items = []
    course_module = mod_progress.course_module

    # Collect completed lessons
    completed_lessons = @enrollment.user.lesson_completions
                                   .joins(:course_lesson)
                                   .joins("INNER JOIN module_items ON module_items.item_id = course_lessons.id
                                           AND module_items.item_type = 'CourseLesson'")
                                   .where(module_items: { course_module_id: course_module.id })
                                   .select('lesson_completions.*, course_lessons.title, course_lessons.id as lesson_id')

    completed_lessons.each do |completion|
      items << {
        type: 'CourseLesson',
        id: completion.lesson_id,
        title: completion.title,
        module_id: course_module.id,
        module_title: course_module.title,
        completed_at: completion.completed_at,
        priority: calculate_priority(completion.completed_at)
      }
    end

    # Collect completed interactive units
    completed_units = @enrollment.user.learning_unit_progresses
                                 .where(completed: true)
                                 .joins("INNER JOIN module_interactive_units ON
                                         module_interactive_units.interactive_learning_unit_id = learning_unit_progresses.interactive_learning_unit_id")
                                 .where(module_interactive_units: { course_module_id: course_module.id })
                                 .includes(:interactive_learning_unit)

    completed_units.each do |progress|
      unit = progress.interactive_learning_unit
      items << {
        type: 'InteractiveLearningUnit',
        id: unit.id,
        title: unit.title,
        slug: unit.slug,
        module_id: course_module.id,
        module_title: course_module.title,
        completed_at: progress.completed_at,
        mastery_score: progress.mastery_score,
        priority: calculate_priority(progress.completed_at, progress.mastery_score)
      }
    end

    items
  end

  def calculate_priority(completed_at, mastery_score = nil)
    # Higher priority for older items or items with low mastery
    days_ago = ((Time.current - completed_at) / 1.day).to_i

    base_priority = days_ago

    # Adjust based on mastery score if available
    if mastery_score && mastery_score < 70
      base_priority += 10 # Boost priority for items with low mastery
    end

    base_priority
  end

  def limit_items_by_review_type(items)
    # Sort by priority (higher priority = needs more review)
    sorted_items = items.sort_by { |item| -item[:priority] }

    case @review_type
    when 'quick_refresh'
      # Top 5-10 most important items
      sorted_items.take(8)
    when 'comprehensive_review'
      # Top 15-20 items
      sorted_items.take(15)
    when 'forgotten_content'
      # All items, but prioritized
      sorted_items.take(25)
    else
      sorted_items.take(10)
    end
  end

  def generate_review_modules
    modules = []

    case @review_type
    when 'quick_refresh'
      modules << generate_quick_recap_module
      modules << generate_key_concepts_quiz
    when 'comprehensive_review'
      modules << generate_detailed_recap_module
      modules << generate_practice_exercises
      modules << generate_comprehensive_quiz
    when 'forgotten_content'
      modules << generate_full_review_module
      modules << generate_practice_exercises
      modules << generate_comprehensive_quiz
      modules << generate_hands_on_challenge
    else
      modules << generate_quick_recap_module
    end

    modules.compact
  end

  def generate_quick_recap_module
    {
      type: 'recap',
      title: 'Quick Recap',
      description: 'A quick review of key concepts you\'ve learned',
      estimated_minutes: 5,
      content: {
        format: 'summary',
        sections: generate_summary_sections
      }
    }
  end

  def generate_detailed_recap_module
    {
      type: 'recap',
      title: 'Comprehensive Review',
      description: 'A thorough review of what you\'ve learned so far',
      estimated_minutes: 15,
      content: {
        format: 'detailed',
        sections: generate_detailed_sections
      }
    }
  end

  def generate_full_review_module
    {
      type: 'full_review',
      title: 'Complete Review Session',
      description: 'Let\'s refresh everything you\'ve learned',
      estimated_minutes: 25,
      content: {
        format: 'comprehensive',
        sections: generate_comprehensive_sections
      }
    }
  end

  def generate_key_concepts_quiz
    {
      type: 'quiz',
      title: 'Quick Concept Check',
      description: 'Test your memory with a few key questions',
      estimated_minutes: 5,
      question_count: 5,
      passing_score: 60
    }
  end

  def generate_comprehensive_quiz
    {
      type: 'quiz',
      title: 'Review Assessment',
      description: 'Comprehensive quiz covering reviewed topics',
      estimated_minutes: 10,
      question_count: 10,
      passing_score: 70
    }
  end

  def generate_practice_exercises
    {
      type: 'exercises',
      title: 'Practice Exercises',
      description: 'Hands-on practice to reinforce your learning',
      estimated_minutes: 15,
      exercise_count: 5
    }
  end

  def generate_hands_on_challenge
    {
      type: 'challenge',
      title: 'Hands-on Challenge',
      description: 'Apply what you\'ve learned in a practical scenario',
      estimated_minutes: 20
    }
  end

  def generate_summary_sections
    completed_modules = @enrollment.module_progresses
                                   .where(status: ['in_progress', 'completed'])
                                   .order(:created_at)
                                   .includes(:course_module)

    completed_modules.map do |mod_progress|
      {
        module_id: mod_progress.course_module_id,
        module_title: mod_progress.course_module.title,
        key_points: extract_key_points(mod_progress.course_module),
        completion_percentage: mod_progress.completion_percentage
      }
    end
  end

  def generate_detailed_sections
    generate_summary_sections.map do |section|
      module_obj = CourseModule.find(section[:module_id])
      section.merge(
        detailed_points: extract_detailed_points(module_obj),
        learning_objectives: module_obj.learning_objectives
      )
    end
  end

  def generate_comprehensive_sections
    generate_detailed_sections.map do |section|
      module_obj = CourseModule.find(section[:module_id])
      section.merge(
        examples: extract_examples(module_obj),
        exercises: extract_exercises(module_obj)
      )
    end
  end

  def extract_key_points(course_module)
    # Extract key concepts from lessons in this module
    lessons = CourseLesson.joins(:module_items)
                          .where(module_items: { course_module_id: course_module.id })
                          .limit(3)

    lessons.map do |lesson|
      {
        lesson_title: lesson.title,
        key_concepts: lesson.key_concepts.is_a?(String) ? [lesson.key_concepts] : (lesson.key_concepts || [])
      }
    end.flatten
  end

  def extract_detailed_points(course_module)
    lessons = CourseLesson.joins(:module_items)
                          .where(module_items: { course_module_id: course_module.id })

    lessons.map do |lesson|
      {
        lesson_title: lesson.title,
        concepts: lesson.key_concepts,
        commands: lesson.key_commands
      }
    end
  end

  def extract_examples(course_module)
    # Get interactive units that have code examples
    units = InteractiveLearningUnit.joins(:module_interactive_units)
                                   .where(module_interactive_units: { course_module_id: course_module.id })
                                   .where.not(code_examples: [])
                                   .limit(3)

    units.map do |unit|
      {
        unit_title: unit.title,
        examples: unit.code_examples
      }
    end
  end

  def extract_exercises(course_module)
    # Get micro lessons with exercises
    micro_lessons = MicroLesson.where(course_module_id: course_module.id)
                                .includes(:exercises)
                                .limit(5)

    micro_lessons.flat_map do |ml|
      ml.exercises.map do |ex|
        {
          type: ex.exercise_type,
          data: ex.exercise_data
        }
      end
    end.take(10)
  end
end
