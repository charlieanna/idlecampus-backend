class ApplicationController < ActionController::Base
  include Authentication
  
  before_action :set_current_site
  before_action :authenticate_user!

  helper_method :current_site, :site_display_name, :current_user

  def current_user
    @current_user
  end

  private

  def set_current_site
    # Priority: params > session > default
    @current_site = params[:site] || session[:selected_site] || 'docker'

    # Store in session for persistence
    session[:selected_site] = @current_site if params[:site].present?
  end

  def current_site
    @current_site
  end

  def site_display_name
    site_names = {
      'docker' => 'Docker & Kubernetes',
      'networkengineering' => 'Network Engineering',
      'math' => 'Mathematics',
      'stackoverflow' => 'Stack Overflow',
      'unix' => 'Unix & Linux',
      'datascience' => 'Data Science',
      'stats' => 'Cross Validated',
      'dba' => 'Database Administrators',
      'cs' => 'Computer Science',
      'softwareengineering' => 'Software Engineering',
      'devops' => 'DevOps',
      'security' => 'Information Security',
      'serverfault' => 'Server Fault',
      'superuser' => 'Super User'
    }
    site_names[@current_site] || @current_site.capitalize
  end
end
