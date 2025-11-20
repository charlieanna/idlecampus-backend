\nrequire 'rails_helper'\n\nRSpec.describe UserCommandMastery, type: :model do\n  let(:user) { create(:user) }\n  let(:mastery) do\n    described_class.create!(\n      user: user,\n      canonical_command: 'docker_run',\n      proficiency_score: 0.75,\n      total_attempts: 10,\n      successful_attempts: 7,\n      practice_attempts: 5,\n      practice_successes: 3,\n      quiz_attempts: 3,\n      quiz_successes: 2,\n      lab_attempts: 2,\n      lab_successes: 2,\n      last_practiced_at: 1.hour.ago,\n      last_correct_at: 30.minutes.ago\n    )\n  end\n\n  describe 'validations' do\n    it { should belong_to(:user) }\n    \n    it 'requires a canonical_command' do\n      mastery = described_class.new(user: user)\n      expect(mastery).not_to be_valid\n      expect(mastery.errors[:canonical_command]).to include(\"can't be blank\")\n    end\n    \n    it 'requires unique canonical_command per user' do\n      mastery.save!\n      duplicate = described_class.new(\n        user: user,\n        canonical_command: 'docker_run'\n      )\n      expect(duplicate).not_to be_valid\n      expect(duplicate.errors[:canonical_command]).to include(\"has already been taken\")\n    end\n    \n    it 'validates proficiency_score range' do\n      mastery.proficiency_score = -0.1\n      expect(mastery).not_to be_valid\n      \n      mastery.proficiency_score = 1.1\n      expect(mastery).not_to be_valid\n      \n      mastery.proficiency_score = 0.5\n      expect(mastery).to be_valid\n    end\n  end\n\n  describe '#calculate_weighted_proficiency' do\n    it 'applies correct weights to different contexts' do\n      mastery.practice_attempts = 10\n      mastery.practice_successes = 8\n      mastery.quiz_attempts = 10\n      mastery.quiz_successes = 7\n      mastery.lab_attempts = 10\n      mastery.lab_successes = 6\n      mastery.real_project_attempts = 10\n      mastery.real_project_successes = 5\n      \n      weighted = mastery.calculate_weighted_proficiency\n      \n      # Expected: (0.8*0.2 + 0.7*0.3 + 0.6*0.4 + 0.5*0.1) = 0.66\n      expect(weighted).to be_within(0.01).of(0.66)\n    end\n    \n    it 'handles zero attempts gracefully' do\n      mastery.practice_attempts = 0\n      mastery.quiz_attempts = 0\n      mastery.lab_attempts = 0\n      mastery.real_project_attempts = 0\n      \n      expect(mastery.calculate_weighted_proficiency).to eq(0.0)\n    end\n  end\n\n  describe '#apply_decay!' do\n    context 'with recent practice' do\n      it 'does not decay within 24 hours' do\n        mastery.last_practiced_at = 12.hours.ago\n        initial_score = mastery.proficiency_score\n        \n        mastery.apply_decay!\n        \n        expect(mastery.proficiency_score).to eq(initial_score)\n      end\n    end\n    \n    context 'with old practice' do\n      it 'applies exponential decay after 24 hours' do\n        mastery.last_practiced_at = 2.days.ago\n        mastery.proficiency_score = 0.8\n        \n        mastery.apply_decay!\n        \n        # Should decay but not below muscle memory floor\n        expect(mastery.proficiency_score).to be < 0.8\n        expect(mastery.proficiency_score).to be >= 0.32 # 40% of 0.8\n        expect(mastery.decay_applied_at).to be_present\n      end\n      \n      it 'respects muscle memory floor of 40%' do\n        mastery.last_practiced_at = 30.days.ago\n        mastery.proficiency_score = 1.0\n        mastery.muscle_memory_floor = 0.4\n        \n        mastery.apply_decay!\n        \n        expect(mastery.proficiency_score).to eq(0.4)\n      end\n    end\n    \n    it 'updates decay_applied_at timestamp' do\n      mastery.last_practiced_at = 3.days.ago\n      \n      freeze_time do\n        mastery.apply_decay!\n        expect(mastery.decay_applied_at).to eq(Time.current)\n      end\n    end\n  end\n\n  describe '#needs_review?' do\n    it 'returns true for low proficiency' do\n      mastery.proficiency_score = 0.3\n      expect(mastery.needs_review?).to be true\n    end\n    \n    it 'returns true for old practice' do\n      mastery.proficiency_score = 0.8\n      mastery.last_practiced_at = 8.days.ago\n      expect(mastery.needs_review?).to be true\n    end\n    \n    it 'returns false for high proficiency and recent practice' do\n      mastery.proficiency_score = 0.8\n      mastery.last_practiced_at = 2.days.ago\n      expect(mastery.needs_review?).to be false\n    end\n    \n    it 'uses custom thresholds' do\n      mastery.proficiency_score = 0.6\n      mastery.last_practiced_at = 4.days.ago\n      \n      expect(mastery.needs_review?(proficiency_threshold: 0.7)).to be true\n      expect(mastery.needs_review?(days_threshold: 3)).to be true\n      expect(mastery.needs_review?(proficiency_threshold: 0.5, days_threshold: 5)).to be false\n    end\n  end\n\n  describe '#memory_shield' do\n    context 'based on last_correct_at' do\n      it 'returns nil for no correct attempts' do\n        mastery.last_correct_at = nil\n        expect(mastery.memory_shield).to be_nil\n      end\n      \n      it 'returns bronze for recent correct (< 7 days)' do\n        mastery.last_correct_at = 3.days.ago\n        expect(mastery.memory_shield).to eq('bronze')\n      end\n      \n      it 'returns silver for 7-30 days retention' do\n        mastery.last_correct_at = 15.days.ago\n        mastery.proficiency_score = 0.8\n        expect(mastery.memory_shield).to eq('silver')\n      end\n      \n      it 'returns gold for 30-90 days retention' do\n        mastery.last_correct_at = 45.days.ago\n        mastery.proficiency_score = 0.9\n        expect(mastery.memory_shield).to eq('gold')\n      end\n      \n      it 'returns platinum for 90+ days retention' do\n        mastery.last_correct_at = 100.days.ago\n        mastery.proficiency_score = 0.95\n        expect(mastery.memory_shield).to eq('platinum')\n      end\n      \n      it 'downgrades shield for low proficiency' do\n        mastery.last_correct_at = 45.days.ago\n        mastery.proficiency_score = 0.4\n        expect(mastery.memory_shield).to eq('bronze')\n      end\n    end\n  end\n\n  describe '#success_rate' do\n    it 'calculates overall success rate' do\n      mastery.total_attempts = 10\n      mastery.successful_attempts = 7\n      expect(mastery.success_rate).to eq(0.7)\n    end\n    \n    it 'handles zero attempts' do\n      mastery.total_attempts = 0\n      expect(mastery.success_rate).to eq(0.0)\n    end\n    \n    it 'calculates context-specific success rates' do\n      mastery.practice_attempts = 10\n      mastery.practice_successes = 8\n      expect(mastery.success_rate('practice')).to eq(0.8)\n      \n      mastery.quiz_attempts = 5\n      mastery.quiz_successes = 3\n      expect(mastery.success_rate('quiz')).to eq(0.6)\n    end\n  end\n\n  describe '#update_contexts_seen' do\n    it 'tracks unique contexts' do\n      mastery.contexts_seen = []\n      \n      mastery.update_contexts_seen('practice')\n      expect(mastery.contexts_seen).to eq(['practice'])\n      \n      mastery.update_contexts_seen('quiz')\n      expect(mastery.contexts_seen).to contain_exactly('practice', 'quiz')\n      \n      mastery.update_contexts_seen('practice') # Duplicate\n      expect(mastery.contexts_seen).to contain_exactly('practice', 'quiz')\n    end\n  end\n\n  describe 'scopes' do\n    let!(:high_proficiency) do\n      described_class.create!(\n        user: user,\n        canonical_command: 'docker_run',\n        proficiency_score: 0.9,\n        last_practiced_at: 1.day.ago\n      )\n    end\n    \n    let!(:low_proficiency) do\n      described_class.create!(\n        user: create(:user),\n        canonical_command: 'docker_ps',\n        prof
iciency_score: 0.3,
        last_practiced_at: 10.days.ago
      )
    end
    
    let!(:needs_review) do
      described_class.create!(
        user: user,
        canonical_command: 'docker_build',
        proficiency_score: 0.4,
        last_practiced_at: 8.days.ago
      )
    end
    
    describe '.needing_review' do
      it 'returns commands needing review' do
        results = described_class.needing_review
        expect(results).to include(needs_review, low_proficiency)
        expect(results).not_to include(high_proficiency)
      end
    end
    
    describe '.mastered' do
      it 'returns commands with high proficiency' do
        results = described_class.mastered
        expect(results).to include(high_proficiency)
        expect(results).not_to include(low_proficiency, needs_review)
      end
    end
    
    describe '.by_command' do
      it 'filters by canonical command' do
        results = described_class.by_command('docker_run')
        expect(results).to include(high_proficiency)
        expect(results).not_to include(low_proficiency)
      end
    end
  end

  describe 'JSON fields' do
    it 'properly stores and retrieves contexts_seen' do
      mastery.contexts_seen = ['practice', 'quiz', 'lab']
      mastery.save!
      mastery.reload
      
      expect(mastery.contexts_seen).to eq(['practice', 'quiz', 'lab'])
    end
    
    it 'handles empty arrays' do
      mastery.contexts_seen = []
      mastery.save!
      mastery.reload
      
      expect(mastery.contexts_seen).to eq([])
    end
  end
end