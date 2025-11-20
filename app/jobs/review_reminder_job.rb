class ReviewReminderJob < ApplicationJob
  queue_as :default
  
  def perform
    """
    Send review reminders to users with items due
    Runs daily at 9 AM
    """
    
    users_with_reviews = SpacedRepetitionItem
      .due
      .group(:user_id)
      .count
    
    reminded = 0
    
    users_with_reviews.each do |user_id, count|
      begin
        user = User.find(user_id)
        
        # Skip if user reviewed recently (today)
        next if reviewed_today?(user)
        
        # Log reminder (email integration would go here)
        Rails.logger.info("📬 Reminder for user #{user_id}: #{count} reviews due")
        
        # Track event
        LearningEvent.create!(
          user_id: user_id,
          event_type: 'review_reminder_sent',
          event_category: 'review',
          event_data: {
            items_due: count,
            sent_at: Time.current
          }
        )
        
        reminded += 1
      rescue => e
        Rails.logger.error("Failed to remind user #{user_id}: #{e.message}")
      end
    end
    
    Rails.logger.info("📬 Review reminders sent: #{reminded}")
    
    { reminded: reminded, total_due_items: users_with_reviews.values.sum }
  end
  
  private
  
  def reviewed_today?(user)
    """Check if user has done reviews today"""
    
    LearningEvent
      .where(user_id: user.id)
      .where(event_type: 'review_completed')
      .where('DATE(created_at) = ?', Date.today)
      .exists?
  end
end

