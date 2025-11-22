class CreateProgressiveChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :progressive_challenges, id: :uuid do |t|
      t.string :slug, null: false
      t.string :title, null: false
      t.text :description
      t.string :category # caching, messaging, storage, etc.
      t.references :progressive_learning_track, type: :uuid, foreign_key: true, index: { name: 'idx_prog_challenges_on_track' }
      t.integer :order_in_track
      t.string :difficulty_base, null: false # beginner, intermediate, advanced
      t.integer :xp_base, default: 100
      t.integer :estimated_minutes, default: 30
      t.jsonb :prerequisites, default: []
      t.jsonb :ddia_concepts, default: []
      t.jsonb :tags, default: []
      t.jsonb :metadata, default: {}
      t.boolean :is_active, default: true
      t.timestamps
    end

    add_index :progressive_challenges, :slug, unique: true
    add_index :progressive_challenges, :category
    add_index :progressive_challenges, :prerequisites, using: :gin
    add_index :progressive_challenges, :tags, using: :gin
    add_index :progressive_challenges, :ddia_concepts, using: :gin
  end
end