class StealthReviewGenerator
  include ActiveModel::Model
  
  REVIEW_INSERTION_STRATEGIES = %w[
    lesson_opener
    mid_lesson_break
    concept_transition
    skill_reinforcement
    lesson_closer
  ].freeze
  
  DISGUISE_PATTERNS = {
    'lesson_opener' => [
      "Let's start by refreshing this key concept: %{command}",
      "Before we dive in, let's quickly review: %{command}",
      "To warm up, try this fundamental operation: %{command}"
    ],
    'mid_lesson_break' => [
      "Let's take a moment to practice: %{command}",
      "Here's a quick exercise to reinforce learning: %{command}",
      "Let's apply what we know with: %{command}"
    ],
    'concept_transition' => [
      "This connects to a concept we learned earlier: %{command}",
      "Building on previous knowledge, let's use: %{command}",
      "This reminds me of when we covered: %{command}"
    ],
    'skill_reinforcement' => [
      "Let's strengthen this skill: %{command}",
      "For additional practice with this pattern: %{command}",
      "To solidify this concept: %{command}"
    ],
    'lesson_closer' => [
      "To wrap up, let's review this important command: %{command}",
      "Before we finish, one more practice with: %{command}",
      "Let's end by reinforcing: %{command}"
    ]
  }.freeze
  
  attr_accessor :user_id, :current_lesson_context
  
  def initialize(user_id:, current_lesson_context: {})
    @user_id = user_id
    @current_lesson_context = current_lesson_context
  end
  
  def queue_stealth_review(canonical_command)
    mastery = find_command_mastery(canonical_command)
    return false unless mastery
    
    review_request = StealthReview.create!(
      user_id: user_id,
      canonical_command: canonical_command,
      priority: calculate_review_priority(mastery),
      requested_at: Time.current,
      status: 'queued'
    )
    
    Rails.logger.info "Queued stealth review for #{canonical_command} (priority: #{review_request.priority})"
    true
  end
  
  def generate_lesson_reviews(max_reviews = 3)
    commands_needing_review = identify_review_candidates
    return [] if commands_needing_review.empty?
    
    selected_commands = select_optimal_commands(commands_needing_review, max_reviews)
    insertion_points = plan_insertion_strategy(selected_commands)
    
    insertion_points.map do |point|
      create_stealth_review(point)
    end
  end
  
  private
  
  def find_command_mastery(canonical_command)
    UserCommandMastery.find_by(
      user_id: user_id,
      canonical_command: canonical_command
    )
  end
  
  def calculate_review_priority(mastery)
    decay_service = MasteryDecayService.new(mastery)
    current_score = decay_service.current_decayed_score
    
    # Higher priority for commands at greater risk
    case current_score
    when 0...50 then 10  # Critical
    when 50...70 then 8  # High risk
    when 70...80 then 5  # Medium risk
    when 80...90 then 3  # Low risk
    else 1               # Maintenance
    end
  end
  
  def identify_review_candidates
    # Find commands that need review based on decay
    UserCommandMastery.where(user_id: user_id)
                      .select do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      current_score = decay_service.current_decayed_score
      
      # Include commands below 90% or not practiced in 7+ days
      current_score < 90 || days_since_practice(mastery) > 7
    end
  end
  
  def select_optimal_commands(candidates, max_count)
    # Sort by priority (decay risk) and select top candidates
    candidates.sort_by do |mastery|
      decay_service = MasteryDecayService.new(mastery)
      -decay_service.current_decayed_score  # Negative for descending sort
    end.first(max_count)
  end
  
  def plan_insertion_strategy(selected_commands)
    strategies = REVIEW_INSERTION_STRATEGIES.cycle
    
    selected_commands.map.with_index do |mastery, index|
      strategy = strategies.next
      {
        command: mastery.canonical_command,
        mastery: mastery,
        strategy: strategy,
        position: index,
        disguise_text: select_disguise_text(strategy, mastery.canonical_command)
      }
    end
  end
  
  def create_stealth_review(insertion_point)
    {
      canonical_command: insertion_point[:command],
      strategy: insertion_point[:strategy],
      position: insertion_point[:position],
      disguise_text: insertion_point[:disguise_text],
      stealth_level: calculate_stealth_level(insertion_point[:strategy])
    }
  end
  
  def select_disguise_text(strategy, command)
    patterns = DISGUISE_PATTERNS[strategy] || []
    return command if patterns.empty?
    
    pattern = patterns.sample
    pattern % { command: command }
  end
  
  def calculate_stealth_level(strategy)
    # Higher stealth level = more disguised
    case strategy
    when 'concept_transition' then 5
    when 'skill_reinforcement' then 4
    when 'mid_lesson_break' then 3
    when 'lesson_opener' then 2
    when 'lesson_closer' then 1
    else 3
    end
  end
  
  def days_since_practice(mastery)
    return Float::INFINITY unless mastery.last_practiced_at
    ((Time.current - mastery.last_practiced_at) / 1.day).round
  end
end
