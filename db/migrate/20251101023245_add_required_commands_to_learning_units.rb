class AddRequiredCommandsToLearningUnits < ActiveRecord::Migration[6.0]
  def change
    # Add required commands to interactive learning units
    add_column :interactive_learning_units, :required_commands, :json, default: []
    
    # Add required commands to hands on labs
    add_column :hands_on_labs, :required_commands, :json, default: []
    
    # Note: JSON columns in SQLite don't support GIN indexes
    # We'll rely on JSON queries for filtering
  end
end
