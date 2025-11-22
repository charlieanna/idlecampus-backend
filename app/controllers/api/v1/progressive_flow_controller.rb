module Api
  module V1
    class ProgressiveFlowController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user
      
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { success: false, error: e.message }, status: :not_found
      end
      
      rescue_from ActiveRecord::RecordInvalid do |e|
        render json: { success: false, error: e.record.errors.full_messages }, status: :unprocessable_entity
      end
      
      private
      
      def set_user
        @user = params[:user_id] ? User.find(params[:user_id]) : current_user
      end
      
      def render_success(data = {}, message = nil)
        response = { success: true }
        response[:message] = message if message
        response[:data] = data
        render json: response
      end
      
      def render_error(error, status = :unprocessable_entity)
        render json: { success: false, error: error }, status: status
      end
    end
  end
end