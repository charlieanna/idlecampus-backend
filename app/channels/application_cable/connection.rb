module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      # Try to find user from session
      user_id = request.session['user_id'] || request.session[:user_id]
      
      if user_id && (verified_user = User.find_by(id: user_id))
        verified_user
      else
        # Try to find from cookies (for persistent sessions)
        if request.cookies['user_id']
          verified_user = User.find_by(id: request.cookies['user_id'])
          return verified_user if verified_user
        end
        
        # For development, allow anonymous connections
        if Rails.env.development?
          logger.add_tags 'ActionCable', 'Anonymous'
          return OpenStruct.new(id: 'anonymous', email: 'anonymous@example.com')
        end
        
        reject_unauthorized_connection
      end
    end
  end
end
