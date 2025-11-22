class CreateProgressiveUserChallengeProgress < ActiveRecord::Migration[6.0]
  def change
    create_table :progressive_user_challenge_progress, id: :uuid do |t|
      t.references :user, foreign_key: true, index: { name: 'idx_prog_user_challenge_on_user' }
      t.references :progressive_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_user_challenge_on_challenge' }
      t.string :status, default: 'not_started' # not_started, in_progress, completed
      t.integer :current_level, default: 0
      t.integer :levels_completed, array: true, default: []
      t.datetime :unlock_date
      t.datetime :start_date
      t.datetime :completion_date
      t.integer :total_attempts, default: 0
      t.integer :total_time_spent_minutes, default: 0
      t.decimal :best_score, precision: 5, scale: 2
      t.integer :xp_earned, default: 0
      t.timestamps
    end

    add_index :progressive_user_challenge_progress, [:user_id, :progressive_challenge_id], 
      unique: true, name: 'idx_prog_user_challenge_unique'
    add_index :progressive_user_challenge_progress, :status
  end
end