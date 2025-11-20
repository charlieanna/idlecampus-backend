# SpacedRepetitionService
# Comprehensive service for managing spaced repetition using FSRS algorithm
# Integrates with DockerCommand, KubernetesResource, and HandsOnLab models

class SpacedRepetitionService
  attr_reader :user, :fsrs
  
  def initialize(user, options = {})
    @user = user
    @fsrs = FsrsAlgorithm.new(load_user_parameters.merge(options))
    @options = options
  end
  
  # ============================================================================
  # CORE REVIEW METHODS
  # ============================================================================
  
  # Schedule a review for any reviewable item (Docker command, K8s resource, lab)
  # @param reviewable [DockerCommand, KubernetesResource, HandsOnLab] Item to review
  # @param grade [Symbol] :again, :hard, :good, or :easy
  # @param review_time [Time] When the review occurred (defaults to now)
  # @return [Hash] Updated schedule information
  def schedule_review(reviewable, grade, review_time = Time.current)
    validate_grade!(grade)
    
    ActiveRecord::Base.transaction do
      # Find or create SR item
      sr_item = find_or_create_sr_item(reviewable)
      
      # Get current state
      current_state = extract_state(sr_item)
      
      # Calculate new schedule using FSRS
      new_state = @fsrs.schedule(current_state, grade, review_time)
      
      # Update database
      update_sr_item(sr_item, new_state, grade)
      
      # Update reviewable item statistics
      update_reviewable_stats(reviewable, grade)
      
      # Log review for analytics
      log_review(sr_item, grade, new_state)
      
      # Return formatted result
      format_schedule_result(sr_item, new_state)
    end
  rescue => e
    Rails.logger.error("SpacedRepetition schedule_review failed: #{e.message}")
    raise
  end
  
  # Get items due for review, sorted by urgency
  # @param options [Hash] Filtering and pagination options
  # @return [Array<Hash>] Review queue with urgency metrics
  def get_review_queue(options = {})
    limit = options[:limit] || 20
    include_future = options[:include_future] || false
    reviewable_type = options[:type] # 'DockerCommand', 'KubernetesResource', 'HandsOnLab'
    
    # Build query
    items = SpacedRepetitionItem.where(user: @user).includes(:reviewable)
    
    # Filter by type if specified
    items = items.where(reviewable_type: reviewable_type) if reviewable_type.present?
    
    # Filter by due date unless including future items
    items = items.where('next_review_at <= ?', Time.current) unless include_future
    
    # Calculate urgency for each item
    queue = items.map do |item|
      calculate_item_urgency(item)
    end
    
    # Sort by urgency (highest first) and limit
    queue.sort_by { |item| -item[:urgency] }.take(limit)
  end
  
  # Get the next single item to review
  # @return [Hash, nil] Next item with full details, or nil if none due
  def get_next_item
    queue = get_review_queue(limit: 1)
    queue.first
  end
  
  # Get items by specific criteria
  # @param criteria [Symbol] :overdue, :due_today, :struggling, :new
  # @return [Array<Hash>] Filtered items
  def get_items_by_criteria(criteria)
    case criteria
    when :overdue
      get_overdue_items
    when :due_today
      get_due_today_items
    when :struggling
      get_struggling_items
    when :new
      get_new_items
    else
      []
    end
  end
  
  # ============================================================================
  # STATISTICS AND ANALYTICS
  # ============================================================================
  
  # Get comprehensive user statistics
  # @return [Hash] Detailed learning statistics
  def get_user_stats
    items = SpacedRepetitionItem.where(user: @user)
    
    {
      overview: calculate_overview_stats(items),
      retention: calculate_retention_stats(items),
      efficiency: calculate_efficiency_stats(items),
      difficulty: calculate_difficulty_stats(items),
      progress: calculate_progress_stats(items),
      forecast: calculate_forecast(items)
    }
  end
  
  # Get statistics for a specific reviewable item
  # @param reviewable [ActiveRecord::Base] Item to analyze
  # @return [Hash] Item-specific statistics
  def get_item_stats(reviewable)
    sr_item = SpacedRepetitionItem.find_by(user: @user, reviewable: reviewable)
    
    return nil unless sr_item
    
    {
      difficulty: sr_item.difficulty,
      stability: sr_item.stability,
      review_count: sr_item.review_count,
      lapse_count: sr_item.lapse_count,
      success_rate: calculate_success_rate(sr_item),
      next_review: sr_item.next_review_at,
      interval_days: sr_item.interval_days,
      retention_probability: calculate_current_retention(sr_item),
      mastery_level: determine_mastery_level(sr_item),
      time_until_review: time_until_review(sr_item),
      is_overdue: sr_item.next_review_at < Time.current
    }
  end
  
  # Get learning velocity metrics
  # @return [Hash] Velocity and efficiency metrics
  def get_learning_velocity
    items = SpacedRepetitionItem.where(user: @user)
    recent_reviews = items.where('last_reviewed_at >= ?', 7.days.ago)
    
    {
      items_learned_total: items.count,
      items_mastered: items.where('stability > ?', 21).count,
      items_in_progress: items.where('stability BETWEEN ? AND ?', 2, 21).count,
      items_struggling: items.where('lapse_count >= ?', 3).count,
      
      reviews_last_7_days: recent_reviews.sum(:review_count),
      average_reviews_per_day: recent_reviews.sum(:review_count) / 7.0,
      
      average_stability: items.average(:stability)&.round(2),
      average_difficulty: items.average(:difficulty)&.round(2),
      
      learning_rate: calculate_learning_rate(items),
      retention_rate: calculate_overall_retention(items)
    }
  end
  
  # ============================================================================
  # RECOMMENDATIONS AND OPTIMIZATION
  # ============================================================================
  
  # Get personalized learning recommendations
  # @return [Hash] Recommendations for optimal learning
  def get_recommendations
    stats = get_user_stats
    items = SpacedRepetitionItem.where(user: @user)
    
    recommendations = []
    
    # Review burden recommendation
    if stats[:efficiency][:daily_review_burden] > 30
      recommendations << {
        type: :reduce_burden,
        priority: :high,
        message: "Your daily review burden is high (#{stats[:efficiency][:daily_review_burden]} items). Consider focusing on overdue items first.",
        action: "Review overdue items to reduce backlog"
      }
    end
    
    # Struggling items recommendation
    struggling = items.where('lapse_count >= ?', 3).count
    if struggling > 5
      recommendations << {
        type: :struggling_items,
        priority: :high,
        message: "You have #{struggling} items with multiple lapses. These need extra attention.",
        action: "Review struggling items with additional context or practice"
      }
    end
    
    # New content recommendation
    mastered = items.where('stability > ?', 21).count
    if mastered > 20 && stats[:efficiency][:daily_review_burden] < 15
      recommendations << {
        type: :add_content,
        priority: :medium,
        message: "Your review burden is low. Good time to learn new content!",
        action: "Add 3-5 new Docker commands or K8s resources"
      }
    end
    
    # Retention optimization
    if stats[:retention][:predicted_30_day] < 0.85
      recommendations << {
        type: :improve_retention,
        priority: :high,
        message: "Your retention rate may drop below 85% in 30 days.",
        action: "Review weak areas more frequently"
      }
    end
    
    # Difficulty distribution
    if stats[:difficulty][:high_difficulty_ratio] > 0.4
      recommendations << {
        type: :difficulty_balance,
        priority: :medium,
        message: "Many items are high difficulty. Consider adding easier content for balance.",
        action: "Mix in fundamental commands for confidence building"
      }
    end
    
    recommendations
  end
  
  # Get optimal daily study plan
  # @param minutes_available [Integer] Minutes user has available
  # @return [Hash] Structured study plan
  def get_daily_study_plan(minutes_available = 30)
    # Assume 2 minutes per review on average
    max_items = (minutes_available / 2.0).floor
    
    # Allocate items by priority
    overdue = get_review_queue(limit: max_items)
    overdue_count = overdue.count
    
    remaining = max_items - overdue_count
    
    plan = {
      total_items: max_items,
      estimated_minutes: max_items * 2,
      
      sections: [
        {
          type: :overdue,
          count: overdue_count,
          items: overdue.take(overdue_count),
          priority: :critical
        }
      ]
    }
    
    # Add due today items if space available
    if remaining > 0
      due_today = get_due_today_items.take(remaining)
      plan[:sections] << {
        type: :due_today,
        count: due_today.count,
        items: due_today,
        priority: :high
      }
      remaining -= due_today.count
    end
    
    # Add new content if space available
    if remaining > 0
      new_items = get_recommended_new_items(remaining)
      plan[:sections] << {
        type: :new_content,
        count: new_items.count,
        items: new_items,
        priority: :medium
      }
    end
    
    plan
  end
  
  # ============================================================================
  # FSRS PARAMETER OPTIMIZATION
  # ============================================================================
  
  # Optimize FSRS parameters based on user's review history
  # This should be run periodically (e.g., after 100 reviews)
  # @return [Hash] Optimized parameters
  def optimize_parameters
    reviews = fetch_review_history
    
    return FsrsAlgorithm::DEFAULT_PARAMS if reviews.count < 50
    
    # Analyze user's actual retention rates
    actual_retention = calculate_actual_retention_curve(reviews)
    
    # Adjust target retention based on user's goals and performance
    optimized = FsrsAlgorithm::DEFAULT_PARAMS.dup
    
    # Adjust based on user's learning goal
    case @user.learning_goal
    when 'certification'
      optimized[:target_retention] = 0.95
      optimized[:maximum_interval] = 90  # Shorter intervals for exam prep
    when 'casual'
      optimized[:target_retention] = 0.85
      optimized[:maximum_interval] = 365
    else
      optimized[:target_retention] = 0.90
      optimized[:maximum_interval] = 180
    end
    
    # Store optimized parameters
    @user.update(fsrs_parameters: optimized)
    
    optimized
  end
  
  # ============================================================================
  # CONTENT DIFFICULTY ANALYSIS
  # ============================================================================
  
  # Calculate initial difficulty for new content
  # @param reviewable [ActiveRecord::Base] Item to analyze
  # @return [Float] Difficulty score (1-10)
  def calculate_initial_difficulty(reviewable)
    case reviewable
    when DockerCommand
      calculate_docker_command_difficulty(reviewable)
    when KubernetesResource
      calculate_k8s_resource_difficulty(reviewable)
    when HandsOnLab
      calculate_lab_difficulty(reviewable)
    else
      5.0  # Default medium difficulty
    end
  end
  
  # ============================================================================
  # PRIVATE METHODS
  # ============================================================================
  
  private
  
  def load_user_parameters
    stored_params = @user.fsrs_parameters
    
    if stored_params.present?
      stored_params.symbolize_keys
    else
      default_params_for_user
    end
  end
  
  def default_params_for_user
    params = FsrsAlgorithm::DEFAULT_PARAMS.dup
    
    # Customize based on user's learning goal
    case @user.learning_goal
    when 'certification'
      params[:target_retention] = 0.95
      params[:maximum_interval] = 90
    when 'casual'
      params[:target_retention] = 0.85
      params[:maximum_interval] = 365
    end
    
    params
  end
  
  def find_or_create_sr_item(reviewable)
    SpacedRepetitionItem.find_or_create_by!(
      user: @user,
      reviewable: reviewable
    ) do |item|
      # Initialize with FSRS defaults
      item.difficulty = calculate_initial_difficulty(reviewable)
      item.stability = FsrsAlgorithm::DEFAULT_PARAMS[:initial_stability][2]
      item.review_count = 0
      item.lapse_count = 0
      item.next_review_at = Time.current
    end
  end
  
  def extract_state(sr_item)
    {
      difficulty: sr_item.difficulty || 5.0,
      stability: sr_item.stability || 2.4,
      elapsed_days: sr_item.elapsed_days || 0,
      reps: sr_item.review_count || 0,
      lapses: sr_item.lapse_count || 0,
      last_review_at: sr_item.last_reviewed_at
    }
  end
  
  def update_sr_item(sr_item, new_state, grade)
    # Calculate elapsed days for next review
    last_review = sr_item.last_reviewed_at || Time.current
    elapsed_days = ((Time.current - last_review) / 1.day).round
    
    sr_item.update!(
      difficulty: new_state[:difficulty],
      stability: new_state[:stability],
      interval_days: new_state[:interval],
      next_review_at: new_state[:next_review_at],
      review_count: new_state[:reps],
      lapse_count: new_state[:lapses],
      last_reviewed_at: Time.current,
      last_grade: grade.to_s,
      elapsed_days: elapsed_days,
      retention_rate: @fsrs.predict_recall_probability(new_state[:stability], new_state[:interval])
    )
    
    # Update average grade
    if sr_item.average_grade.present?
      grade_value = FsrsAlgorithm::GRADES[grade]
      new_avg = (sr_item.average_grade * (sr_item.review_count - 1) + grade_value) / sr_item.review_count
      sr_item.update(average_grade: new_avg.round(2))
    else
      sr_item.update(average_grade: FsrsAlgorithm::GRADES[grade])
    end
  end
  
  def update_reviewable_stats(reviewable, grade)
    # Update practice statistics on the reviewable item itself
    if reviewable.respond_to?(:times_practiced)
      reviewable.increment!(:times_practiced)
    end
    
    if reviewable.respond_to?(:average_success_rate)
      success = [:good, :easy].include?(grade)
      current_rate = reviewable.average_success_rate || 0
      times = reviewable.times_practiced || 1
      
      new_rate = ((current_rate * (times - 1)) + (success ? 100 : 0)) / times
      reviewable.update(average_success_rate: new_rate.round(2))
    end
  end
  
  def log_review(sr_item, grade, new_state)
    # Could log to a separate reviews table for detailed analytics
    Rails.logger.info(
      "FSRS Review: user=#{@user.id} item=#{sr_item.reviewable_type}:#{sr_item.reviewable_id} " \
      "grade=#{grade} new_interval=#{new_state[:interval]}d stability=#{new_state[:stability]}"
    )
  end
  
  def format_schedule_result(sr_item, new_state)
    {
      success: true,
      next_review_at: new_state[:next_review_at],
      interval_days: new_state[:interval],
      difficulty: new_state[:difficulty],
      stability: new_state[:stability],
      review_count: new_state[:reps],
      lapse_count: new_state[:lapses],
      retention_probability: @fsrs.predict_recall_probability(
        new_state[:stability],
        new_state[:interval]
      ).round(2),
      mastery_level: determine_mastery_level(sr_item.reload)
    }
  end
  
  def validate_grade!(grade)
    unless FsrsAlgorithm::GRADES.key?(grade)
      raise ArgumentError, "Invalid grade: #{grade}. Must be one of #{FsrsAlgorithm::GRADES.keys.join(', ')}"
    end
  end
  
  def calculate_item_urgency(item)
    elapsed = ((Time.current - item.next_review_at) / 1.day).to_f
    retention = @fsrs.predict_recall_probability(item.stability, elapsed.abs)
    
    # Calculate urgency score
    if elapsed > 0
      # Overdue: urgency increases with time and decreases with retention
      urgency = (1 - retention) * 100 + elapsed
    else
      # Not due yet: negative urgency
      urgency = elapsed
    end
    
    {
      item: item.reviewable,
      sr_item: item,
      urgency: urgency.round(2),
      retention: retention.round(2),
      days_overdue: elapsed > 0 ? elapsed.round : 0,
      difficulty: item.difficulty,
      stability: item.stability,
      is_overdue: elapsed > 0,
      next_review_at: item.next_review_at
    }
  end
  
  def calculate_overview_stats(items)
    {
      total_items: items.count,
      items_due: items.where('next_review_at <= ?', Time.current).count,
      items_overdue: items.where('next_review_at < ?', 1.day.ago).count,
      items_mastered: items.where('stability > ?', 21).count,
      items_learning: items.where('stability BETWEEN ? AND ?', 2, 21).count,
      items_new: items.where('stability < ?', 2).count
    }
  end
  
  def calculate_retention_stats(items)
    {
      average_retention: items.average(:retention_rate)&.round(2) || 0,
      predicted_30_day: predict_retention_at_days(items, 30),
      predicted_90_day: predict_retention_at_days(items, 90),
      current_success_rate: calculate_overall_success_rate(items)
    }
  end
  
  def calculate_efficiency_stats(items)
    daily_burden = items.sum { |item| 1.0 / (item.interval_days || 1) }
    
    {
      daily_review_burden: daily_burden.round(1),
      optimal_burden: (items.count * 0.1).round(1),
      efficiency_ratio: calculate_efficiency_ratio(items),
      average_interval: items.average(:interval_days)&.round(1) || 0
    }
  end
  
  def calculate_difficulty_stats(items)
    total = items.count
    return {} if total == 0
    
    easy = items.where('difficulty < ?', 4).count
    medium = items.where('difficulty BETWEEN ? AND ?', 4, 7).count
    hard = items.where('difficulty > ?', 7).count
    
    {
      average_difficulty: items.average(:difficulty)&.round(2) || 0,
      easy_count: easy,
      medium_count: medium,
      hard_count: hard,
      easy_ratio: (easy.to_f / total).round(2),
      medium_ratio: (medium.to_f / total).round(2),
      high_difficulty_ratio: (hard.to_f / total).round(2)
    }
  end
  
  def calculate_progress_stats(items)
    {
      total_reviews: items.sum(:review_count),
      total_lapses: items.sum(:lapse_count),
      average_reviews_per_item: items.average(:review_count)&.round(1) || 0,
      items_reviewed_today: items.where('last_reviewed_at >= ?', Time.current.beginning_of_day).count,
      streak_days: calculate_streak_days
    }
  end
  
  def calculate_forecast(items)
    {
      reviews_due_tomorrow: items.where(
        'next_review_at BETWEEN ? AND ?',
        1.day.from_now.beginning_of_day,
        1.day.from_now.end_of_day
      ).count,
      reviews_due_week: items.where(
        'next_review_at BETWEEN ? AND ?',
        Time.current,
        7.days.from_now
      ).count,
      estimated_time_tomorrow: estimate_review_time(items, 1),
      estimated_time_week: estimate_review_time(items, 7)
    }
  end
  
  def calculate_success_rate(sr_item)
    return 0 if sr_item.review_count == 0
    ((sr_item.review_count - sr_item.lapse_count).to_f / sr_item.review_count * 100).round(2)
  end
  
  def calculate_current_retention(sr_item)
    return 1.0 unless sr_item.last_reviewed_at && sr_item.stability
    
    elapsed = ((Time.current - sr_item.last_reviewed_at) / 1.day).to_f
    @fsrs.predict_recall_probability(sr_item.stability, elapsed).round(2)
  end
  
  def determine_mastery_level(sr_item)
    stability = sr_item.stability || 0
    success_rate = calculate_success_rate(sr_item)
    
    if stability > 30 && success_rate > 90
      :mastered
    elsif stability > 14 && success_rate > 80
      :proficient
    elsif stability > 7 && success_rate > 70
      :learning
    elsif sr_item.review_count > 3 && success_rate < 50
      :struggling
    else
      :new
    end
  end
  
  def time_until_review(sr_item)
    return 0 if sr_item.next_review_at <= Time.current
    ((sr_item.next_review_at - Time.current) / 1.day).ceil
  end
  
  def get_overdue_items
    items = SpacedRepetitionItem
      .where(user: @user)
      .where('next_review_at < ?', 1.day.ago)
      .includes(:reviewable)
    
    items.map { |item| calculate_item_urgency(item) }
         .sort_by { |item| -item[:urgency] }
  end
  
  def get_due_today_items
    items = SpacedRepetitionItem
      .where(user: @user)
      .where('next_review_at BETWEEN ? AND ?', 
             1.day.ago, 
             Time.current.end_of_day)
      .includes(:reviewable)
    
    items.map { |item| calculate_item_urgency(item) }
         .sort_by { |item| -item[:urgency] }
  end
  
  def get_struggling_items
    items = SpacedRepetitionItem
      .where(user: @user)
      .where('lapse_count >= ?', 3)
      .includes(:reviewable)
    
    items.map { |item| calculate_item_urgency(item) }
         .sort_by { |item| -item[:lapse_count] }
  end
  
  def get_new_items
    # Items never reviewed or only reviewed once
    items = SpacedRepetitionItem
      .where(user: @user)
      .where('review_count <= ?', 1)
      .includes(:reviewable)
    
    items.map { |item| calculate_item_urgency(item) }
  end
  
  def get_recommended_new_items(limit)
    # Find Docker commands or K8s resources not yet in spaced repetition
    existing_ids = SpacedRepetitionItem
      .where(user: @user, reviewable_type: 'DockerCommand')
      .pluck(:reviewable_id)
    
    new_commands = DockerCommand
      .where.not(id: existing_ids)
      .active
      .by_difficulty(determine_user_level)
      .limit(limit)
    
    new_commands.map do |command|
      {
        item: command,
        type: :new,
        difficulty: calculate_initial_difficulty(command)
      }
    end
  end
  
  def determine_user_level
    items = SpacedRepetitionItem.where(user: @user)
    return 'beginner' if items.count < 10
    
    avg_difficulty = items.average(:difficulty) || 5.0
    
    case avg_difficulty
    when 0..4 then 'beginner'
    when 4..6.5 then 'intermediate'
    else 'advanced'
    end
  end
  
  def calculate_docker_command_difficulty(command)
    scores = []
    
    # Command length
    words = command.command.split.length
    scores << case words
    when 1..2 then 2.0
    when 3..4 then 4.0
    when 5..6 then 6.0
    else 8.0
    end
    
    # Category complexity
    category_scores = {
      'basic' => 2.0,
      'images' => 3.0,
      'containers' => 4.0,
      'networks' => 6.0,
      'volumes' => 5.0,
      'swarm' => 8.0,
      'security' => 9.0
    }
    scores << (category_scores[command.category] || 5.0)
    
    # Flags complexity
    flags_count = command.flags&.keys&.length || 0
    scores << [flags_count * 0.5 + 2, 10].min
    
    # Average all scores
    (scores.sum / scores.length).round(1)
  end
  
  def calculate_k8s_resource_difficulty(resource)
    base_difficulty = {
      'pod' => 3.0,
      'service' => 4.0,
      'deployment' => 5.0,
      'statefulset' => 7.0,
      'daemonset' => 6.5,
      'configmap' => 4.0,
      'secret' => 4.5,
      'ingress' => 7.0,
      'networkpolicy' => 8.5,
      'persistentvolume' => 6.0
    }
    
    base = base_difficulty[resource.resource_type] || 5.0
    
    # Adjust based on YAML complexity
    if resource.yaml_template.present?
      lines = resource.yaml_template.lines.count
      complexity_bonus = [lines / 10.0, 3].min
      base + complexity_bonus
    else
      base
    end
  end
  
  def calculate_lab_difficulty(lab)
    lab.difficulty_score || 5.0
  end
  
  def predict_retention_at_days(items, days)
    return 0 if items.empty?
    
    predictions = items.map do |item|
      @fsrs.predict_recall_probability(item.stability, days)
    end
    
    (predictions.sum / predictions.length).round(2)
  end
  
  def calculate_overall_success_rate(items)
    total_reviews = items.sum(:review_count)
    return 0 if total_reviews == 0
    
    total_successes = items.sum { |item| item.review_count - item.lapse_count }
    (total_successes.to_f / total_reviews * 100).round(2)
  end
  
  def calculate_efficiency_ratio(items)
    return 0 if items.empty?
    
    retention = items.average(:retention_rate) || 0
    burden = items.sum { |item| 1.0 / (item.interval_days || 1) }
    normalized_burden = burden / items.count
    
    (retention / normalized_burden).round(2)
  end
  
  def calculate_streak_days
    # Count consecutive days with reviews
    current_date = Date.current
    streak = 0
    
    loop do
      reviewed = SpacedRepetitionItem
        .where(user: @user)
        .where('DATE(last_reviewed_at) = ?', current_date)
        .exists?
      
      break unless reviewed
      
      streak += 1
      current_date -= 1.day
      break if streak > 365  # Cap at 1 year
    end
    
    streak
  end
  
  def estimate_review_time(items, days)
    count = items.where(
      'next_review_at BETWEEN ? AND ?',
      Time.current,
      days.days.from_now
    ).count
    
    # Assume 2 minutes per review
    (count * 2).round
  end
  
  def calculate_learning_rate(items)
    recent = items.where('created_at >= ?', 30.days.ago)
    return 0 if recent.empty?
    
    (recent.count / 30.0).round(2)
  end
  
  def calculate_overall_retention(items)
    return 0 if items.empty?
    
    items.average(:retention_rate)&.round(2) || 0
  end
  
  def calculate_actual_retention_curve(reviews)
    # Group reviews by interval and calculate actual success rate
    # This would be used for parameter optimization
    reviews.group_by(&:interval_days).transform_values do |interval_reviews|
      successes = interval_reviews.count { |r| [:good, :easy].include?(r.last_grade&.to_sym) }
      successes.to_f / interval_reviews.length
    end
  end
  
  def fetch_review_history
    SpacedRepetitionItem
      .where(user: @user)
      .where('review_count > 0')
      .order(last_reviewed_at: :desc)
      .limit(1000)
  end
end