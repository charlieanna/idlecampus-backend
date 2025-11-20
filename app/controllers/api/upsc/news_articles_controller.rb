# frozen_string_literal: true

module Api
  module Upsc
    class NewsArticlesController < BaseController
      before_action :set_news_article, only: [:show, :update, :destroy]

      # GET /api/upsc/news_articles
      def index
        @articles = ::Upsc::NewsArticle.all

        # Filter by topic
        @articles = @articles.where(upsc_topic_id: params[:topic_id]) if params[:topic_id].present?

        # Filter by category
        @articles = @articles.where(category: params[:category]) if params[:category].present?

        # Filter by importance
        @articles = @articles.where(importance: params[:importance]) if params[:importance].present?

        # Filter by date range
        if params[:from_date].present?
          @articles = @articles.where('published_date >= ?', params[:from_date])
        end

        if params[:to_date].present?
          @articles = @articles.where('published_date <= ?', params[:to_date])
        end

        # Filter by tags
        if params[:tags].present?
          tags = params[:tags].split(',')
          @articles = @articles.where('tags && ARRAY[?]::varchar[]', tags)
        end

        @articles = @articles.order(published_date: :desc)

        # Pagination
        page = params[:page] || 1
        per_page = params[:per_page] || 20
        @articles = @articles.page(page).per(per_page)

        render_success({
          news_articles: @articles.as_json(
            include: { topic: { only: [:id, :name, :slug] } }
          ),
          meta: pagination_meta(@articles)
        })
      end

      # GET /api/upsc/news_articles/:id
      def show
        render_success({
          news_article: @news_article.as_json(
            include: {
              topic: { only: [:id, :name, :slug] },
              related_articles: { only: [:id, :title, :published_date, :importance] }
            }
          )
        })
      end

      # POST /api/upsc/news_articles
      def create
        @news_article = ::Upsc::NewsArticle.new(news_article_params)

        if @news_article.save
          render_success({ news_article: @news_article }, 'News article created successfully', :created)
        else
          render_error('Failed to create news article', @news_article.errors.full_messages)
        end
      end

      # PATCH/PUT /api/upsc/news_articles/:id
      def update
        if @news_article.update(news_article_params)
          render_success({ news_article: @news_article }, 'News article updated successfully')
        else
          render_error('Failed to update news article', @news_article.errors.full_messages)
        end
      end

      # DELETE /api/upsc/news_articles/:id
      def destroy
        @news_article.destroy
        render_success({}, 'News article deleted successfully')
      end

      # GET /api/upsc/news_articles/today
      def today
        @articles = ::Upsc::NewsArticle.where(published_date: Date.current)
          .order(importance: :desc)

        render_success({ news_articles: @articles })
      end

      # GET /api/upsc/news_articles/this_week
      def this_week
        @articles = ::Upsc::NewsArticle.where('published_date >= ?', 1.week.ago)
          .order(published_date: :desc, importance: :desc)

        render_success({ news_articles: @articles })
      end

      # GET /api/upsc/news_articles/important
      def important
        @articles = ::Upsc::NewsArticle.where(importance: 'high')
          .where('published_date >= ?', 1.month.ago)
          .order(published_date: :desc)

        render_success({ news_articles: @articles })
      end

      # GET /api/upsc/news_articles/categories
      def categories
        categories = ::Upsc::NewsArticle.distinct.pluck(:category).compact

        render_success({ categories: categories })
      end

      private

      def set_news_article
        @news_article = ::Upsc::NewsArticle.find(params[:id])
      end

      def news_article_params
        params.require(:news_article).permit(
          :upsc_topic_id, :title, :summary, :content, :source_name,
          :source_url, :published_date, :category, :importance,
          :image_url, :exam_relevance_notes,
          tags: [], key_points: [], related_topics: []
        )
      end
    end
  end
end
