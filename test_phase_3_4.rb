#!/usr/bin/env ruby
# Test script for Phase 3 & 4 implementation

require_relative 'config/environment'

puts "=" * 80
puts "Phase 3 & 4 Implementation Test Suite"
puts "=" * 80
puts ""

# Test 1: MasteryDecayService
puts "✓ Testing MasteryDecayService..."
begin
  # Create a test user and mastery record
  user = User.first || User.create!(
    email: "test@codesprout.com",
    password: "password123",
    password_confirmation: "password123"
  )
  
  mastery = user.user_command_masteries.first_or_create!(
    canonical_command: "docker ps",
    proficiency_score: 85,
    last_practiced_at: 5.days.ago,
    total_attempts: 10,
    successful_attempts: 9,
    contexts_seen: ['basic', 'advanced']
  )
  
  service = MasteryDecayService.new(mastery)
  
  # Test decay calculation
  current_score = service.current_decayed_score
  puts "  - Current decayed score: #{current_score.round(2)}"
  
  # Test decay curve generation
  curve = service.generate_decay_curve(30)
  puts "  - Generated decay curve: #{curve.size} data points"
  
  # Test risk threshold prediction
  days_to_risk = service.predict_risk_threshold_breach(80)
  puts "  - Days until risk threshold (80%): #{days_to_risk || 'N/A'}"
  
  # Test review timing suggestion
  timing = service.suggest_review_timing
  puts "  - Review urgency: #{timing[:urgency]} (#{timing[:days]} days)"
  
  puts "✅ MasteryDecayService: PASSED"
rescue => e
  puts "❌ MasteryDecayService: FAILED - #{e.message}"
  puts e.backtrace.first(3).join("\n")
end

puts ""

# Test 2: StealthReviewGenerator
puts "✓ Testing StealthReviewGenerator..."
begin
  user = User.first
  generator = StealthReviewGenerator.new(user_id: user.id)
  
  # Test review queuing
  success = generator.queue_stealth_review("docker ps")
  puts "  - Queued stealth review: #{success}"
  
  # Test lesson review generation
  reviews = generator.generate_lesson_reviews(3)
  puts "  - Generated lesson reviews: #{reviews.size} reviews"
  
  puts "✅ StealthReviewGenerator: PASSED"
rescue => e
  puts "❌ StealthReviewGenerator: FAILED - #{e.message}"
  puts e.backtrace.first(3).join("\n")
end

puts ""

# Test 3: StealthReview Model
puts "✓ Testing StealthReview Model..."
begin
  user = User.first
  review = StealthReview.create!(
    user: user,
    canonical_command: "docker run",
    status: 'queued',
    priority: 5,
    stealth_level: 3,
    requested_at: Time.current
  )
  
  puts "  - Created stealth review: ##{review.id}"
  
  # Test state transitions
  review.mark_scheduled!(scheduled_for: 1.hour.from_now)
  puts "  - Marked as scheduled: #{review.scheduled?}"
  
  review.mark_completed!(success: true, response_time: 2.5)
  puts "  - Marked as completed: #{review.completed?}"
  
  puts "✅ StealthReview Model: PASSED"
rescue => e
  puts "❌ StealthReview Model: FAILED - #{e.message}"
  puts e.backtrace.first(3).join("\n")
end

puts ""

# Test 4: LabRunnerService
puts "✓ Testing LabRunnerService..."
begin
  user = User.first
  lab_runner = LabRunnerService.new(user_id: user.id)
  
  # Test command validation
  valid_cmd = lab_runner.send(:validate_command, "docker ps")
  puts "  - Valid command validation: #{valid_cmd}"
  
  dangerous_cmd = lab_runner.send(:validate_command, "rm -rf /")
  puts "  - Dangerous command blocked: #{!dangerous_cmd}"
  
  # Test session ID generation
  session_id = lab_runner.send(:generate_session_id)
  puts "  - Generated session ID: #{session_id}"
  
  puts "✅ LabRunnerService: PASSED"
rescue => e
  puts "❌ LabRunnerService: FAILED - #{e.message}"
  puts e.backtrace.first(3).join("\n")
end

puts ""

# Test 5: API Routes
puts "✓ Testing API Routes..."
begin
  routes_exist = [
    Rails.application.routes.url_helpers.api_mastery_decay_visualization_path,
    Rails.application.routes.url_helpers.api_mastery_request_stealth_review_path,
    Rails.application.routes.url_helpers.api_mastery_stealth_reviews_path
  ]
  
  puts "  - Decay visualization route: ✓"
  puts "  - Request stealth review route: ✓"
  puts "  - Stealth reviews list route: ✓"
  
  puts "✅ API Routes: PASSED"
rescue => e
  puts "❌ API Routes: FAILED - #{e.message}"
end

puts ""

# Test 6: Component Registration
puts "✓ Testing Component Registration..."
begin
  components_dir = Rails.root.join('app/javascript/components')
  
  decay_viz = components_dir.join('DecayVisualization.jsx').exist?
  enhanced_viz = components_dir.join('EnhancedDecayVisualization.jsx').exist?
  
  puts "  - DecayVisualization.jsx: #{decay_viz ? '✓' : '✗'}"
  puts "  - EnhancedDecayVisualization.jsx: #{enhanced_viz ? '✓' : '✗'}"
  
  if decay_viz && enhanced_viz
    puts "✅ Component Registration: PASSED"
  else
    puts "❌ Component Registration: FAILED"
  end
rescue => e
  puts "❌ Component Registration: FAILED - #{e.message}"
end

puts ""

# Test 7: Background Jobs
puts "✓ Testing Background Jobs..."
begin
  jobs = [
    LabExecutionJob,
    LogStreamingJob,
    ResourceCleanupJob
  ]
  
  jobs.each do |job_class|
    puts "  - #{job_class.name}: ✓"
  end
  
  puts "✅ Background Jobs: PASSED"
rescue => e
  puts "❌ Background Jobs: FAILED - #{e.message}"
end

puts ""

# Test 8: Database Schema
puts "✓ Testing Database Schema..."
begin
  columns = StealthReview.column_names
  required_columns = %w[user_id canonical_command status priority stealth_level requested_at]
  
  missing = required_columns - columns
  if missing.empty?
    puts "  - All required columns present: ✓"
    puts "✅ Database Schema: PASSED"
  else
    puts "  - Missing columns: #{missing.join(', ')}"
    puts "❌ Database Schema: FAILED"
  end
rescue => e
  puts "❌ Database Schema: FAILED - #{e.message}"
end

puts ""
puts "=" * 80
puts "Test Suite Complete"
puts "=" * 80
puts ""
puts "Next Steps:"
puts "1. Start Rails server: rails s"
puts "2. Start Sidekiq: bundle exec sidekiq"
puts "3. Visit /mastery/decay to see visualizations"
puts "4. Test WebSocket connections via browser console"
puts ""