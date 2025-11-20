class CreateUpscRevisions < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_revisions do |t|
      t.references :user, foreign_key: true, null: false
      t.references :upsc_topic, foreign_key: true
      t.string :revision_type
      t.date :scheduled_for, null: false
      t.datetime :completed_at
      t.integer :interval_index, default: 0
      t.integer :performance_rating
      t.integer :time_spent_minutes
      t.text :notes
      t.string :status, default: 'pending'

      t.timestamps
    end

    add_index :upsc_revisions, [:user_id, :scheduled_for]
    add_index :upsc_revisions, :status
    add_index :upsc_revisions, [:scheduled_for, :status]
  end
end
