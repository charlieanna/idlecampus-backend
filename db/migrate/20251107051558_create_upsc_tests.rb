class CreateUpscTests < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_tests do |t|
      t.string :test_type, null: false
      t.string :title, null: false
      t.text :description
      t.text :instructions
      t.references :upsc_subject, foreign_key: true
      t.integer :duration_minutes, null: false
      t.decimal :total_marks, precision: 7, scale: 2, null: false
      t.decimal :passing_marks, precision: 7, scale: 2
      t.boolean :negative_marking_enabled, default: true
      t.decimal :negative_marking_ratio, precision: 3, scale: 2, default: 0.33
      t.boolean :is_live, default: false
      t.boolean :is_free, default: false
      t.datetime :scheduled_at
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :result_publish_at
      t.integer :max_attempts, default: 1
      t.boolean :shuffle_questions, default: true
      t.boolean :shuffle_options, default: true
      t.boolean :show_answers_after_submit, default: true
      t.string :difficulty_level
      t.text :tags, array: true, default: []
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :upsc_tests, :test_type
    add_index :upsc_tests, :scheduled_at
    add_index :upsc_tests, :is_live
  end
end
