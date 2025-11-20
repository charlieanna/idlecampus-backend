require 'net/http'
require 'uri'
require 'json'
require 'pp'
require "set"

class DashboardController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :load_current_user
  before_action :set_user_and_profile, if: -> { session[:user_id] }
  
  def show
    @courses = Course.where(published: true).order(:sequence_order)
    if @current_user
      @enrollments = @current_user.course_enrollments.where(course: @courses).index_by(&:course_id)
    end

    # Organize courses by category
    @iit_jee_courses = @courses.select { |c| c.slug.include?('iit-jee') }
    @tech_courses = @courses.reject { |c| c.slug.include?('iit-jee') }
  end

  private

  def load_current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      Rails.logger.info "🔍 Dashboard - Session user_id: #{session[:user_id]}, Current user: #{@current_user&.name}"
    end
  end

  def set_user_and_profile
    return unless @current_user
    @profile = Profile.find_or_create_by(user_id: @current_user.id)
  end

end
