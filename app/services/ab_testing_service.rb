class AbTestingService
  """
  A/B testing framework for comparing adaptive strategies
  Tests: Heuristic vs IRT, Different feedback styles, etc.
  """
  
  EXPERIMENTS = {
    'adaptive_algorithm' => {
      variants: ['heuristic', 'irt_flask'],
      description: 'Compare heuristic vs IRT question selection',
      metrics: ['accuracy', 'time_per_question', 'ability_improvement'],
      allocation: { 'heuristic' => 0.5, 'irt_flask' => 0.5 }
    },
    'feedback_style' => {
      variants: ['progressive', 'immediate_full'],
      description: 'Progressive hints vs full explanation',
      metrics: ['retry_rate', 'learning_efficiency'],
      allocation: { 'progressive' => 0.5, 'immediate_full' => 0.5 }
    },
    'difficulty_progression' => {
      variants: ['conservative', 'aggressive'],
      description: 'Conservative vs aggressive difficulty increase',
      metrics: ['completion_rate', 'frustration_score'],
      allocation: { 'conservative' => 0.5, 'aggressive' => 0.5 }
    }
  }.freeze
  
  def assign_variant(user_id:, experiment:)
    """
    Assign user to experiment variant
    Uses consistent hashing for stable assignment
    """
    
    return nil unless EXPERIMENTS.key?(experiment)
    
    # Check if already assigned
    cache_key = "ab:#{experiment}:user:#{user_id}"
    cached_variant = Rails.cache.read(cache_key)
    return cached_variant if cached_variant
    
    # Assign based on hash
    variants = EXPERIMENTS[experiment][:variants]
    allocation = EXPERIMENTS[experiment][:allocation]
    
    # Consistent hash
    hash = Digest::MD5.hexdigest("#{user_id}:#{experiment}").to_i(16)
    threshold = hash % 100
    
    cumulative = 0
    assigned_variant = variants.first
    
    allocation.each do |variant, percentage|
      cumulative += (percentage * 100).to_i
      if threshold < cumulative
        assigned_variant = variant
        break
      end
    end
    
    # Cache assignment
    Rails.cache.write(cache_key, assigned_variant, expires_in: 30.days)
    
    # Log assignment
    track_assignment(user_id, experiment, assigned_variant)
    
    assigned_variant
  end
  
  def get_variant(user_id:, experiment:)
    """Get user's assigned variant (without assignment)"""
    
    cache_key = "ab:#{experiment}:user:#{user_id}"
    Rails.cache.read(cache_key) || EXPERIMENTS[experiment][:variants].first
  end
  
  def track_metric(user_id:, experiment:, metric:, value:)
    """Track A/B test metric"""
    
    variant = get_variant(user_id: user_id, experiment: experiment)
    
    LearningEvent.create!(
      user_id: user_id,
      event_type: 'ab_test_metric',
      event_category: 'experiment',
      event_data: {
        experiment: experiment,
        variant: variant,
        metric: metric,
        value: value
      },
      performance_score: value
    )
  end
  
  def get_experiment_results(experiment:)
    """Get results for an experiment"""
    
    return nil unless EXPERIMENTS.key?(experiment)
    
    variants = EXPERIMENTS[experiment][:variants]
    metrics = EXPERIMENTS[experiment][:metrics]
    
    results = {}
    
    variants.each do |variant|
      variant_metrics = {}
      
      metrics.each do |metric|
        # Get all metric values for this variant
        values = LearningEvent
          .where(event_type: 'ab_test_metric')
          .where("json_extract(event_data, '$.experiment') = ?", experiment)
          .where("json_extract(event_data, '$.variant') = ?", variant)
          .where("json_extract(event_data, '$.metric') = ?", metric)
          .pluck(:performance_score)
        
        variant_metrics[metric] = {
          count: values.count,
          mean: values.any? ? (values.sum / values.count.to_f).round(3) : 0,
          median: values.any? ? median(values) : 0,
          stddev: values.any? ? standard_deviation(values) : 0
        }
      end
      
      results[variant] = variant_metrics
    end
    
    # Calculate statistical significance
    results[:significance] = calculate_significance(results, metrics.first)
    
    results
  end
  
  def is_experiment_active?(experiment)
    """Check if experiment is currently active"""
    
    EXPERIMENTS.key?(experiment)
  end
  
  private
  
  def track_assignment(user_id, experiment, variant)
    """Log variant assignment"""
    
    LearningEvent.create!(
      user_id: user_id,
      event_type: 'ab_test_assigned',
      event_category: 'experiment',
      event_data: {
        experiment: experiment,
        variant: variant,
        assigned_at: Time.current
      }
    )
  end
  
  def median(array)
    """Calculate median"""
    return 0.0 if array.empty?
    
    sorted = array.sort
    len = sorted.length
    
    if len.odd?
      sorted[len / 2]
    else
      (sorted[len / 2 - 1] + sorted[len / 2]) / 2.0
    end
  end
  
  def standard_deviation(array)
    """Calculate standard deviation"""
    return 0.0 if array.empty?
    
    mean = array.sum.to_f / array.length
    variance = array.map { |x| (x - mean) ** 2 }.sum / array.length
    
    Math.sqrt(variance)
  end
  
  def calculate_significance(results, primary_metric)
    """
    Calculate statistical significance using t-test approximation
    Returns p-value
    """
    
    variants = results.keys.select { |k| k.is_a?(String) }
    return nil if variants.length != 2
    
    v1_data = results[variants[0]][primary_metric]
    v2_data = results[variants[1]][primary_metric]
    
    # Simple t-test approximation
    n1 = v1_data[:count]
    n2 = v2_data[:count]
    
    return nil if n1 < 30 || n2 < 30 # Need sufficient sample
    
    mean_diff = (v1_data[:mean] - v2_data[:mean]).abs
    pooled_std = Math.sqrt((v1_data[:stddev]**2 / n1) + (v2_data[:stddev]**2 / n2))
    
    return nil if pooled_std == 0
    
    t_stat = mean_diff / pooled_std
    
    # Approximate p-value (simplified)
    p_value = 2 * (1 - normal_cdf(t_stat.abs))
    
    {
      p_value: p_value.round(4),
      significant: p_value < 0.05,
      effect_size: mean_diff
    }
  end
  
  def normal_cdf(z)
    """Approximate standard normal CDF"""
    0.5 * (1 + Math.erf(z / Math.sqrt(2)))
  end
end

