class AddCodeEditorFieldsToHandsOnLabs < ActiveRecord::Migration[6.0]
  def change
    # Lab format: 'terminal', 'code_editor', or 'hybrid'
    add_column :hands_on_labs, :lab_format, :string, default: 'terminal'

    # Programming language for code editor labs
    add_column :hands_on_labs, :programming_language, :string

    # Initial code shown in the editor
    add_column :hands_on_labs, :starter_code, :text

    # Test cases with inputs and expected outputs
    add_column :hands_on_labs, :test_cases, :jsonb, default: []

    # Custom validation script if needed
    add_column :hands_on_labs, :validation_script, :text

    # For multi-file projects
    add_column :hands_on_labs, :file_structure, :jsonb, default: {}

    # Solution code (hidden from users)
    add_column :hands_on_labs, :solution_code, :text

    # Whitelist of allowed imports/libraries
    add_column :hands_on_labs, :allowed_imports, :jsonb, default: []

    # Execution limits
    add_column :hands_on_labs, :time_limit_seconds, :integer, default: 5
    add_column :hands_on_labs, :memory_limit_mb, :integer, default: 128

    # Add index for querying by lab format
    add_index :hands_on_labs, :lab_format
    add_index :hands_on_labs, :programming_language
  end
end
