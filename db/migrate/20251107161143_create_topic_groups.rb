class CreateTopicGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_groups do |t|
      t.references :course_module, null: false, foreign_key: true

      t.string :title, null: false
      t.text :description
      t.integer :sequence_order, null: false, default: 0
      t.string :icon
      t.string :color

      t.timestamps
    end

    add_index :topic_groups, [:course_module_id, :sequence_order]
  end
end
