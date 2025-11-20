class AddChaptersAtMasteryToUserCommandMasteries < ActiveRecord::Migration[6.0]
  def change
    add_column :user_command_masteries, :chapters_at_mastery, :integer
    add_column :user_command_masteries, :learning_path_position, :integer
    add_column :user_command_masteries, :stability, :decimal, precision: 6, scale: 2, default: 7.0

    add_index :user_command_masteries, :chapters_at_mastery
    add_index :user_command_masteries, :learning_path_position
  end
end
