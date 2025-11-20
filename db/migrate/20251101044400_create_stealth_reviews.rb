class CreateStealthReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :stealth_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.string :canonical_command, null: false
      t.integer :priority, default: 5
      t.string :status, default: 'queued' # queued, scheduled, completed, cancelled
      t.string :strategy # lesson_opener, mid_lesson_break, etc.
      t.datetime :requested_at
      t.datetime :scheduled_for
      t.datetime :completed_at
      t.boolean :success, null: true
      t.integer :response_time, null: true # in milliseconds
      t.text :context_data # JSON data about lesson context when inserted
      t.integer :stealth_level, default: 3 # 1-5, how disguised the review is
      
      t.timestamps
    end

    add_index :stealth_reviews, [:user_id, :status]
    add_index :stealth_reviews, [:user_id, :canonical_command]
    add_index :stealth_reviews, [:priority, :requested_at]
    add_index :stealth_reviews, :scheduled_for
  end
end