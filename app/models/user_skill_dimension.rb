class UserSkillDimension < ApplicationRecord
  belongs_to :user
  
  # Validations
  validates :dimension, presence: true, uniqueness: { scope: :user_id }
  validates :ability_estimate, presence: true
  validates :standard_error, presence: true
  validates :n_observations, numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :by_dimension, ->(dim) { where(dimension: dim) }
  scope :recently_updated, -> { order(last_updated_at: :desc) }
  scope :high_confidence, -> { where('standard_error < ?', 0.5) }
  scope :needs_assessment, -> { where('n_observations < ?', 5) }
  
  # Skill dimensions
  DIMENSIONS = %w[
    docker_basics
    docker_advanced
    docker_networking
    docker_security
    docker_compose
    k8s_basics
    k8s_workloads
    k8s_networking
    k8s_storage
    k8s_security
    k8s_administration
    gre_reading_comprehension
    gre_text_completion
    gre_sentence_equivalence
    gre_quantitative_arithmetic
    gre_quantitative_algebra
    gre_quantitative_geometry
    gre_quantitative_data_analysis
  ].freeze
  
  validates :dimension, inclusion: { in: DIMENSIONS }
  
  # Update ability after assessment
  def update_ability!(new_estimate, new_se, observations: 1)
    self.ability_estimate = new_estimate
    self.standard_error = new_se
    self.n_observations += observations
    self.confidence_lower = new_estimate - (1.96 * new_se)
    self.confidence_upper = new_estimate + (1.96 * new_se)
    self.last_updated_at = Time.current
    save!
  end
  
  # Confidence interval methods
  def confidence_interval
    [confidence_lower, confidence_upper]
  end
  
  def high_confidence?
    standard_error < 0.5
  end
  
  def needs_more_data?
    n_observations < 5
  end
  
  # Helper to get or create dimension
  def self.for_user_and_dimension(user, dimension)
    find_or_create_by!(user: user, dimension: dimension)
  end
end

