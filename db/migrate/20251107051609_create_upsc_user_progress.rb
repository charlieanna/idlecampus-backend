class CreateUpscUserProgress < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_user_progress do |t|
      t.references :user, foreign_key: true, null: false
      t.references :upsc_topic, foreign_key: true, null: false
      t.string :status, default: 'not_started'
      t.integer :completion_percentage, default: 0
      t.integer :confidence_level
      t.integer :time_spent_minutes, default: 0
      t.datetime :last_accessed_at
      t.datetime :first_started_at
      t.datetime :completed_at
      t.datetime :mastered_at
      t.text :notes
      t.boolean :bookmarked, default: false
      t.integer :revision_count, default: 0
      t.datetime :last_revised_at

      t.timestamps
    end

    add_index :upsc_user_progress, [:user_id, :upsc_topic_id], unique: true, name: 'index_upsc_user_progress_unique'
    add_index :upsc_user_progress, :status
    add_index :upsc_user_progress, :last_accessed_at
  end
end
