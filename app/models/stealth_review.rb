class StealthReview < ApplicationRecord
  belongs_to :user
  
  validates :canonical_command, presence: true
  validates :status, inclusion: { in: %w[queued scheduled completed cancelled] }
  validates :priority, inclusion: { in: 1..10 }
  validates :stealth_level, inclusion: { in: 1..5 }
  
  scope :queued, -> { where(status: 'queued') }
  scope :scheduled, -> { where(status: 'scheduled') }
  scope :completed, -> { where(status: 'completed') }
  scope :by_priority, -> { order(:priority, :requested_at) }
  
  # Serialize context data as JSON
  serialize :context_data, JSON
  
  def mark_completed!(success:, response_time: nil)
    update!(
      status: 'completed',
      completed_at: Time.current,
      success: success,
      response_time: response_time
    )
  end
  
  def mark_scheduled!(scheduled_for: Time.current)
    update!(
      status: 'scheduled',
      scheduled_for: scheduled_for
    )
  end
  
  def overdue?
    scheduled? && scheduled_for && scheduled_for < Time.current
  end
  
  def scheduled?
    status == 'scheduled'
  end
  
  def completed?
    status == 'completed'
  end
  
  def success_rate
    return nil unless completed?
    success? ? 1.0 : 0.0
  end
end