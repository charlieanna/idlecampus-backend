class CleanupExpiredLabSessionsJob < ApplicationJob
  queue_as :default
  
  def perform
    """
    Cleanup expired lab sessions and containers
    Runs every 15 minutes via cron
    """
    
    orchestrator = LabOrchestratorService.new
    result = orchestrator.cleanup_expired_sessions
    
    Rails.logger.info("🧹 Lab cleanup complete: #{result[:cleaned]} sessions cleaned")
    
    # Also cleanup orphaned containers (containers without session records)
    cleanup_orphaned_containers
    
    result
  end
  
  private
  
  def cleanup_orphaned_containers
    """Remove containers that have no active session"""
    
    begin
      Docker.url = ENV['DOCKER_HOST'] || 'unix:///var/run/docker.sock'
      
      # Get all lab containers
      containers = Docker::Container.all(
        all: true,
        filters: { label: ['lab.user_id'] }.to_json
      )
      
      cleaned = 0
      
      containers.each do |container|
        container_id = container.id
        created_at = container.info.dig('Labels', 'lab.created_at').to_i
        age_hours = (Time.current.to_i - created_at) / 3600.0
        
        # Check if session exists
        session = LabSession.find_by(container_id: container_id)
        
        # Remove if no session or very old
        if session.nil? || age_hours > 24
          container.stop(timeout: 10) rescue nil
          container.remove(force: true) rescue nil
          cleaned += 1
          
          Rails.logger.info("Removed orphaned container: #{container_id}")
        end
      end
      
      Rails.logger.info("🧹 Orphaned containers cleaned: #{cleaned}")
      
    rescue => e
      Rails.logger.error("Failed to cleanup orphaned containers: #{e.message}")
    end
  end
end

