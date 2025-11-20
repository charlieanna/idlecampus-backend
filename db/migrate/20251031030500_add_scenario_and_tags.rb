class AddScenarioAndTags < ActiveRecord::Migration[6.0]
  def change
    if table_exists?(:interactive_learning_units)
      add_column :interactive_learning_units, :scenario_narrative, :text unless column_exists?(:interactive_learning_units, :scenario_narrative)
      add_column :interactive_learning_units, :problem_statement, :text unless column_exists?(:interactive_learning_units, :problem_statement)
      add_column :interactive_learning_units, :concept_tags, :json, default: [] unless column_exists?(:interactive_learning_units, :concept_tags)
    end

    if table_exists?(:hands_on_labs)
      change_table :hands_on_labs do |t|
        t.text :scenario_narrative unless column_exists?(:hands_on_labs, :scenario_narrative)
        t.json :concept_tags, default: [] unless column_exists?(:hands_on_labs, :concept_tags)
      end
    end
  end
end


