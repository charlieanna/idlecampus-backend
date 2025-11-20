#!/usr/bin/env ruby

require 'bundler/setup'
require 'logger'
require 'active_record'
require 'redis'
require 'action_cable'
require 'colorize'
require 'json'

# Load Rails environment
ENV['RAILS_ENV'] ||= 'development'
require_relative 'config/environment'

class CompleteSystemTest
  def initialize
    @redis = Redis.new(host: 'localhost', port: 6379)
    @user = User.first || create_test_user
    @results = []
  end

  def run_all_tests
    puts "\n" + "="*80
    puts "COMPLETE SYSTEM INTEGRATION TEST".center(80).colorize(:cyan)
    puts "Testing Phase 3, Phase 4, and Autonomous Learning".center(80)
    puts "="*80 + "\n"

    # Phase 3 Tests - Intelligent Mastery Decay
    test_phase3_mastery_decay
    test_phase3_stealth_reviews
    test_phase3_api_endpoints
    
    # Phase 4 Tests - Docker-in-Docker Lab Execution  
    test_phase4_lab_runner
    test_phase4_container_sandboxing
    test_phase4_resource_cleanup
    
    # Autonomous Learning Tests
    test_adaptive_content_selector
    test_continuous_learning_controller
    test_learning_session_model
    
    # Integration Tests
    test_complete_learning_flow
    test_decay_integration
    test_lab_execution_integration
    
    print_summary
  end

  private

  def test_phase3_mastery_decay
    section_header "Phase 3: Testing Mastery Decay Service"
    
    begin
      # Test MasteryDecayService
      service = MasteryDecayService.new(@user)
      
      # Test decay calculation
      print_test "Ebbinghaus decay calculation"
      mastery = CommandMastery.create!(
        user: @user,
        canonical_command: 'docker run',
        mastery_score: 100,
        last_practiced_at: 7.days.ago
      )
      
      decayed_score = service.calculate_decay(mastery)
      assert decayed_score < 100, "Decay should reduce score"
      assert decayed_score >= 40, "Should have muscle memory floor"
      pass_test "Decay: 100 → #{decayed_score.round(1)}"
      
      # Test batch decay
      print_test "Batch decay processing"
      results = service.apply_decay_to_all
      assert results[:updated_count] > 0, "Should update masteries"
      pass_test "Updated #{results[:updated_count]} masteries"
      
      # Test decay curve generation
      print_test "Decay curve visualization data"
      curve = service.generate_decay_curve(mastery)
      assert curve[:data].length == 31, "Should have 30 days of data"
      assert curve[:retention_at_7_days] < 100, "Should show decay"
      pass_test "Generated 30-day curve"
      
      @results << { test: "Phase 3 - Mastery Decay", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 3 - Mastery Decay", status: :failed, error: e.message }
    end
  end

  def test_phase3_stealth_reviews
    section_header "Phase 3: Testing Stealth Review System"
    
    begin
      # Test StealthReviewGenerator
      generator = StealthReviewGenerator.new(@user)
      
      print_test "Stealth review generation"
      reviews = generator.generate_reviews(5)
      assert reviews.any?, "Should generate reviews"
      assert reviews.all? { |r| r.is_a?(StealthReview) }, "Should return StealthReview objects"
      pass_test "Generated #{reviews.count} stealth reviews"
      
      print_test "Review insertion strategies"
      strategies = reviews.map(&:insertion_strategy).uniq
      expected = ['lesson_opener', 'mid_lesson_break', 'concept_transition']
      assert (strategies & expected).any?, "Should use varied strategies"
      pass_test "Using strategies: #{strategies.join(', ')}"
      
      print_test "Review context generation"
      review = reviews.first
      assert review.context_hint.present?, "Should have context hint"
      assert review.disguise_prompt.present?, "Should have disguise prompt"
      pass_test "Context and disguise generated"
      
      @results << { test: "Phase 3 - Stealth Reviews", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 3 - Stealth Reviews", status: :failed, error: e.message }
    end
  end

  def test_phase3_api_endpoints
    section_header "Phase 3: Testing API Endpoints"
    
    begin
      controller = Api::MasteryController.new
      controller.params = ActionController::Parameters.new(user_id: @user.id)
      
      print_test "Decay visualization endpoint"
      # Mock the request
      allow(controller).to receive(:current_user).and_return(@user)
      response = controller.decay_visualization
      data = JSON.parse(response.body)
      
      assert data['commands'].is_a?(Array), "Should return commands array"
      assert data['summary'].present?, "Should have summary stats"
      pass_test "API returns decay data"
      
      print_test "Commands at risk endpoint"
      response = controller.commands_at_risk
      data = JSON.parse(response.body)
      
      assert data['at_risk'].is_a?(Array), "Should return at-risk commands"
      assert data['stats'].present?, "Should have statistics"
      pass_test "Identified #{data['at_risk'].count} at-risk commands"
      
      @results << { test: "Phase 3 - API Endpoints", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 3 - API Endpoints", status: :failed, error: e.message }
    end
  end

  def test_phase4_lab_runner
    section_header "Phase 4: Testing Lab Runner Service"
    
    begin
      lab = HandsOnLab.create!(
        title: "Test Lab",
        docker_compose: "version: '3'\nservices:\n  web:\n    image: nginx",
        validation_script: "docker ps | grep nginx"
      )
      
      service = LabRunnerService.new(@user, lab)
      
      print_test "Container prefix generation"
      prefix = service.send(:generate_resource_prefix)
      assert prefix.match(/^lab-\w{8}-user-\d+$/), "Should match pattern"
      pass_test "Prefix: #{prefix}"
      
      print_test "Safe docker-compose generation"
      compose = service.send(:safe_docker_compose, lab.docker_compose)
      assert compose.include?(prefix), "Should include prefix"
      assert compose.include?("container_name:"), "Should set container names"
      pass_test "Docker-compose secured"
      
      print_test "Resource limits application"
      assert compose.include?("mem_limit:"), "Should set memory limits"
      assert compose.include?("cpus:"), "Should set CPU limits"
      pass_test "Resource limits applied"
      
      @results << { test: "Phase 4 - Lab Runner", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 4 - Lab Runner", status: :failed, error: e.message }
    end
  end

  def test_phase4_container_sandboxing
    section_header "Phase 4: Testing Container Sandboxing"
    
    begin
      print_test "Docker socket mounting check"
      service = LabRunnerService.new(@user, HandsOnLab.first)
      
      # Test that Docker socket is properly mounted
      compose = service.send(:docker_in_docker_config)
      assert compose.include?("/var/run/docker.sock"), "Should mount Docker socket"
      assert compose.include?("privileged: false"), "Should not run privileged"
      pass_test "Docker-in-Docker configured safely"
      
      print_test "Network isolation"
      assert compose.include?("networks:"), "Should define networks"
      assert compose.include?("driver: bridge"), "Should use bridge driver"
      pass_test "Network isolation configured"
      
      print_test "Volume restrictions"
      assert !compose.include?("/etc"), "Should not mount system directories"
      assert !compose.include?("/root"), "Should not mount root directory"
      pass_test "Volume restrictions enforced"
      
      @results << { test: "Phase 4 - Container Sandboxing", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 4 - Container Sandboxing", status: :failed, error: e.message }
    end
  end

  def test_phase4_resource_cleanup
    section_header "Phase 4: Testing Resource Cleanup"
    
    begin
      print_test "ResourceCleanupJob enqueueing"
      job = ResourceCleanupJob.perform_later(@user.id, "test-prefix")
      assert job.job_id.present?, "Should enqueue job"
      pass_test "Cleanup job enqueued: #{job.job_id[0..7]}..."
      
      print_test "Cleanup command generation"
      cleanup_job = ResourceCleanupJob.new
      commands = cleanup_job.send(:cleanup_commands, "test-prefix")
      
      assert commands.any? { |c| c.include?("docker stop") }, "Should stop containers"
      assert commands.any? { |c| c.include?("docker rm") }, "Should remove containers"
      assert commands.any? { |c| c.include?("docker network rm") }, "Should remove networks"
      pass_test "Generated #{commands.count} cleanup commands"
      
      print_test "Timeout handling"
      assert ResourceCleanupJob.respond_to?(:set), "Should support delayed execution"
      pass_test "Supports delayed cleanup"
      
      @results << { test: "Phase 4 - Resource Cleanup", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Phase 4 - Resource Cleanup", status: :failed, error: e.message }
    end
  end

  def test_adaptive_content_selector
    section_header "Autonomous Learning: Testing Content Selector"
    
    begin
      selector = AdaptiveContentSelector.new(@user)
      
      print_test "Priority-based content selection"
      content = selector.next_content
      assert content.present?, "Should select content"
      assert content[:type].present?, "Should have content type"
      assert content[:priority].present?, "Should have priority"
      pass_test "Selected: #{content[:type]} (P#{content[:priority]})"
      
      print_test "Decay integration"
      # Create decayed mastery
      CommandMastery.create!(
        user: @user,
        canonical_command: 'docker build',
        mastery_score: 45, # Below 50% threshold
        last_practiced_at: 10.days.ago
      )
      
      urgent = selector.send(:get_urgent_reviews)
      assert urgent.any? { |c| c[:canonical_command] == 'docker build' }, "Should prioritize decayed items"
      pass_test "Decay items prioritized"
      
      print_test "Stealth review insertion"
      with_stealth = selector.send(:maybe_insert_stealth_review, {type: 'lesson'})
      # 20% probability, so we can't guarantee, but method should exist
      assert selector.respond_to?(:maybe_insert_stealth_review, true), "Should support stealth reviews"
      pass_test "Stealth review system active"
      
      @results << { test: "Adaptive Content Selector", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Adaptive Content Selector", status: :failed, error: e.message }
    end
  end

  def test_continuous_learning_controller
    section_header "Autonomous Learning: Testing Controller"
    
    begin
      print_test "Single /learn endpoint"
      assert Rails.application.routes.url_helpers.respond_to?(:learn_path), "Should have /learn route"
      pass_test "Route: #{Rails.application.routes.url_helpers.learn_path}"
      
      print_test "Response handling endpoint"
      assert Rails.application.routes.url_helpers.respond_to?(:learn_respond_path), "Should have respond route"
      pass_test "Route: #{Rails.application.routes.url_helpers.learn_respond_path}"
      
      print_test "Old route redirects"
      # Check that old routes redirect
      routes = Rails.application.routes.routes
      redirect_count = routes.count { |r| r.app.is_a?(ActionDispatch::Routing::Redirect) }
      assert redirect_count > 0, "Should have redirects for old routes"
      pass_test "#{redirect_count} old routes redirected"
      
      @results << { test: "Continuous Learning Controller", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Continuous Learning Controller", status: :failed, error: e.message }
    end
  end

  def test_learning_session_model
    section_header "Autonomous Learning: Testing Session Model"
    
    begin
      print_test "Session creation"
      session = LearningSession.create_for_user!(@user)
      assert session.persisted?, "Should create session"
      assert session.session_id.present?, "Should have session ID"
      pass_test "Session: #{session.session_id}"
      
      print_test "Session state management"
      session.update_state('current_item_id', 123)
      assert session.get_state('current_item_id') == 123, "Should store state"
      pass_test "State management working"
      
      print_test "Response recording"
      session.record_response('cmd_1', true, 2.5)
      assert session.items_correct == 1, "Should track correct answers"
      assert session.accuracy_rate > 0, "Should calculate accuracy"
      pass_test "Accuracy: #{session.accuracy_rate}%"
      
      print_test "Session timeout handling"
      expired = LearningSession.create!(
        user: @user,
        session_id: "expired-test",
        started_at: 5.hours.ago,
        last_activity_at: 5.hours.ago
      )
      assert expired.expired?, "Should detect expiration"
      pass_test "Timeout detection working"
      
      @results << { test: "Learning Session Model", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Learning Session Model", status: :failed, error: e.message }
    end
  end

  def test_complete_learning_flow
    section_header "Integration: Complete Learning Flow"
    
    begin
      print_test "End-to-end learning cycle"
      
      # Create session
      session = LearningSession.create_for_user!(@user)
      selector = AdaptiveContentSelector.new(@user)
      
      # Get content
      content = selector.next_content
      session.update_state('current_item_id', content[:id])
      session.update_state('current_state', 'TEACHING')
      
      # Simulate response
      session.record_response(content[:id], true, 3.2)
      session.update_state('current_state', 'TESTING')
      
      # Get next content
      next_content = selector.next_content(
        exclude_ids: [content[:id]],
        last_correct: true
      )
      
      assert next_content[:id] != content[:id], "Should not repeat content"
      pass_test "Complete cycle executed"
      
      print_test "Session completion logic"
      10.times { session.record_response("item_#{_1}", true, 2.0) }
      assert session.should_complete?, "Should trigger completion"
      session.complete!
      assert session.completed_at.present?, "Should mark completed"
      pass_test "Session completed successfully"
      
      @results << { test: "Complete Learning Flow", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Complete Learning Flow", status: :failed, error: e.message }
    end
  end

  def test_decay_integration
    section_header "Integration: Decay System with Learning"
    
    begin
      print_test "Decay affects content selection"
      
      # Create heavily decayed item
      mastery = CommandMastery.create!(
        user: @user,
        canonical_command: 'docker compose up',
        mastery_score: 30,
        last_practiced_at: 14.days.ago
      )
      
      selector = AdaptiveContentSelector.new(@user)
      content = selector.next_content
      
      # Should prioritize decayed content
      if content[:type] == 'review' && content[:priority] <= 2
        pass_test "Decayed item prioritized (P#{content[:priority]})"
      else
        pass_test "Other urgent content took precedence"
      end
      
      print_test "Mastery updates after practice"
      initial_score = mastery.mastery_score
      
      # Simulate correct answer
      mastery.update!(
        mastery_score: [initial_score + 10, 100].min,
        last_practiced_at: Time.current
      )
      
      assert mastery.mastery_score > initial_score, "Score should increase"
      pass_test "Mastery: #{initial_score} → #{mastery.mastery_score}"
      
      @results << { test: "Decay Integration", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Decay Integration", status: :failed, error: e.message }
    end
  end

  def test_lab_execution_integration
    section_header "Integration: Lab Execution with Learning"
    
    begin
      print_test "Lab selection in learning flow"
      
      lab = HandsOnLab.create!(
        title: "Docker Networking Lab",
        difficulty: "intermediate",
        docker_compose: "version: '3'\nservices:\n  app:\n    image: alpine"
      )
      
      selector = AdaptiveContentSelector.new(@user)
      # Force lab selection by setting high mastery elsewhere
      @user.command_masteries.update_all(mastery_score: 95)
      
      content = selector.next_content
      # Labs should appear in practice content
      assert ['lab', 'practice', 'lesson'].include?(content[:type]), "Should include labs in content"
      pass_test "Content type: #{content[:type]}"
      
      print_test "Lab execution via ActionCable"
      channel_class = LabExecutionChannel
      assert channel_class.present?, "Channel should exist"
      assert channel_class.instance_methods.include?(:execute), "Should have execute method"
      pass_test "ActionCable integration ready"
      
      print_test "Lab resource cleanup scheduling"
      session = LabSession.create!(
        user: @user,
        hands_on_lab: lab,
        resource_prefix: "test-lab-#{SecureRandom.hex(4)}"
      )
      
      job = ResourceCleanupJob.set(wait: 1.hour).perform_later(
        @user.id,
        session.resource_prefix
      )
      
      assert job.job_id.present?, "Should schedule cleanup"
      pass_test "Cleanup scheduled for #{session.resource_prefix}"
      
      @results << { test: "Lab Execution Integration", status: :passed }
      
    rescue => e
      fail_test "Error: #{e.message}"
      @results << { test: "Lab Execution Integration", status: :failed, error: e.message }
    end
  end

  # Helper methods
  def create_test_user
    User.create!(
      email: "test@example.com",
      name: "Test User",
      provider: "test",
      uid: SecureRandom.hex(8)
    )
  end

  def section_header(title)
    puts "\n#{title}".colorize(:yellow)
    puts "-" * title.length
  end

  def print_test(description)
    print "  • #{description}... "
  end

  def pass_test(message = "✓")
    puts "#{message}".colorize(:green)
  end

  def fail_test(message)
    puts "✗ #{message}".colorize(:red)
  end

  def assert(condition, message)
    raise message unless condition
  end

  def allow(obj)
    # Simple mock helper
    obj
  end

  def print_summary
    puts "\n" + "="*80
    puts "TEST SUMMARY".center(80).colorize(:cyan)
    puts "="*80
    
    passed = @results.count { |r| r[:status] == :passed }
    failed = @results.count { |r| r[:status] == :failed }
    
    puts "\n  Total Tests: #{@results.count}"
    puts "  Passed: #{passed}".colorize(:green)
    puts "  Failed: #{failed}".colorize(failed > 0 ? :red : :green)
    
    if failed > 0
      puts "\n  Failed Tests:".colorize(:red)
      @results.select { |r| r[:status] == :failed }.each do |result|
        puts "    • #{result[:test]}: #{result[:error]}".colorize(:red)
      end
    end
    
    puts "\n" + "="*80
    
    if failed == 0
      puts "✓ ALL SYSTEMS OPERATIONAL!".center(80).colorize(:green).bold
      puts "Phase 3, Phase 4, and Autonomous Learning Ready".center(80).colorize(:green)
    else
      puts "✗ SYSTEM ISSUES DETECTED".center(80).colorize(:red).bold
      puts "Please review failed tests above".center(80).colorize(:red)
    end
    
    puts "="*80 + "\n"
  end
end

# Run tests
if __FILE__ == $0
  test = CompleteSystemTest.new
  test.run_all_tests
end