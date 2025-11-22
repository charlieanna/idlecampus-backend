# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Load Progressive Flow seed data (tracks, challenges, levels, achievements)"
    task progressive_flow: :environment do
      puts "\n🌱 Loading Progressive Flow seed data..."
      load Rails.root.join('db', 'seeds', 'progressive_flow_seeds.rb')
      puts "✅ Progressive Flow seed data loaded successfully!\n"
    end
  end
end

namespace :progressive_flow do
  desc "Reset and reload all Progressive Flow data"
  task reset: :environment do
    puts "\n⚠️  Resetting Progressive Flow data..."
    
    # Disable foreign key constraints temporarily
    ActiveRecord::Base.connection.execute("SET session_replication_role = 'replica';")
    
    # Clear existing data in reverse dependency order
    ProgressiveUserSkill.delete_all
    ProgressiveSkill.delete_all
    ProgressiveUserAchievement.delete_all
    ProgressiveAchievement.delete_all
    ProgressiveXpTransaction.delete_all
    ProgressiveLevelAttempt.delete_all
    ProgressiveUserChallengeProgress.delete_all
    ProgressiveChallengeLevel.delete_all
    ProgressiveChallenge.delete_all
    ProgressiveLearningTrack.delete_all
    ProgressiveUserStat.delete_all
    
    # Re-enable foreign key constraints
    ActiveRecord::Base.connection.execute("SET session_replication_role = 'origin';")
    
    puts "   ✓ Cleared existing data"
    
    # Reload seed data
    Rake::Task['db:seed:progressive_flow'].invoke
  end
  
  desc "Show Progressive Flow statistics"
  task stats: :environment do
    puts "\n📊 Progressive Flow Statistics"
    puts "=" * 80
    puts "Learning Tracks:        #{ProgressiveLearningTrack.count}"
    puts "Challenges:             #{ProgressiveChallenge.count}"
    puts "Challenge Levels:       #{ProgressiveChallengeLevel.count}"
    puts "Achievements:           #{ProgressiveAchievement.count}"
    puts "Skills:                 #{ProgressiveSkill.count}"
    puts ""
    puts "Track Distribution:"
    ProgressiveLearningTrack.order(:order_index).each do |track|
      count = ProgressiveChallenge.where(progressive_learning_track_id: track.id).count
      puts "  #{track.title.ljust(25)} #{count} challenges"
    end
    puts ""
    puts "Challenges with Prerequisites: #{ProgressiveChallenge.where.not(prerequisites: []).count}"
    puts "=" * 80
  end
end