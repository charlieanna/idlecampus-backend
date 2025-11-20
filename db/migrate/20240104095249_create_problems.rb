class CreateProblems < ActiveRecord::Migration[6.0]
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.text :sample_input
      t.text :sample_output

      t.timestamps
    end
  end
end
