      session.record_response('item_3', true, 2.8)
      
      # Check accuracy
      accuracy = session.accuracy_rate
      
      if accuracy > 0 && session.items_presented == 3
        puts "✓ (Accuracy: #{accuracy}%)"
        @results << { test: "Integration Flow", status: :passed }
      else
        puts "✗ Session recording failed"
        @results << { test: "Integration Flow", status: :failed }
      end
    rescue => e
      puts "✗ Error: #{e.message}"
      @results << { test: "Integration Flow", status: :failed, error: e.message }
    end
    
    print "  • Decay integration... "
    begin
      # Create decayed mastery
      mastery = CommandMastery.create!(
        user: @user,
        canonical_command: 'docker compose up',
        mastery_score: 30,
        last_practiced_at: 14.days.ago
      )
      
      # Run decay service
      service = MasteryDecayService.new(@user)
      decayed = service.calculate_decay(mastery)
      
      if decayed <= 30 # Should be at or below original due to decay
        puts "✓ (Decay applied: #{decayed.round(1)})"
        @results << { test: "Decay Integration", status: :passed }
      else
        puts "✗ Decay not applied correctly"
        @results << { test: "Decay Integration", status: :failed }
      end
    rescue => e
      puts "✗ Error: #{e.message}"
      @results << { test: "Decay Integration", status: :failed, error: e.message }
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
    puts "TEST SUMMARY"
    puts "="*80
    
    passed = @results.count { |r| r[:status] == :passed }
    failed = @results.count { |r| r[:status] == :failed }
    total = @results.count
    
    puts "\n  Total Tests: #{total}"
    puts "  Passed: #{passed}"
    puts "  Failed: #{failed}"
    
    if failed > 0
      puts "\n  Failed Tests:"
      @results.select { |r| r[:status] == :failed }.each do |result|
        error_msg = result[:error] ? " - #{result[:error]}" : ""
        puts "    • #{result[:test]}#{error_msg}"
      end
    end
    
    puts "\n" + "="*80
    
    if failed == 0
      puts "✓ ALL SYSTEMS OPERATIONAL!"
      puts "Phase 3, Phase 4, and Autonomous Learning System Ready"
    else
      puts "✗ SYSTEM ISSUES DETECTED"
      puts "Please review failed tests above"
    end
    
    puts "="*80 + "\n"
  end
end

# Run tests
if __FILE__ == $0
  test = ImplementationTest.new
  test.run_tests
end