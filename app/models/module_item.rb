class ModuleItem < ApplicationRecord
  # Associations
  belongs_to :course_module
  belongs_to :item, polymorphic: true
  
  # Validations
  validates :sequence_order, presence: true, numericality: { only_integer: true }
  validates :item_type, presence: true
  
  # Scopes
  scope :ordered, -> { order(sequence_order: :asc) }
  scope :required_items, -> { where(required: true) }
  
  # Delegation methods
  delegate :title, to: :item, allow_nil: true
  
  # Instance methods
  def item_title
    item&.title || "Untitled #{item_type}"
  end
  
  def item_type_display
    case item_type
    when 'CourseLesson'
      'Lesson'
    when 'Quiz'
      'Quiz'
    when 'HandsOnLab'
      'Lab'
    when 'InteractiveLearningUnit'
      'Interactive Unit'
    else
      item_type
    end
  end
  
  def completed_by?(user)
    case item_type
    when 'CourseLesson'
      item.completed_by?(user)
    when 'Quiz'
      item.passed_by?(user)
    when 'HandsOnLab'
      LabSession.exists?(user: user, hands_on_lab_id: item.id, status: 'completed')
    when 'InteractiveLearningUnit'
      item.completed_by?(user)
    else
      false
    end
  end
  
  def duration_estimate
    case item_type
    when 'CourseLesson'
      "#{item.reading_time_minutes || 5} min"
    when 'Quiz'
      "#{item.time_limit_minutes || 15} min"
    when 'HandsOnLab'
      "#{item.estimated_time_minutes || 30} min"
    when 'InteractiveLearningUnit'
      "#{item.estimated_minutes || 5} min"
    else
      "N/A"
    end
  end
  
  def icon_class
    case item_type
    when 'CourseLesson'
      'fa-book-open'
    when 'Quiz'
      'fa-clipboard-question'
    when 'HandsOnLab'
      'fa-flask'
    when 'InteractiveLearningUnit'
      'fa-graduation-cap'
    else
      'fa-file'
    end
  end
end