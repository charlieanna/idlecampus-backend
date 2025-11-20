class CreateDockerCommands < ActiveRecord::Migration[6.0]
  def change
    create_table :docker_commands do |t|
      t.string :command, null: false
      t.text :explanation
      t.string :difficulty, null: false
      t.string :category, null: false
      t.integer :exam_frequency, default: 5
      t.json :variations, default: []
      t.json :flags, default: {}
      t.json :common_options, default: {}
      t.text :use_cases
      t.text :gotchas
      t.string :certification_exam
      t.integer :times_practiced, default: 0
      t.float :average_success_rate, default: 0.0
      t.boolean :is_deprecated, default: false
      t.string :docker_version_min
      t.timestamps
    end

    add_index :docker_commands, :command, unique: true
    add_index :docker_commands, :difficulty
    add_index :docker_commands, :category
    add_index :docker_commands, [:difficulty, :exam_frequency]
    add_index :docker_commands, [:category, :difficulty]
    add_index :docker_commands, :exam_frequency
    add_index :docker_commands, :certification_exam
    add_index :docker_commands, :is_deprecated
  end
end