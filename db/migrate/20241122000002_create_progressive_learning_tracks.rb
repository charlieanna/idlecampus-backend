class CreateProgressiveLearningTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :progressive_learning_tracks, id: :uuid do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.text :description
      t.string :difficulty_level, null: false # fundamentals, concepts, systems
      t.integer :estimated_hours
      t.jsonb :prerequisites, default: []
      t.integer :order_index, null: false
      t.boolean :is_active, default: true
      t.jsonb :metadata, default: {}
      t.timestamps
    end

    add_index :progressive_learning_tracks, :slug, unique: true
    add_index :progressive_learning_tracks, :difficulty_level
    add_index :progressive_learning_tracks, :order_index
  end
end