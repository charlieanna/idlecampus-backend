class CacheWarmupJob < ApplicationJob
  queue_as :default
  
  def perform
    """
    Warm up caches for active users
    Runs hourly to ensure fast response times
    """
    
    # Get users active in last 24 hours
    active_users = LearningEvent
      .where('created_at >= ?', 24.hours.ago)
      .distinct
      .pluck(:user_id)
      .first(100) # Cap at 100 most active
    
    warmed = 0
    
    active_users.each do |user_id|
      begin
        # Warm ability cache
        AbilityCacheService.warm_cache(user_id)
        
        # Warm Flask availability check
        FlaskClient.reset_availability_check
        
        warmed += 1
      rescue => e
        Rails.logger.error("Cache warmup failed for user #{user_id}: #{e.message}")
      end
    end
    
    Rails.logger.info("🔥 Cache warmed for #{warmed} users")
    
    { warmed: warmed }
  end
end

