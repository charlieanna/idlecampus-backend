import React from 'react';
import { CheckCircleIcon } from '@heroicons/react/24/solid';

const ProgressTracker = ({ steps, currentStep }) => {
  return (
    <div className="relative">
      <div className="flex items-center justify-between">
        {steps.map((step, index) => {
          const stepNumber = index + 1;
          const isActive = stepNumber === currentStep;
          const isCompleted = step.completed;
          const isPast = stepNumber < currentStep;

          return (
            <React.Fragment key={index}>
              {/* Step */}
              <div className="flex flex-col items-center relative z-10">
                <div
                  className={`w-12 h-12 rounded-full flex items-center justify-center border-2 transition ${
                    isCompleted || isPast
                      ? 'bg-green-500 border-green-500'
                      : isActive
                      ? 'bg-blue-500 border-blue-500'
                      : 'bg-white border-gray-300'
                  }`}
                >
                  {isCompleted || isPast ? (
                    <CheckCircleIcon className="h-6 w-6 text-white" />
                  ) : (
                    <span
                      className={`font-semibold ${
                        isActive ? 'text-white' : 'text-gray-400'
                      }`}
                    >
                      {stepNumber}
                    </span>
                  )}
                </div>
                <span
                  className={`mt-2 text-sm font-medium ${
                    isActive || isCompleted || isPast
                      ? 'text-gray-900'
                      : 'text-gray-500'
                  }`}
                >
                  {step.name}
                </span>
              </div>

              {/* Connector Line */}
              {index < steps.length - 1 && (
                <div className="flex-1 relative" style={{ marginTop: '-28px' }}>
                  <div className="h-0.5 bg-gray-300 w-full">
                    <div
                      className={`h-full transition-all duration-300 ${
                        isPast || isCompleted ? 'bg-green-500' : 'bg-gray-300'
                      }`}
                      style={{
                        width: isPast || isCompleted ? '100%' : '0%'
                      }}
                    />
                  </div>
                </div>
              )}
            </React.Fragment>
          );
        })}
      </div>
    </div>
  );
};

export default ProgressTracker;

