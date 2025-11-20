class AddDiagnosticFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :diagnostic_completed, :boolean, default: false
    add_column :users, :diagnostic_skill_level, :string
    add_column :users, :diagnostic_score, :float
    
    add_index :users, :diagnostic_skill_level
  end
end
