class AddResultDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :result_data, :jsonb
  end
end
