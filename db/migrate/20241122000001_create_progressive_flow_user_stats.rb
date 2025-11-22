class CreateProgressiveFlowUserStats < ActiveRecord::Migration[6.0]
  def change
    create_table :progressive_user_stats, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :total_xp, default: 0
      t.integer :current_level, default: 1
      t.integer :total_challenges_started, default: 0
      t.integer :total_challenges_completed, default: 0
      t.integer :total_levels_completed, default: 0
      t.integer :total_time_spent_minutes, default: 0
      t.integer :current_streak_days, default: 0
      t.integer :longest_streak_days, default: 0
      t.date :last_activity_date
      t.decimal :rank_percentile, precision: 5, scale: 2
      t.timestamps
    end

    add_index :progressive_user_stats, :total_xp
    add_index :progressive_user_stats, :current_level
    add_index :progressive_user_stats, :current_streak_days
  end
end