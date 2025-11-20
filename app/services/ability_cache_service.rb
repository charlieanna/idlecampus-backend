class AbilityCacheService
  """
  Redis-backed caching for user ability estimates
  Reduces database queries and improves adaptive question selection performance
  """
  
  CACHE_TTL = 1.hour.to_i
  
  def self.get_ability(user_id, dimension = 'overall')
    """Get cached ability or fetch from database"""
    
    cache_key = ability_cache_key(user_id, dimension)
    
    # Try cache first
    cached = Rails.cache.read(cache_key)
    return cached if cached
    
    # Fetch from database
    skill_dim = UserSkillDimension.find_by(user_id: user_id, dimension: dimension)
    
    ability_data = if skill_dim
      {
        ability: skill_dim.ability_estimate,
        standard_error: skill_dim.standard_error,
        confidence: 1 - skill_dim.standard_error,
        n_observations: skill_dim.n_observations,
        last_updated: skill_dim.last_updated_at
      }
    else
      default_ability(dimension)
    end
    
    # Cache it
    Rails.cache.write(cache_key, ability_data, expires_in: CACHE_TTL)
    
    ability_data
  end
  
  def self.update_ability(user_id, dimension, new_ability, standard_error, n_observations)
    """Update ability in cache and database"""
    
    # Update database
    skill_dim = UserSkillDimension.find_or_initialize_by(
      user_id: user_id,
      dimension: dimension
    )
    
    skill_dim.assign_attributes(
      ability_estimate: new_ability,
      standard_error: standard_error,
      n_observations: n_observations,
      confidence_lower: new_ability - (1.96 * standard_error),
      confidence_upper: new_ability + (1.96 * standard_error),
      last_updated_at: Time.current
    )
    
    skill_dim.save!
    
    # Update cache
    ability_data = {
      ability: new_ability,
      standard_error: standard_error,
      confidence: 1 - standard_error,
      n_observations: n_observations,
      last_updated: Time.current
    }
    
    cache_key = ability_cache_key(user_id, dimension)
    Rails.cache.write(cache_key, ability_data, expires_in: CACHE_TTL)
    
    ability_data
  end
  
  def self.invalidate_ability(user_id, dimension = nil)
    """Invalidate cached ability"""
    
    if dimension
      Rails.cache.delete(ability_cache_key(user_id, dimension))
    else
      # Invalidate all dimensions for user
      UserSkillDimension.where(user_id: user_id).pluck(:dimension).each do |dim|
        Rails.cache.delete(ability_cache_key(user_id, dim))
      end
    end
  end
  
  def self.get_all_abilities(user_id)
    """Get all skill dimension abilities for user"""
    
    cache_key = "user:#{user_id}:abilities:all"
    
    cached = Rails.cache.read(cache_key)
    return cached if cached
    
    abilities = {}
    
    UserSkillDimension.where(user_id: user_id).each do |dim|
      abilities[dim.dimension] = {
        ability: dim.ability_estimate,
        standard_error: dim.standard_error,
        confidence: 1 - dim.standard_error,
        n_observations: dim.n_observations,
        level: ability_to_level(dim.ability_estimate)
      }
    end
    
    # Add default for overall if not present
    abilities['overall'] ||= default_ability('overall')
    
    Rails.cache.write(cache_key, abilities, expires_in: CACHE_TTL)
    
    abilities
  end
  
  def self.warm_cache(user_id)
    """Preload all abilities into cache"""
    get_all_abilities(user_id)
  end
  
  private
  
  def self.ability_cache_key(user_id, dimension)
    "user:#{user_id}:ability:#{dimension}:v1"
  end
  
  def self.default_ability(dimension)
    """Default ability for new users"""
    {
      ability: 0.0,
      standard_error: 1.5,
      confidence: 0.0,
      n_observations: 0,
      last_updated: nil
    }
  end
  
  def self.ability_to_level(ability)
    """Convert ability to level name"""
    case ability
    when -Float::INFINITY..-0.5
      'Beginner'
    when -0.5..0.5
      'Intermediate'
    when 0.5..1.5
      'Advanced'
    else
      'Expert'
    end
  end
  
  # ============================================
  # Batch Operations
  # ============================================
  
  def self.cache_multiple_abilities(user_ids, dimension = 'overall')
    """Cache abilities for multiple users (for leaderboards, etc.)"""
    
    abilities = {}
    
    UserSkillDimension
      .where(user_id: user_ids, dimension: dimension)
      .each do |dim|
        ability_data = {
          ability: dim.ability_estimate,
          standard_error: dim.standard_error,
          confidence: 1 - dim.standard_error
        }
        
        cache_key = ability_cache_key(dim.user_id, dimension)
        Rails.cache.write(cache_key, ability_data, expires_in: CACHE_TTL)
        
        abilities[dim.user_id] = ability_data
      end
    
    abilities
  end
  
  def self.clear_all_caches
    """Clear all ability caches (use sparingly)"""
    Rails.cache.delete_matched("user:*:ability:*")
  end
end

