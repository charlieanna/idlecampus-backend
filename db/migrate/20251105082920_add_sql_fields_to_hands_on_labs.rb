class AddSqlFieldsToHandsOnLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :hands_on_labs, :schema_setup, :text unless column_exists?(:hands_on_labs, :schema_setup)
    add_column :hands_on_labs, :sample_data, :text unless column_exists?(:hands_on_labs, :sample_data)
    add_column :hands_on_labs, :hints, :json unless column_exists?(:hands_on_labs, :hints)
  end
end
