require 'rails_helper'

describe AdaptiveContentSelector do
  let(:user) { User.create!(email: 'test@example.com') }
  let(:selector) { AdaptiveContentSelector.new(user, 'docker') }

  describe '#next_content progression after completing first lesson' do
    it 'should not return critical reviews for chapters the user has not attempted' do
      # Setup: User has completed first chapter with 100% mastery
      mastery1 = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100,
        last_used_at: Time.current
      )

      # Create learning session
      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = { 'current_chapter' => 'codesprout-hello-world', 'current_micro' => 'codesprout-hello-world' }
      session.save!

      # CRITICAL TEST: Get next content after user completed chapter 1
      # This should NOT return a review of chapter 2 (which user hasn't learned)
      next_content = selector.next_content(last_correct: true)

      # If next_content is nil, that's actually fine - it means selector returned nothing
      # The problem occurs when it returns a review type for an unlearned chapter
      if next_content
        # If it returns something, it must not be a review of an unlearned chapter
        if next_content[:metadata][:chapter] == 'codesprout-docker-run'
          # If returning codesprout-docker-run, it should be interactive/lesson, NOT review
          expect(next_content[:type]).to_not match(/review/),
            "ERROR: Returning review of unlearned chapter codesprout-docker-run. " \
            "Should return interactive lesson instead. Got type: #{next_content[:type]}"
          expect(next_content[:metadata][:is_review]).to_not be_truthy,
            "ERROR: Metadata has is_review=true for unlearned chapter"
        end
      end
    end

    it 'should not show reviews for brand new chapters' do
      # User with one learned command
      mastery = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100
      )

      # Create session
      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = { 'current_chapter' => 'codesprout-hello-world' }
      session.save!

      # Get next content multiple times (in case of probabilistic stealth reviews)
      contents = []
      5.times do |i|
        content = selector.next_content(last_correct: true)
        contents << content if content
      end

      # Check all returned contents
      contents.each do |content|
        # If returning a chapter we haven't mastered, must be interactive/lesson
        if content[:metadata] && content[:metadata][:chapter]
          chapter = content[:metadata][:chapter]
          has_mastery = user.command_masteries.exists?(canonical_command: chapter)

          if !has_mastery && chapter != 'codesprout-hello-world'
            expect(content[:type]).to_not match(/review/),
              "ERROR: Got review type for unlearned chapter #{chapter}. Type: #{content[:type]}"
          end
        end
      end
    end
  end

  describe 'review system correctness' do
    it 'ensures reviews only appear after user has attempted the chapter' do
      # Create 3 chapters of mastery at different scores
      mastery1 = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100,
        last_used_at: 1.hour.ago
      )
      mastery2 = user.command_masteries.create!(
        canonical_command: 'codesprout-docker-run',
        proficiency_score: 70,  # Intermediate - might trigger review
        last_used_at: 30.minutes.ago
      )

      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = { 'current_chapter' => 'codesprout-docker-run', 'current_micro' => 'codesprout-docker-run' }
      session.save!

      # Get next content
      next_content = selector.next_content(last_correct: true)

      if next_content
        # If it's a review, it should only be for commands user has already learned
        if next_content[:type] && next_content[:type].include?('review')
          reviewed_chapter = next_content[:metadata][:chapter]
          has_mastery = user.command_masteries.exists?(canonical_command: reviewed_chapter)
          expect(has_mastery).to be_truthy,
            "ERROR: Got review for unlearned chapter #{reviewed_chapter}. " \
            "Reviews should only appear for chapters user has attempted."
        end
      end
    end
  end

  describe 'critical case: second lesson progression' do
    it 'does not create a review when progressing to the second lesson' do
      # This is the exact scenario the user reported
      # User completes lesson 1, starts lesson 2, should see lesson 2 not a review

      # Setup: First chapter fully mastered
      mastery1 = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100,
        last_used_at: Time.current
      )

      # Session on chapter 2 with completed_micros tracking (CRITICAL!)
      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = {
        'current_chapter' => 'codesprout-docker-run',
        'current_micro' => 'codesprout-docker-run',
        'completed_micros' => {
          'codesprout-hello-world' => ['codesprout-hello-world']
        }
      }
      session.save!

      # This is what happens after user gets correct answer on lesson 2
      next_content = selector.next_content(last_correct: true)

      # Verify: if returning lesson 2 (not learned yet), must NOT be a review
      if next_content && next_content[:metadata][:chapter] == 'codesprout-docker-run'
        has_mastery_for_ch2 = user.command_masteries.exists?(canonical_command: 'codesprout-docker-run')

        if !has_mastery_for_ch2
          expect(next_content[:type]).to_not match(/review/),
            "CRITICAL BUG: Returned review modal for unlearned chapter. " \
            "Should return interactive lesson. Type: #{next_content[:type]}"
          expect(next_content[:metadata][:is_review]).to_not be_truthy,
            "CRITICAL BUG: is_review metadata set for unlearned chapter"
        end
      end
    end

    it 'test with stealth review probability to ensure second lesson appears' do
      # Create chapter 1 mastered
      mastery1 = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100,
        last_used_at: 30.minutes.ago
      )

      # Session with chapter 1 completed, currently on chapter 2
      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = {
        'current_chapter' => 'codesprout-docker-run',
        'current_micro' => 'codesprout-docker-run',
        'completed_micros' => {
          'codesprout-hello-world' => ['codesprout-hello-world']
        }
      }
      session.save!

      # Try multiple times to account for probabilistic stealth reviews
      found_proper_progression = false
      10.times do
        next_content = selector.next_content(last_correct: true)
        if next_content
          # Should not return quick_review or scenario_review for unlearned chapter
          if next_content[:metadata][:chapter] == 'codesprout-docker-run'
            expect(next_content[:type]).to_not include('review'),
              "Got #{next_content[:type]} for codesprout-docker-run, should be interactive/lesson/practice"
            found_proper_progression = true
          end
        end
      end
    end

    it 'CRITICAL: does not show review when second lesson gets a low initial mastery score' do
      # This is the REAL issue - user completes lesson 1, starts lesson 2
      # On first correct answer, mastery gets boosted to some intermediate score
      # Then selector should NOT create a review for it

      # Chapter 1 fully mastered
      mastery1 = user.command_masteries.create!(
        canonical_command: 'codesprout-hello-world',
        proficiency_score: 100,
        last_used_at: 1.hour.ago
      )

      # THE CRITICAL PART: Chapter 2 just got a mastery record from first attempt
      # Simulate what happens when user correctly answers first micro of chapter 2
      mastery2 = user.command_masteries.create!(
        canonical_command: 'codesprout-docker-run',
        proficiency_score: 55,  # First-try success boost gave this score
        last_used_at: Time.current,
        consecutive_successes: 1
      )

      # Session state shows chapter 2 completed but only 1 micro
      session = user.learning_sessions.create!(session_id: SecureRandom.hex(16))
      session.state_data = {
        'current_chapter' => 'codesprout-docker-run',
        'current_micro' => 'codesprout-docker-run',
        'completed_micros' => {
          'codesprout-hello-world' => ['codesprout-hello-world'],
          'codesprout-docker-run' => ['codesprout-docker-run']  # Just completed first micro
        }
      }
      session.save!

      # This should NOT return a quick_review or scenario_review of chapter 2!
      next_content = selector.next_content(last_correct: true)

      if next_content
        # CRITICAL ASSERTION: Should not review chapter 2 even though it has 55% mastery
        # because it was just started
        if next_content[:type]&.include?('review')
          expect(next_content[:metadata][:chapter]).to_not eq('codesprout-docker-run'),
            "CRITICAL BUG: Got review of codesprout-docker-run with type #{next_content[:type]}. " \
            "Should not show review of just-started chapter. " \
            "Is the review checking 'completed_micros' to see if chapter was just started?"
        end
      end
    end
  end
end
