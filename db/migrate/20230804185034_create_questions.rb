class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :difficulty
      t.string :url_link
      t.boolean :solved
      t.date :solved_date
      t.integer :confidence_level
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
