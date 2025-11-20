import React, { useState } from 'react';
import { BeakerIcon, CheckCircleIcon } from '@heroicons/react/24/solid';

const ScenarioLab = ({ title, description, steps, onComplete }) => {
  const [currentStepIndex, setCurrentStepIndex] = useState(0);
  const [completedSteps, setCompletedSteps] = useState([]);

  const currentStep = steps[currentStepIndex];
  const isLastStep = currentStepIndex === steps.length - 1;
  const allStepsCompleted = completedSteps.length === steps.length;

  const handleStepComplete = () => {
    if (!completedSteps.includes(currentStepIndex)) {
      setCompletedSteps([...completedSteps, currentStepIndex]);
    }

    if (isLastStep) {
      // All steps completed
      setTimeout(() => {
        onComplete();
      }, 500);
    } else {
      // Move to next step
      setCurrentStepIndex(currentStepIndex + 1);
    }
  };

  const handlePreviousStep = () => {
    if (currentStepIndex > 0) {
      setCurrentStepIndex(currentStepIndex - 1);
    }
  };

  return (
    <div className="space-y-6">
      {/* Title */}
      <div className="flex items-center space-x-3 mb-6">
        <BeakerIcon className="h-8 w-8 text-orange-600" />
        <h2 className="text-2xl font-bold text-gray-900">{title}</h2>
      </div>

      {/* Description */}
      <div className="bg-orange-50 border border-orange-200 rounded-lg p-4">
        <p className="text-orange-900 font-medium">{description}</p>
      </div>

      {/* Progress Indicator */}
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center space-x-2">
          {steps.map((_, index) => (
            <div
              key={index}
              className={`h-2 w-12 rounded-full transition ${
                completedSteps.includes(index)
                  ? 'bg-green-500'
                  : index === currentStepIndex
                  ? 'bg-orange-500'
                  : 'bg-gray-300'
              }`}
            />
          ))}
        </div>
        <span className="text-sm text-gray-600">
          Step {currentStepIndex + 1} of {steps.length}
        </span>
      </div>

      {/* Current Step */}
      <div className="bg-white border border-gray-200 rounded-lg p-6">
        <div className="mb-4">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-lg font-semibold text-gray-900">
              Step {currentStep.step}: {currentStep.instruction}
            </h3>
            {completedSteps.includes(currentStepIndex) && (
              <CheckCircleIcon className="h-6 w-6 text-green-500" />
            )}
          </div>
        </div>

        {/* Command to Execute */}
        {currentStep.command && (
          <div className="mb-4">
            <label className="block text-sm font-medium text-gray-700 mb-2">
              Command to execute:
            </label>
            <div className="bg-gray-900 text-green-400 p-4 rounded-lg font-mono text-sm">
              <code>{currentStep.command}</code>
            </div>
            <button
              onClick={() => {
                navigator.clipboard.writeText(currentStep.command);
              }}
              className="mt-2 text-sm text-blue-600 hover:text-blue-700"
            >
              📋 Copy to clipboard
            </button>
          </div>
        )}

        {/* Explanation */}
        {currentStep.explanation && (
          <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-4">
            <p className="text-sm text-blue-900">
              <span className="font-semibold">💡 Tip: </span>
              {currentStep.explanation}
            </p>
          </div>
        )}

        {/* Action Buttons */}
        <div className="flex items-center justify-between mt-6">
          <button
            onClick={handlePreviousStep}
            disabled={currentStepIndex === 0}
            className="px-4 py-2 text-gray-600 hover:text-gray-700 hover:bg-gray-50 rounded-lg transition disabled:opacity-50 disabled:cursor-not-allowed"
          >
            ← Previous
          </button>

          <button
            onClick={handleStepComplete}
            className="px-6 py-3 bg-orange-600 text-white rounded-lg hover:bg-orange-700 transition font-semibold"
          >
            {isLastStep ? 'Complete Scenario' : 'Next Step →'}
          </button>
        </div>
      </div>

      {/* All Steps Overview */}
      <div className="mt-6">
        <h4 className="text-sm font-semibold text-gray-700 mb-3">All Steps:</h4>
        <div className="space-y-2">
          {steps.map((step, index) => (
            <div
              key={index}
              className={`flex items-center space-x-3 p-3 rounded-lg ${
                completedSteps.includes(index)
                  ? 'bg-green-50 text-green-900'
                  : index === currentStepIndex
                  ? 'bg-orange-50 text-orange-900'
                  : 'bg-gray-50 text-gray-600'
              }`}
            >
              {completedSteps.includes(index) ? (
                <CheckCircleIcon className="h-5 w-5 text-green-500 flex-shrink-0" />
              ) : (
                <div className={`h-5 w-5 rounded-full border-2 flex-shrink-0 ${
                  index === currentStepIndex ? 'border-orange-500' : 'border-gray-300'
                }`} />
              )}
              <span className="text-sm font-medium">{step.instruction}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default ScenarioLab;

