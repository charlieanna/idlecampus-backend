class Lesson < ApplicationRecord
  # Associations
  has_many :user_lessons, dependent: :destroy
  has_many :users, through: :user_lessons
  has_many :lesson_completions, dependent: :destroy
  has_many :completed_users, through: :lesson_completions, source: :user

  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validates :reading_time_minutes, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  # Instance methods
  def completed_by?(user)
    lesson_completions.exists?(user: user)
  end

  def reading_time_display
    "#{reading_time_minutes} min read"
  end

  def excerpt(length = 150)
    return "" unless content.present?
    
    # Strip markdown and HTML, then truncate
    plain_text = content.gsub(/[#*`\[\]()]/m, '').gsub(/\n+/, ' ').strip
    plain_text.length > length ? "#{plain_text[0...length]}..." : plain_text
  end

  def key_concepts_list
    return [] unless key_concepts.present?
    
    begin
      JSON.parse(key_concepts)
    rescue JSON::ParserError
      []
    end
  end

  def difficulty_badge_class
    case difficulty_level
    when 'beginner'
      'badge-success'
    when 'intermediate'
      'badge-warning'
    when 'advanced'
      'badge-danger'
    else
      'badge-secondary'
    end
  end
end