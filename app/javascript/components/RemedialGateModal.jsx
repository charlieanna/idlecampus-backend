import React, { useState, useEffect } from 'react';
import { 
  ExclamationTriangleIcon, 
  ClockIcon, 
  AcademicCapIcon,
  ArrowRightIcon,
  XMarkIcon,
  ChartBarIcon
} from '@heroicons/react/24/outline';
import RemedialDrill from './RemedialDrill';
import MemoryShield from './MemoryShield';

const RemedialGateModal = ({ 
  isOpen, 
  onClose, 
  onProceed, 
  gateStatus,
  unitTitle,
  csrfToken 
}) => {
  const [currentDrillIndex, setCurrentDrillIndex] = useState(0);
  const [completedDrills, setCompletedDrills] = useState(new Set());
  const [drillData, setDrillData] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [showDrills, setShowDrills] = useState(false);

  useEffect(() => {
    if (isOpen && gateStatus?.blocked_commands) {
      loadDrillData();
    }
  }, [isOpen, gateStatus]);

  const loadDrillData = async () => {
    setIsLoading(true);
    try {
      const response = await fetch('/api/mastery/remedial_drill', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          commands: gateStatus.blocked_commands
        })
      });

      if (response.ok) {
        const data = await response.json();
        setDrillData(data.drill.drills || []);
      }
    } catch (error) {
      console.error('Failed to load drill data:', error);
    }
    setIsLoading(false);
  };

  const handleDrillComplete = async (drill, results) => {
    const newCompleted = new Set(completedDrills);
    newCompleted.add(currentDrillIndex);
    setCompletedDrills(newCompleted);

    // Record drill completion
    try {
      await fetch('/api/mastery/record_attempt', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          command: drill.command,
          success: true,
          context: 'remedial_drill',
          ...results
        })
      });
    } catch (error) {
      console.error('Failed to record drill completion:', error);
    }

    // Move to next drill or complete
    if (currentDrillIndex < drillData.length - 1) {
      setCurrentDrillIndex(currentDrillIndex + 1);
    } else {
      // All drills complete - check gate again
      await recheckGate();
    }
  };

  const recheckGate = async () => {
    try {
      const response = await fetch(`/api/mastery/remedial_gate/${gateStatus.unit_slug}`, {
        headers: {
          'X-CSRF-Token': csrfToken
        }
      });

      if (response.ok) {
        const data = await response.json();
        if (data.can_proceed) {
          onProceed();
        }
      }
    } catch (error) {
      console.error('Failed to recheck gate:', error);
    }
  };

  const formatEstimatedTime = (timeString) => {
    return timeString || '3-5 minutes';
  };

  const getCompletionPercentage = () => {
    if (drillData.length === 0) return 0;
    return Math.round((completedDrills.size / drillData.length) * 100);
  };

  if (!isOpen) return null;

  // Show drill interface
  if (showDrills && drillData.length > 0) {
    const currentDrill = drillData[currentDrillIndex];
    const isLastDrill = currentDrillIndex === drillData.length - 1;
    
    return (
      <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
        <div className="bg-white rounded-lg shadow-xl max-w-4xl w-full max-h-[90vh] overflow-hidden">
          {/* Header with Progress */}
          <div className="bg-gradient-to-r from-blue-600 to-blue-700 text-white p-4">
            <div className="flex items-center justify-between mb-3">
              <h2 className="text-xl font-bold">Remedial Practice Session</h2>
              <button 
                onClick={onClose}
                className="text-white hover:text-gray-200"
              >
                <XMarkIcon className="h-6 w-6" />
              </button>
            </div>
            
            {/* Progress Bar */}
            <div className="mb-2">
              <div className="flex justify-between text-sm text-blue-100 mb-1">
                <span>Command {currentDrillIndex + 1} of {drillData.length}</span>
                <span>{getCompletionPercentage()}% Complete</span>
              </div>
              <div className="w-full bg-blue-800 rounded-full h-2">
                <div 
                  className="bg-white rounded-full h-2 transition-all duration-300"
                  style={{ width: `${((currentDrillIndex + (completedDrills.has(currentDrillIndex) ? 1 : 0)) / drillData.length) * 100}%` }}
                />
              </div>
            </div>

            {/* Command Progress Indicators */}
            <div className="flex space-x-2 mt-3">
              {drillData.map((drill, index) => (
                <div
                  key={index}
                  className={`px-2 py-1 rounded text-xs font-medium transition-all ${
                    completedDrills.has(index)
                      ? 'bg-green-500 text-white'
                      : index === currentDrillIndex
                      ? 'bg-white text-blue-700'
                      : 'bg-blue-800 text-blue-200'
                  }`}
                >
                  {drill.label || drill.command}
                </div>
              ))}
            </div>
          </div>

          {/* Drill Content */}
          <div className="p-6 overflow-y-auto max-h-[calc(90vh-200px)]">
            <RemedialDrill
              drill={currentDrill}
              onComplete={handleDrillComplete}
              onSkip={() => setCurrentDrillIndex(currentDrillIndex + 1)}
              userMastery={gateStatus.masteries?.find(m => m.command === currentDrill.command)}
            />
          </div>

          {/* Footer */}
          <div className="bg-gray-50 px-6 py-3 border-t">
            <div className="flex justify-between items-center">
              <div className="text-sm text-gray-600">
                {isLastDrill ? 'Last command!' : `${drillData.length - currentDrillIndex - 1} commands remaining`}
              </div>
              <div className="text-xs text-gray-500">
                Complete all drills to unlock the unit
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Show gate modal
  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
      <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full">
        {/* Header */}
        <div className="bg-orange-50 border-b border-orange-200 p-6">
          <div className="flex items-center">
            <ExclamationTriangleIcon className="h-8 w-8 text-orange-500 mr-3" />
            <div className="flex-1">
              <h2 className="text-xl font-bold text-gray-900">
                Prerequisites Required
              </h2>
              <p className="text-sm text-gray-600 mt-1">
                Complete practice drills before accessing "{unitTitle}"
              </p>
            </div>
            <button 
              onClick={onClose}
              className="text-gray-400 hover:text-gray-600"
            >
              <XMarkIcon className="h-6 w-6" />
            </button>
          </div>
        </div>

        {/* Content */}
        <div className="p-6">
          {/* Summary */}
          <div className="mb-6">
            <div className="flex items-center mb-3">
              <AcademicCapIcon className="h-5 w-5 text-blue-600 mr-2" />
              <span className="font-medium text-gray-900">
                {gateStatus?.blocked_commands?.length || 0} commands need mastery
              </span>
            </div>
            
            <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
              <p className="text-sm text-blue-800 leading-relaxed">
                You need 100% mastery of prerequisite commands before accessing Apply steps. 
                Complete the targeted practice drills below to build the required muscle memory.
              </p>
            </div>
          </div>

          {/* Command List */}
          <div className="mb-6">
            <h3 className="font-medium text-gray-900 mb-3">Commands requiring practice:</h3>
            <div className="space-y-2">
              {gateStatus?.masteries?.map((mastery, index) => (
                <div 
                  key={index}
                  className="flex items-center justify-between p-3 bg-gray-50 rounded-lg"
                >
                  <div className="flex items-center">
                    <code className="bg-gray-200 px-2 py-1 rounded text-sm font-mono">
                      {mastery.command}
                    </code>
                    <span className="ml-2 text-sm text-gray-600">
                      {mastery.display_name}
                    </span>
                  </div>
                  <div className="text-right">
                    <div className={`text-sm font-medium ${
                      mastery.current_score >= 90 ? 'text-yellow-600' : 'text-red-600'
                    }`}>
                      {Math.round(mastery.current_score)}%
                    </div>
                    <div className="text-xs text-gray-500">
                      {mastery.attempts} attempts
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Time Estimate */}
          <div className="mb-6">
            <div className="flex items-center text-sm text-gray-600">
              <ClockIcon className="h-4 w-4 mr-2" />
              <span>Estimated time: {formatEstimatedTime(gateStatus?.estimated_time)}</span>
            </div>
          </div>

          {/* Memory Shield Preview */}
          {gateStatus?.masteries?.some(m => m.current_score > 0) && (
            <div className="mb-6">
              <h3 className="font-medium text-gray-900 mb-3">Your Memory Shields:</h3>
              <div className="flex space-x-2">
                {gateStatus.masteries.map((mastery, index) => (
                  <MemoryShield
                    key={index}
                    score={mastery.current_score}
                    command={mastery.command}
                    className="scale-75"
                  />
                ))}
              </div>
            </div>
          )}
        </div>

        {/* Actions */}
        <div className="bg-gray-50 px-6 py-4 border-t flex justify-between items-center">
          <button
            onClick={onClose}
            className="text-gray-600 hover:text-gray-800 text-sm"
          >
            View Unit (Read Only)
          </button>
          
          <div className="flex space-x-3">
            <button
              onClick={() => setShowDrills(true)}
              disabled={isLoading}
              className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:bg-gray-400 disabled:cursor-not-allowed"
            >
              {isLoading ? 'Loading...' : 'Start Practice Drills'}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default RemedialGateModal;