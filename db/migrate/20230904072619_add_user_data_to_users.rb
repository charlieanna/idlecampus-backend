class AddUserDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :user_data, :jsonb
  end
end
