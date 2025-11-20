class RemediationSession < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :enrollment, class_name: 'CourseEnrollment'
  belongs_to :trigger_item, polymorphic: true, optional: true
  
  # Validations
  validates :status, inclusion: { in: %w[active completed abandoned] }
  
  # Scopes
  scope :active, -> { where(status: 'active') }
  scope :completed, -> { where(status: 'completed') }
  scope :for_user, ->(user) { where(user: user) }
  
  # Instance methods
  
  # Generate review items based on weak concepts
  def generate_review_items!
    items = []
    
    weak_concepts.each do |concept_tag|
      # Find interactive units with this concept tag
      matching_units = InteractiveLearningUnit.published
        .where("concept_tags @> ?", [concept_tag].to_json)
        .where.not(id: enrollment.ordered_course_items.select { |i| i.is_a?(InteractiveLearningUnit) }.map(&:id))
        .limit(2)
      
      matching_units.each do |unit|
        items << {
          type: 'InteractiveLearningUnit',
          id: unit.id,
          title: unit.title,
          concept: concept_tag
        }
      end
      
      # Find quiz questions with this concept tag
      matching_questions = QuizQuestion.joins(:quiz)
        .where("quiz_questions.concept_tags @> ?", [concept_tag].to_json)
        .limit(3)
      
      matching_questions.each do |question|
        items << {
          type: 'QuizQuestion',
          id: question.id,
          quiz_id: question.quiz_id,
          concept: concept_tag
        }
      end
    end
    
    update(
      review_items: items,
      items_total: items.length,
      started_at: Time.current
    )
  end
  
  # Mark an item as completed
  def complete_item!(item_type, item_id)
    updated_items = review_items.map do |item|
      if item['type'] == item_type && item['id'] == item_id
        item.merge('completed' => true, 'completed_at' => Time.current.iso8601)
      else
        item
      end
    end
    
    completed_count = updated_items.count { |i| i['completed'] }
    
    update(
      review_items: updated_items,
      items_completed: completed_count
    )
    
    # Auto-complete if all items done
    complete! if completed_count >= items_total
  end
  
  # Complete the remediation session
  def complete!
    update(
      status: 'completed',
      completed: true,
      completed_at: Time.current
    )
    
    # Clear weak concepts from user_stats
    user.user_stat&.update(
      weak_concepts: user.user_stat.weak_concepts - weak_concepts
    )
  end
  
  # Abandon the session
  def abandon!
    update(status: 'abandoned')
  end
  
  # Check if complete
  def all_items_completed?
    items_completed >= items_total && items_total > 0
  end
  
  # Progress percentage
  def progress_percentage
    return 0 if items_total.zero?
    (items_completed.to_f / items_total * 100).round
  end
  
  # Get next incomplete item
  def next_item
    review_items.find { |item| !item['completed'] }
  end
end
