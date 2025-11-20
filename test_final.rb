#!/usr/bin/env ruby

# Load Rails environment
ENV['RAILS_ENV'] ||= 'development'
require_relative 'config/environment'

class FinalSystemTest
  def initialize
    @user = User.first || create_test_user
    @results = []
  end

  def run_tests
    puts "\n" + "="*80
    puts "COMPLETE SYSTEM IMPLEMENTATION TEST"
    puts "Phase 3, Phase 4, and Autonomous Learning"
    puts "="*80 + "\n"

    test_phase3
    test_phase4  
    test_autonomous
    test_integration
    
    print_summary
  end

  private

  def test_phase3
    puts "\n[Phase 3] Intelligent Mastery Decay..."
    
    # Test MasteryDecayService
    print "  • MasteryDecayService... "
    begin
      service = MasteryDecayService.new(@user)
      mastery = CommandMastery.create!(
        user: @user,
        canonical_command: 'docker run',
        mastery_score: 100,
        last_practiced_at: 7.days.ago
      )
      
      decayed = service.calculate_decay(mastery)
      if decayed < 100 && decayed >= 40
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test StealthReviewGenerator
    print "  • StealthReviewGenerator... "
    begin
      generator = StealthReviewGenerator.new(@user)
      reviews = generator.generate_reviews(3)
      
      if reviews.any?
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test API Routes
    print "  • API Endpoints... "
    begin
      if defined?(Api::MasteryController)
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
  end

  def test_phase4
    puts "\n[Phase 4] Docker-in-Docker Lab Execution..."
    
    # Test LabRunnerService
    print "  • LabRunnerService... "
    begin
      lab = HandsOnLab.create!(
        title: "Test Lab",
        docker_compose: "version: '3'\nservices:\n  web:\n    image: nginx",
        validation_script: "docker ps"
      )
      
      service = LabRunnerService.new(@user, lab)
      prefix = service.send(:generate_resource_prefix)
      
      if prefix.match(/^lab-\w{8}-user-\d+$/)
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test ActionCable
    print "  • LabExecutionChannel... "
    begin
      if defined?(LabExecutionChannel)
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test ResourceCleanupJob
    print "  • ResourceCleanupJob... "
    begin
      job = ResourceCleanupJob.perform_later(@user.id, "test")
      if job.job_id
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
  end

  def test_autonomous
    puts "\n[Autonomous Learning] Zero Navigation..."
    
    # Test Routes
    print "  • /learn endpoint... "
    begin
      if Rails.application.routes.url_helpers.respond_to?(:learn_path)
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test LearningSession
    print "  • LearningSession Model... "
    begin
      session = LearningSession.create_for_user!(@user)
      if session.persisted?
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    # Test Redirects
    print "  • Route redirects... "
    begin
      routes = Rails.application.routes.routes
      redirects = routes.count { |r| r.app.is_a?(ActionDispatch::Routing::Redirect) }
      
      if redirects > 0
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
  end

  def test_integration
    puts "\n[Integration] Complete System..."
    
    print "  • End-to-end flow... "
    begin
      session = LearningSession.find_or_create_active(@user)
      session.record_response('item_1', true, 2.5)
      session.record_response('item_2', false, 3.1)
      
      if session.accuracy_rate > 0
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
    
    print "  • Decay integration... "
    begin
      mastery = CommandMastery.create!(
        user: @user,
        canonical_command: 'docker compose',
        mastery_score: 30,
        last_practiced_at: 14.days.ago
      )
      
      service = MasteryDecayService.new(@user)
      decayed = service.calculate_decay(mastery)
      
      if decayed <= 30
        puts "✓"
        @results << :pass
      else
        puts "✗"
        @results << :fail
      end
    rescue => e
      puts "✗ #{e.message}"
      @results << :fail
    end
  end

  def create_test_user
    User.create!(
      email: "test_#{SecureRandom.hex(4)}@example.com",
      name: "Test User",
      provider: "test",
      uid: SecureRandom.hex(8)
    )
  end

  def print_summary
    puts "\n" + "="*80
    puts "SUMMARY"
    puts "="*80
    
    passed = @results.count(:pass)
    failed = @results.count(:fail)
    total = @results.count
    
    puts "\n  Tests: #{total}"
    puts "  Passed: #{passed}"
    puts "  Failed: #{failed}"
    
    puts "\n" + "="*80
    
    if failed == 0
      puts "✓ ALL SYSTEMS OPERATIONAL!"
    else
      puts "✗ #{failed} TESTS FAILED"
    end
    
    puts "="*80 + "\n"
  end
end

# Run tests
if __FILE__ == $0
  test = FinalSystemTest.new
  test.run_tests
end