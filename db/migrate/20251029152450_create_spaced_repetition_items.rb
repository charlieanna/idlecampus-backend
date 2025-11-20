class CreateSpacedRepetitionItems < ActiveRecord::Migration[6.0]
  def change
    return if table_exists?(:spaced_repetition_items)
    
    create_table :spaced_repetition_items do |t|
      t.integer :user_id, null: false
      t.integer :coding_problem_id
      t.datetime :next_review_at, null: false
      t.integer :interval_days, default: 1
      t.integer :ease_factor, default: 250
      t.string :state, default: 'new'
      
      t.timestamps
    end
    
    add_index :spaced_repetition_items, :user_id
    add_index :spaced_repetition_items, :coding_problem_id
    add_index :spaced_repetition_items, :next_review_at
    add_index :spaced_repetition_items, [:user_id, :coding_problem_id], unique: true,
              name: 'index_sri_on_user_and_problem'
  end
end

