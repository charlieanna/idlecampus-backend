import React, { useState, useEffect } from 'react';
import { ChevronRightIcon, LightBulbIcon, CheckCircleIcon, XCircleIcon, ArrowRightIcon } from '@heroicons/react/24/outline';

const RemedialDrill = ({ 
  drill, 
  onComplete, 
  onSkip,
  userMastery,
  className = '' 
}) => {
  const [currentAttempt, setCurrentAttempt] = useState('');
  const [attempts, setAttempts] = useState([]);
  const [hintLevel, setHintLevel] = useState(0);
  const [isComplete, setIsComplete] = useState(false);
  const [showSuccess, setShowSuccess] = useState(false);
  const [timeSpent, setTimeSpent] = useState(0);
  const [startTime, setStartTime] = useState(null);

  // Start timing when component mounts
  useEffect(() => {
    setStartTime(Date.now());
    const timer = setInterval(() => {
      if (startTime) {
        setTimeSpent(Math.floor((Date.now() - startTime) / 1000));
      }
    }, 1000);

    return () => clearInterval(timer);
  }, [startTime]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!currentAttempt.trim()) return;

    const attempt = {
      command: currentAttempt.trim(),
      hintLevel,
      timeSpent: Date.now() - startTime
    };

    const isCorrect = checkAnswer(currentAttempt.trim());
    const newAttempts = [...attempts, { ...attempt, correct: isCorrect }];
    setAttempts(newAttempts);

    if (isCorrect) {
      setIsComplete(true);
      setShowSuccess(true);
      
      // Record successful completion
      await recordAttempt({
        command: drill.canonical_command,
        context: 'remedial_drill',
        success: true,
        hintLevel,
        attempts: newAttempts.length,
        timeSpent: Date.now() - startTime
      });

      setTimeout(() => {
        onComplete(drill, {
          attempts: newAttempts.length,
          hintLevel,
          timeSpent: Date.now() - startTime
        });
      }, 2000);
    } else {
      // Escalate hint after 2 wrong attempts
      if (newAttempts.filter(a => !a.correct).length >= 2 && hintLevel < drill.hints.length - 1) {
        setHintLevel(hintLevel + 1);
      }
      
      // Record failed attempt
      await recordAttempt({
        command: drill.canonical_command,
        context: 'remedial_drill',
        success: false,
        hintLevel,
        attempts: newAttempts.length,
        timeSpent: Date.now() - startTime
      });
    }

    setCurrentAttempt('');
  };

  const checkAnswer = (answer) => {
    // Normalize answer for comparison
    const normalized = answer.toLowerCase().trim();
    const expectedPatterns = drill.expected_answers || [drill.canonical_command];
    
    return expectedPatterns.some(pattern => {
      if (typeof pattern === 'string') {
        return normalized === pattern.toLowerCase().trim();
      }
      // Support regex patterns
      if (pattern.type === 'regex') {
        return new RegExp(pattern.pattern, 'i').test(answer);
      }
      return false;
    });
  };

  const recordAttempt = async (data) => {
    try {
      await fetch('/api/mastery/update', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify(data)
      });
    } catch (error) {
      console.error('Failed to record attempt:', error);
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const getHintIcon = (level) => {
    if (level <= hintLevel) {
      return <LightBulbIcon className="h-4 w-4 text-yellow-500" />;
    }
    return <LightBulbIcon className="h-4 w-4 text-gray-300" />;
  };

  const getProficiencyColor = (score) => {
    if (score >= 0.9) return 'text-emerald-600';
    if (score >= 0.7) return 'text-blue-600';
    if (score >= 0.5) return 'text-yellow-600';
    return 'text-red-600';
  };

  if (showSuccess) {
    return (
      <div className={`bg-emerald-50 border border-emerald-200 rounded-lg p-6 ${className}`}>
        <div className="flex items-center justify-center mb-4">
          <CheckCircleIcon className="h-12 w-12 text-emerald-500" />
        </div>
        <div className="text-center">
          <h3 className="text-lg font-semibold text-emerald-800 mb-2">
            Excellent! Command Mastered
          </h3>
          <p className="text-emerald-700 mb-4">
            You've successfully completed the drill for <code className="bg-emerald-100 px-2 py-1 rounded">{drill.canonical_command}</code>
          </p>
          <div className="flex justify-center space-x-4 text-sm text-emerald-600">
            <span>Attempts: {attempts.length}</span>
            <span>Hints used: {hintLevel + 1}</span>
            <span>Time: {formatTime(timeSpent)}</span>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className={`bg-white border border-gray-200 rounded-lg shadow-sm ${className}`}>
      {/* Header */}
      <div className="bg-gradient-to-r from-blue-600 to-blue-700 text-white p-4 rounded-t-lg">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-lg font-semibold">Remedial Drill Required</h3>
            <p className="text-blue-100 text-sm">
              Master this command before proceeding to Apply
            </p>
          </div>
          <div className="text-right text-sm">
            <div className="text-blue-100">Time: {formatTime(timeSpent)}</div>
            {userMastery && (
              <div className={`font-medium ${getProficiencyColor(userMastery.proficiency_score)} bg-white px-2 py-1 rounded text-xs mt-1`}>
                Current: {Math.round(userMastery.proficiency_score * 100)}%
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="p-6">
        {/* Command Focus */}
        <div className="mb-6">
          <div className="flex items-center mb-3">
            <div className="bg-gray-100 rounded-lg px-3 py-2 font-mono text-sm">
              {drill.canonical_command}
            </div>
            <ArrowRightIcon className="h-4 w-4 text-gray-400 mx-2" />
            <span className="text-gray-600 text-sm">Proficiency Required: 100%</span>
          </div>
          
          <div className="bg-gray-50 rounded-lg p-4 mb-4">
            <h4 className="font-medium text-gray-800 mb-2">Command Description:</h4>
            <p className="text-gray-700 text-sm">{drill.description}</p>
          </div>
        </div>

        {/* Scenario */}
        <div className="mb-6">
          <h4 className="font-medium text-gray-800 mb-3">Scenario:</h4>
          <div className="bg-blue-50 border-l-4 border-blue-400 p-4 rounded">
            <p className="text-gray-800">{drill.scenario}</p>
            {drill.context && (
              <div className="mt-2 text-sm text-gray-600">
                <strong>Context:</strong> {drill.context}
              </div>
            )}
          </div>
        </div>

        {/* Hints */}
        <div className="mb-6">
          <h4 className="font-medium text-gray-800 mb-3">Available Hints:</h4>
          <div className="space-y-2">
            {drill.hints.map((hint, index) => (
              <div
                key={index}
                className={`flex items-start p-3 rounded-lg border ${
                  index <= hintLevel 
                    ? 'bg-yellow-50 border-yellow-200 text-gray-800' 
                    : 'bg-gray-50 border-gray-200 text-gray-400'
                }`}
              >
                <div className="mr-3 mt-0.5">
                  {getHintIcon(index)}
                </div>
                <div className="flex-1">
                  <div className="font-medium text-sm mb-1">Hint {index + 1}</div>
                  <div className="text-sm">
                    {index <= hintLevel ? hint.text : '???'}
                  </div>
                </div>
              </div>
            ))}
          </div>
          
          {hintLevel < drill.hints.length - 1 && attempts.filter(a => !a.correct).length >= 2 && (
            <div className="mt-3 text-sm text-yellow-600 bg-yellow-50 border border-yellow-200 rounded p-2">
              💡 New hint available after 2 incorrect attempts!
            </div>
          )}
        </div>

        {/* Previous Attempts */}
        {attempts.length > 0 && (
          <div className="mb-6">
            <h4 className="font-medium text-gray-800 mb-3">Previous Attempts:</h4>
            <div className="space-y-2">
              {attempts.map((attempt, index) => (
                <div
                  key={index}
                  className={`flex items-center p-2 rounded text-sm ${
                    attempt.correct 
                      ? 'bg-emerald-50 text-emerald-800 border border-emerald-200'
                      : 'bg-red-50 text-red-800 border border-red-200'
                  }`}
                >
                  {attempt.correct ? (
                    <CheckCircleIcon className="h-4 w-4 mr-2" />
                  ) : (
                    <XCircleIcon className="h-4 w-4 mr-2" />
                  )}
                  <code className="flex-1">{attempt.command}</code>
                  <span className="text-xs opacity-75">
                    Attempt {index + 1}
                  </span>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Answer Input */}
        <form onSubmit={handleSubmit} className="mb-4">
          <label htmlFor="command-input" className="block text-sm font-medium text-gray-700 mb-2">
            Enter the correct command:
          </label>
          <div className="flex">
            <input
              id="command-input"
              type="text"
              value={currentAttempt}
              onChange={(e) => setCurrentAttempt(e.target.value)}
              placeholder="Type your command here..."
              className="flex-1 rounded-l-md border border-gray-300 px-3 py-2 font-mono text-sm focus:border-blue-500 focus:outline-none focus:ring-1 focus:ring-blue-500"
              disabled={isComplete}
              autoComplete="off"
              spellCheck="false"
            />
            <button
              type="submit"
              disabled={!currentAttempt.trim() || isComplete}
              className="rounded-r-md bg-blue-600 px-4 py-2 text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:bg-gray-400 disabled:cursor-not-allowed"
            >
              Submit
            </button>
          </div>
        </form>

        {/* Actions */}
        <div className="flex justify-between items-center pt-4 border-t border-gray-200">
          <button
            onClick={() => onSkip(drill)}
            className="text-gray-500 hover:text-gray-700 text-sm"
          >
            Skip for now (will block Apply access)
          </button>
          
          <div className="text-xs text-gray-500">
            Press Enter to submit • {attempts.length} attempts so far
          </div>
        </div>
      </div>
    </div>
  );
};

export default RemedialDrill;