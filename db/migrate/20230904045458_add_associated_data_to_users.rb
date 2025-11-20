class AddAssociatedDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :associated_data, :jsonb
  end
end
