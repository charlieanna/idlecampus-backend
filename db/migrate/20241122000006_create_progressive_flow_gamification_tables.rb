class CreateProgressiveFlowGamificationTables < ActiveRecord::Migration[6.0]
  def change
    # Level Attempts table
    create_table :progressive_level_attempts, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_attempts_on_challenge' }
      t.integer :level_number, null: false
      t.integer :attempt_number, null: false
      t.jsonb :design_snapshot, null: false
      t.jsonb :test_results, null: false
      t.decimal :score, precision: 5, scale: 2, null: false
      t.boolean :passed, null: false
      t.integer :xp_earned, default: 0
      t.integer :hints_used, default: 0
      t.integer :time_spent_minutes
      t.jsonb :feedback, default: {}
      t.timestamps
    end

    add_index :progressive_level_attempts, [:progressive_challenge_id, :level_number], name: 'idx_prog_attempts_challenge_level'
    add_index :progressive_level_attempts, :created_at

    # User Track Progress table
    create_table :progressive_user_track_progress, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_learning_track, type: :uuid, foreign_key: true, index: { name: 'idx_prog_track_progress_on_track' }
      t.string :status, default: 'not_started'
      t.decimal :progress_percentage, precision: 5, scale: 2, default: 0.0
      t.integer :challenges_completed, default: 0
      t.integer :total_challenges, null: false
      t.datetime :unlock_date
      t.datetime :start_date
      t.datetime :completion_date
      t.timestamps
    end

    add_index :progressive_user_track_progress, [:user_id, :progressive_learning_track_id], 
      unique: true, name: 'idx_prog_user_track_unique'

    # Achievements table
    create_table :progressive_achievements, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.text :description
      t.string :icon_url
      t.string :category # speed, mastery, streak, exploration
      t.string :rarity, default: 'common' # common, rare, epic, legendary
      t.integer :xp_reward, default: 0
      t.jsonb :criteria, null: false
      t.boolean :is_active, default: true
      t.timestamps
    end

    add_index :progressive_achievements, :slug, unique: true

    # User Achievements table
    create_table :progressive_user_achievements, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_achievement, type: :uuid, foreign_key: true, index: { name: 'idx_prog_user_achievement' }
      t.datetime :unlocked_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.decimal :progress, precision: 5, scale: 2, default: 100.0
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :progressive_user_achievements, [:user_id, :progressive_achievement_id], 
      unique: true, name: 'idx_prog_user_achievement_unique'
    add_index :progressive_user_achievements, :unlocked_at

    # Skills table
    create_table :progressive_skills, id: :uuid do |t|
      t.string :slug, null: false
      t.string :name, null: false
      t.text :description
      t.string :category
      t.references :parent_skill, type: :uuid, foreign_key: { to_table: :progressive_skills }
      t.jsonb :prerequisites, default: []
      t.integer :max_level, default: 5
      t.integer :xp_per_level, default: 100
      t.timestamps
    end

    add_index :progressive_skills, :slug, unique: true

    # User Skills table
    create_table :progressive_user_skills, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_skill, type: :uuid, foreign_key: true, index: true
      t.integer :current_level, default: 0
      t.integer :points_allocated, default: 0
      t.datetime :unlocked_at
      t.datetime :mastered_at
      t.timestamps
    end

    add_index :progressive_user_skills, [:user_id, :progressive_skill_id], 
      unique: true, name: 'idx_prog_user_skill_unique'

    # XP Transactions table
    create_table :progressive_xp_transactions, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :amount, null: false
      t.string :source_type, null: false # challenge, achievement, daily, streak
      t.string :source_id
      t.text :description
      t.timestamps
    end

    add_index :progressive_xp_transactions, :created_at

    # Daily Challenges table
    create_table :progressive_daily_challenges, id: :uuid do |t|
      t.references :progressive_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_daily_challenge' }
      t.date :date, null: false
      t.decimal :difficulty_modifier, precision: 3, scale: 2, default: 1.0
      t.decimal :xp_multiplier, precision: 3, scale: 2, default: 2.0
      t.jsonb :special_requirements, default: {}
      t.integer :participants_count, default: 0
      t.decimal :average_score, precision: 5, scale: 2
      t.timestamps
    end

    add_index :progressive_daily_challenges, :date, unique: true

    # Daily Challenge Attempts table
    create_table :progressive_daily_challenge_attempts, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_daily_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_daily_attempt' }
      t.decimal :score, precision: 5, scale: 2, null: false
      t.integer :xp_earned, default: 0
      t.integer :rank
      t.datetime :completed_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end

    add_index :progressive_daily_challenge_attempts, [:user_id, :progressive_daily_challenge_id], 
      unique: true, name: 'idx_prog_daily_attempt_unique'

    # Leaderboard Entries table
    create_table :progressive_leaderboard_entries, id: :uuid do |t|
      t.string :period_type, null: false # daily, weekly, monthly, all_time
      t.date :period_date
      t.references :user, foreign_key: true, index: true
      t.string :metric_type, null: false # xp, challenges, streak
      t.integer :metric_value, null: false
      t.integer :rank, null: false
      t.timestamps
    end

    add_index :progressive_leaderboard_entries, [:period_type, :period_date], name: 'idx_prog_leaderboard_period'
    add_index :progressive_leaderboard_entries, :rank
    add_index :progressive_leaderboard_entries, [:period_type, :period_date, :user_id, :metric_type], 
      unique: true, name: 'idx_prog_leaderboard_unique'

    # Assessment Results table
    create_table :progressive_assessment_results, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.string :assessment_type, null: false # initial, track_placement, periodic
      t.jsonb :questions, null: false
      t.jsonb :responses, null: false
      t.decimal :score, precision: 5, scale: 2, null: false
      t.string :skill_level_recommendation
      t.jsonb :track_recommendations, default: []
      t.jsonb :challenge_recommendations, default: []
      t.jsonb :strengths, default: []
      t.jsonb :weaknesses, default: []
      t.datetime :completed_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end

    add_index :progressive_assessment_results, :completed_at

    # Learning Sessions table
    create_table :progressive_learning_sessions, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.string :session_type, null: false # challenge, assessment, lesson
      t.string :resource_id
      t.datetime :start_time, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :end_time
      t.integer :duration_minutes
      t.integer :xp_earned, default: 0
      t.boolean :completed, default: false
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :progressive_learning_sessions, :start_time

    # Hint Usage table
    create_table :progressive_hint_usage, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.references :progressive_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_hint_challenge' }
      t.integer :level_number, null: false
      t.integer :hint_number, null: false
      t.integer :xp_penalty, default: 0
      t.datetime :used_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end

    add_index :progressive_hint_usage, [:progressive_challenge_id, :level_number], name: 'idx_prog_hint_challenge_level'

    # Notifications table
    create_table :progressive_notifications, id: :uuid do |t|
      t.references :user, foreign_key: true, index: true
      t.string :notification_type, null: false # achievement, level_complete, streak, challenge_unlock
      t.string :title, null: false
      t.text :message
      t.string :action_url
      t.boolean :is_read, default: false
      t.datetime :read_at
      t.timestamps
    end

    add_index :progressive_notifications, [:user_id, :is_read], name: 'idx_prog_notifications_unread', where: 'is_read = false'
    add_index :progressive_notifications, :created_at
  end
end