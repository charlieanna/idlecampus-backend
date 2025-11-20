import React, { useState, useEffect, useCallback } from 'react';
import { ChevronRightIcon, CheckCircleIcon, XCircleIcon, ClockIcon, LightBulbIcon } from '@heroicons/react/24/solid';

const CommandPractice = ({ user, currentCommand, onComplete, onNext }) => {
  const [userInput, setUserInput] = useState('');
  const [attempts, setAttempts] = useState(0);
  const [showHint, setShowHint] = useState(false);
  const [isCorrect, setIsCorrect] = useState(null);
  const [feedback, setFeedback] = useState('');
  const [timeSpent, setTimeSpent] = useState(0);
  const [startTime] = useState(Date.now());

  // Update timer every second
  useEffect(() => {
    const timer = setInterval(() => {
      setTimeSpent(Math.floor((Date.now() - startTime) / 1000));
    }, 1000);

    return () => clearInterval(timer);
  }, [startTime]);

  const checkAnswer = useCallback(() => {
    if (!currentCommand || !userInput.trim()) return;

    const trimmedInput = userInput.trim();
    const correctAnswer = currentCommand.command;
    const isAnswerCorrect = trimmedInput === correctAnswer;

    setAttempts(prev => prev + 1);
    setIsCorrect(isAnswerCorrect);

    if (isAnswerCorrect) {
      setFeedback('Excellent! That\'s the correct command.');
      setTimeout(() => {
        onComplete({
          commandId: currentCommand.id,
          attempts: attempts + 1,
          timeSpent,
          correct: true,
          userAnswer: trimmedInput
        });
      }, 1500);
    } else {
      // Provide specific feedback based on common mistakes
      setFeedback(generateFeedback(trimmedInput, correctAnswer));
      
      if (attempts >= 2 && !showHint) {
        setShowHint(true);
      }
    }
  }, [userInput, currentCommand, attempts, timeSpent, onComplete, showHint]);

  const generateFeedback = (userAnswer, correctAnswer) => {
    const userWords = userAnswer.split(' ');
    const correctWords = correctAnswer.split(' ');

    if (userWords[0] !== correctWords[0]) {
      return `Incorrect command. The command should start with "${correctWords[0]}".`;
    }

    if (userWords.length !== correctWords.length) {
      return `Check the number of arguments. Expected ${correctWords.length} parts, got ${userWords.length}.`;
    }

    for (let i = 1; i < correctWords.length; i++) {
      if (userWords[i] !== correctWords[i]) {
        return `Check argument ${i}: expected "${correctWords[i]}", got "${userWords[i] || '(missing)'}".`;
      }
    }

    return 'Close, but not quite right. Check your syntax carefully.';
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      checkAnswer();
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const getDifficultyColor = (difficulty) => {
    if (difficulty <= 0.3) return 'text-green-600 bg-green-100';
    if (difficulty <= 0.7) return 'text-yellow-600 bg-yellow-100';
    return 'text-red-600 bg-red-100';
  };

  const getDifficultyLabel = (difficulty) => {
    if (difficulty <= 0.3) return 'Easy';
    if (difficulty <= 0.7) return 'Medium';
    return 'Hard';
  };

  if (!currentCommand) {
    return (
      <div className="flex items-center justify-center h-64">
        <div className="text-gray-500">Loading command...</div>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-lg p-6 max-w-4xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center space-x-4">
          <h2 className="text-2xl font-bold text-gray-900">{currentCommand.title}</h2>
          <span className={`px-3 py-1 rounded-full text-sm font-medium ${getDifficultyColor(currentCommand.difficulty)}`}>
            {getDifficultyLabel(currentCommand.difficulty)}
          </span>
        </div>
        <div className="flex items-center space-x-4 text-sm text-gray-500">
          <div className="flex items-center space-x-1">
            <ClockIcon className="h-4 w-4" />
            <span>{formatTime(timeSpent)}</span>
          </div>
          <div>Attempts: {attempts}</div>
        </div>
      </div>

      {/* Description */}
      <div className="mb-6">
        <p className="text-gray-700 text-lg leading-relaxed">
          {currentCommand.explanation}
        </p>
      </div>

      {/* Example (if available) */}
      {currentCommand.example && (
        <div className="mb-6 p-4 bg-gray-50 rounded-lg">
          <h3 className="text-sm font-medium text-gray-700 mb-2">Example:</h3>
          <code className="text-sm text-gray-800 font-mono">
            {currentCommand.example}
          </code>
        </div>
      )}

      {/* Practice Area */}
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
            disabled={isCorrect === true}
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
      </div>

      {/* Feedback */}
      {feedback && (
        <div className={`mb-4 p-4 rounded-lg ${isCorrect ? 'bg-green-50 text-green-800' : 'bg-red-50 text-red-800'}`}>
          <p>{feedback}</p>
        </div>
      )}

      {/* Hint */}
      {showHint && !isCorrect && (
        <div className="mb-4 p-4 bg-blue-50 border border-blue-200 rounded-lg">
          <div className="flex items-start space-x-2">
            <LightBulbIcon className="h-5 w-5 text-blue-500 mt-0.5" />
            <div>
              <h4 className="text-sm font-medium text-blue-800 mb-1">Hint:</h4>
              <p className="text-sm text-blue-700">
                {currentCommand.hint || `The command starts with "${currentCommand.command.split(' ')[0]}"`}
              </p>
            </div>
          </div>
        </div>
      )}

      {/* Action Buttons */}
      <div className="flex items-center justify-between">
        <button
          onClick={() => setShowHint(true)}
          className="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-100 hover:bg-gray-200 rounded-lg transition-colors"
          disabled={showHint}
        >
          Show Hint
        </button>

        <div className="flex space-x-3">
          {isCorrect === true ? (
            <button
              onClick={onNext}
              className="flex items-center space-x-2 px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 transition-colors"
            >
              <span>Next Command</span>
              <ChevronRightIcon className="h-4 w-4" />
            </button>
          ) : (
            <button
              onClick={checkAnswer}
              disabled={!userInput.trim()}
              className="px-6 py-3 bg-blue-600 text-white font-medium rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
            >
              Check Answer
            </button>
          )}
        </div>
      </div>

      {/* Progress indicator */}
      <div className="mt-6 pt-4 border-t border-gray-200">
        <div className="flex items-center justify-between text-sm text-gray-500">
          <span>Category: {currentCommand.category}</span>
          <span>Exam Frequency: {Math.round(currentCommand.exam_frequency * 100)}%</span>
        </div>
      </div>
    </div>
  );
};

export default CommandPractice;