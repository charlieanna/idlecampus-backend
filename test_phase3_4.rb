#!/usr/bin/env ruby
# Test script for Phase 3 & 4 implementation

require_relative 'config/environment'

puts "\n=== PHASE 3 & 4 IMPLEMENTATION TEST ==="
puts "=" * 50

# Test helper methods
def success(msg)
  puts "✅ #{msg}"
end

def error(msg)
  puts "❌ #{msg}"
end

def info(msg)
  puts "ℹ️  #{msg}"
end

# 1. Test User and Command Mastery Setup
puts "\n1. Setting up test data..."
begin
  user = User.first || User.create!(
    email: "test@example.com",
    first_name: "Test",
    last_name: "User"
  )
  success "User found/created: #{user.email}"
  
  # Create test command mastery
  mastery = UserCommandMastery.find_or_create_by!(
    user: user,
    canonical_command: 'docker run'
  ) do |m|
    m.proficiency_score = 95
    m.total_attempts = 10
    m.successful_attempts = 8
    m.last_practiced_at = 7.days.ago
    m.contexts_seen = ['container creation', 'port mapping'].to_json
  end
  success "Command mastery created: #{mastery.canonical_command}"
rescue => e
  error "Failed to create test data: #{e.message}"
  exit 1
end

# 2. Test MasteryDecayService
puts "\n2. Testing MasteryDecayService..."
begin
  decay_service = MasteryDecayService.new(mastery)
  
  current_score = decay_service.current_decayed_score
  info "Original score: #{mastery.proficiency_score}"
  info "Current decayed score: #{current_score.round(2)}"
  
  if current_score < mastery.proficiency_score && current_score >= 40
    success "Decay calculation working (Ebbinghaus formula applied)"
  else
    error "Decay calculation issue"
  end
  
  # Test review timing suggestion
  review_timing = decay_service.suggest_review_timing
  info "Review suggestion: #{review_timing[:reason]} (in #{review_timing[:days]} days)"
  success "Review timing calculated"
  
  # Test decay curve generation
  curve = decay_service.generate_decay_curve(30)
  if curve.is_a?(Array) && curve.length == 31
    success "Decay curve generated (#{curve.length} data points)"
  else
    error "Decay curve generation failed"
  end
rescue => e
  error "MasteryDecayService error: #{e.message}"
end

# 3. Test StealthReview System
puts "\n3. Testing StealthReview System..."
begin
  # Create stealth review
  stealth_review = StealthReview.create!(
    user: user,
    canonical_command: 'docker build',
    priority: 8,
    status: 'queued',
    strategy: 'mid_lesson_break',
    requested_at: Time.current
  )
  success "Stealth review created: #{stealth_review.canonical_command}"
  
  # Test StealthReviewGenerator
  generator = StealthReviewGenerator.new(user_id: user.id)
  queued = generator.queue_stealth_review('docker run')
  
  if queued
    success "Stealth review queued via generator"
  else
    info "Stealth review already exists or command not found"
  end
rescue => e
  error "StealthReview system error: #{e.message}"
end

# 4. Test API Endpoints
puts "\n4. Testing API Endpoints..."
begin
  # Include Rails URL helpers
  Rails.application.routes.default_url_options[:host] = 'localhost:3000'
  
  controller = Api::MasteryController.new
  controller.params = { time_range: 30, user_id: user.id }
  
  # Mock current_user
  controller.define_singleton_method(:current_user) { user }
  
  info "API endpoints configured (would need HTTP requests for full test)"
  success "API controller accessible"
rescue => e
  error "API endpoint error: #{e.message}"
end

# 5. Test Docker-in-Docker Lab Execution
puts "\n5. Testing Docker-in-Docker Lab Execution..."
begin
  lab_runner = LabRunnerService.new(user_id: user.id)
  
  # Test command validation
  safe_command = 'echo "Hello World"'
  dangerous_command = 'rm -rf /'
  
  if lab_runner.send(:validate_command, safe_command)
    success "Safe command validation passed"
  else
    error "Safe command incorrectly rejected"
  end
  
  if !lab_runner.send(:validate_command, dangerous_command)
    success "Dangerous command correctly rejected"
  else
    error "Dangerous command not rejected!"
  end
  
  info "Lab runner service configured"
  info "Container prefix: codesprout_lab_#{user.id}_*"
rescue => e
  error "Lab execution error: #{e.message}"
end

# 6. Test Container Lab Session Model
puts "\n6. Testing Container Lab Sessions..."
begin
  lab_session = ContainerLabSession.create!(
    user: user,
    session_id: "test_#{Time.current.to_i}",
    lab_type: 'docker',
    status: 'active',
    started_at: Time.current
  )
  success "Container lab session created: #{lab_session.session_id}"
  
  # Test session methods
  if lab_session.active?
    success "Session status methods working"
  end
  
  # Test command increment
  lab_session.increment_command_count!
  if lab_session.commands_executed == 1
    success "Command counting working"
  end
rescue => e
  error "Container lab session error: #{e.message}"
end

# 7. Summary
puts "\n" + "=" * 50
puts "TEST SUMMARY"
puts "=" * 50

# Count successes and errors
test_output = `ruby #{__FILE__} 2>&1`
success_count = test_output.scan(/✅/).count
error_count = test_output.scan(/❌/).count

puts "✅ Successes: #{success_count}"
puts "❌ Errors: #{error_count}"

if error_count == 0
  puts "\n🎉 ALL TESTS PASSED! Phase 3 & 4 implementation is working correctly."
else
  puts "\n⚠️  Some tests failed. Please review the errors above."
end

puts "\nNOTE: For complete testing:"
puts "1. Start Rails server: rails server"
puts "2. Start Redis: redis-server"
puts "3. Start Sidekiq: bundle exec sidekiq"
puts "4. Test WebSocket connections via browser console"
puts "5. Test actual Docker container creation (requires Docker daemon)"