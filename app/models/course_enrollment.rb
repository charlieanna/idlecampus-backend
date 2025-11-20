class CourseEnrollment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course
  belongs_to :current_item, polymorphic: true, optional: true
  belongs_to :last_completed_item, polymorphic: true, optional: true
  has_many :remediation_sessions, foreign_key: :enrollment_id, dependent: :destroy
  has_many :module_progresses, dependent: :destroy
  has_many :quiz_attempts, dependent: :destroy
  has_many :review_sessions, dependent: :destroy
  
  # Validations
  validates :user_id, uniqueness: { scope: :course_id }
  validates :status, inclusion: { in: %w[enrolled in_progress completed dropped] }
  
  # Scopes
  scope :active, -> { where(status: %w[enrolled in_progress]) }
  scope :completed, -> { where(status: 'completed') }
  scope :in_progress, -> { where(status: 'in_progress') }
  
  # Callbacks
  before_create :set_enrolled_at
  
  # Instance methods
  def start!
    update(status: 'in_progress', started_at: Time.current) if status == 'enrolled'
  end
  
  def complete!
    update(
      status: 'completed',
      completed_at: Time.current,
      completion_percentage: 100
    )
  end
  
  def drop!
    update(status: 'dropped')
  end
  
  def update_progress!
    total_modules = course.course_modules.published.count
    return if total_modules.zero?
    
    completed_modules = module_progresses.where(status: 'completed').count
    new_percentage = (completed_modules.to_f / total_modules * 100).round
    
    update(completion_percentage: new_percentage)
    
    # Auto-complete course if all modules are done
    complete! if new_percentage == 100 && status != 'completed'
    
    # Mark as in_progress if started but not yet in that status
    start! if new_percentage > 0 && status == 'enrolled'
  end
  
  def current_module
    # Find the first incomplete module
    course.course_modules.published.ordered.find do |mod|
      progress = module_progresses.find_by(course_module: mod)
      progress.nil? || progress.status != 'completed'
    end || course.course_modules.published.ordered.first
  end
  
  def completed_modules_count
    module_progresses.where(status: 'completed').count
  end
  
  def total_modules_count
    course.course_modules.published.count
  end
  
  def progress_percentage
    completion_percentage
  end
  
  def estimated_time_remaining
    completed_count = completed_modules_count
    total_count = total_modules_count
    return 0 if total_count.zero? || completed_count >= total_count
    
    remaining_modules = course.course_modules.published.ordered.offset(completed_count)
    remaining_modules.sum(:estimated_minutes)
  end
  
  def add_points(points)
    increment!(:total_points, points)
  end
  
  def days_enrolled
    return 0 unless enrolled_at
    ((Time.current - enrolled_at) / 1.day).to_i
  end
  
  def active?
    %w[enrolled in_progress].include?(status)
  end
  
  def completed?
    status == 'completed'
  end

  # Guided progression helpers - handles ALL content types
  def set_initial_current_item!
    items = ordered_course_items
    # Prefer InteractiveLearningUnit as the starting point
    first_item = items.find { |item| item.is_a?(InteractiveLearningUnit) } || items.first
    update(current_item: first_item) if first_item
  end

  def ordered_course_items
    course.course_modules.published.ordered.flat_map do |mod|
      # Collect all items with their sequence order
      items = []
      
      # Add interactive units with their sequence order
      mod.module_interactive_units.ordered.each do |miu|
        items << { item: miu.interactive_learning_unit, order: miu.sequence_order } if miu.interactive_learning_unit
      end
      
      # Add module items (lessons, quizzes, labs) with their sequence order
      mod.module_items.ordered.each do |mi|
        items << { item: mi.item, order: mi.sequence_order } if mi.item
      end
      
      # Sort by sequence order and return just the items
      items.sort_by { |h| h[:order] }.map { |h| h[:item] }
    end
  end

  def next_item_after(item)
    items = ordered_course_items
    return nil if items.empty?
    idx = items.index(item)
    return items.first unless idx # if item not found, start from first
    items[idx + 1]
  end

  def set_next_current_item!(completed_item)
    next_item = next_item_after(completed_item)
    update(current_item: next_item)
  end

  # Legacy method name for backwards compatibility
  def ordered_interactive_units
    ordered_course_items.select { |item| item.is_a?(InteractiveLearningUnit) }
  end

  def next_interactive_unit_after(unit)
    next_item_after(unit)
  end

  # Progress tracking methods
  def touch_access!
    update_columns(
      last_accessed_at: Time.current,
      time_away_days: 0
    )
    check_and_clear_review_flag
  end

  def record_item_completion!(item)
    update_columns(
      last_completed_item_type: item.class.name,
      last_completed_item_id: item.id,
      last_accessed_at: Time.current
    )
  end

  def calculate_time_away
    return 0 unless last_accessed_at
    ((Time.current - last_accessed_at) / 1.day).to_i
  end

  def check_review_needed!
    days_away = calculate_time_away

    # Update time away
    update_column(:time_away_days, days_away)

    # Determine if review is needed based on time away
    should_review = case days_away
                    when 0..2
                      false # Recent activity, no review needed
                    when 3..7
                      true # Quick refresh recommended
                    else
                      true # Comprehensive review recommended
                    end

    update_column(:needs_review, should_review) if needs_review != should_review
    should_review
  end

  def review_type_needed
    return nil unless needs_review || calculate_time_away >= 3

    days_away = calculate_time_away

    case days_away
    when 3..7
      'quick_refresh' # 3-7 days: Quick recap of key concepts
    when 8..14
      'comprehensive_review' # 8-14 days: More thorough review
    else
      'forgotten_content' # 15+ days: Extensive review with exercises
    end
  end

  def has_made_progress?
    completion_percentage > 0 || module_progresses.any?
  end

  def resume_point
    # Return where user should resume
    if needs_review && review_type_needed
      {
        type: 'review_session',
        review_type: review_type_needed,
        message: review_message
      }
    elsif current_item
      {
        type: 'resume',
        item: current_item,
        message: "Continue from where you left off"
      }
    else
      {
        type: 'start',
        item: ordered_course_items.first,
        message: "Start the course"
      }
    end
  end

  def review_message
    days_away = calculate_time_away

    case review_type_needed
    when 'quick_refresh'
      "Welcome back! It's been #{days_away} days. Let's do a quick refresh before continuing."
    when 'comprehensive_review'
      "It's been #{days_away} days since your last visit. We recommend a review session to refresh your memory."
    when 'forgotten_content'
      "It's been #{days_away} days! Let's review what you've learned so far before moving forward."
    else
      "Welcome back! Ready to continue?"
    end
  end

  private

  def check_and_clear_review_flag
    # If user starts a review session, clear the flag
    update_column(:needs_review, false) if needs_review
  end
  
  def set_enrolled_at
    self.enrolled_at ||= Time.current
  end
end