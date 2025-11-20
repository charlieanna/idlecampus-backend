# frozen_string_literal: true

module Upsc
  class NewsArticle < ApplicationRecord
    self.table_name = 'upsc_news_articles'

    # Associations
    belongs_to :created_by, class_name: 'User', optional: true

    # Validations
    validates :title, presence: true
    validates :slug, presence: true, uniqueness: true
    validates :full_content, presence: true
    validates :published_date, presence: true
    validates :importance_level, inclusion: { in: %w[low medium high critical] }, allow_nil: true

    # Callbacks
    before_validation :generate_slug, on: :create

    # Scopes
    scope :published, -> { where(status: 'published') }
    scope :featured, -> { where(is_featured: true) }
    scope :recent, -> { order(published_date: :desc) }
    scope :by_category, ->(category) { where('? = ANY(categories)', category) }
    scope :by_date_range, ->(start_date, end_date) { where(published_date: start_date..end_date) }
    scope :high_relevance, -> { where('relevance_score >= ?', 70) }

    # Class methods
    def self.daily_news(date = Date.current)
      where(published_date: date).published.order(relevance_score: :desc)
    end

    def self.weekly_roundup(weeks_ago = 0)
      start_date = weeks_ago.weeks.ago.beginning_of_week
      end_date = weeks_ago.weeks.ago.end_of_week
      by_date_range(start_date, end_date).published.order(relevance_score: :desc)
    end

    # Instance methods
    def related_topics
      return [] unless related_topic_ids.present?
      Upsc::Topic.where(id: related_topic_ids)
    end

    def related_subjects
      return [] unless related_subject_ids.present?
      Upsc::Subject.where(id: related_subject_ids)
    end

    def increment_view_count
      increment!(:view_count)
    end

    def increment_like_count
      increment!(:like_count)
    end

    private

    def generate_slug
      self.slug = title.parameterize if title.present? && slug.blank?
    end
  end
end
