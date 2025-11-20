class CourseModule < ApplicationRecord
  # Associations
  belongs_to :course
  has_many :module_items, dependent: :destroy
  has_many :lessons, through: :module_items, source: :item, source_type: 'CourseLesson'
  has_many :quizzes, through: :module_items, source: :item, source_type: 'Quiz'
  has_many :hands_on_labs, through: :module_items, source: :item, source_type: 'HandsOnLab'
  has_many :module_progresses, dependent: :destroy
  has_many :module_interactive_units, dependent: :destroy
  has_many :interactive_learning_units, through: :module_interactive_units

  # New Microlesson Associations
  has_many :topic_groups, dependent: :destroy
  has_many :micro_lessons, dependent: :destroy
  belongs_to :module_quiz, class_name: 'Quiz', optional: true

  # Validations
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: :course_id }
  validates :sequence_order, presence: true, numericality: { only_integer: true }
  
  # Scopes
  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(sequence_order: :asc) }
  
  # Callbacks
  before_validation :generate_slug, on: :create
  
  # Instance methods
  def total_items
    module_items.count
  end
  
  def required_items_count
    module_items.where(required: true).count
  end
  
  def progress_for(user)
    module_progresses.find_by(user: user)
  end
  
  def completed?(user)
    progress = progress_for(user)
    progress&.status == 'completed'
  end
  
  def completion_percentage_for(user)
    progress = progress_for(user)
    progress&.completion_percentage || 0
  end
  
  def next_item_for(user)
    progress = progress_for(user)
    return module_items.ordered.first unless progress
    
    # Get completed item IDs from various sources
    completed_lesson_ids = user.lesson_completions.pluck(:lesson_id)
    completed_quiz_ids = QuizAttempt.where(user: user, passed: true).pluck(:quiz_id)
    completed_lab_ids = LabSession.where(user: user, status: 'completed').pluck(:hands_on_lab_id)
    
    # Find first uncompleted item
    module_items.ordered.find do |item|
      case item.item_type
      when 'CourseLesson'
        !completed_lesson_ids.include?(item.item_id)
      when 'Quiz'
        !completed_quiz_ids.include?(item.item_id)
      when 'HandsOnLab'
        !completed_lab_ids.include?(item.item_id)
      else
        true
      end
    end
  end
  
  def items_completed_by(user)
    completed_lesson_ids = user.lesson_completions.pluck(:lesson_id)
    completed_quiz_ids = QuizAttempt.where(user: user, passed: true).pluck(:quiz_id)
    completed_lab_ids = LabSession.where(user: user, status: 'completed').pluck(:hands_on_lab_id)
    
    module_items.count do |item|
      case item.item_type
      when 'CourseLesson'
        completed_lesson_ids.include?(item.item_id)
      when 'Quiz'
        completed_quiz_ids.include?(item.item_id)
      when 'HandsOnLab'
        completed_lab_ids.include?(item.item_id)
      else
        false
      end
    end
  end
  
  def update_progress_for(user, enrollment)
    progress = module_progresses.find_or_create_by(user: user, course_enrollment: enrollment)
    
    items_completed = items_completed_by(user)
    total = total_items
    
    completion_pct = total.positive? ? (items_completed.to_f / total * 100).round : 0
    
    progress.update(
      items_completed: items_completed,
      total_items: total,
      completion_percentage: completion_pct,
      status: determine_status(completion_pct, items_completed),
      started_at: progress.started_at || Time.current,
      completed_at: completion_pct == 100 ? Time.current : nil
    )
    
    progress
  end
  
  private
  
  def generate_slug
    self.slug ||= title.parameterize if title.present?
  end
  
  def determine_status(completion_pct, items_completed)
    if completion_pct == 100
      'completed'
    elsif items_completed.positive?
      'in_progress'
    else
      'not_started'
    end
  end
end