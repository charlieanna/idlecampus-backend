class AddTestCasesToSolutions < ActiveRecord::Migration[6.0]
  def change
    add_column :solutions, :test_cases, :string
  end
end
