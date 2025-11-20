class AddProgressiveMasteryToUserCommandMasteries < ActiveRecord::Migration[6.0]
  def change
    add_column :user_command_masteries, :consecutive_successes, :integer, default: 0
    add_column :user_command_masteries, :consecutive_failures, :integer, default: 0
    add_column :user_command_masteries, :saw_answer_last, :boolean, default: false
    add_column :user_command_masteries, :hints_used_last, :integer, default: 0
  end
end
