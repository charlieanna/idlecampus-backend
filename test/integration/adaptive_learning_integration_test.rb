require 'test_helper'
require 'webmock/minitest'

class AdaptiveLearningIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @docker_command = docker_commands(:basic_run)
    @kubernetes_resource = kubernetes_resources(:pod_basic)
    @hands_on_lab = hands_on_labs(:container_basics)
    
    # Mock Flask ML service responses
    setup_flask_mocks
  end

  def teardown
    WebMock.reset!
  end

  test "should get personalized curriculum from Flask service" do
    # Mock Flask response for curriculum generation
    curriculum_response = {
      "curriculum" => [
        {
          "command_id" => @docker_command.id,
          "priority_score" => 0.85,
          "estimated_difficulty" => 0.3,
          "recommended_order" => 1
        }
      ],
      "personalization_factors" => {
        "user_level" => "beginner",
        "focus_areas" => ["basic_commands", "container_lifecycle"]
      }
    }

    stub_request(:post, "http://localhost:5001/api/v1/curriculum/generate")
      .with(
        body: hash_including({
          "user_id" => @user.id.to_s,
          "competencies" => kind_of(Hash),
          "preferences" => kind_of(Hash)
        }),
        headers: { 'Content-Type' => 'application/json' }
      )
      .to_return(
        status: 200,
        body: curriculum_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/generate_curriculum", 
         params: { user_id: @user.id },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_not_nil response_data['curriculum']
    assert_equal 1, response_data['curriculum'].length
    assert_equal @docker_command.id, response_data['curriculum'][0]['command_id']
    assert_equal 0.85, response_data['curriculum'][0]['priority_score']
  end

  test "should assess command difficulty using IRT" do
    # Mock Flask IRT assessment response
    irt_response = {
      "difficulty" => 0.45,
      "discrimination" => 1.2,
      "competency_requirements" => {
        "basic_commands" => 0.4,
        "container_lifecycle" => 0.3
      },
      "expected_performance" => 0.7
    }

    stub_request(:post, "http://localhost:5001/api/v1/irt/assess_item")
      .with(
        body: hash_including({
          "item_id" => @docker_command.id.to_s,
          "item_type" => "docker_command",
          "user_competencies" => kind_of(Hash)
        })
      )
      .to_return(
        status: 200,
        body: irt_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/assess_difficulty",
         params: { 
           command_id: @docker_command.id,
           user_id: @user.id 
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_equal 0.45, response_data['difficulty']
    assert_equal 1.2, response_data['discrimination']
    assert_not_nil response_data['competency_requirements']
  end

  test "should generate optimized learning path" do
    # Mock Flask learning path response
    path_response = {
      "learning_path" => [
        {
          "step" => 1,
          "resource_type" => "docker_command",
          "resource_id" => @docker_command.id,
          "estimated_time" => 15,
          "difficulty" => 0.3,
          "dependencies" => []
        }
      ],
      "total_estimated_time" => 15,
      "path_efficiency" => 0.92,
      "personalization_score" => 0.88
    }

    stub_request(:post, "http://localhost:5001/api/v1/learning_path/generate")
      .with(
        body: hash_including({
          "user_id" => @user.id.to_s,
          "goal_competencies" => kind_of(Hash),
          "current_competencies" => kind_of(Hash),
          "time_constraint" => kind_of(Numeric),
          "preferences" => kind_of(Hash)
        })
      )
      .to_return(
        status: 200,
        body: path_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/generate_path",
         params: {
           user_id: @user.id,
           goal_competencies: {
             "basic_commands" => 0.8,
             "container_lifecycle" => 0.7
           },
           time_constraint: 60
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_not_nil response_data['learning_path']
    assert_equal 1, response_data['learning_path'].length
    assert_equal 15, response_data['total_estimated_time']
    assert_equal 0.92, response_data['path_efficiency']
  end

  test "should schedule next review using FSRS" do
    # Mock FSRS scheduling response
    fsrs_response = {
      "next_review_date" => (Time.current + 3.days).iso8601,
      "interval_days" => 3,
      "ease_factor" => 2.5,
      "repetition_count" => 2,
      "stability" => 4.2,
      "difficulty" => 0.4,
      "confidence" => 0.85
    }

    stub_request(:post, "http://localhost:5001/api/v1/fsrs/schedule_review")
      .with(
        body: hash_including({
          "user_id" => @user.id.to_s,
          "item_id" => @docker_command.id.to_s,
          "item_type" => "docker_command",
          "performance" => kind_of(Numeric),
          "response_time" => kind_of(Numeric)
        })
      )
      .to_return(
        status: 200,
        body: fsrs_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/schedule_review",
         params: {
           user_id: @user.id,
           command_id: @docker_command.id,
           performance: 0.85,
           response_time: 45
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_not_nil response_data['next_review_date']
    assert_equal 3, response_data['interval_days']
    assert_equal 2.5, response_data['ease_factor']
  end

  test "should handle Flask service timeout gracefully" do
    # Mock timeout scenario
    stub_request(:post, "http://localhost:5001/api/v1/curriculum/generate")
      .to_timeout

    post "/api/v1/adaptive_learning/generate_curriculum",
         params: { user_id: @user.id },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success  # Should fallback gracefully
    response_data = JSON.parse(response.body)
    
    # Should have fallback curriculum
    assert_not_nil response_data['curriculum']
    assert response_data['fallback_used']
  end

  test "should handle Flask service unavailable" do
    # Mock service unavailable
    stub_request(:post, "http://localhost:5001/api/v1/irt/assess_item")
      .to_return(status: 503, body: "Service Unavailable")

    post "/api/v1/adaptive_learning/assess_difficulty",
         params: { 
           command_id: @docker_command.id,
           user_id: @user.id 
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success  # Should fallback gracefully
    response_data = JSON.parse(response.body)
    
    # Should use static difficulty
    assert_not_nil response_data['difficulty']
    assert response_data['fallback_used']
  end

  test "should validate Flask request payloads" do
    # Test missing required parameters
    post "/api/v1/adaptive_learning/generate_curriculum",
         params: {},  # Missing user_id
         headers: { 'Content-Type' => 'application/json' }

    assert_response :bad_request
    response_data = JSON.parse(response.body)
    assert_match /user_id.*required/i, response_data['error']
  end

  test "should retry failed Flask requests" do
    # Mock first request failure, second success
    curriculum_response = {
      "curriculum" => [
        {
          "command_id" => @docker_command.id,
          "priority_score" => 0.85,
          "estimated_difficulty" => 0.3,
          "recommended_order" => 1
        }
      ]
    }

    stub_request(:post, "http://localhost:5001/api/v1/curriculum/generate")
      .to_return(status: 500).then
      .to_return(
        status: 200,
        body: curriculum_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/generate_curriculum",
         params: { user_id: @user.id },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    assert_not_nil response_data['curriculum']
  end

  test "should update user competencies after successful practice" do
    # Mock competency update response
    competency_response = {
      "updated_competencies" => {
        "basic_commands" => 0.6,
        "container_lifecycle" => 0.4
      },
      "skill_improvements" => [
        {
          "skill" => "basic_commands",
          "previous_level" => 0.5,
          "new_level" => 0.6,
          "improvement" => 0.1
        }
      ]
    }

    stub_request(:post, "http://localhost:5001/api/v1/irt/update_competency")
      .with(
        body: hash_including({
          "user_id" => @user.id.to_s,
          "item_id" => @docker_command.id.to_s,
          "performance" => 1.0,  # Correct answer
          "response_time" => kind_of(Numeric)
        })
      )
      .to_return(
        status: 200,
        body: competency_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/update_competency",
         params: {
           user_id: @user.id,
           command_id: @docker_command.id,
           performance: 1.0,
           response_time: 30
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_equal 0.6, response_data['updated_competencies']['basic_commands']
    assert_equal 1, response_data['skill_improvements'].length
  end

  test "should get next recommended item based on current competencies" do
    # Mock next item recommendation
    recommendation_response = {
      "recommended_item" => {
        "type" => "docker_command",
        "id" => @docker_command.id,
        "difficulty" => 0.35,
        "expected_performance" => 0.75,
        "reason" => "Optimal difficulty for current skill level"
      },
      "alternatives" => [
        {
          "type" => "hands_on_lab",
          "id" => @hands_on_lab.id,
          "difficulty" => 0.4,
          "expected_performance" => 0.7
        }
      ]
    }

    stub_request(:post, "http://localhost:5001/api/v1/adaptive/next_item")
      .with(
        body: hash_including({
          "user_id" => @user.id.to_s,
          "current_competencies" => kind_of(Hash),
          "previous_items" => kind_of(Array)
        })
      )
      .to_return(
        status: 200,
        body: recommendation_response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

    post "/api/v1/adaptive_learning/next_item",
         params: {
           user_id: @user.id,
           current_competencies: {
             "basic_commands" => 0.5,
             "container_lifecycle" => 0.3
           }
         },
         headers: { 'Content-Type' => 'application/json' }

    assert_response :success
    response_data = JSON.parse(response.body)
    
    assert_equal "docker_command", response_data['recommended_item']['type']
    assert_equal @docker_command.id, response_data['recommended_item']['id']
    assert_equal 0.35, response_data['recommended_item']['difficulty']
    assert_not_nil response_data['alternatives']
  end

  private

  def setup_flask_mocks
    # Enable WebMock
    WebMock.enable!
    WebMock.disable_net_connect!(allow_localhost: false)
    
    # Default health check mock
    stub_request(:get, "http://localhost:5001/health")
      .to_return(
        status: 200,
        body: { "status" => "healthy", "timestamp" => Time.current.iso8601 }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end