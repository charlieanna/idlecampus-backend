class CreateHandsOnLabs < ActiveRecord::Migration[6.0]
  def change
    create_table :hands_on_labs do |t|
      t.string :title, null: false
      t.text :description
      t.string :difficulty, null: false
      t.integer :estimated_minutes, default: 30
      t.json :steps, default: []
      t.json :validation_rules, default: {}
      t.string :lab_type, null: false
      t.string :category
      t.text :learning_objectives
      t.json :prerequisites, default: []
      t.text :success_criteria
      t.string :environment_image
      t.json :required_tools, default: []
      t.integer :max_attempts, default: 3
      t.integer :times_completed, default: 0
      t.float :average_completion_time, default: 0.0
      t.float :average_success_rate, default: 0.0
      t.string :certification_exam
      t.boolean :is_active, default: true
      t.integer :points_reward, default: 100
      t.timestamps
    end

    add_index :hands_on_labs, :title
    add_index :hands_on_labs, :difficulty
    add_index :hands_on_labs, :lab_type
    add_index :hands_on_labs, :category
    add_index :hands_on_labs, [:lab_type, :difficulty]
    add_index :hands_on_labs, [:category, :difficulty]
    add_index :hands_on_labs, :certification_exam
    add_index :hands_on_labs, :is_active
  end
end