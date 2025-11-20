import React, { useState } from 'react';
import { BookOpenIcon, LightBulbIcon } from '@heroicons/react/24/solid';
import SimpleMarkdown from './SimpleMarkdown';

const ConceptExplainer = ({ title, content, scenarioNarrative, problemStatement, codeExamples, visualAidUrl, onComplete }) => {
  const [readingComplete, setReadingComplete] = useState(false);

  const handleContinue = () => {
    setReadingComplete(true);
    onComplete();
  };

  return (
    <div className="space-y-6">
      {/* Title */}
      <div className="flex items-center space-x-3 mb-6">
        <BookOpenIcon className="h-8 w-8 text-blue-600" />
        <h2 className="text-2xl font-bold text-gray-900">{title}</h2>
      </div>

      {/* Visual Aid */}
      {visualAidUrl && (
        <div className="mb-6">
          <img
            src={visualAidUrl}
            alt="Concept diagram"
            className="w-full rounded-lg shadow-md"
          />
        </div>
      )}

      {/* Scenario Briefing (The Why) */}
      {(scenarioNarrative || problemStatement) && (
        <div className="rounded-lg border border-blue-200 bg-blue-50 p-5">
          <div className="flex items-start space-x-3">
            <LightBulbIcon className="h-6 w-6 text-blue-500 mt-0.5" />
            <div>
              {problemStatement && (
                <p className="text-sm text-blue-900 font-semibold mb-1">Why this matters</p>
              )}
              {problemStatement && (
                <p className="text-blue-800 mb-2">{problemStatement}</p>
              )}
              {scenarioNarrative && (
                <div className="text-blue-800">
                  {scenarioNarrative}
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Main Content */}
      <div className="bg-gradient-to-br from-gray-50 to-white rounded-xl p-6 border border-gray-200">
        <SimpleMarkdown content={content} />
      </div>

      {/* Code Examples */}
      {codeExamples && codeExamples.length > 0 && (
        <div className="mt-6">
          <h3 className="text-lg font-semibold text-gray-900 mb-3">Examples</h3>
          <div className="space-y-4">
            {codeExamples.map((example, index) => (
              <div key={index} className="border border-gray-200 rounded-lg overflow-hidden">
                {example.title && (
                  <div className="bg-gray-100 px-4 py-2 border-b border-gray-200">
                    <p className="text-sm font-medium text-gray-700">{example.title}</p>
                  </div>
                )}
                <pre className="bg-gray-900 text-gray-100 p-4 overflow-x-auto" style={{ margin: 0, borderRadius: 0 }}>
                  <code>{example.code}</code>
                </pre>
                {example.explanation && (
                  <div className="bg-blue-50 px-4 py-3 border-t border-blue-100">
                    <div className="flex items-start space-x-2">
                      <LightBulbIcon className="h-5 w-5 text-blue-500 mt-0.5 flex-shrink-0" />
                      <p className="text-sm text-blue-800">{example.explanation}</p>
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Call to Action */}
      <div className="mt-8 pt-6 border-t border-gray-200">
        <div className="flex items-center justify-between">
          <p className="text-gray-600">
            Ready to practice? Click continue when you understand the concept.
          </p>
          <button
            onClick={handleContinue}
            className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition font-semibold flex items-center"
          >
            Continue to Practice
            <svg className="h-5 w-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
            </svg>
          </button>
        </div>
      </div>
    </div>
  );
};

export default ConceptExplainer;

