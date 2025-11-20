class CreateProblemAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :problem_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :problem, null: false, foreign_key: true

      # Attempt details
      t.boolean :success, default: false
      t.integer :time_spent_seconds
      t.text :submitted_code
      t.jsonb :test_results, default: []
      t.integer :hints_used, default: 0
      t.jsonb :hints_viewed, default: []

      # Struggle indicators
      t.integer :attempts_count, default: 1
      t.boolean :gave_up, default: false
      t.boolean :viewed_solution, default: false
      t.integer :syntax_errors, default: 0
      t.integer :logic_errors, default: 0
      t.integer :compilation_errors, default: 0

      # Learning indicators
      t.string :confidence_level # 'confident', 'uncertain', 'struggling', 'gave_up'
      t.text :user_notes
      t.jsonb :code_execution_history, default: []

      # Timestamps
      t.datetime :started_at
      t.datetime :completed_at
      t.timestamps
    end

    # Indexes
    add_index :problem_attempts, [:user_id, :problem_id]
    add_index :problem_attempts, [:user_id, :success]
    add_index :problem_attempts, :confidence_level
    add_index :problem_attempts, :created_at
  end
end
