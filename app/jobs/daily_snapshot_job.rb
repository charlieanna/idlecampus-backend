class DailySnapshotJob < ApplicationJob
  queue_as :default
  
  def perform
    """
    Create daily performance snapshots for all active users
    Enables historical tracking and trend analysis
    """
    
    date = Date.today
    created = 0
    
    # Get users active in last 30 days
    active_users = LearningEvent
      .where('created_at >= ?', 30.days.ago)
      .distinct
      .pluck(:user_id)
    
    active_users.each do |user_id|
      begin
        create_snapshot_for_user(user_id, date)
        created += 1
      rescue => e
        Rails.logger.error("Failed to create snapshot for user #{user_id}: #{e.message}")
      end
    end
    
    Rails.logger.info("📸 Daily snapshots created: #{created}")
    
    { created: created, date: date }
  end
  
  private
  
  def create_snapshot_for_user(user_id, date)
    """Create snapshot for single user"""
    
    # Get all skill dimension estimates
    skill_estimates = {}
    UserSkillDimension.where(user_id: user_id).each do |dim|
      skill_estimates[dim.dimension] = {
        ability: dim.ability_estimate,
        confidence: 1 - dim.standard_error,
        observations: dim.n_observations
      }
    end
    
    # Get today's quiz performance
    quiz_events = LearningEvent
      .where(user_id: user_id)
      .where('DATE(created_at) = ?', date)
      .where(event_type: ['quiz_started', 'quiz_completed', 'quiz_question_answered'])
    
    quiz_performance = {
      quizzes_taken: quiz_events.where(event_type: 'quiz_completed').count,
      questions_answered: quiz_events.where(event_type: 'quiz_question_answered').count,
      average_accuracy: calculate_accuracy(quiz_events)
    }
    
    # Get today's lab performance
    lab_events = LearningEvent
      .where(user_id: user_id)
      .where('DATE(created_at) = ?', date)
      .where(event_type: ['lab_started', 'lab_completed'])
    
    lab_performance = {
      labs_started: lab_events.where(event_type: 'lab_started').count,
      labs_completed: lab_events.where(event_type: 'lab_completed').count,
      average_score: lab_events.where(event_type: 'lab_completed').average(:performance_score).to_f * 100
    }
    
    # Get time spent today
    time_spent = LearningEvent
      .where(user_id: user_id)
      .where('DATE(created_at) = ?', date)
      .sum(:time_spent_seconds) / 60
    
    # Get items completed
    items_completed = quiz_events.where(event_type: 'quiz_completed').count +
                      LearningEvent.where(user_id: user_id, event_type: 'lesson_completed')
                        .where('DATE(created_at) = ?', date).count +
                      lab_events.where(event_type: 'lab_completed').count
    
    # Get achievements earned today
    achievements = UserCourseAchievement
      .where(user_id: user_id)
      .where('DATE(earned_at) = ?', date)
      .pluck(:achievement_id, :earned_at)
    
    # Create or update snapshot
    DailyPerformanceSnapshot.create_or_find_by!(
      user_id: user_id,
      snapshot_date: date
    ).update!(
      skill_estimates: skill_estimates,
      quiz_performance: quiz_performance,
      lab_performance: lab_performance,
      time_spent_minutes: time_spent,
      items_completed: items_completed,
      achievements_earned: achievements
    )
  end
  
  def calculate_accuracy(quiz_events)
    """Calculate accuracy from quiz events"""
    
    answered = quiz_events.where(event_type: 'quiz_question_answered')
    total = answered.count
    return 0.0 if total == 0
    
    correct = answered.where('performance_score > 0').count
    (correct.to_f / total * 100).round(1)
  end
end

