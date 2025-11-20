class CreateUserCommandMasteries < ActiveRecord::Migration[6.0]
  def change
    create_table :user_command_masteries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :canonical_command, null: false
      t.string :command_category # docker, kubernetes, docker-compose
      
      # Mastery metrics
      t.integer :total_attempts, default: 0
      t.integer :successful_attempts, default: 0
      t.decimal :proficiency_score, precision: 5, scale: 2, default: 0.0
      
      # Context-specific tracking
      t.json :context_performance, default: {}
      # { practice: {attempts: 5, successes: 4}, quiz: {attempts: 3, successes: 3}, lab: {attempts: 1, successes: 1} }
      
      # Temporal tracking
      t.datetime :last_used_at
      t.datetime :last_correct_at
      t.datetime :first_mastered_at # When first reached 100%
      
      # Decay system (for Phase 3)
      t.decimal :decay_rate, precision: 5, scale: 2, default: 1.0
      t.datetime :last_decay_calculation_at
      t.json :shields, default: [] # Gamification shields
      
      t.timestamps
      
      t.index [:user_id, :canonical_command], unique: true, name: 'idx_user_command_unique'
      t.index :proficiency_score
      t.index :last_used_at
      t.index :command_category
    end
  end
end
