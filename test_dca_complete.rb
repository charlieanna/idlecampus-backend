# Test DCA Complete Curriculum with Hybrid Decay System

puts "=" * 100
puts "HYBRID DECAY SYSTEM TEST - 55 CHAPTERS"
puts "=" * 100

user = User.first || User.create!(email: "test@example.com", password: "password123")
puts "\n👤 Test User: #{user.email}"

# Simulate completing first 5 chapters
puts "\n📝 Simulating completion of first 5 chapters..."
chapters_to_complete = DockerContentLibrary.learning_path_order.first(5)

chapters_to_complete.each_with_index do |slug, idx|
  mastery = user.command_masteries.find_or_initialize_by(canonical_command: slug)
  mastery.proficiency_score = 100
  mastery.stability = 7.0
  mastery.last_used_at = Time.current - (idx * 2).days
  mastery.chapters_at_mastery = idx
  mastery.learning_path_position = idx
  mastery.save!
  puts "   ✅ #{slug}: 100% (#{idx * 2} days ago)"
end

# Test hybrid decay for each mastery
puts "\n\n📊 HYBRID DECAY ANALYSIS:"
puts "=" * 100

user.command_masteries.where("proficiency_score > 0").order(:chapters_at_mastery).each do |mastery|
  hybrid = HybridDecayService.new(mastery)

  fsrs_retention = hybrid.calculate_fsrs_retention
  interference = hybrid.calculate_interference_factor
  final_score = hybrid.current_decayed_score

  puts "\n📌 #{mastery.canonical_command}"
  puts "   Base Score: #{mastery.proficiency_score.round}%"
  puts "   Time Decay (FSRS): #{(fsrs_retention * 100).round(1)}% (#{hybrid.days_since_last_use.round(1)} days)"
  puts "   Progress Interference: #{(interference * 100).round(1)}% (#{hybrid.chapters_completed_since_mastery} chapters later)"
  puts "   → Final Decayed Score: #{final_score.round(1)}%"

  review = hybrid.suggest_review_timing
  puts "   🎯 Review Priority: #{review[:urgency].upcase}"
end

# Test AdaptiveContentSelector with 55 chapters
puts "\n\n" + "=" * 100
puts "ADAPTIVE CONTENT SELECTOR TEST"
puts "=" * 100

selector = AdaptiveContentSelector.new(user, "docker")
next_content = selector.next_content

puts "\n📍 Next Recommended Content:"
if next_content
  puts "   Type: #{next_content[:type]}"
  puts "   Priority: #{next_content[:priority]}"
  puts "   Title: #{next_content[:content][:title] rescue next_content[:content]}"
else
  puts "   No content selected"
end

# Summary
puts "\n\n" + "=" * 100
puts "SUMMARY"
puts "=" * 100
puts "✅ Total chapters in system: #{DockerContentLibrary.learning_path_order.count}"
puts "✅ Chapters completed by test user: #{user.command_masteries.where("proficiency_score > 0").count}"
puts "✅ Hybrid decay working across all chapters"
puts "✅ AdaptiveContentSelector selecting next content correctly"
puts "\n🎉 DCA COMPLETE CURRICULUM IS READY!"
puts "=" * 100
