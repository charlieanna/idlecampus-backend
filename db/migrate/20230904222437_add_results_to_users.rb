class AddResultsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :results, :jsonb
  end
end
