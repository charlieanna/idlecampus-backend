class CreateMicroLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :micro_lessons do |t|
      t.references :course_module, null: false, foreign_key: true
      t.references :topic_group, null: true, foreign_key: true

      t.string :title, null: false
      t.string :slug, null: false
      t.text :content

      t.integer :sequence_order, null: false, default: 0
      t.integer :estimated_minutes, default: 2
      t.string :difficulty, default: 'medium'

      t.jsonb :key_concepts, default: []
      t.jsonb :prerequisite_ids, default: []

      t.boolean :published, default: true

      t.timestamps
    end

    add_index :micro_lessons, :slug, unique: true
    add_index :micro_lessons, [:course_module_id, :sequence_order]
    # topic_group_id index already created by t.references
  end
end
