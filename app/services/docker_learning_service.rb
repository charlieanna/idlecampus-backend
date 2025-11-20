# frozen_string_literal: true

# DockerLearningService
# Enhanced service for Docker/Kubernetes adaptive learning
# Integrates with Flask ML microservice for personalized learning paths
class DockerLearningService
  include Loggable

  def initialize
    @adaptive_client = AdaptiveLearningClient.new
    @fallback_enabled = Rails.env.production?
  end

  # === PERSONALIZED CURRICULUM GENERATION ===

  def generate_personalized_curriculum(user, certification_goals)
    log_info "Generating personalized curriculum for user #{user.id}"

    # Convert Rails models to goal identifiers
    learning_goals = extract_learning_goals(certification_goals)
    
    # Build user constraints and preferences
    constraints = build_user_constraints(user)
    preferences = build_user_preferences(user)

    begin
      # Call Flask ML service for optimal path generation
      response = @adaptive_client.generate_learning_path(
        user.id.to_s,
        learning_goals,
        constraints: constraints,
        preferences: preferences
      )

      if response[:success] && response[:learning_path]
        create_learning_path_from_response(user, response[:learning_path])
      else
        log_warning "ML service failed to generate path: #{response[:error]}"
        generate_fallback_curriculum(user, certification_goals)
      end

    rescue AdaptiveLearningClient::TimeoutError, AdaptiveLearningClient::NetworkError => e
      log_error "Network error during curriculum generation: #{e.message}"
      generate_fallback_curriculum(user, certification_goals) if @fallback_enabled

    rescue AdaptiveLearningClient::ServerError => e
      log_error "ML service error during curriculum generation: #{e.message}"
      generate_fallback_curriculum(user, certification_goals) if @fallback_enabled

    rescue StandardError => e
      log_error "Unexpected error during curriculum generation: #{e.message}"
      log_error e.backtrace.join("\n")
      generate_fallback_curriculum(user, certification_goals) if @fallback_enabled
    end
  end

  # === ADAPTIVE PATH REFINEMENT ===

  def update_path_based_on_performance(user, session_data)
    return unless user.current_learning_path

    log_info "Updating learning path for user #{user.id} based on performance"

    current_path = user.current_learning_path.node_sequence || []
    current_position = user.current_position || 0
    
    performance_data = normalize_performance_data(session_data)

    begin
      response = @adaptive_client.refine_learning_path(
        user.id.to_s,
        current_path,
        current_position,
        performance_data
      )

      if response[:refined_path]
        update_user_path(user, response[:refined_path], current_position)
        log_info "Successfully refined path for user #{user.id}"
      end

    rescue AdaptiveLearningClient::BadRequestError => e
      log_warning "Bad request during path refinement: #{e.message}"
    rescue StandardError => e
      log_error "Error during path refinement: #{e.message}"
    end
  end

  # === DIFFICULTY ASSESSMENT ===

  def assess_content_difficulty(user, content_items)
    return fallback_difficulty_assessment(content_items) if content_items.empty?

    log_debug "Assessing difficulty for #{content_items.length} items for user #{user.id}"

    begin
      # Build response data for IRT analysis
      response_data = content_items.map do |item|
        {
          item_id: item.id,
          difficulty: item.difficulty || 0.5,
          discrimination: item.discrimination || 1.0,
          user_response: item.user_attempts.where(user: user).last&.correct || false,
          response_time: item.user_attempts.where(user: user).last&.duration_seconds
        }
      end

      ability_response = @adaptive_client.estimate_ability(user.id.to_s, response_data)
      
      if ability_response[:ability_estimate]
        update_user_ability_estimates(user, ability_response)
        return calculate_personalized_difficulties(content_items, ability_response[:ability_estimate])
      end

    rescue StandardError => e
      log_error "Error during difficulty assessment: #{e.message}"
    end

    fallback_difficulty_assessment(content_items)
  end

  # === NEXT CONTENT SELECTION ===

  def select_next_content(user, available_content, constraints = {})
    return available_content.first if available_content.length <= 1

    log_debug "Selecting next content for user #{user.id} from #{available_content.length} options"

    begin
      content_pool = available_content.map do |content|
        {
          id: content.id,
          difficulty: content.difficulty || 0.5,
          category: content.category,
          estimated_time: content.estimated_time_minutes || 15,
          skills: content.skills || [],
          last_seen: user.content_interactions.where(content: content).last&.updated_at
        }
      end

      response = @adaptive_client.select_next_item(
        user.id.to_s,
        content_pool,
        constraints.merge(avoid_recent: true)
      )

      if response[:selected_item_id]
        selected = available_content.find { |c| c.id.to_s == response[:selected_item_id].to_s }
        return selected if selected
      end

    rescue StandardError => e
      log_error "Error during content selection: #{e.message}"
    end

    # Fallback: select based on simple rules
    fallback_content_selection(user, available_content)
  end

  # === SPACED REPETITION SCHEDULING ===

  def schedule_reviews(user, time_horizon_days = 30)
    log_info "Scheduling reviews for user #{user.id} over #{time_horizon_days} days"

    # Get user's FSRS card states
    card_states = user.spaced_repetition_cards.includes(:content).map do |card|
      {
        card_id: card.id,
        content_id: card.content_id,
        stability: card.stability,
        difficulty: card.difficulty,
        last_review: card.last_review_at,
        due_date: card.due_at,
        review_count: card.review_count
      }
    end

    return [] if card_states.empty?

    begin
      response = @adaptive_client.get_fsrs_schedule(user.id.to_s, card_states)
      
      if response[:schedule]
        create_review_schedule(user, response[:schedule])
        return response[:schedule]
      end

    rescue StandardError => e
      log_error "Error during review scheduling: #{e.message}"
    end

    # Fallback: simple exponential backoff
    generate_fallback_schedule(user, time_horizon_days)
  end

  # === LEARNING ANALYTICS ===

  def generate_learning_analytics(user, time_period = 30.days)
    log_info "Generating learning analytics for user #{user.id}"

    begin
      learning_context = {
        time_period_days: time_period.to_i / 1.day,
        include_predictions: true,
        include_weaknesses: true
      }

      response = @adaptive_client.get_adaptive_recommendation(
        user.id.to_s,
        learning_context
      )

      if response[:analytics]
        cache_analytics(user, response[:analytics])
        return response[:analytics]
      end

    rescue StandardError => e
      log_error "Error generating learning analytics: #{e.message}"
    end

    generate_fallback_analytics(user, time_period)
  end

  # === RECOMMENDATIONS ===

  def get_personalized_recommendations(user, context = {})
    log_debug "Getting personalized recommendations for user #{user.id}"

    current_path = user.current_learning_path&.node_sequence || []
    goals = user.learning_goals.pluck(:identifier)

    begin
      response = @adaptive_client.get_learning_recommendations(
        user.id.to_s,
        current_path,
        goals
      )

      if response[:recommendations]
        return format_recommendations(response[:recommendations])
      end

    rescue StandardError => e
      log_error "Error getting recommendations: #{e.message}"
    end

    generate_fallback_recommendations(user)
  end

  private

  # === HELPER METHODS ===

  def extract_learning_goals(certification_goals)
    goals = []
    
    certification_goals.each do |goal|
      case goal.certification_type
      when 'docker_associate'
        goals += %w[docker_run docker_build docker_compose docker_networking docker_security]
      when 'kubernetes_admin'
        goals += %w[k8s_pods k8s_deployments k8s_services k8s_networking k8s_storage]
      when 'kubernetes_developer'
        goals += %w[k8s_pods k8s_configmaps k8s_secrets k8s_debugging]
      else
        goals << goal.identifier if goal.identifier.present?
      end
    end

    goals.uniq
  end

  def build_user_constraints(user)
    {
      max_time: user.available_study_time || 120,
      max_difficulty: calculate_max_difficulty(user),
      preferred_session_length: user.preferred_session_length || 45,
      avoid_topics: user.blocked_topics || []
    }
  end

  def build_user_preferences(user)
    {
      learning_style: user.learning_style || 'balanced',
      objective_weights: user.learning_priorities || default_objective_weights,
      cognitive_capacity: estimate_cognitive_capacity(user),
      time_of_day: user.preferred_study_time,
      pace_preference: user.learning_pace || 'normal'
    }
  end

  def calculate_max_difficulty(user)
    # Calculate based on user's historical performance
    recent_performance = user.user_lessons
                            .where('updated_at > ?', 2.weeks.ago)
                            .average(:score) || 0.5

    case recent_performance
    when 0.8..1.0 then 0.9
    when 0.6..0.8 then 0.7
    when 0.4..0.6 then 0.5
    else 0.3
    end
  end

  def default_objective_weights
    {
      time: 0.3,
      difficulty: 0.2,
      retention: 0.25,
      engagement: 0.15,
      coverage: 0.1
    }
  end

  def estimate_cognitive_capacity(user)
    # Estimate based on user's multitasking ability and session performance
    base_capacity = 10.0
    
    # Adjust based on recent session completion rates
    completion_rate = user.user_lessons
                         .where('updated_at > ?', 1.week.ago)
                         .where.not(completed_at: nil)
                         .count.to_f / [user.user_lessons.where('updated_at > ?', 1.week.ago).count, 1].max

    base_capacity * (0.5 + completion_rate * 0.5)
  end

  def normalize_performance_data(session_data)
    {
      score: ensure_numeric(session_data[:score], 0.0, 1.0),
      completion_time: session_data[:duration_minutes] || session_data[:completion_time] || 0,
      mistakes: session_data[:mistakes] || session_data[:errors] || [],
      engagement: ensure_numeric(session_data[:engagement_score] || session_data[:engagement], 0.0, 1.0),
      difficulty_rating: ensure_numeric(session_data[:difficulty_rating] || session_data[:perceived_difficulty], 0.0, 1.0)
    }
  end

  def ensure_numeric(value, min_val, max_val)
    numeric_value = value.to_f
    [[numeric_value, min_val].max, max_val].min
  end

  # === FALLBACK METHODS ===

  def generate_fallback_curriculum(user, certification_goals)
    log_info "Generating fallback curriculum for user #{user.id}"

    # Simple sequential approach based on prerequisites
    learning_path = user.learning_paths.create!(
      name: "Basic Learning Path",
      total_estimated_time: 300,
      is_fallback: true
    )

    # Add basic Docker content first
    docker_commands = DockerCommand.where(difficulty: 0.0..0.5).order(:difficulty).limit(10)
    docker_commands.each_with_index do |command, index|
      learning_path.path_nodes.create!(
        content_id: command.id,
        content_type: 'DockerCommand',
        position: index,
        estimated_time: command.estimated_time_minutes || 15
      )
    end

    # Add basic Kubernetes content
    k8s_resources = KubernetesResource.where(difficulty: 0.0..0.5).order(:difficulty).limit(5)
    k8s_resources.each_with_index do |resource, index|
      learning_path.path_nodes.create!(
        content_id: resource.id,
        content_type: 'KubernetesResource',
        position: docker_commands.length + index,
        estimated_time: resource.estimated_time_minutes || 20
      )
    end

    learning_path
  end

  def fallback_difficulty_assessment(content_items)
    content_items.map do |item|
      {
        content_id: item.id,
        difficulty: item.difficulty || 0.5,
        confidence: 0.5,
        source: 'fallback'
      }
    end
  end

  def fallback_content_selection(user, available_content)
    # Select based on user's current level and recency
    user_level = calculate_user_level(user)
    
    # Filter by appropriate difficulty
    suitable_content = available_content.select do |content|
      content_difficulty = content.difficulty || 0.5
      (user_level - 0.2..user_level + 0.3).cover?(content_difficulty)
    end

    # Avoid recently seen content
    recent_content_ids = user.content_interactions
                            .where('updated_at > ?', 1.day.ago)
                            .pluck(:content_id)
    
    suitable_content.reject! { |c| recent_content_ids.include?(c.id) }

    suitable_content.first || available_content.first
  end

  def calculate_user_level(user)
    # Calculate based on average performance across categories
    docker_performance = user.user_lessons.joins(:lesson)
                            .where(lessons: { category: 'docker' })
                            .average(:score) || 0.3

    k8s_performance = user.user_lessons.joins(:lesson)
                         .where(lessons: { category: 'kubernetes' })
                         .average(:score) || 0.3

    (docker_performance + k8s_performance) / 2.0
  end

  def generate_fallback_schedule(user, time_horizon_days)
    cards = user.spaced_repetition_cards.includes(:content)
    schedule = []

    cards.each do |card|
      next_review = card.due_at || 1.day.from_now
      
      while next_review <= time_horizon_days.days.from_now
        schedule << {
          card_id: card.id,
          content_id: card.content_id,
          scheduled_at: next_review,
          priority: calculate_review_priority(card)
        }
        
        # Simple exponential backoff
        next_review += (card.review_count + 1).days
      end
    end

    schedule.sort_by { |item| item[:scheduled_at] }
  end

  def calculate_review_priority(card)
    # Higher priority for cards that are due or overdue
    days_overdue = [(Time.current - card.due_at).to_i / 1.day, 0].max
    base_priority = card.difficulty || 0.5
    
    base_priority + (days_overdue * 0.1)
  end

  def generate_fallback_analytics(user, time_period)
    {
      study_time: user.user_lessons.where('updated_at > ?', time_period.ago).sum(:duration_minutes) || 0,
      completion_rate: calculate_completion_rate(user, time_period),
      average_score: user.user_lessons.where('updated_at > ?', time_period.ago).average(:score) || 0.0,
      topics_covered: user.user_lessons.joins(:lesson).where('user_lessons.updated_at > ?', time_period.ago).distinct.count('lessons.category'),
      predictions: {
        next_week_progress: 0.1,
        certification_readiness: calculate_certification_readiness(user)
      }
    }
  end

  def calculate_completion_rate(user, time_period)
    started = user.user_lessons.where('updated_at > ?', time_period.ago).count
    completed = user.user_lessons.where('updated_at > ? AND completed_at IS NOT NULL', time_period.ago).count
    
    return 0.0 if started.zero?
    completed.to_f / started
  end

  def calculate_certification_readiness(user)
    # Simple readiness calculation based on coverage and performance
    total_required_topics = 20 # Approximate number of topics for certification
    covered_topics = user.user_lessons.joins(:lesson).distinct.count('lessons.category')
    
    coverage_score = [covered_topics.to_f / total_required_topics, 1.0].min
    performance_score = user.user_lessons.average(:score) || 0.0
    
    (coverage_score * 0.6 + performance_score * 0.4)
  end

  def generate_fallback_recommendations(user)
    recommendations = []
    
    # Recommend next logical topics
    current_level = calculate_user_level(user)
    
    if current_level < 0.4
      recommendations << {
        type: 'topic',
        title: 'Focus on Docker Fundamentals',
        description: 'Complete basic Docker commands and concepts',
        priority: 'high',
        estimated_time: 120
      }
    elsif current_level < 0.7
      recommendations << {
        type: 'topic',
        title: 'Kubernetes Basics',
        description: 'Start with Pod and Deployment concepts',
        priority: 'medium',
        estimated_time: 180
      }
    else
      recommendations << {
        type: 'practice',
        title: 'Advanced Labs',
        description: 'Practice with complex scenarios',
        priority: 'medium',
        estimated_time: 240
      }
    end

    recommendations
  end

  # === DATABASE OPERATIONS ===

  def create_learning_path_from_response(user, path_data)
    ActiveRecord::Base.transaction do
      learning_path = user.learning_paths.create!(
        name: "AI-Generated Path #{Time.current.strftime('%Y-%m-%d')}",
        total_estimated_time: path_data[:metadata][:total_time],
        difficulty_range: path_data[:metadata][:difficulty_range],
        objective_scores: path_data[:metadata][:objective_scores],
        ml_generated: true
      )

      path_data[:nodes].each_with_index do |node, index|
        content = find_content_by_id(node[:id])
        next unless content

        learning_path.path_nodes.create!(
          content: content,
          position: index,
          estimated_time: node[:estimated_time],
          difficulty: node[:difficulty],
          node_type: node[:type]
        )
      end

      user.update!(current_learning_path: learning_path)
      learning_path
    end
  end

  def find_content_by_id(content_id)
    # Try to find content across different models
    DockerCommand.find_by(id: content_id) ||
      KubernetesResource.find_by(id: content_id) ||
      HandsOnLab.find_by(id: content_id) ||
      Lesson.find_by(id: content_id)
  end

  def update_user_path(user, refined_path, current_position)
    return unless user.current_learning_path

    # Remove future nodes and replace with refined path
    user.current_learning_path.path_nodes
        .where('position > ?', current_position)
        .destroy_all

    # Add new nodes from refined path
    refined_path.each_with_index do |node_id, index|
      content = find_content_by_id(node_id)
      next unless content

      user.current_learning_path.path_nodes.create!(
        content: content,
        position: current_position + index + 1,
        estimated_time: content.estimated_time_minutes || 15,
        node_type: 'refined'
      )
    end
  end

  def update_user_ability_estimates(user, ability_response)
    user.update!(
      estimated_ability: ability_response[:ability_estimate],
      ability_confidence: ability_response[:standard_error],
      last_ability_update: Time.current
    )
  end

  def calculate_personalized_difficulties(content_items, user_ability)
    content_items.map do |item|
      # Adjust difficulty based on user ability
      base_difficulty = item.difficulty || 0.5
      adjusted_difficulty = base_difficulty + (0.5 - user_ability) * 0.3
      
      {
        content_id: item.id,
        difficulty: [0.1, [adjusted_difficulty, 0.9].min].max,
        confidence: 0.8,
        source: 'irt_personalized'
      }
    end
  end

  def create_review_schedule(user, schedule_data)
    schedule_data.each do |item|
      user.scheduled_reviews.create!(
        content_id: item[:content_id],
        content_type: item[:content_type] || 'Lesson',
        scheduled_at: Time.parse(item[:scheduled_at]),
        priority: item[:priority] || 0.5,
        review_type: item[:review_type] || 'spaced_repetition'
      )
    end
  end

  def cache_analytics(user, analytics_data)
    Rails.cache.write(
      "user_analytics:#{user.id}",
      analytics_data,
      expires_in: 1.hour
    )
  end

  def format_recommendations(recommendations_data)
    recommendations_data.map do |rec|
      {
        type: rec[:type],
        title: rec[:title] || rec[:message],
        description: rec[:description] || rec[:details],
        priority: rec[:priority] || 'medium',
        estimated_time: rec[:estimated_time],
        suggested_content: rec[:suggested_content] || [],
        confidence: rec[:confidence] || 0.5
      }
    end
  end

  def log_info(message)
    Rails.logger.info "[DockerLearningService] #{message}"
  end

  def log_warning(message)
    Rails.logger.warn "[DockerLearningService] #{message}"
  end

  def log_error(message)
    Rails.logger.error "[DockerLearningService] #{message}"
  end

  def log_debug(message)
    Rails.logger.debug "[DockerLearningService] #{message}"
  end
end