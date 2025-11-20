class AddPolymorphicToSpacedRepetitionItems < ActiveRecord::Migration[6.0]
  def change
    # Add polymorphic columns
    add_column :spaced_repetition_items, :item_type, :string unless column_exists?(:spaced_repetition_items, :item_type)
    add_column :spaced_repetition_items, :item_id, :integer unless column_exists?(:spaced_repetition_items, :item_id)
    
    # Add FSRS-specific columns
    add_column :spaced_repetition_items, :difficulty, :float, default: 4.93 unless column_exists?(:spaced_repetition_items, :difficulty)
    add_column :spaced_repetition_items, :stability, :float, default: 2.4 unless column_exists?(:spaced_repetition_items, :stability)
    add_column :spaced_repetition_items, :review_count, :integer, default: 0 unless column_exists?(:spaced_repetition_items, :review_count)
    add_column :spaced_repetition_items, :lapse_count, :integer, default: 0 unless column_exists?(:spaced_repetition_items, :lapse_count)
    add_column :spaced_repetition_items, :last_review_grade, :integer unless column_exists?(:spaced_repetition_items, :last_review_grade)
    
    # Add indexes
    add_index :spaced_repetition_items, [:item_type, :item_id] unless index_exists?(:spaced_repetition_items, [:item_type, :item_id])
    add_index :spaced_repetition_items, [:user_id, :item_type, :item_id], unique: true, name: 'index_sri_on_user_item' unless index_exists?(:spaced_repetition_items, [:user_id, :item_type, :item_id], name: 'index_sri_on_user_item')
    
    # Migrate existing data from coding_problem_id to polymorphic
    if column_exists?(:spaced_repetition_items, :coding_problem_id)
      reversible do |dir|
        dir.up do
          execute <<-SQL
            UPDATE spaced_repetition_items 
            SET item_type = 'CodingProblem', item_id = coding_problem_id 
            WHERE coding_problem_id IS NOT NULL AND item_type IS NULL
          SQL
        end
      end
    end
  end
end