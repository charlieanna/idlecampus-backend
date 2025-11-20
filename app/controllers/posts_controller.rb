# app/controllers/posts_controller.rb

class PostsController < ApplicationController
  include Authentication
  before_action :authenticate_user! # Ensure the user is logged in

  def show
    @post_id = params[:id]
    @site = current_site

    # Fetch full post details from the Flask API
    @post = fetch_post_details(@site, @post_id)

    if @post.nil?
      flash[:alert] = "Unable to find post with ID #{@post_id}"
      redirect_back(fallback_location: root_path)
    end
  end

  # POST /posts/:id/mark_interested
  def mark_interested
    puts "Marking as interested"
    @post = Post.find_by(id: params[:id], database: params[:database])

    if @post.nil?
      render json: { success: false, message: 'Post not found.' }, status: :not_found
      return
    end

    # Assuming you have a model to track user interests, e.g., Interest
    # Adjust according to your actual models

    interest = current_user.interests.find_or_initialize_by(post: @post)

    if interest.persisted?
      render json: { success: false, message: 'Already marked as interested.' }, status: :unprocessable_entity
      return
    end

    puts "Marking as interested"

    if interest.save
      # do a http get to http://localhost:3001/?articleContent=https://stackoverflow.com/questions/26975880/Convert+map%5Binterface+%7B%7D%5Dinterface+%7B%7D+to+map%5Bstring%5Dstring
      # to get the article content
      # and then save it to the database
      # and then send a notification to the user

      http = Net::HTTP.new('localhost', 3001)
      request = Net::HTTP::Get.new("/?articleContent=#{@post[:url]}")
      response = http.request(request)
      puts response.body
      render json: { success: true }, status: :ok
    else
      render json: { success: false, message: 'Failed to mark as interested.' }, status: :unprocessable_entity
    end
  end

  private

  def fetch_post_details(site, post_id)
    begin
      # Get the post from the unified API
      post = StackexchangeApi.get_post(site, post_id)

      if post && post['id']
        # Enrich with additional data
        post['site'] = site
        post['external_url'] = build_external_url(site, post_id)

        # Parse tags if they're a string
        if post['tags'].is_a?(String)
          post['tags'] = post['tags'].strip.split('|').select(&:present?)
        end

        # Get related posts for the same tags
        if post['tags'] && post['tags'].any?
          post['related_posts'] = fetch_related_posts(site, post['tags'].first, post_id)
        end

        post
      end
    rescue => e
      Rails.logger.error "Error fetching post details: #{e.message}"
      nil
    end
  end

  def fetch_related_posts(site, tag, exclude_id)
    begin
      posts = StackexchangeApi.get_posts(site, tag)
      if posts
        # Get up to 5 related posts, excluding the current one
        posts.reject { |p| p['id'].to_s == exclude_id.to_s }.first(5)
      else
        []
      end
    rescue => e
      Rails.logger.error "Error fetching related posts: #{e.message}"
      []
    end
  end

  def build_external_url(site, post_id)
    if site == 'stackoverflow'
      "https://stackoverflow.com/questions/#{post_id}"
    else
      "https://#{site}.stackexchange.com/questions/#{post_id}"
    end
  end

end
