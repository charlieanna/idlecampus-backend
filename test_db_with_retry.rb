#!/usr/bin/env ruby
# Test script to verify database concurrency with retry logic

require_relative 'config/environment'

puts "🧪 Testing Database Concurrency with WAL mode + Retry Logic"
puts "=" * 60

# Check WAL mode is enabled
journal_mode = ActiveRecord::Base.connection.execute('PRAGMA journal_mode').first['journal_mode']
puts "✓ Journal mode: #{journal_mode}"

if journal_mode != 'wal'
  puts "❌ WAL mode is not enabled! This test may fail."
  exit 1
end

# Retry logic (same as in controller)
def with_db_retry(max_retries: 10, base_delay: 0.05)
  retries = 0
  begin
    ActiveRecord::Base.transaction do
      yield
    end
  rescue ActiveRecord::StatementInvalid, SQLite3::BusyException, ActiveRecord::LockWaitTimeout => e
    error_message = e.message.to_s.downcase
    is_lock_error = error_message.include?('database is locked') || 
                    error_message.include?('busy') ||
                    e.is_a?(SQLite3::BusyException) ||
                    e.is_a?(ActiveRecord::LockWaitTimeout)
    
    if is_lock_error && retries < max_retries
      retries += 1
      jitter = rand(0.0..0.02)
      sleep_time = (base_delay * (2 ** retries)) + jitter
      sleep(sleep_time)
      retry
    else
      raise
    end
  end
end

# Get or create a test user
user = User.first || User.create!(account_id: "test-#{SecureRandom.hex(4)}")
puts "✓ Using user ID: #{user.id}"

# Create a learning session
session = LearningSession.find_or_create_active(user)
puts "✓ Created learning session: #{session.id}"

# Test concurrent writes WITH retry logic
puts "\n🔄 Testing concurrent database writes with retry logic..."
success_count = 0
error_count = 0
retry_count = 0

threads = []
20.times do |i|
  threads << Thread.new do
    begin
      with_db_retry do
        session.reload
        session.update!(
          items_presented: session.items_presented + 1,
          last_activity_at: Time.current
        )
      end
      success_count += 1
      print "."
    rescue => e
      error_count += 1
      puts "\n❌ Error: #{e.message}"
      print "E"
    end
  end
end

threads.each(&:join)

puts "\n\n📊 Results:"
puts "  ✓ Successful writes: #{success_count}/20"
puts "  ❌ Failed writes: #{error_count}/20"

# Verify final state
session.reload
puts "\n✓ Final items_presented: #{session.items_presented}"

if error_count == 0
  puts "\n🎉 SUCCESS: All database writes succeeded!"
  puts "   WAL mode + retry logic is working correctly."
  exit 0
else
  puts "\n⚠️  WARNING: #{error_count} database writes failed even with retry logic."
  exit 1
end

