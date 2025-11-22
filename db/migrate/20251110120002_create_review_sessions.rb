class CreateReviewSessions < ActiveRecord::Migration[6.0]
  def change
    unless table_exists?(:review_sessions)
      create_table :review_sessions do |t|
        t.references :user, null: false, foreign_key: true
        t.references :course_enrollment, null: false, foreign_key: true
        t.references :course, null: false, foreign_key: true

        # Session details
        t.integer :days_since_last_visit, null: false
        t.string :review_type # quick_refresh, comprehensive_review, forgotten_content
        t.jsonb :items_to_review, default: []
        t.jsonb :review_modules, default: [] # Generated review content

        # Progress tracking
        t.integer :items_reviewed, default: 0
        t.integer :total_items, default: 0
        t.integer :score, default: 0
        t.boolean :completed, default: false

        # Timestamps
        t.datetime :started_at
        t.datetime :completed_at
        t.integer :time_spent_seconds, default: 0

        t.timestamps
      end
    end

    unless index_exists?(:review_sessions, [:user_id, :course_id])
      add_index :review_sessions, [:user_id, :course_id]
    end
    unless index_exists?(:review_sessions, :review_type)
      add_index :review_sessions, :review_type
    end
    unless index_exists?(:review_sessions, :completed)
      add_index :review_sessions, :completed
    end
    unless index_exists?(:review_sessions, :created_at)
      add_index :review_sessions, :created_at
    end
  end
end
