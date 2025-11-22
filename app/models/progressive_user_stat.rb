class ProgressiveUserStat < ApplicationRecord
  # Associations
  belongs_to :user
  
  # Validations
  validates :user_id, presence: true, uniqueness: true
  validates :total_xp, :current_level, :total_challenges_started, 
            :total_challenges_completed, :total_levels_completed,
            :total_time_spent_minutes, :current_streak_days, 
            :longest_streak_days, numericality: { greater_than_or_equal_to: 0 }
  
  # Scopes
  scope :top_by_xp, -> { order(total_xp: :desc) }
  scope :top_by_level, -> { order(current_level: :desc) }
  scope :top_by_streak, -> { order(current_streak_days: :desc) }
  scope :active_recently, -> { where('last_activity_date > ?', 30.days.ago) }
  
  # Class methods
  def self.calculate_level_from_xp(total_xp)
    # Level N requires: 100 * N * (N + 1) / 2 total XP
    # Inverse: level = floor((-1 + sqrt(1 + 8*xp/100)) / 2) + 1
    level = ((-1 + Math.sqrt(1 + 8 * total_xp.to_f / 100)) / 2).floor + 1
    [level, 1].max
  end
  
  def self.xp_for_level(level)
    100 * level * (level + 1) / 2
  end
  
  # Instance methods
  def update_level!
    new_level = self.class.calculate_level_from_xp(total_xp)
    update!(current_level: new_level) if new_level != current_level
    new_level
  end
  
  def xp_progress
    current_level_xp = self.class.xp_for_level(current_level - 1)
    next_level_xp = self.class.xp_for_level(current_level)
    xp_in_level = total_xp - current_level_xp
    xp_needed = next_level_xp - current_level_xp
    {
      level: current_level,
      xp_in_level: xp_in_level,
      xp_needed: xp_needed,
      progress: (xp_in_level.to_f / xp_needed * 100).round(2)
    }
  end
  
  def rank_name
    case current_level
    when 1...5 then 'Novice'
    when 5...10 then 'Apprentice'
    when 10...20 then 'Practitioner'
    when 20...30 then 'Expert'
    when 30...50 then 'Master'
    else 'Grandmaster'
    end
  end
  
  def update_streak!(activity_date = Date.current)
    if last_activity_date == activity_date
      return # Already active today
    elsif last_activity_date == activity_date - 1
      # Continuing streak
      new_streak = current_streak_days + 1
      update!(
        current_streak_days: new_streak,
        longest_streak_days: [longest_streak_days, new_streak].max,
        last_activity_date: activity_date
      )
    else
      # Streak broken
      update!(
        current_streak_days: 1,
        longest_streak_days: [longest_streak_days, 1].max,
        last_activity_date: activity_date
      )
    end
  end
  
  def active_today?
    last_activity_date == Date.current
  end
end