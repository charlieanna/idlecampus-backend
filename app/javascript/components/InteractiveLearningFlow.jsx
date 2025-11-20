import React, { useState, useEffect } from 'react';
import ConceptExplainer from './ConceptExplainer';
import CommandPractice from './CommandPracticeEnhanced';
import QuickQuiz from './QuickQuiz';
import DockerTerminalLab from './DockerTerminalLab';
import ProgressTracker from './ProgressTracker';
import { CheckCircleIcon, ClockIcon, TrophyIcon } from '@heroicons/react/24/solid';

const InteractiveLearningFlow = ({ unit, initialProgress, csrfToken, streamNextPath }) => {
  const [currentStep, setCurrentStep] = useState(1);
  const [progress, setProgress] = useState(initialProgress || {
    explanation_read: false,
    practice_completed: false,
    quiz_answered: false,
    scenario_completed: false,
    completed: false,
    completion_percentage: 0,
    mastery_score: 0.0
  });
  const [timeSpent, setTimeSpent] = useState(0);
  const [startTime] = useState(Date.now());
  const [completedUnit, setCompletedUnit] = useState(false);
  const [xpEarned, setXpEarned] = useState(0);

  // Timer
  useEffect(() => {
    const timer = setInterval(() => {
      setTimeSpent(Math.floor((Date.now() - startTime) / 1000));
    }, 1000);

    return () => clearInterval(timer);
  }, [startTime]);

  // Determine which step to show based on progress
  useEffect(() => {
    if (!progress.explanation_read) {
      setCurrentStep(1);
    } else if (!progress.practice_completed) {
      setCurrentStep(2);
    } else if (!progress.quiz_answered) {
      setCurrentStep(3);
    } else if (!progress.scenario_completed) {
      setCurrentStep(4);
    } else if (progress.completed) {
      setCurrentStep(5);
      setCompletedUnit(true);
    }
  }, [progress]);

  const handleExplanationComplete = async () => {
    try {
      const response = await fetch(`/interactive_learning/${unit.slug}/complete_explanation`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        }
      });

      const data = await response.json();
      if (data.success) {
        setProgress(data.progress);
        setCurrentStep(2);
      }
    } catch (error) {
      console.error('Error completing explanation:', error);
    }
  };

  const handlePracticeComplete = (practiceData) => {
    setProgress(practiceData.progress);
    if (practiceData.xp_earned) {
      setXpEarned(prev => prev + practiceData.xp_earned);
    }
    if (practiceData.correct) {
      // Wait a moment before moving to next step
      setTimeout(() => setCurrentStep(3), 1500);
    }
  };

  const handleQuizComplete = (quizData) => {
    setProgress(quizData.progress);
    if (quizData.xp_earned) {
      setXpEarned(prev => prev + quizData.xp_earned);
    }
    if (quizData.correct) {
      setTimeout(() => setCurrentStep(4), 1500);
    }
  };

  const handleScenarioComplete = async () => {
    try {
      const response = await fetch(`/interactive_learning/${unit.slug}/complete_scenario`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        }
      });

      const data = await response.json();
      if (data.success) {
        setProgress(data.progress);
        if (data.completed) {
          setCompletedUnit(true);
          setXpEarned(prev => prev + (data.xp_earned || 0));
          setCurrentStep(5);
          // Auto-advance the stream to next item after short pause
          if (streamNextPath) {
            setTimeout(() => {
              window.location.href = streamNextPath;
            }, 1500);
          }
        }
      }
    } catch (error) {
      console.error('Error completing scenario:', error);
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const goToPreviousStep = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1);
    }
  };

  const goToNextStep = () => {
    if (currentStep < 5) {
      setCurrentStep(currentStep + 1);
    }
  };

  return (
    <div className="max-w-4xl mx-auto p-6">
      {/* Header */}
      <div className="mb-6">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-3xl font-bold text-gray-900">{unit.title}</h1>
          <div className="flex items-center space-x-4">
            <div className="flex items-center text-gray-600">
              <ClockIcon className="h-5 w-5 mr-1" />
              <span>{formatTime(timeSpent)}</span>
            </div>
            {xpEarned > 0 && (
              <div className="flex items-center text-green-600 font-semibold">
                <TrophyIcon className="h-5 w-5 mr-1" />
                <span>+{xpEarned} XP</span>
              </div>
            )}
          </div>
        </div>

        {/* Progress Tracker with Navigation */}
        <div className="flex items-center justify-between">
          <button
            onClick={goToPreviousStep}
            disabled={currentStep === 1}
            className={`px-4 py-2 rounded-lg flex items-center ${
              currentStep === 1
                ? 'bg-gray-200 text-gray-400 cursor-not-allowed'
                : 'bg-blue-600 text-white hover:bg-blue-700'
            }`}
          >
            <svg className="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
            </svg>
            Previous
          </button>

          <ProgressTracker
            steps={[
              { name: 'Learn', completed: progress.explanation_read },
              { name: 'Practice', completed: progress.practice_completed },
              { name: 'Quiz', completed: progress.quiz_answered },
              { name: 'Apply', completed: progress.scenario_completed }
            ]}
            currentStep={currentStep}
          />

          <button
            onClick={goToNextStep}
            disabled={currentStep === 5}
            className={`px-4 py-2 rounded-lg flex items-center ${
              currentStep === 5
                ? 'bg-gray-200 text-gray-400 cursor-not-allowed'
                : 'bg-blue-600 text-white hover:bg-blue-700'
            }`}
          >
            Next
            <svg className="h-5 w-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </div>

      {/* Main Content Area */}
      <div className="bg-white rounded-lg shadow-lg p-8">
        {/* Step 1: Concept Explanation */}
        {currentStep === 1 && (
          <ConceptExplainer
            title="Learn the Concept"
            content={unit.concept_explanation}
            scenarioNarrative={unit.scenario_narrative}
            problemStatement={unit.problem_statement}
            codeExamples={unit.code_examples}
            visualAidUrl={unit.visual_aid_url}
            onComplete={handleExplanationComplete}
          />
        )}

        {/* Step 2: Command Practice */}
        {currentStep === 2 && (
          <CommandPractice
            unit={unit}
            csrfToken={csrfToken}
            onComplete={handlePracticeComplete}
            attempts={progress.practice_attempts || 0}
          />
        )}

        {/* Step 3: Quick Quiz */}
        {currentStep === 3 && (
          <QuickQuiz
            question={{
              text: unit.quiz_question_text,
              type: unit.quiz_question_type,
              options: unit.quiz_options,
              explanation: unit.quiz_explanation
            }}
            unitSlug={unit.slug}
            csrfToken={csrfToken}
            onComplete={handleQuizComplete}
          />
        )}

        {/* Step 4: Docker Terminal Lab */}
        {currentStep === 4 && (
          <DockerTerminalLab
            unit={unit}
            csrfToken={csrfToken}
            onComplete={handleScenarioComplete}
          />
        )}

        {/* Step 5: Completion */}
        {currentStep === 5 && completedUnit && (
          <div className="text-center py-12">
            <CheckCircleIcon className="h-24 w-24 text-green-500 mx-auto mb-6" />
            <h2 className="text-3xl font-bold text-gray-900 mb-4">
              Congratulations! 🎉
            </h2>
            <p className="text-xl text-gray-600 mb-6">
              You've mastered: {unit.title}
            </p>
            
            <div className="bg-gray-50 rounded-lg p-6 mb-8 inline-block">
              <div className="grid grid-cols-2 gap-8 text-left">
                <div>
                  <p className="text-sm text-gray-600">Time Spent</p>
                  <p className="text-2xl font-bold text-gray-900">{formatTime(timeSpent)}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">XP Earned</p>
                  <p className="text-2xl font-bold text-green-600">+{xpEarned}</p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Mastery Score</p>
                  <p className="text-2xl font-bold text-blue-600">
                    {Math.round(progress.mastery_score * 100)}%
                  </p>
                </div>
                <div>
                  <p className="text-sm text-gray-600">Practice Attempts</p>
                  <p className="text-2xl font-bold text-gray-900">{progress.practice_attempts}</p>
                </div>
              </div>
            </div>

            <div className="flex justify-center space-x-4">
              <a
                href="/interactive_learning"
                className="px-6 py-3 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition"
              >
                Back to Units
              </a>
              {streamNextPath && (
                <a
                  href={streamNextPath}
                  className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition flex items-center"
                >
                  Continue
                  <svg className="h-5 w-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </a>
              )}
            </div>
          </div>
        )}
      </div>

      {/* Learning Objectives Sidebar */}
      {currentStep < 5 && unit.learning_objectives && unit.learning_objectives.length > 0 && (
        <div className="mt-6 bg-blue-50 rounded-lg p-6">
          <h3 className="text-lg font-semibold text-blue-900 mb-3">Learning Objectives</h3>
          <ul className="space-y-2">
            {unit.learning_objectives.map((objective, index) => (
              <li key={index} className="flex items-start text-blue-800">
                <svg className="h-5 w-5 mr-2 mt-0.5 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                </svg>
                <span>{objective}</span>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
};

export default InteractiveLearningFlow;

