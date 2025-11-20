class AddDecayFieldsToUserCommandMasteries < ActiveRecord::Migration[6.0]
  def change
    # Only add columns that don't already exist
    unless column_exists?(:user_command_masteries, :last_decay_applied_at)
      add_column :user_command_masteries, :last_decay_applied_at, :datetime
    end
    
    unless column_exists?(:user_command_masteries, :strength_factor)
      add_column :user_command_masteries, :strength_factor, :float
    end
    
    unless column_exists?(:user_command_masteries, :shields_count)
      add_column :user_command_masteries, :shields_count, :integer, default: 0
    end
    
    unless column_exists?(:user_command_masteries, :last_practiced_at)
      add_column :user_command_masteries, :last_practiced_at, :datetime
    end
    
    unless column_exists?(:user_command_masteries, :contexts_seen)
      add_column :user_command_masteries, :contexts_seen, :text
    end
    
    # Add indexes
    unless index_exists?(:user_command_masteries, :last_decay_applied_at)
      add_index :user_command_masteries, :last_decay_applied_at
    end
    
    unless index_exists?(:user_command_masteries, :proficiency_score)
      add_index :user_command_masteries, :proficiency_score
    end
  end
end