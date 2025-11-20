# frozen_string_literal: true

# AdaptiveLearningClient
# HTTP client for communicating with Flask ML microservice
# Provides methods to call IRT, Adaptive Learning, and Learning Path services
class AdaptiveLearningClient
  include HTTParty

  base_uri ENV.fetch('FLASK_ML_SERVICE_URL', 'http://localhost:5000')
  
  # Default timeout for HTTP requests
  default_timeout 10
  
  # Custom exceptions
  class BadRequestError < StandardError; end
  class ServerError < StandardError; end
  class TimeoutError < StandardError; end
  class NetworkError < StandardError; end

  def initialize
    @headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
      'User-Agent' => 'Rails-AdaptiveLearning/1.0'
    }
  end

  # === LEARNING PATH OPTIMIZATION ===

  def generate_learning_path(learner_id, goals, options = {})
    payload = {
      learner_id: learner_id,
      learning_goals: goals,
      constraints: options[:constraints],
      preferences: options[:preferences]
    }

    Rails.logger.info "Generating learning path for learner #{learner_id} with goals: #{goals}"

    response = self.class.post('/api/learning_path/generate',
      body: payload.to_json,
      headers: @headers,
      timeout: 10
    )

    handle_response(response, 'generate_learning_path')
  end

  def refine_learning_path(learner_id, current_path, position, performance_data)
    payload = {
      learner_id: learner_id,
      current_path: current_path,
      current_position: position,
      performance_data: performance_data
    }

    Rails.logger.debug "Refining learning path for learner #{learner_id} at position #{position}"

    response = self.class.post('/api/learning_path/refine',
      body: payload.to_json,
      headers: @headers,
      timeout: 5
    )

    handle_response(response, 'refine_learning_path')
  end

  def get_learning_recommendations(learner_id, current_path, goals = [])
    payload = {
      learner_id: learner_id,
      current_path: current_path,
      learning_goals: goals
    }

    response = self.class.post('/api/learning_path/recommendations',
      body: payload.to_json,
      headers: @headers,
      timeout: 5
    )

    handle_response(response, 'get_learning_recommendations')
  end

  # === IRT ADAPTIVE TESTING ===

  def estimate_ability(learner_id, response_data)
    payload = {
      learner_id: learner_id,
      responses: response_data
    }

    response = self.class.post('/api/irt/estimate_ability',
      body: payload.to_json,
      headers: @headers,
      timeout: 5
    )

    handle_response(response, 'estimate_ability')
  end

  def select_next_item(learner_id, content_pool, constraints = {})
    payload = {
      learner_id: learner_id,
      available_items: content_pool,
      constraints: constraints
    }

    response = self.class.post('/api/irt/select_item',
      body: payload.to_json,
      headers: @headers,
      timeout: 3
    )

    handle_response(response, 'select_next_item')
  end

  def analyze_item_performance(item_responses)
    payload = {
      item_responses: item_responses
    }

    response = self.class.post('/api/irt/analyze_performance',
      body: payload.to_json,
      headers: @headers,
      timeout: 8
    )

    handle_response(response, 'analyze_item_performance')
  end

  # === FSRS SPACED REPETITION ===

  # === ADAPTIVE LEARNING ===

  def get_adaptive_recommendation(learner_id, learning_context = {})
    payload = {
      learner_id: learner_id,
      context: learning_context
    }

    response = self.class.post('/api/adaptive/recommend',
      body: payload.to_json,
      headers: @headers,
      timeout: 5
    )

    handle_response(response, 'get_adaptive_recommendation')
  end

  def update_learner_profile(learner_id, profile_updates)
    payload = {
      learner_id: learner_id,
      updates: profile_updates
    }

    response = self.class.post('/api/adaptive/update_profile',
      body: payload.to_json,
      headers: @headers,
      timeout: 3
    )

    handle_response(response, 'update_learner_profile')
  end

  def predict_learning_outcome(learner_id, proposed_path)
    payload = {
      learner_id: learner_id,
      learning_path: proposed_path
    }

    response = self.class.post('/api/adaptive/predict_outcome',
      body: payload.to_json,
      headers: @headers,
      timeout: 8
    )

    handle_response(response, 'predict_learning_outcome')
  end

  # === HEALTH AND STATUS ===

  def health_check
    response = self.class.get('/api/health',
      headers: @headers,
      timeout: 3
    )

    handle_response(response, 'health_check')
  end

  def service_status
    response = self.class.get('/api/learning_path/health',
      headers: @headers,
      timeout: 3
    )

    handle_response(response, 'service_status')
  end

  def get_graph_stats
    response = self.class.get('/api/learning_path/graph/stats',
      headers: @headers,
      timeout: 5
    )

    handle_response(response, 'get_graph_stats')
  end

  private

  def handle_response(response, method_name)
    case response.code
    when 200, 201
      parse_response_body(response.body)
    when 400
      error_msg = "Bad request in #{method_name}: #{extract_error_message(response.body)}"
      Rails.logger.warn error_msg
      raise BadRequestError, error_msg
    when 404
      error_msg = "Resource not found in #{method_name}"
      Rails.logger.warn error_msg
      raise BadRequestError, error_msg
    when 422
      error_msg = "Unprocessable entity in #{method_name}: #{extract_error_message(response.body)}"
      Rails.logger.warn error_msg
      raise BadRequestError, error_msg
    when 500
      error_msg = "Server error in #{method_name}: #{extract_error_message(response.body)}"
      Rails.logger.error error_msg
      raise ServerError, error_msg
    when 502, 503, 504
      error_msg = "Service unavailable in #{method_name} (HTTP #{response.code})"
      Rails.logger.error error_msg
      raise NetworkError, error_msg
    else
      error_msg = "Unexpected response in #{method_name}: #{response.code} - #{response.body}"
      Rails.logger.error error_msg
      raise NetworkError, error_msg
    end
  rescue Net::TimeoutError, HTTParty::Error => e
    error_msg = "Network timeout/error in #{method_name}: #{e.message}"
    Rails.logger.error error_msg
    raise TimeoutError, error_msg
  end

  def parse_response_body(body)
    return {} if body.blank?

    JSON.parse(body, symbolize_names: true)
  rescue JSON::ParserError => e
    Rails.logger.error "Failed to parse JSON response: #{e.message}, Body: #{body}"
    { error: 'Invalid JSON response from ML service' }
  end

  def extract_error_message(body)
    parsed = JSON.parse(body, symbolize_names: true)
    parsed[:error] || parsed[:message] || 'Unknown error'
  rescue JSON::ParserError
    body.truncate(200)
  end
end
