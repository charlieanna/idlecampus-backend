require 'rails_helper'

RSpec.describe ReviewGenerator do
  let(:user) { User.first || User.create!(email: 'test@example.com') }
  let(:mastery) do
    UserCommandMastery.create!(
      user: user,
      canonical_command: 'codesprout-naming-containers',
      proficiency_score: 45,
      last_used_at: 5.days.ago
    )
  end

  describe '.generate_single_command_review' do
    it 'generates a review for the command' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review).to be_a(Hash)
      expect(review[:id]).to be_present
      expect(review[:type]).to eq('quick_review')
      expect(review[:content]).to be_a(Hash)
    end

    it 'includes the command to review' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:content][:command_to_learn]).to be_present
      expect(review[:content][:expected_command]).to be_present
    end

    it 'includes scenario narrative' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:content][:scenario_narrative]).to be_present
      expect(review[:content][:scenario_narrative]).to be_a(String)
    end

    it 'includes progressive hints (3 levels)' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:content][:practice_hints]).to be_an(Array)
      expect(review[:content][:practice_hints].length).to eq(3)

      # All hints should be present and meaningful
      hint1, hint2, hint3 = review[:content][:practice_hints]
      expect(hint1).to be_present
      expect(hint2).to be_present
      expect(hint3).to be_present
    end

    it 'includes original chapter slug' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:content][:original_chapter]).to eq('codesprout-naming-containers')
    end

    it 'marks as review content' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:content][:is_review]).to be true
      expect(review[:content][:difficulty_level]).to eq('review')
    end
  end

  describe '.generate_multi_command_review' do
    let(:mastery1) do
      UserCommandMastery.create!(
        user: user,
        canonical_command: 'docker run',
        proficiency_score: 65
      )
    end

    let(:mastery2) do
      UserCommandMastery.create!(
        user: user,
        canonical_command: 'docker ps',
        proficiency_score: 70
      )
    end

    let(:mastery3) do
      UserCommandMastery.create!(
        user: user,
        canonical_command: 'docker stop',
        proficiency_score: 68
      )
    end

    it 'generates a batch review for multiple commands' do
      masteries = [mastery1, mastery2, mastery3]
      review = described_class.generate_multi_command_review(masteries, user)

      expect(review).to be_a(Hash)
      expect(review[:id]).to be_present
      expect(review[:type]).to eq('scenario_review')
    end

    it 'includes all commands in the review' do
      masteries = [mastery1, mastery2, mastery3]
      review = described_class.generate_multi_command_review(masteries, user)

      steps = review[:content][:steps]
      expect(steps).to be_an(Array)
      expect(steps.length).to eq(3)
    end

    it 'creates a realistic scenario involving all commands' do
      masteries = [mastery1, mastery2, mastery3]
      review = described_class.generate_multi_command_review(masteries, user)

      scenario = review[:content][:scenario_narrative]
      expect(scenario).to be_present
      expect(scenario).to be_a(String)
      expect(scenario.length).to be > 50  # Should be a detailed scenario
    end
  end

  describe '.get_original_chapter_slug' do
    it 'returns the chapter slug for a command' do
      # For a command like "docker run -d --name web nginx"
      # Should return the base chapter slug
      slug = described_class.get_original_chapter_slug('docker run -d --name web nginx')

      expect(slug).to be_a(String)
      # Should return something like 'codesprout-naming-containers' or 'docker run'
      expect(slug).to be_present
    end

    it 'handles slug-like commands' do
      slug = described_class.get_original_chapter_slug('codesprout-naming-containers')

      expect(slug).to eq('codesprout-naming-containers')
    end
  end

  describe 'hint quality' do
    it 'first hint is general guidance' do
      review = described_class.generate_single_command_review(mastery, user)
      hints = review[:content][:practice_hints]
      hint1 = hints[0]

      # Should be guiding, not specific
      expect(hint1).to be_present
      expect(hint1.length).to be < 200
    end

    it 'second hint is more specific' do
      review = described_class.generate_single_command_review(mastery, user)
      hints = review[:content][:practice_hints]
      hint2 = hints[1]

      # Should mention specific parts needed
      expect(hint2).to be_present
      expect(hint2.length).to be > 20
    end

    it 'third hint nearly gives the answer' do
      review = described_class.generate_single_command_review(mastery, user)
      hints = review[:content][:practice_hints]
      hint3 = hints[2]

      # Should be detailed
      expect(hint3).to be_present
      expect(hint3.length).to be > 30  # Substantial hint
    end
  end

  describe 'review content validation' do
    it 'all required fields are present' do
      review = described_class.generate_single_command_review(mastery, user)

      expect(review[:id]).to be_present
      expect(review[:type]).to be_present
      expect(review[:content]).to be_present
      expect(review[:content][:scenario_narrative]).to be_present
      expect(review[:content][:command_to_learn]).to be_present
      expect(review[:content][:expected_command]).to be_present
      expect(review[:content][:practice_hints]).to be_present
    end

    it 'hints are not empty strings' do
      review = described_class.generate_single_command_review(mastery, user)

      review[:content][:practice_hints].each do |hint|
        expect(hint).to be_present
        expect(hint.length).to be > 10
      end
    end

    it 'scenario is contextual and not generic' do
      review = described_class.generate_single_command_review(mastery, user)
      scenario = review[:content][:scenario_narrative]

      # Should not be generic like "Practice this command"
      expect(scenario).not_to match(/practice this/i)
      expect(scenario).not_to match(/try this/i)

      # Should describe a real task
      expect(scenario.length).to be > 30
    end
  end
end
