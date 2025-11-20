namespace :docker do
  desc "Cleanup Docker containers for inactive users"
  task cleanup: :environment do
    puts "🧹 Starting Docker cleanup for inactive learning sessions..."

    # Find sessions inactive for more than 24 hours
    inactive_sessions = LearningSession.where("updated_at < ?", 24.hours.ago)
                                      .where(active: true)

    puts "Found #{inactive_sessions.count} inactive sessions"

    inactive_sessions.find_each do |session|
      user = session.user
      next unless user

      begin
        executor = DockerExecutionService.new(user)
        result = executor.cleanup_all

        if result[:success]
          puts "✅ Cleaned up containers for user #{user.id}: #{result[:message]}"
        else
          puts "⚠️  Failed cleanup for user #{user.id}: #{result[:message]}"
        end

        # Mark session as inactive
        session.update(active: false)
      rescue => e
        puts "❌ Error cleaning up user #{user.id}: #{e.message}"
      end
    end

    puts "✅ Docker cleanup complete!"
  end

  desc "Cleanup Docker containers for a specific user"
  task :cleanup_user, [:user_id] => :environment do |t, args|
    user_id = args[:user_id] || ENV['USER_ID']

    unless user_id
      puts "❌ Please provide a user ID: rake docker:cleanup_user[123]"
      exit 1
    end

    user = User.find_by(id: user_id)
    unless user
      puts "❌ User not found: #{user_id}"
      exit 1
    end

    puts "🧹 Cleaning up containers for user #{user.id}..."
    executor = DockerExecutionService.new(user)
    result = executor.cleanup_all

    if result[:success]
      puts "✅ #{result[:message]}"
    else
      puts "❌ Cleanup failed: #{result[:message]}"
    end
  end

  desc "List all user containers"
  task list_containers: :environment do
    puts "📦 Listing all user containers..."

    User.find_each do |user|
      executor = DockerExecutionService.new(user)
      containers = executor.user_containers

      if containers.any?
        puts "\nUser #{user.id} (#{user.email}):"
        containers.each do |container|
          puts "  - #{container}"
        end
      end
    end

    puts "\n✅ Done!"
  end

  desc "Cleanup ALL user containers (use with caution!)"
  task cleanup_all: :environment do
    puts "⚠️  This will cleanup containers for ALL users!"
    puts "Continue? (y/N)"

    input = STDIN.gets.chomp
    unless input.downcase == 'y'
      puts "Cancelled."
      exit
    end

    puts "🧹 Cleaning up all user containers..."
    count = 0

    User.find_each do |user|
      executor = DockerExecutionService.new(user)
      result = executor.cleanup_all

      if result[:success] && result[:message] != "No containers to clean up"
        puts "✅ User #{user.id}: #{result[:message]}"
        count += 1
      end
    end

    puts "\n✅ Cleaned up containers for #{count} users"
  end
end
