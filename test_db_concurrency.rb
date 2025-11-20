#!/usr/bin/env ruby
# Test script to verify database concurrency improvements

require_relative 'config/environment'

puts "🧪 Testing Database Concurrency with WAL mode"
puts "=" * 60

# Check WAL mode is enabled
journal_mode = ActiveRecord::Base.connection.execute('PRAGMA journal_mode').first['journal_mode']
puts "✓ Journal mode: #{journal_mode}"

if journal_mode != 'wal'
  puts "❌ WAL mode is not enabled! This test may fail."
  exit 1
end

# Get or create a test user
user = User.first || User.create!(account_id: "test-#{SecureRandom.hex(4)}")
puts "✓ Using user ID: #{user.id}"

# Create a learning session
session = LearningSession.find_or_create_active(user)
puts "✓ Created learning session: #{session.id}"

# Test concurrent writes
puts "\n🔄 Testing concurrent database writes..."
success_count = 0
error_count = 0
lock_error_count = 0

threads = []
10.times do |i|
  threads << Thread.new do
    begin
      # Simulate what happens during learning
      LearningSession.transaction do
        session.reload
        session.update!(
          items_presented: session.items_presented + 1,
          last_activity_at: Time.current
        )
      end
      success_count += 1
      print "."
    rescue ActiveRecord::StatementInvalid, SQLite3::BusyException => e
      if e.message.include?('database is locked') || e.is_a?(SQLite3::BusyException)
        lock_error_count += 1
        print "L"
      else
        error_count += 1
        print "E"
      end
    rescue => e
      error_count += 1
      print "E"
    end
  end
end

threads.each(&:join)

puts "\n\n📊 Results:"
puts "  ✓ Successful writes: #{success_count}/10"
puts "  🔒 Lock errors: #{lock_error_count}/10"
puts "  ❌ Other errors: #{error_count}/10"

# Verify final state
session.reload
puts "\n✓ Final items_presented: #{session.items_presented}"

if lock_error_count == 0
  puts "\n🎉 SUCCESS: No database lock errors detected!"
  puts "   WAL mode is working correctly."
  exit 0
else
  puts "\n⚠️  WARNING: #{lock_error_count} database lock errors occurred."
  puts "   This may indicate WAL mode is not fully effective."
  exit 1
end

