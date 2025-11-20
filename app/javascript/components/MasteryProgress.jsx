import React, { useState, useEffect } from 'react';
import { 
  TrophyIcon, 
  FireIcon, 
  ClockIcon,
  ChartBarIcon,
  ArrowUpIcon,
  ArrowDownIcon
} from '@heroicons/react/24/outline';
import { 
  TrophyIcon as TrophySolidIcon,
  FireIcon as FireSolidIcon 
} from '@heroicons/react/24/solid';

const MasteryProgress = ({ 
  command, 
  mastery, 
  showDetails = false,
  compact = false,
  className = '' 
}) => {
  const [showTooltip, setShowTooltip] = useState(false);
  const [previousScore, setPreviousScore] = useState(null);

  useEffect(() => {
    if (mastery && previousScore !== null) {
      // Animate score changes
      const scoreChange = mastery.proficiency_score - previousScore;
      if (Math.abs(scoreChange) > 0.01) {
        // Trigger animation
        setTimeout(() => setPreviousScore(mastery.proficiency_score), 300);
      }
    } else if (mastery) {
      setPreviousScore(mastery.proficiency_score);
    }
  }, [mastery?.proficiency_score]);

  if (!mastery) {
    return (
      <div className={`bg-gray-50 rounded-lg p-3 ${className}`}>
        <div className="flex items-center">
          <div className="w-2 h-2 bg-gray-300 rounded-full mr-3"></div>
          <div className="flex-1">
            <div className="font-mono text-sm text-gray-600">{command}</div>
            <div className="text-xs text-gray-500">Not practiced yet</div>
          </div>
        </div>
      </div>
    );
  }

  const {
    proficiency_score,
    memory_shield,
    last_practiced_at,
    last_correct_at,
    total_attempts,
    successful_attempts,
    contexts_seen = []
  } = mastery;

  const percentage = Math.round(proficiency_score * 100);
  const successRate = total_attempts > 0 ? Math.round((successful_attempts / total_attempts) * 100) : 0;
  
  const getShieldInfo = (shield) => {
    const shields = {
      platinum: { 
        icon: TrophySolidIcon, 
        color: 'text-purple-600', 
        bg: 'bg-purple-100',
        label: 'Platinum Shield',
        description: '90+ days retention'
      },
      gold: { 
        icon: TrophySolidIcon, 
        color: 'text-yellow-500', 
        bg: 'bg-yellow-100',
        label: 'Gold Shield',
        description: '30-90 days retention'
      },
      silver: { 
        icon: TrophyIcon, 
        color: 'text-gray-500', 
        bg: 'bg-gray-100',
        label: 'Silver Shield',
        description: '7-30 days retention'
      },
      bronze: { 
        icon: TrophyIcon, 
        color: 'text-orange-500', 
        bg: 'bg-orange-100',
        label: 'Bronze Shield',
        description: '< 7 days retention'
      }
    };
    return shields[shield] || null;
  };

  const getProficiencyColor = (score) => {
    if (score >= 0.9) return 'bg-emerald-500';
    if (score >= 0.7) return 'bg-blue-500';
    if (score >= 0.5) return 'bg-yellow-500';
    return 'bg-red-500';
  };

  const getProficiencyTextColor = (score) => {
    if (score >= 0.9) return 'text-emerald-600';
    if (score >= 0.7) return 'text-blue-600';
    if (score >= 0.5) return 'text-yellow-600';
    return 'text-red-600';
  };

  const getStreakDays = () => {
    if (!last_correct_at) return 0;
    const days = Math.floor((Date.now() - new Date(last_correct_at)) / (1000 * 60 * 60 * 24));
    return Math.max(0, 7 - days); // Streak breaks after 7 days
  };

  const formatTimeAgo = (timestamp) => {
    if (!timestamp) return 'Never';
    const date = new Date(timestamp);
    const now = new Date();
    const diffInHours = Math.floor((now - date) / (1000 * 60 * 60));
    
    if (diffInHours < 1) return 'Just now';
    if (diffInHours < 24) return `${diffInHours}h ago`;
    const diffInDays = Math.floor(diffInHours / 24);
    if (diffInDays < 7) return `${diffInDays}d ago`;
    if (diffInDays < 30) return `${Math.floor(diffInDays / 7)}w ago`;
    return `${Math.floor(diffInDays / 30)}mo ago`;
  };

  const shieldInfo = getShieldInfo(memory_shield);
  const streakDays = getStreakDays();

  if (compact) {
    return (
      <div 
        className={`flex items-center space-x-2 p-2 rounded-lg bg-white border ${className}`}
        onMouseEnter={() => setShowTooltip(true)}
        onMouseLeave={() => setShowTooltip(false)}
      >
        <div className="relative">
          <div className="w-8 h-8 rounded-full border-2 border-gray-200 flex items-center justify-center">
            <div 
              className={`w-6 h-6 rounded-full ${getProficiencyColor(proficiency_score)}`}
              style={{ 
                transform: `scale(${Math.max(0.3, proficiency_score)})`,
                transition: 'transform 0.3s ease'
              }}
            ></div>
          </div>
          {shieldInfo && (
            <div className={`absolute -top-1 -right-1 w-4 h-4 rounded-full ${shieldInfo.bg} flex items-center justify-center`}>
              <shieldInfo.icon className={`w-2.5 h-2.5 ${shieldInfo.color}`} />
            </div>
          )}
        </div>
        
        <div className="flex-1 min-w-0">
          <div className="font-mono text-xs font-medium text-gray-900 truncate">{command}</div>
          <div className={`text-xs font-semibold ${getProficiencyTextColor(proficiency_score)}`}>
            {percentage}%
          </div>
        </div>

        {showTooltip && (
          <div className="absolute z-10 bg-black text-white text-xs rounded px-2 py-1 -mt-8 left-1/2 transform -translate-x-1/2">
            {percentage}% proficiency • {total_attempts} attempts
          </div>
        )}
      </div>
    );
  }

  return (
    <div className={`bg-white rounded-lg border border-gray-200 shadow-sm ${className}`}>
      {/* Header */}
      <div className="p-4 border-b border-gray-100">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-3">
            <div className="relative">
              <div className="w-10 h-10 rounded-full border-3 border-gray-200 flex items-center justify-center">
                <div 
                  className={`w-8 h-8 rounded-full ${getProficiencyColor(proficiency_score)} transition-all duration-500`}
                  style={{ 
                    transform: `scale(${Math.max(0.3, proficiency_score)})` 
                  }}
                ></div>
              </div>
              {shieldInfo && (
                <div className={`absolute -top-1 -right-1 w-6 h-6 rounded-full ${shieldInfo.bg} flex items-center justify-center border-2 border-white`}>
                  <shieldInfo.icon className={`w-3.5 h-3.5 ${shieldInfo.color}`} />
                </div>
              )}
            </div>
            
            <div>
              <h3 className="font-mono font-semibold text-gray-900">{command}</h3>
              <div className="flex items-center space-x-4 text-sm text-gray-500">
                <span className={`font-semibold ${getProficiencyTextColor(proficiency_score)}`}>
                  {percentage}% Proficiency
                </span>
                {proficiency_score >= 1.0 && (
                  <span className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-emerald-100 text-emerald-800">
                    ✓ Mastered
                  </span>
                )}
              </div>
            </div>
          </div>

          {streakDays > 0 && (
            <div className="flex items-center space-x-1 text-orange-500">
              <FireSolidIcon className="w-4 h-4" />
              <span className="text-sm font-medium">{streakDays}d</span>
            </div>
          )}
        </div>
      </div>

      {/* Stats Grid */}
      <div className="p-4 grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="text-center">
          <div className="text-2xl font-bold text-gray-900">{percentage}%</div>
          <div className="text-xs text-gray-500">Proficiency</div>
        </div>
        
        <div className="text-center">
          <div className="text-2xl font-bold text-gray-900">{successRate}%</div>
          <div className="text-xs text-gray-500">Success Rate</div>
        </div>
        
        <div className="text-center">
          <div className="text-2xl font-bold text-gray-900">{total_attempts}</div>
          <div className="text-xs text-gray-500">Attempts</div>
        </div>
        
        <div className="text-center">
          <div className="text-2xl font-bold text-gray-900">{contexts_seen.length}</div>
          <div className="text-xs text-gray-500">Contexts</div>
        </div>
      </div>

      {showDetails && (
        <>
          {/* Memory Shield Details */}
          {shieldInfo && (
            <div className="px-4 py-3 border-t border-gray-100">
              <div className="flex items-center space-x-3">
                <div className={`w-8 h-8 rounded-full ${shieldInfo.bg} flex items-center justify-center`}>
                  <shieldInfo.icon className={`w-5 h-5 ${shieldInfo.color}`} />
                </div>
                <div>
                  <div className="font-medium text-gray-900">{shieldInfo.label}</div>
                  <div className="text-sm text-gray-500">{shieldInfo.description}</div>
                </div>
              </div>
            </div>
          )}

          {/* Timing Information */}
          <div className="px-4 py-3 border-t border-gray-100">
            <div className="grid grid-cols-2 gap-4">
              <div className="flex items-center space-x-2">
                <ClockIcon className="w-4 h-4 text-gray-400" />
                <div>
                  <div className="text-sm font-medium text-gray-900">Last Practice</div>
                  <div className="text-xs text-gray-500">{formatTimeAgo(last_practiced_at)}</div>
                </div>
              </div>
              
              <div className="flex items-center space-x-2">
                <ArrowUpIcon className="w-4 h-4 text-emerald-500" />
                <div>
                  <div className="text-sm font-medium text-gray-900">Last Correct</div>
                  <div className="text-xs text-gray-500">{formatTimeAgo(last_correct_at)}</div>
                </div>
              </div>
            </div>
          </div>

          {/* Context Breakdown */}
          {contexts_seen.length > 0 && (
            <div className="px-4 py-3 border-t border-gray-100">
              <div className="flex items-center space-x-2 mb-2">
                <ChartBarIcon className="w-4 h-4 text-gray-400" />
                <span className="text-sm font-medium text-gray-900">Practice Contexts</span>
              </div>
              <div className="flex flex-wrap gap-1">
                {contexts_seen.map((context, index) => (
                  <span 
                    key={index}
                    className="inline-flex items-center px-2 py-1 rounded-full text-xs bg-blue-100 text-blue-800"
                  >
                    {context}
                  </span>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </div>
  );
};

export default MasteryProgress;