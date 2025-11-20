class CreateLessons < ActiveRecord::Migration[6.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :content
      t.string :link

      t.timestamps
    end
  end
end
