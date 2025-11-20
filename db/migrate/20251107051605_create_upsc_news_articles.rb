class CreateUpscNewsArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :upsc_news_articles do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary
      t.text :full_content, null: false
      t.string :source
      t.string :source_url
      t.string :author
      t.date :published_date, null: false
      t.text :categories, array: true, default: []
      t.text :tags, array: true, default: []
      t.integer :relevance_score, default: 50
      t.string :importance_level
      t.boolean :is_featured, default: false
      t.string :image_url
      t.bigint :related_topic_ids, array: true, default: []
      t.bigint :related_subject_ids, array: true, default: []
      t.text :exam_perspective
      t.text :key_points, array: true, default: []
      t.integer :view_count, default: 0
      t.integer :like_count, default: 0
      t.string :status, default: 'published'
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :upsc_news_articles, :slug, unique: true
    add_index :upsc_news_articles, :published_date
    add_index :upsc_news_articles, :categories, using: :gin
    add_index :upsc_news_articles, :tags, using: :gin
    add_index :upsc_news_articles, :is_featured
  end
end
