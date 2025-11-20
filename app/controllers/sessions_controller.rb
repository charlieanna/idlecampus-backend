class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :failure]

  def new
    # Show login form
  end

  def create
    # Only handle OAuth callback from Google
    if request.env['omniauth.auth']
      handle_oauth_login
    else
      redirect_to new_session_path, alert: "Please sign in with Google"
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to root_path, notice: "Successfully logged out"
  end

  def failure
    error_message = params[:message] || "Authentication failed"
    Rails.logger.error "OAuth Failure: #{error_message}"
    Rails.logger.error "Origin: #{params[:origin]}"
    Rails.logger.error "Strategy: #{params[:strategy]}"
    
    flash[:alert] = "Google authentication failed: #{error_message}. Please try again."
    redirect_to new_session_path
  end

  private

  def handle_oauth_login
    auth = request.env['omniauth.auth']
    
    # Extract user info from Google OAuth
    email = auth['info']['email']
    name = auth['info']['name']
    google_uid = auth['uid']
    
    # Log for debugging
    Rails.logger.info "🔐 OAuth Login - Email: #{email}, Name: #{name}, Google UID: #{google_uid}"
    
    # Find or create user with Google data
    user = User.find_or_create_by(google_id: google_uid) do |u|
      u.email = email
      u.name = name
      u.provider = 'google'
    end
    
    # Update name and email if they changed
    if user.name != name || user.email != email
      user.update(name: name, email: email)
    end
    
    session[:user_id] = user.id
    Rails.logger.info "✅ Session set - user_id: #{user.id}, email: #{user.email}"
    
    redirect_to root_path, notice: "Successfully logged in with Google!"
  end
end
