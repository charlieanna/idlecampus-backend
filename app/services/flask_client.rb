require 'httparty'
require 'securerandom'

class FlaskClient
  include HTTParty
  
  BASE_URL = ENV['FLASK_SERVICE_URL'] || 'http://localhost:5001'
  API_TOKEN = ENV['FLASK_API_TOKEN'] || 'dev-token-change-in-production'
  
  # ============================================
  # Adaptive Testing Endpoints
  # ============================================
  
  def self.get_next_question(user_id:, context:)
    # Get next adaptive question for user
    #
    # Context:
    #   - course_id: int
    #   - module_id: int
    #   - skill_dimension: str (e.g., "k8s_basics")
    #   - recent_topics: array of strings
    #   - target_difficulty: float (optional)
    #
    # Returns:
    #   {
    #     question: { id, text, question_type, topic, difficulty },
    #     reason: string,
    #     difficulty_match: float
    #   }
    post('/api/v1/adaptive/next_question', {
      user_id: user_id,
      context: context
    })
  end
  
  def self.submit_answer(user_id:, question_id:, answer:, correct:, time_taken:)
    # Submit quiz answer and update ability
    #
    # Returns:
    #   {
    #     ability_update: { new_ability, confidence },
    #     feedback: { level_1, explanation },
    #     next_difficulty: float
    #   }
    post('/api/v1/adaptive/submit_answer', {
      user_id: user_id,
      question_id: question_id,
      answer: answer,
      correct: correct,
      time_taken: time_taken
    })
  end
  
  def self.get_ability_estimate(user_id:, skill_dimension: 'overall')
    # Get current ability estimate for user in dimension
    get("/api/v1/adaptive/ability/#{user_id}?dimension=#{skill_dimension}")
  end
  
  # ============================================
  # Analytics Endpoints
  # ============================================
  
  def self.get_user_analytics(user_id:)
    # Get comprehensive analytics for user
    #
    # Returns:
    #   {
    #     skill_radar: hash,
    #     weak_areas: array,
    #     recommendations: array
    #   }
    get("/api/v1/analytics/user/#{user_id}")
  end
  
  def self.get_progress_visualization(user_id:, time_range: 30)
    # Get progress timeline data
    get("/api/v1/progress/visualization/#{user_id}?days=#{time_range}")
  end
  
  def self.get_dashboard_data(user_id:)
    # Get complete dashboard data in one call
    get("/api/v1/dashboard/#{user_id}")
  end
  
  # ============================================
  # Weakness Detection Endpoints
  # ============================================
  
  def self.get_weaknesses(user_id:)
    # Analyze weaknesses for user
    #
    # Returns:
    #   {
    #     weaknesses: [{ dimension, topic, severity, error_count }],
    #     recommendations: [{ type, content_id, reason }]
    #   }
    get("/api/v1/weakness/analyze/#{user_id}")
  end
  
  def self.get_remediation_plan(user_id:, weakness:)
    # Get targeted remediation plan for weakness
    post('/api/v1/weakness/remediation', {
      user_id: user_id,
      weakness: weakness
    })
  end
  
  # ============================================
  # FSRS Spaced Repetition Endpoints
  # ============================================
  
  def self.calculate_next_review(item_data:, performance:)
    # Calculate next review using FSRS
    #
    # Performance grades: 1=Again, 2=Hard, 3=Good, 4=Easy
    #
    # Returns:
    #   {
    #     next_review_at: datetime,
    #     interval_days: int,
    #     stability: float,
    #     difficulty: float
    #   }
    post('/api/v1/fsrs/calculate', {
      item: item_data,
      performance: performance
    })
  end
  
  def self.get_items_due(user_id:)
    # Get spaced repetition items due for review
    get("/api/v1/fsrs/due/#{user_id}")
  end
  
  # ============================================
  # Lab Performance Tracking
  # ============================================
  
  def self.update_lab_completion(user_id:, lab_id:, performance:)
    # Update skill profile after lab completion
    post('/api/v1/labs/complete', {
      user_id: user_id,
      lab_id: lab_id,
      performance: performance
    })
  end
  
  # ============================================
  # Private HTTP Methods
  # ============================================
  
  private
  
  def self.get(path, options = {})
    url = "#{BASE_URL}#{path}"
    start_time = Time.current
    
    response = HTTParty.get(url, {
      headers: auth_headers,
      timeout: options[:timeout] || 10
    })
    
    duration_ms = ((Time.current - start_time) * 1000).round(2)
    
    StructuredLogger.log_api_call(
      service: 'flask',
      endpoint: path,
      duration_ms: duration_ms,
      success: response.success?
    )
    
    handle_response(response, path)
  rescue HTTParty::Error, Timeout::Error, Errno::ECONNREFUSED => e
    duration_ms = ((Time.current - start_time) * 1000).round(2)
    
    StructuredLogger.log_api_call(
      service: 'flask',
      endpoint: path,
      duration_ms: duration_ms,
      success: false,
      error: e.message
    )
    
    handle_error(e, 'GET', path)
  end
  
  def self.post(path, body, options = {})
    url = "#{BASE_URL}#{path}"
    start_time = Time.current
    
    response = HTTParty.post(url, {
      body: body.to_json,
      headers: auth_headers.merge('Content-Type' => 'application/json'),
      timeout: options[:timeout] || 10
    })
    
    duration_ms = ((Time.current - start_time) * 1000).round(2)
    
    StructuredLogger.log_api_call(
      service: 'flask',
      endpoint: path,
      duration_ms: duration_ms,
      success: response.success?
    )
    
    handle_response(response, path)
  rescue HTTParty::Error, Timeout::Error, Errno::ECONNREFUSED => e
    duration_ms = ((Time.current - start_time) * 1000).round(2)
    
    StructuredLogger.log_api_call(
      service: 'flask',
      endpoint: path,
      duration_ms: duration_ms,
      success: false,
      error: e.message
    )
    
    handle_error(e, 'POST', path)
  end
  
  def self.auth_headers
    {
      'Authorization' => "Bearer #{API_TOKEN}",
      'X-Request-ID' => Thread.current[:trace_id] || SecureRandom.uuid,
      'X-Trace-ID' => Thread.current[:trace_id] || SecureRandom.uuid,
      'X-Service' => 'rails-app'
    }
  end
  
  def self.handle_response(response, path)
    if response.success?
      JSON.parse(response.body) rescue response.body
    else
      Rails.logger.error("Flask API Error: #{response.code} - #{path}")
      { 
        error: "Flask service returned #{response.code}",
        details: response.body,
        fallback: true
      }
    end
  end
  
  def self.handle_error(error, method, path)
    Rails.logger.error("Flask API #{method} #{path} failed: #{error.message}")
    Rails.logger.error(error.backtrace.first(5).join("\n"))
    
    {
      error: error.message,
      service: 'flask',
      fallback: true
    }
  end
  
  # ============================================
  # Fallback/Stub Methods (when Flask is unavailable)
  # ============================================
  
  def self.use_fallback?
    # Check if Flask service is available
    !flask_available?
  end
  
  def self.flask_available?
    return @flask_available if defined?(@flask_available)
    
    begin
      response = HTTParty.get("#{BASE_URL}/health", timeout: 2)
      @flask_available = response.success?
    rescue
      @flask_available = false
    end
    
    @flask_available
  end
  
  def self.reset_availability_check
    remove_instance_variable(:@flask_available) if defined?(@flask_available)
  end
end

