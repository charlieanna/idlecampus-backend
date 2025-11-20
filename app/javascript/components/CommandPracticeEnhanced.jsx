import React, { useState, useCallback } from 'react';
import { CheckCircleIcon, XCircleIcon, LightBulbIcon, CommandLineIcon } from '@heroicons/react/24/solid';

const CommandPracticeEnhanced = ({ unit, csrfToken, onComplete, attempts: initialAttempts }) => {
  const [userInput, setUserInput] = useState('');
  const [attempts, setAttempts] = useState(initialAttempts || 0);
  const [showHint, setShowHint] = useState(false);
  const [isCorrect, setIsCorrect] = useState(null);
  const [feedback, setFeedback] = useState('');
  const [hint, setHint] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = useCallback(async () => {
    if (!userInput.trim() || isSubmitting) return;

    setIsSubmitting(true);

    try {
      const response = await fetch(`/interactive_learning/${unit.slug}/submit_practice`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({ answer: userInput })
      });

      const data = await response.json();
      
      if (data.success) {
        setIsCorrect(data.correct);
        setFeedback(data.message);
        setAttempts(data.progress.practice_attempts);
        
        if (data.hint) {
          setHint(data.hint);
          setShowHint(true);
        }

        if (data.correct) {
          // Call onComplete with the full response data
          setTimeout(() => {
            onComplete(data);
          }, 1500);
        }
      }
    } catch (error) {
      console.error('Error submitting practice:', error);
      setFeedback('An error occurred. Please try again.');
    } finally {
      setIsSubmitting(false);
    }
  }, [userInput, unit.slug, csrfToken, onComplete, isSubmitting]);

  const handleKeyPress = (e) => {
    if (e.key === 'Enter' && !isCorrect) {
      handleSubmit();
    }
  };

  const handleGetHint = async () => {
    try {
      const response = await fetch(`/interactive_learning/${unit.slug}/hint`, {
        headers: {
          'X-CSRF-Token': csrfToken
        }
      });

      const data = await response.json();
      if (data.success && data.hint) {
        setHint(data.hint);
        setShowHint(true);
      }
    } catch (error) {
      console.error('Error getting hint:', error);
    }
  };

  return (
    <div className="space-y-6">
      {/* Title */}
      <div className="flex items-center space-x-3 mb-6">
        <CommandLineIcon className="h-8 w-8 text-green-600" />
        <h2 className="text-2xl font-bold text-gray-900">Practice Time</h2>
      </div>

      {/* Instructions */}
      <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
        <p className="text-blue-900 font-medium">
          Type the command to {unit.title.toLowerCase()}:
        </p>
      </div>

      {/* Command Input */}
      <div className="mb-6">
        <label htmlFor="command-input" className="block text-sm font-medium text-gray-700 mb-2">
          Enter the Docker command:
        </label>
        <div className="relative">
          <input
            id="command-input"
            type="text"
            value={userInput}
            onChange={(e) => setUserInput(e.target.value)}
            onKeyPress={handleKeyPress}
            className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent font-mono text-lg"
            placeholder="docker ..."
            disabled={isCorrect === true || isSubmitting}
            autoFocus
          />
          {isCorrect !== null && (
            <div className="absolute right-3 top-1/2 transform -translate-y-1/2">
              {isCorrect ? (
                <CheckCircleIcon className="h-6 w-6 text-green-500" />
              ) : (
                <XCircleIcon className="h-6 w-6 text-red-500" />
              )}
            </div>
          )}
        </div>
        
        {/* Attempts Counter */}
        {attempts > 0 && (
          <p className="mt-2 text-sm text-gray-600">
            Attempts: {attempts}
          </p>
        )}
      </div>

      {/* Feedback */}
      {feedback && (
        <div className={`p-4 rounded-lg ${isCorrect ? 'bg-green-50 text-green-800' : 'bg-red-50 text-red-800'}`}>
          <p className="font-medium">{feedback}</p>
        </div>
      )}

      {/* Hint */}
      {showHint && hint && !isCorrect && (
        <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
          <div className="flex items-start space-x-2">
            <LightBulbIcon className="h-5 w-5 text-yellow-500 mt-0.5 flex-shrink-0" />
            <div>
              <h4 className="text-sm font-medium text-yellow-900 mb-1">Hint:</h4>
              <p className="text-sm text-yellow-800">{hint}</p>
            </div>
          </div>
        </div>
      )}

      {/* Action Buttons */}
      <div className="flex items-center justify-between pt-4">
        <button
          onClick={handleGetHint}
          disabled={isCorrect === true}
          className="px-4 py-2 text-blue-600 hover:text-blue-700 hover:bg-blue-50 rounded-lg transition disabled:opacity-50 disabled:cursor-not-allowed"
        >
          💡 Get Hint
        </button>
        
        <button
          onClick={handleSubmit}
          disabled={isCorrect === true || isSubmitting || !userInput.trim()}
          className="px-6 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700 transition font-semibold disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSubmitting ? 'Checking...' : 'Submit'}
        </button>
      </div>
    </div>
  );
};

export default CommandPracticeEnhanced;

