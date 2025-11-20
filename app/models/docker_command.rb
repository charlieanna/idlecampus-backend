class DockerCommand < ApplicationRecord
  # Associations
  has_many :lab_sessions, as: :practiceble, dependent: :nullify
  has_many :user_question_attempts, as: :attemptable, dependent: :destroy
  has_many :spaced_repetition_items, foreign_key: :command_id, dependent: :destroy
  
  # Validations
  validates :command, presence: true, uniqueness: true
  validates :difficulty, presence: true, inclusion: { in: %w[easy medium hard] }
  validates :category, presence: true
  validates :exam_frequency, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
  
  # Scopes
  scope :by_difficulty, ->(level) { where(difficulty: level) }
  scope :by_category, ->(cat) { where(category: cat) }
  scope :high_frequency, -> { where('exam_frequency >= ?', 7) }
  scope :exam_focused, ->(exam) { where(certification_exam: exam) }
  scope :active, -> { where(is_deprecated: false) }
  scope :for_beginners, -> { where(difficulty: 'easy') }
  scope :for_intermediate, -> { where(difficulty: 'medium') }
  scope :for_advanced, -> { where(difficulty: 'hard') }
  scope :popular, -> { order(times_practiced: :desc) }
  scope :highly_successful, -> { where('average_success_rate >= ?', 0.7) }
  
  # Class methods
  def self.categories
    %w[basics images containers networks volumes registry security swarm compose]
  end
  
  def self.difficulties
    %w[easy medium hard]
  end
  
  def self.certification_exams
    %w[DCA CKAD CKA CKS]
  end
  
  # Instance methods
  def record_practice(success)
    increment!(:times_practiced)
    update_success_rate(success)
  end
  
  def beginner_friendly?
    difficulty == 'easy' && exam_frequency >= 7
  end
  
  def advanced?
    difficulty == 'hard'
  end
  
  def exam_critical?
    exam_frequency >= 8
  end
  
  def flag_list
    flags.is_a?(Hash) ? flags.keys : []
  end
  
  def variation_count
    variations.is_a?(Array) ? variations.length : 0
  end
  
  private
  
  def update_success_rate(success)
    current_rate = average_success_rate || 0.0
    current_count = times_practiced - 1
    new_rate = ((current_rate * current_count) + (success ? 1.0 : 0.0)) / times_practiced
    update_column(:average_success_rate, new_rate.round(2))
  end
end