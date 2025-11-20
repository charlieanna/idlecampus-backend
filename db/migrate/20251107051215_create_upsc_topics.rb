class CreateUpscTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_topics do |t|
      t.references :upsc_subject, foreign_key: true, null: false
      t.references :parent_topic, foreign_key: { to_table: :upsc_topics }
      t.string :name, null: false
      t.string :slug, null: false
      t.text :description
      t.string :difficulty_level # beginner, intermediate, advanced
      t.decimal :estimated_hours, precision: 5, scale: 2
      t.integer :order_index
      t.boolean :is_high_yield, default: false
      t.integer :pyq_frequency, default: 0
      t.text :tags, array: true, default: []
      t.text :learning_objectives, array: true, default: []
      t.bigint :prerequisite_topic_ids, array: true, default: []

      # Links to existing course system
      t.references :course_lesson, foreign_key: true
      t.references :course_module, foreign_key: true

      t.timestamps
    end

    add_index :upsc_topics, [:upsc_subject_id, :slug], unique: true
    # parent_topic_id index already created by t.references
    add_index :upsc_topics, :difficulty_level
    add_index :upsc_topics, :is_high_yield
    add_index :upsc_topics, :order_index
  end
end
