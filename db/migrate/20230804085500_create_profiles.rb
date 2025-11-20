class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :email
      t.string :name
    end
  end
end
