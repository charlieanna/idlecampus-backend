class CreateProgressiveChallengeLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :progressive_challenge_levels, id: :uuid do |t|
      t.references :progressive_challenge, type: :uuid, foreign_key: true, index: { name: 'idx_prog_levels_on_challenge' }
      t.integer :level_number, null: false
      t.string :level_name, null: false # 'Connectivity', 'Capacity', etc.
      t.text :description
      t.jsonb :requirements, null: false
      t.jsonb :test_cases, null: false
      t.jsonb :passing_criteria, null: false
      t.integer :xp_reward, null: false
      t.jsonb :hints, default: []
      t.text :solution_approach
      t.integer :estimated_minutes, default: 15
      t.timestamps
    end

    add_index :progressive_challenge_levels, [:progressive_challenge_id, :level_number], 
      unique: true, name: 'idx_prog_challenge_level_unique'
    add_index :progressive_challenge_levels, :level_number
    add_index :progressive_challenge_levels, :requirements, using: :gin
  end
end