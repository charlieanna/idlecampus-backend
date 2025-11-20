# Whenever gem configuration for scheduled tasks
# Generate crontab: whenever --update-crontab
# Clear crontab: whenever --clear-crontab

# Set environment
set :output, "log/cron.log"
set :environment, "production"

# Lab cleanup - every 15 minutes
every 15.minutes do
  runner "CleanupExpiredLabSessionsJob.perform_now"
end

# IRT calibration - weekly on Sunday at 3 AM
every :sunday, at: '3:00 am' do
  rake "irt:calibrate"
end

# Daily performance snapshots - every day at 2 AM
every 1.day, at: '2:00 am' do
  runner "DailySnapshotJob.perform_now"
end

# Review reminders - every day at 9 AM
every 1.day, at: '9:00 am' do
  runner "ReviewReminderJob.perform_now"
end

# Cache warmup - every hour
every 1.hour do
  runner "CacheWarmupJob.perform_now"
end
