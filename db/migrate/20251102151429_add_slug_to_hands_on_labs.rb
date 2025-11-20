class AddSlugToHandsOnLabs < ActiveRecord::Migration[6.0]
  def change
    add_column :hands_on_labs, :slug, :string
  end
end
