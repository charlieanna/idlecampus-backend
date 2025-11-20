# db/migrate/20240101123456_recreate_interests_table.rb

class RecreateInterestsTable < ActiveRecord::Migration[6.0]
  def up
    # Drop the interests table if it exists
    if table_exists?(:interests)
      drop_table :interests
    end

    # Recreate the interests table
    create_table :interests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :post_id, null: false
      t.string :database, null: false

      t.timestamps
    end

    # Add a unique index to prevent duplicate interests
    add_index :interests, [:user_id, :post_id, :database], unique: true, name: 'index_interests_on_user_id_and_post_id_and_database'
  end

  def down
    # Drop the interests table to revert the migration
    drop_table :interests
  end
end
