class CreateLabAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :lab_attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hands_on_lab, null: false, foreign_key: true
      t.integer :score
      t.boolean :passed, default: false
      t.json :failed_commands, default: []
      t.datetime :retry_locked_until

      t.timestamps
    end

    add_index :lab_attempts, [:user_id, :hands_on_lab_id]
    add_index :lab_attempts, :created_at

    # Add lab tracking columns to hands_on_labs
    add_column :hands_on_labs, :commands_tested, :json, default: []
    add_column :hands_on_labs, :pass_threshold, :integer, default: 70
    add_column :hands_on_labs, :stability_multiplier, :decimal, precision: 4, scale: 2, default: 1.5
  end
end
