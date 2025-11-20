import React, { useState } from 'react';
import { CheckCircleIcon, XCircleIcon, QuestionMarkCircleIcon } from '@heroicons/react/24/solid';

const QuickQuiz = ({ question, unitSlug, csrfToken, onComplete }) => {
  const [selectedAnswer, setSelectedAnswer] = useState('');
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [isCorrect, setIsCorrect] = useState(null);
  const [showExplanation, setShowExplanation] = useState(false);

  const handleSubmit = async () => {
    if (!selectedAnswer) return;

    try {
      const response = await fetch(`/interactive_learning/${unitSlug}/submit_quiz`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ answer: selectedAnswer })
      });

      const data = await response.json();
      
      if (data.success) {
        setIsSubmitted(true);
        setIsCorrect(data.correct);
        setShowExplanation(true);
        
        if (data.correct) {
          setTimeout(() => {
            onComplete(data);
          }, 2000);
        }
      }
    } catch (error) {
      console.error('Error submitting quiz:', error);
    }
  };

  const handleRetry = () => {
    setSelectedAnswer('');
    setIsSubmitted(false);
    setIsCorrect(null);
    setShowExplanation(false);
  };

  return (
    <div className="space-y-6">
      {/* Title */}
      <div className="flex items-center space-x-3 mb-6">
        <QuestionMarkCircleIcon className="h-8 w-8 text-purple-600" />
        <h2 className="text-2xl font-bold text-gray-900">Quick Check</h2>
      </div>

      {/* Question */}
      <div className="bg-purple-50 border border-purple-200 rounded-lg p-6">
        <p className="text-lg text-purple-900 font-medium">
          {question.text}
        </p>
      </div>

      {/* Answer Options */}
      <div className="space-y-3">
        {question.type === 'mcq' && question.options && (
          <div className="space-y-3">
            {question.options.map((option, index) => {
              const isSelected = selectedAnswer === option.text;
              const showCorrect = isSubmitted && option.correct;
              const showWrong = isSubmitted && isSelected && !option.correct;
              
              return (
                <button
                  key={index}
                  onClick={() => !isSubmitted && setSelectedAnswer(option.text)}
                  disabled={isSubmitted}
                  className={`w-full text-left p-4 rounded-lg border-2 transition ${
                    showCorrect
                      ? 'border-green-500 bg-green-50'
                      : showWrong
                      ? 'border-red-500 bg-red-50'
                      : isSelected
                      ? 'border-purple-500 bg-purple-50'
                      : 'border-gray-200 hover:border-purple-300 bg-white'
                  } ${isSubmitted ? 'cursor-default' : 'cursor-pointer'}`}
                >
                  <div className="flex items-center justify-between">
                    <span className={`${showCorrect ? 'text-green-900' : showWrong ? 'text-red-900' : 'text-gray-900'}`}>
                      {option.text}
                    </span>
                    {showCorrect && <CheckCircleIcon className="h-6 w-6 text-green-500" />}
                    {showWrong && <XCircleIcon className="h-6 w-6 text-red-500" />}
                  </div>
                </button>
              );
            })}
          </div>
        )}

        {question.type === 'true_false' && (
          <div className="grid grid-cols-2 gap-4">
            {['true', 'false'].map((value) => {
              const isSelected = selectedAnswer === value;
              const isCorrectAnswer = isSubmitted && question.correct_answer === value;
              const isWrongAnswer = isSubmitted && isSelected && question.correct_answer !== value;
              
              return (
                <button
                  key={value}
                  onClick={() => !isSubmitted && setSelectedAnswer(value)}
                  disabled={isSubmitted}
                  className={`p-6 rounded-lg border-2 font-semibold text-lg transition ${
                    isCorrectAnswer
                      ? 'border-green-500 bg-green-50 text-green-900'
                      : isWrongAnswer
                      ? 'border-red-500 bg-red-50 text-red-900'
                      : isSelected
                      ? 'border-purple-500 bg-purple-50 text-purple-900'
                      : 'border-gray-200 hover:border-purple-300 bg-white text-gray-900'
                  } ${isSubmitted ? 'cursor-default' : 'cursor-pointer'}`}
                >
                  {value === 'true' ? '✓ True' : '✗ False'}
                </button>
              );
            })}
          </div>
        )}

        {question.type === 'fill_in_blank' && (
          <div>
            <input
              type="text"
              value={selectedAnswer}
              onChange={(e) => setSelectedAnswer(e.target.value)}
              disabled={isSubmitted}
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-purple-500 focus:border-transparent font-mono"
              placeholder="Type your answer..."
            />
          </div>
        )}
      </div>

      {/* Explanation */}
      {showExplanation && question.explanation && (
        <div className={`p-4 rounded-lg border-2 ${
          isCorrect 
            ? 'bg-green-50 border-green-200' 
            : 'bg-blue-50 border-blue-200'
        }`}>
          <h4 className={`font-semibold mb-2 ${
            isCorrect ? 'text-green-900' : 'text-blue-900'
          }`}>
            {isCorrect ? '✓ Correct!' : 'Explanation:'}
          </h4>
          <p className={isCorrect ? 'text-green-800' : 'text-blue-800'}>
            {question.explanation}
          </p>
        </div>
      )}

      {/* Action Buttons */}
      <div className="flex items-center justify-between pt-4">
        <div>
          {isSubmitted && !isCorrect && (
            <button
              onClick={handleRetry}
              className="px-4 py-2 text-purple-600 hover:text-purple-700 hover:bg-purple-50 rounded-lg transition"
            >
              Try Again
            </button>
          )}
        </div>
        
        <button
          onClick={handleSubmit}
          disabled={!selectedAnswer || isSubmitted}
          className="px-6 py-3 bg-purple-600 text-white rounded-lg hover:bg-purple-700 transition font-semibold disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSubmitted ? (isCorrect ? 'Moving on...' : 'Submitted') : 'Submit Answer'}
        </button>
      </div>
    </div>
  );
};

export default QuickQuiz;

