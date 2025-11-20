class ReviewSession < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :course_enrollment
  belongs_to :course

  # Validations
  validates :days_since_last_visit, presence: true
  validates :review_type, inclusion: {
    in: %w[quick_refresh comprehensive_review forgotten_content],
    allow_nil: true
  }

  # Scopes
  scope :active, -> { where(completed: false) }
  scope :completed, -> { where(completed: true) }
  scope :by_type, ->(type) { where(review_type: type) }

  # Callbacks
  before_create :set_started_at
  before_create :generate_review_content

  # Instance methods
  def start!
    update(started_at: Time.current)
  end

  def complete!
    update(
      completed: true,
      completed_at: Time.current
    )
    course_enrollment.update(needs_review: false)
  end

  def record_item_reviewed!
    increment!(:items_reviewed)
    complete! if items_reviewed >= total_items
  end

  def progress_percentage
    return 0 if total_items.zero?
    (items_reviewed.to_f / total_items * 100).round
  end

  private

  def set_started_at
    self.started_at ||= Time.current
  end

  def generate_review_content
    generator = ReviewModuleGenerator.new(course_enrollment, review_type)
    result = generator.generate

    self.items_to_review = result[:items]
    self.review_modules = result[:modules]
    self.total_items = result[:items].length
  end
end
