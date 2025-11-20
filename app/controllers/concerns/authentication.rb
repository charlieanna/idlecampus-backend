require 'pp'
module Authentication
  def authenticate_user!
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      Rails.logger.info "🔍 Session user_id: #{session[:user_id]}, Current user: #{@current_user&.email}"
    else
      Rails.logger.info "🔍 No session user_id found"
      redirect_to new_session_path, alert: "Please sign in to access this page."
      return
    end
  end
end