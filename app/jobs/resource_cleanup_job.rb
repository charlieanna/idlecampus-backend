class ResourceCleanupJob < ApplicationJob
  queue_as :maintenance
  
  # Cleanup stale lab resources and containers
  MAX_CONTAINERS_PER_USER = 5
  MAX_CONTAINER_AGE_HOURS = 2
  
  def perform
    cleanup_stale_containers
    cleanup_old_lab_sessions
    Rails.logger.info "Resource cleanup completed at #{Time.current}"
  end
  
  private
  
  def cleanup_stale_containers
    # Find all codesprout lab containers
    container_list = `docker ps -a --format "{{.Names}}\t{{.CreatedAt}}" --filter "name=codesprout_lab_"`.strip
    return if container_list.empty?
    
    containers = container_list.split("\n").map do |line|
      name, created_at = line.split("\t")
      {
        name: name,
        created_at: Time.parse(created_at),
        user_id: extract_user_id(name)
      }
    end
    
    # Group by user and cleanup excess containers
    containers.group_by { |c| c[:user_id] }.each do |user_id, user_containers|
      cleanup_user_containers(user_containers)
    end
    
    # Cleanup containers older than threshold
    old_containers = containers.select do |container|
      container[:created_at] < MAX_CONTAINER_AGE_HOURS.hours.ago
    end
    
    old_containers.each do |container|
      stop_and_remove_container(container[:name])
      Rails.logger.info "Removed old container: #{container[:name]}"
    end
  end
  
  def cleanup_user_containers(user_containers)
    return if user_containers.size <= MAX_CONTAINERS_PER_USER
    
    # Sort by creation time, keep newest ones
    sorted_containers = user_containers.sort_by { |c| c[:created_at] }.reverse
    containers_to_remove = sorted_containers[MAX_CONTAINERS_PER_USER..-1]
    
    containers_to_remove.each do |container|
      stop_and_remove_container(container[:name])
      Rails.logger.info "Removed excess container: #{container[:name]} for user #{container[:user_id]}"
    end
  end
  
  def cleanup_old_lab_sessions
    # This would integrate with a lab_sessions table if it exists
    # For now, just log the intent
    Rails.logger.info "Lab session cleanup placeholder - would clean database records"
  end
  
  def extract_user_id(container_name)
    # Extract user_id from container name format: codesprout_lab_{user_id}_{session_id}
    parts = container_name.split('_')
    parts[2] if parts.size >= 3
  end
  
  def stop_and_remove_container(container_name)
    system("docker stop #{container_name} >/dev/null 2>&1")
    system("docker rm #{container_name} >/dev/null 2>&1")
  end
end
