# app/controllers/interests_controller.rb
class InterestsController < ApplicationController
  include Authentication
  before_action :authenticate_user! # Ensure the user is logged in

  def mark_interested
    post_id = params[:post_id]
    database = params[:database] || 'default_database' # Adjust as needed

    # Check if the interest already exists
    existing_interest = @current_user.interests.find_by(post_id: post_id, database: database)

    if existing_interest
      render json: { success: false, message: 'You have already marked this post as interested.' }, status: :unprocessable_entity
    else
      # Create a new interest
      interest = @current_user.interests.build(post_id: post_id, database: database)

      if interest.save
        http = Net::HTTP.new('localhost', 8080)
        post_url = url(post_id, database)
        puts "Marking as interested: #{post_url}"
        request = Net::HTTP::Get.new("/get-learning-objectives?articleContent=#{post_url}")
        response = http.request(request)
        puts response.body
        render json: { success: true, message: 'Post marked as interested.' }, status: :ok
      else
        render json: { success: false, message: 'Failed to mark post as interested.' }, status: :unprocessable_entity
      end
    end
  end


  def unmark_interested 
    post_id = params[:post_id]
    database = params[:database] || 'default_database'

    interest = @current_user.interests.find_by(post_id: post_id, database: database)

    if interest
      interest.destroy
      render json: { success: true, message: 'Interest removed.' }, status: :ok
    else
      render json: { success: false, message: 'Interest not found.' }, status: :not_found
    end
  end

  private
  def url(post_id, database)
    if database == 'stackoverflow'
      "https://stackoverflow.com/questions/#{post_id}"
    else
      "https://#{database}/questions/#{post_id}"
    end
  end
end
