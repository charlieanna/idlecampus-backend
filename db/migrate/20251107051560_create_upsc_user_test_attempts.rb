class CreateUpscUserTestAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_user_test_attempts do |t|
      t.references :user, foreign_key: true, null: false
      t.references :upsc_test, foreign_key: true, null: false
      t.integer :attempt_number, default: 1
      t.datetime :started_at, null: false
      t.datetime :submitted_at
      t.integer :time_taken_minutes
      t.decimal :score, precision: 7, scale: 2
      t.decimal :percentage, precision: 5, scale: 2
      t.decimal :percentile, precision: 5, scale: 2
      t.integer :rank
      t.integer :total_questions
      t.integer :correct_answers, default: 0
      t.integer :wrong_answers, default: 0
      t.integer :unanswered, default: 0
      t.jsonb :answers, default: {}
      t.jsonb :question_wise_time, default: {}
      t.jsonb :analysis, default: {}
      t.string :status, default: 'in_progress'

      t.timestamps
    end

    add_index :upsc_user_test_attempts, [:user_id, :upsc_test_id]
    add_index :upsc_user_test_attempts, :status
    add_index :upsc_user_test_attempts, :submitted_at
  end
end
