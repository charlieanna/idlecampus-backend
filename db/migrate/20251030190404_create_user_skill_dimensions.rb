class CreateUserSkillDimensions < ActiveRecord::Migration[6.0]
  def change
    create_table :user_skill_dimensions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :dimension, null: false, limit: 50
      t.decimal :ability_estimate, precision: 5, scale: 2, null: false, default: 0.0
      t.decimal :standard_error, precision: 5, scale: 2, null: false, default: 1.5
      t.decimal :confidence_lower, precision: 5, scale: 2
      t.decimal :confidence_upper, precision: 5, scale: 2
      t.integer :n_observations, default: 0
      t.datetime :last_updated_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      
      t.timestamps
    end
    
    add_index :user_skill_dimensions, [:user_id, :dimension], unique: true
    add_index :user_skill_dimensions, :last_updated_at
  end
end
