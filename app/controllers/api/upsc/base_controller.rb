# frozen_string_literal: true

module Api
  module Upsc
    class BaseController < ApplicationController
      # Skip CSRF for API requests
      skip_before_action :verify_authenticity_token

      # Authentication (assuming you have devise or similar)
      # before_action :authenticate_user!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
      rescue_from ActionController::ParameterMissing, with: :bad_request

      private

      def render_success(data = {}, message = 'Success', status = :ok)
        render json: {
          success: true,
          message: message,
          data: data
        }, status: status
      end

      def render_error(message = 'Error occurred', errors = [], status = :unprocessable_entity)
        render json: {
          success: false,
          message: message,
          errors: errors
        }, status: status
      end

      def not_found(exception)
        render_error('Resource not found', [exception.message], :not_found)
      end

      def unprocessable_entity(exception)
        render_error('Validation failed', exception.record.errors.full_messages, :unprocessable_entity)
      end

      def bad_request(exception)
        render_error('Bad request', [exception.message], :bad_request)
      end

      def pagination_meta(collection)
        {
          current_page: collection.current_page,
          total_pages: collection.total_pages,
          total_count: collection.total_count,
          per_page: collection.limit_value
        }
      end

      def current_user
        # Override this with your authentication logic
        # For now, return first user or nil
        @current_user ||= User.first
      end

      def cors_preflight
        head :ok
      end
    end
  end
end
