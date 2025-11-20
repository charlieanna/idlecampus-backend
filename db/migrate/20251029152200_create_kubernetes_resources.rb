class CreateKubernetesResources < ActiveRecord::Migration[6.0]
  def change
    create_table :kubernetes_resources do |t|
      t.string :resource_type, null: false
      t.string :name, null: false
      t.text :yaml_template, null: false
      t.text :explanation
      t.string :difficulty, null: false
      t.string :category, null: false
      t.integer :exam_frequency, default: 5
      t.json :key_fields, default: {}
      t.text :common_errors
      t.string :certification_exam
      t.text :best_practices
      t.json :related_resources, default: []
      t.integer :times_practiced, default: 0
      t.float :average_success_rate, default: 0.0
      t.boolean :is_deprecated, default: false
      t.string :kubernetes_version_min
      t.string :api_version
      t.timestamps
    end

    add_index :kubernetes_resources, :resource_type
    add_index :kubernetes_resources, :name
    add_index :kubernetes_resources, [:resource_type, :name], unique: true
    add_index :kubernetes_resources, :difficulty
    add_index :kubernetes_resources, :category
    add_index :kubernetes_resources, [:difficulty, :exam_frequency]
    add_index :kubernetes_resources, [:category, :difficulty]
    add_index :kubernetes_resources, :exam_frequency
    add_index :kubernetes_resources, :certification_exam
    add_index :kubernetes_resources, :is_deprecated
    add_index :kubernetes_resources, :api_version
  end
end