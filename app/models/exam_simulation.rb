class ExamSimulation < ApplicationRecord
  belongs_to :user
  
  # Validations
  validates :certification_type, presence: true, inclusion: { in: %w[dca ckad cka cks gre] }
  validates :status, presence: true, inclusion: { in: %w[in_progress completed expired] }
  validates :time_limit, presence: true, numericality: { greater_than: 0 }
  
  # Scopes
  scope :completed, -> { where(status: 'completed') }
  scope :passed, -> { where(passed: true) }
  scope :recent, -> { order(created_at: :desc) }
  
  def questions
    return [] unless question_ids.present?
    ids = JSON.parse(question_ids) rescue []
    QuizQuestion.where(id: ids).order(Arel.sql("FIELD(id, #{ids.join(',')})"))
  end
  
  def question_ids=(value)
    super(value.is_a?(Array) ? value.to_json : value)
  end
  
  def answers
    return {} unless read_attribute(:answers).present?
    JSON.parse(read_attribute(:answers)) rescue {}
  end
  
  def answers=(value)
    super(value.is_a?(Hash) ? value.to_json : value)
  end
  
  def correct_answers
    return {} unless read_attribute(:correct_answers).present?
    JSON.parse(read_attribute(:correct_answers)) rescue {}
  end
  
  def correct_answers=(value)
    super(value.is_a?(Hash) ? value.to_json : value)
  end
  
  def time_remaining
    return 0 unless status == 'in_progress'
    
    elapsed = (Time.current - started_at).to_i / 60 # in minutes
    remaining = time_limit - elapsed
    
    [remaining, 0].max
  end
  
  def time_expired?
    time_remaining == 0
  end
  
  def auto_submit!
    return if status != 'in_progress'
    
    self.submitted_at = Time.current
    self.time_taken = time_limit * 60 # Max time in seconds
    self.status = 'expired'
    
    # Calculate score with current answers
    calculate_score
    save!
  end
  
  def passed?
    return false unless score

    passing_scores = {
      'dca' => 65,
      'ckad' => 66,
      'cka' => 66,
      'cks' => 67,
      'gre' => 150  # GRE scaled score (130-170 scale), 150 is competitive
    }

    score >= passing_scores[certification_type]
  end
  
  def performance_summary
    return {} unless correct_answers.present?
    
    by_difficulty = Hash.new { |h, k| h[k] = { correct: 0, total: 0 } }
    by_topic = Hash.new { |h, k| h[k] = { correct: 0, total: 0 } }
    
    questions.each do |question|
      answer_data = correct_answers[question.id.to_s] || {}
      is_correct = answer_data['correct'] == true
      
      # By difficulty
      difficulty = question.difficulty_level || 'medium'
      by_difficulty[difficulty][:total] += 1
      by_difficulty[difficulty][:correct] += 1 if is_correct
      
      # By topic
      topic = question.topic || 'general'
      by_topic[topic][:total] += 1
      by_topic[topic][:correct] += 1 if is_correct
    end
    
    {
      by_difficulty: calculate_percentages(by_difficulty),
      by_topic: calculate_percentages(by_topic)
    }
  end
  
  private
  
  def calculate_score
    return unless question_ids.present?
    
    questions_list = questions
    user_answers = answers || {}
    
    correct = 0
    correct_data = {}
    
    questions_list.each do |question|
      user_answer = user_answers[question.id.to_s]
      is_correct = question.correct_answer?(user_answer)
      
      correct += 1 if is_correct
      correct_data[question.id.to_s] = {
        'correct' => is_correct,
        'user_answer' => user_answer,
        'correct_answer' => question.correct_answer
      }
    end
    
    self.correct_count = correct
    self.total_questions = questions_list.count
    self.score = (correct.to_f / questions_list.count * 100).round(1)
    self.passed = passed?
    self.correct_answers = correct_data
  end
  
  def calculate_percentages(data_hash)
    data_hash.transform_values do |data|
      percentage = data[:total] > 0 ? (data[:correct].to_f / data[:total] * 100).round(1) : 0
      data.merge(percentage: percentage)
    end
  end
end