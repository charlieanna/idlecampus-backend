class CreateSolutions < ActiveRecord::Migration[6.0]
  def change
    create_table :solutions do |t|
      t.integer :user_id
      t.integer :problem_id
      t.string :code
      t.string :status
      t.string :execution_result

      t.timestamps
    end
  end
end
