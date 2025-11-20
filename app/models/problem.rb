class Problem < ApplicationRecord
  # Associations
  has_many :solutions

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :difficulty, inclusion: { in: %w[easy medium hard expert] }, allow_nil: true
  validates :topic, presence: true
  validates :family_id, presence: true

  # Scopes for filtering
  scope :by_difficulty, ->(difficulty) { where(difficulty: difficulty) }
  scope :by_topic, ->(topic) { where(topic: topic) }
  scope :by_subtopic, ->(subtopic) { where(subtopic: subtopic) }
  scope :by_family, ->(family_id) { where(family_id: family_id) }
  scope :by_company, ->(company) { where("? = ANY(companies)", company) }
  scope :by_tag, ->(tag) { where("? = ANY(tags)", tag) }
  scope :high_frequency, -> { where(frequency: %w[high very-high]) }
  scope :easy_problems, -> { where(difficulty: 'easy') }
  scope :medium_problems, -> { where(difficulty: 'medium') }
  scope :hard_problems, -> { where(difficulty: 'hard') }
  scope :expert_problems, -> { where(difficulty: 'expert') }

  # Callbacks
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  # Instance methods

  # Get problems from the same family (for spaced repetition)
  def family_problems
    Problem.where(family_id: family_id).where.not(id: id)
  end

  # Get related problems by IDs
  def get_related_problems
    return [] if related_problems.blank?
    Problem.where(id: related_problems)
  end

  # Get prerequisite problems
  def get_prerequisites
    return [] if prerequisites.blank?
    Problem.where(id: prerequisites)
  end

  # Get next problem in same family (for progressive learning)
  def next_in_family
    family_problems.where("id > ?", id).order(:id).first
  end

  # Get previous problem in same family
  def previous_in_family
    family_problems.where("id < ?", id).order(id: :desc).first
  end

  # Calculate actual success rate based on attempts
  def actual_success_rate
    return success_rate if total_attempts.zero?
    (successful_attempts.to_f / total_attempts * 100).round(2)
  end

  # Update statistics after an attempt
  def record_attempt(success:, time_spent_mins:)
    increment!(:total_attempts)
    increment!(:successful_attempts) if success

    # Update average time spent
    new_avg = if average_time_spent.nil? || average_time_spent.zero?
                time_spent_mins
              else
                ((average_time_spent * (total_attempts - 1)) + time_spent_mins) / total_attempts
              end

    update(average_time_spent: new_avg)
  end

  # Get difficulty level as integer (for sorting/filtering)
  def difficulty_level
    case difficulty
    when 'easy' then 1
    when 'medium' then 2
    when 'hard' then 3
    when 'expert' then 4
    else 0
    end
  end

  # Check if problem is popular (high frequency)
  def popular?
    frequency.in?(%w[high very-high])
  end

  # Get recommended next problems (adaptive learning)
  def recommended_next_problems(user_performance: :medium)
    case user_performance
    when :struggling
      # Recommend easier problems in same family or topic
      family_problems.where("difficulty_level <= ?", difficulty_level)
                    .or(Problem.where(topic: topic, difficulty: 'easy'))
                    .limit(5)
    when :excelling
      # Recommend harder problems in same family or related topics
      family_problems.where("difficulty_level >= ?", difficulty_level)
                    .or(get_related_problems)
                    .limit(5)
    else
      # Recommend similar difficulty in same family
      family_problems.where(difficulty: difficulty).limit(5)
    end
  end

  # Class methods
  class << self
    # Get random problem by difficulty
    def random_by_difficulty(difficulty)
      by_difficulty(difficulty).order("RANDOM()").first
    end

    # Get problems for spaced repetition learning
    def for_spaced_repetition(family_id, last_difficulty: 'easy')
      family = by_family(family_id)

      # Return problems in increasing difficulty
      case last_difficulty
      when 'easy'
        family.where(difficulty: %w[easy medium])
      when 'medium'
        family.where(difficulty: %w[medium hard])
      when 'hard'
        family.where(difficulty: %w[hard expert])
      else
        family
      end
    end

    # Get learning path (ordered progression)
    def learning_path_for_topic(topic_name)
      where(topic: topic_name)
        .order(:family_id, difficulty_level: :asc)
    end

    # Get problems by multiple tags (AND condition)
    def by_tags(tags_array)
      query = all
      tags_array.each do |tag|
        query = query.where("? = ANY(tags)", tag)
      end
      query
    end

    # Get interview prep set (curated collection)
    def interview_prep_set(company: nil, difficulty_mix: true)
      problems = high_frequency

      problems = problems.by_company(company) if company.present?

      if difficulty_mix
        # Return mix of difficulties (30% easy, 50% medium, 20% hard)
        easy_count = (problems.count * 0.3).to_i
        medium_count = (problems.count * 0.5).to_i
        hard_count = (problems.count * 0.2).to_i

        easy_problems.high_frequency.limit(easy_count) +
          medium_problems.high_frequency.limit(medium_count) +
          hard_problems.high_frequency.limit(hard_count)
      else
        problems
      end
    end

    # Get daily challenge
    def daily_challenge
      date_seed = Date.today.strftime('%Y%m%d').to_i
      high_frequency.offset(date_seed % high_frequency.count).first
    end

    # Analytics: Get topic difficulty distribution
    def topic_difficulty_stats(topic_name)
      where(topic: topic_name).group(:difficulty).count
    end

    # Analytics: Get average success rate by difficulty
    def avg_success_rate_by_difficulty
      group(:difficulty).average(:success_rate)
    end
  end

  private

  def generate_slug
    self.slug = title.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/(^-|-$)/, '')
  end
end
