namespace :irt do
  desc "Calibrate IRT parameters for all questions"
  task calibrate: :environment do
    puts "🔬 Starting IRT parameter calibration..."
    
    service = IRTCalibrationService.new
    result = service.calibrate_all_questions
    
    puts "\n📊 Calibration Results:"
    puts "   Questions calibrated: #{result[:calibrated]}"
    puts "   Questions skipped: #{result[:skipped]} (need more responses)"
    puts "   Timestamp: #{result[:timestamp]}"
    
    # Show sample of calibrated questions
    puts "\n🔍 Sample calibrated questions:"
    QuizQuestion.where('difficulty != 0.0').limit(5).each do |q|
      puts "   - #{q.question_text.truncate(60)}"
      puts "     Difficulty: #{q.difficulty.round(2)}, Discrimination: #{q.discrimination.round(2)}"
    end
  end
  
  desc "Show IRT calibration status"
  task status: :environment do
    total = QuizQuestion.count
    with_responses = QuizQuestion.joins(
      "INNER JOIN learning_events ON json_extract(learning_events.event_data, '$.question_id') = CAST(quiz_questions.id AS TEXT)"
    ).where(learning_events: { event_type: 'quiz_question_answered' })
    .group('quiz_questions.id')
    .having('COUNT(*) >= 30')
    .count
    
    puts "📊 IRT Calibration Status:"
    puts "   Total questions: #{total}"
    puts "   Ready for calibration (≥30 responses): #{with_responses.count}"
    puts "   Needs more data: #{total - with_responses.count}"
    
    last_calibration = Rails.cache.read('irt:last_calibration')
    if last_calibration
      puts "   Last calibration: #{last_calibration.strftime('%Y-%m-%d %H:%M')}"
    else
      puts "   Last calibration: Never"
    end
  end
end

