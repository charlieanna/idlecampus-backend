require 'rails_helper'

RSpec.describe QuizQuestion, type: :model do
  let(:quiz) { Quiz.create!(title: 'Chemistry Quiz', description: 'Test quiz', time_limit_minutes: 60, passing_score: 60) }

  describe 'numerical questions' do
    let(:numerical_question) do
      QuizQuestion.create!(
        quiz: quiz,
        question_type: 'numerical',
        question_text: 'What is the molar mass of H2SO4? (in g/mol)',
        correct_answer: '98.08',
        tolerance: 0.1,
        points: 2,
        difficulty: 0.5,
        discrimination: 1.2,
        guessing: 0.0,
        difficulty_level: 'medium'
      )
    end

    it 'accepts answer within tolerance' do
      expect(numerical_question.correct_answer?('98.0')).to be true
      expect(numerical_question.correct_answer?('98.08')).to be true
      expect(numerical_question.correct_answer?('98.15')).to be true
    end

    it 'rejects answer outside tolerance' do
      expect(numerical_question.correct_answer?('97.5')).to be false
      expect(numerical_question.correct_answer?('98.5')).to be false
      expect(numerical_question.correct_answer?('100.0')).to be false
    end

    it 'rejects non-numeric answers' do
      expect(numerical_question.correct_answer?('abc')).to be false
      expect(numerical_question.correct_answer?('')).to be false
    end

    it 'uses default tolerance if not specified' do
      question = QuizQuestion.create!(
        quiz: quiz,
        question_type: 'numerical',
        question_text: 'Calculate the value',
        correct_answer: '5.0',
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.0
      )

      expect(question.correct_answer?('5.01')).to be true
      expect(question.correct_answer?('5.02')).to be false  # Outside default 0.01 tolerance
    end
  end

  describe 'multiple-correct MCQs' do
    let(:multi_correct_question) do
      QuizQuestion.create!(
        quiz: quiz,
        question_type: 'mcq',
        multiple_correct: true,
        question_text: 'Which of the following are transition metals?',
        options: [
          { text: 'Iron (Fe)', correct: true },
          { text: 'Sodium (Na)', correct: false },
          { text: 'Copper (Cu)', correct: true },
          { text: 'Calcium (Ca)', correct: false }
        ],
        points: 3,
        difficulty: 1.0,
        discrimination: 1.5,
        guessing: 0.0,
        difficulty_level: 'hard'
      )
    end

    it 'accepts correct combination as array' do
      expect(multi_correct_question.correct_answer?([0, 2])).to be true
      expect(multi_correct_question.correct_answer?([2, 0])).to be true  # Order doesn't matter
    end

    it 'accepts correct combination as comma-separated string' do
      expect(multi_correct_question.correct_answer?('0,2')).to be true
      expect(multi_correct_question.correct_answer?('2,0')).to be true
    end

    it 'accepts correct combination as text' do
      expect(multi_correct_question.correct_answer?(['Iron (Fe)', 'Copper (Cu)'])).to be true
    end

    it 'rejects incorrect combinations' do
      expect(multi_correct_question.correct_answer?([0])).to be false  # Missing one correct answer
      expect(multi_correct_question.correct_answer?([0, 1, 2])).to be false  # Includes incorrect
      expect(multi_correct_question.correct_answer?([1, 3])).to be false  # All wrong
    end

    it 'validates that multiple_correct has at least 2 correct options' do
      invalid_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'mcq',
        multiple_correct: true,
        question_text: 'Test question',
        options: [
          { text: 'Option A', correct: true },
          { text: 'Option B', correct: false },
          { text: 'Option C', correct: false }
        ],
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.25
      )

      expect(invalid_question).not_to be_valid
      expect(invalid_question.errors[:multiple_correct]).to include('should have at least 2 correct options when multiple_correct is true')
    end
  end

  describe 'sequence questions' do
    let(:sequence_question) do
      QuizQuestion.create!(
        quiz: quiz,
        question_type: 'sequence',
        question_text: 'Arrange the following steps in the correct order for preparing a coordination compound:',
        sequence_items: [
          { id: 1, text: 'Dissolve metal salt in water' },
          { id: 2, text: 'Add ligand solution slowly' },
          { id: 3, text: 'Stir and heat the mixture' },
          { id: 4, text: 'Filter and dry the precipitate' }
        ],
        correct_answer: '1,2,3,4',  # Correct sequence
        points: 3,
        difficulty: 0.8,
        discrimination: 1.3,
        guessing: 0.0,
        difficulty_level: 'hard'
      )
    end

    it 'accepts correct sequence as array' do
      expect(sequence_question.correct_answer?([1, 2, 3, 4])).to be true
    end

    it 'accepts correct sequence as comma-separated string' do
      expect(sequence_question.correct_answer?('1,2,3,4')).to be true
      expect(sequence_question.correct_answer?('1, 2, 3, 4')).to be true  # With spaces
    end

    it 'rejects incorrect sequence' do
      expect(sequence_question.correct_answer?([2, 1, 3, 4])).to be false
      expect(sequence_question.correct_answer?([1, 3, 2, 4])).to be false
      expect(sequence_question.correct_answer?('4,3,2,1')).to be false
    end

    it 'validates sequence_items format' do
      invalid_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'sequence',
        question_text: 'Test',
        sequence_items: [{ text: 'Missing ID' }],  # Missing 'id' field
        correct_answer: '1',
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.0
      )

      expect(invalid_question).not_to be_valid
      expect(invalid_question.errors[:sequence_items]).to include("item 0 must have 'id' and 'text' fields")
    end

    it 'requires sequence_items to be present for sequence questions' do
      invalid_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'sequence',
        question_text: 'Test',
        sequence_items: [],
        correct_answer: '1,2,3',
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.0
      )

      expect(invalid_question).not_to be_valid
      expect(invalid_question.errors[:sequence_items]).to include("can't be blank")
    end
  end

  describe 'equation_balance questions' do
    let(:equation_question) do
      QuizQuestion.create!(
        quiz: quiz,
        question_type: 'equation_balance',
        question_text: 'Balance the following equation: Fe + O2 -> Fe2O3',
        correct_answer: '4 Fe + 3 O2 -> 2 Fe2O3',
        points: 3,
        difficulty: 1.2,
        discrimination: 1.4,
        guessing: 0.0,
        difficulty_level: 'hard'
      )
    end

    it 'accepts correctly balanced equation' do
      expect(equation_question.correct_answer?('4 Fe + 3 O2 -> 2 Fe2O3')).to be true
      expect(equation_question.correct_answer?('4Fe + 3O2 -> 2Fe2O3')).to be true  # No spaces
    end

    it 'accepts equivalent balanced equations with different formatting' do
      expect(equation_question.correct_answer?('4 Fe + 3 O2 => 2 Fe2O3')).to be true  # Different arrow
    end

    it 'rejects unbalanced equations' do
      expect(equation_question.correct_answer?('Fe + O2 -> Fe2O3')).to be false
      expect(equation_question.correct_answer?('2 Fe + O2 -> Fe2O3')).to be false
    end

    it 'rejects equations with wrong stoichiometry' do
      expect(equation_question.correct_answer?('2 Fe + 3 O2 -> Fe2O3')).to be false
    end
  end

  describe 'question type validation' do
    it 'accepts new chemistry question types' do
      expect {
        QuizQuestion.create!(
          quiz: quiz,
          question_type: 'numerical',
          question_text: 'Test',
          correct_answer: '1.0',
          points: 1,
          difficulty: 0.0,
          discrimination: 1.0,
          guessing: 0.0
        )
      }.not_to raise_error

      expect {
        QuizQuestion.create!(
          quiz: quiz,
          question_type: 'equation_balance',
          question_text: 'Test',
          correct_answer: 'H2 + O2 -> H2O',
          points: 1,
          difficulty: 0.0,
          discrimination: 1.0,
          guessing: 0.0
        )
      }.not_to raise_error

      expect {
        QuizQuestion.create!(
          quiz: quiz,
          question_type: 'sequence',
          question_text: 'Test',
          sequence_items: [{ id: 1, text: 'Step 1' }],
          correct_answer: '1',
          points: 1,
          difficulty: 0.0,
          discrimination: 1.0,
          guessing: 0.0
        )
      }.not_to raise_error
    end

    it 'rejects invalid question types' do
      invalid_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'invalid_type',
        question_text: 'Test',
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.0
      )

      expect(invalid_question).not_to be_valid
      expect(invalid_question.errors[:question_type]).to be_present
    end
  end

  describe 'tolerance validation' do
    it 'requires positive tolerance for numerical questions' do
      invalid_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'numerical',
        question_text: 'Test',
        correct_answer: '5.0',
        tolerance: -0.1,  # Negative tolerance
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.0
      )

      expect(invalid_question).not_to be_valid
      expect(invalid_question.errors[:tolerance]).to be_present
    end

    it 'does not require tolerance for non-numerical questions' do
      mcq_question = QuizQuestion.new(
        quiz: quiz,
        question_type: 'mcq',
        question_text: 'Test',
        options: [{ text: 'A', correct: true }],
        points: 1,
        difficulty: 0.0,
        discrimination: 1.0,
        guessing: 0.25
      )

      expect(mcq_question).to be_valid
    end
  end
end
