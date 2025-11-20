import React, { useState, useEffect } from 'react';
import { 
  ChartBarIcon, 
  TrophyIcon, 
  CalendarIcon, 
  ClockIcon,
  AcademicCapIcon,
  FireIcon,
  ChevronUpIcon,
  ChevronDownIcon
} from '@heroicons/react/24/solid';

const ProgressDashboard = ({ user, progressData, learningStats }) => {
  const [selectedTimeframe, setSelectedTimeframe] = useState('week');
  const [expandedSections, setExpandedSections] = useState({
    overview: true,
    skills: true,
    recent: true
  });

  const toggleSection = (section) => {
    setExpandedSections(prev => ({
      ...prev,
      [section]: !prev[section]
    }));
  };

  // Calculate key metrics
  const totalCommands = progressData?.totalCommands || 0;
  const masteredCommands = progressData?.masteredCommands || 0;
  const currentStreak = progressData?.currentStreak || 0;
  const totalStudyTime = progressData?.totalStudyTime || 0;
  const averageAccuracy = progressData?.averageAccuracy || 0;

  const masteryPercentage = totalCommands > 0 ? Math.round((masteredCommands / totalCommands) * 100) : 0;

  // Skill competencies (8 dimensions from IRT)
  const skillCompetencies = learningStats?.competencies || {
    basic_commands: 0.5,
    container_lifecycle: 0.3,
    image_management: 0.7,
    networking: 0.2,
    volumes_storage: 0.4,
    docker_compose: 0.1,
    security: 0.3,
    troubleshooting: 0.2
  };

  const getSkillLevel = (competency) => {
    if (competency >= 0.8) return { level: 'Expert', color: 'text-purple-600 bg-purple-100' };
    if (competency >= 0.6) return { level: 'Advanced', color: 'text-blue-600 bg-blue-100' };
    if (competency >= 0.4) return { level: 'Intermediate', color: 'text-green-600 bg-green-100' };
    if (competency >= 0.2) return { level: 'Beginner', color: 'text-yellow-600 bg-yellow-100' };
    return { level: 'Novice', color: 'text-gray-600 bg-gray-100' };
  };

  const formatSkillName = (skillKey) => {
    return skillKey.split('_').map(word => 
      word.charAt(0).toUpperCase() + word.slice(1)
    ).join(' ');
  };

  const formatTime = (minutes) => {
    const hours = Math.floor(minutes / 60);
    const mins = minutes % 60;
    if (hours > 0) {
      return `${hours}h ${mins}m`;
    }
    return `${mins}m`;
  };

  // Recent activity data
  const recentActivity = progressData?.recentActivity || [];

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="bg-white rounded-lg shadow-lg p-6">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-3xl font-bold text-gray-900">Learning Progress</h1>
          <div className="flex items-center space-x-2">
            <select
              value={selectedTimeframe}
              onChange={(e) => setSelectedTimeframe(e.target.value)}
              className="px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="week">This Week</option>
              <option value="month">This Month</option>
              <option value="all">All Time</option>
            </select>
          </div>
        </div>

        {/* Key Metrics */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <div className="bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg p-4 text-white">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-blue-100 text-sm">Commands Mastered</p>
                <p className="text-2xl font-bold">{masteredCommands}/{totalCommands}</p>
                <p className="text-blue-100 text-sm">{masteryPercentage}% complete</p>
              </div>
              <TrophyIcon className="h-8 w-8 text-blue-100" />
            </div>
          </div>

          <div className="bg-gradient-to-r from-green-500 to-green-600 rounded-lg p-4 text-white">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-green-100 text-sm">Current Streak</p>
                <p className="text-2xl font-bold">{currentStreak}</p>
                <p className="text-green-100 text-sm">days in a row</p>
              </div>
              <FireIcon className="h-8 w-8 text-green-100" />
            </div>
          </div>

          <div className="bg-gradient-to-r from-purple-500 to-purple-600 rounded-lg p-4 text-white">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-purple-100 text-sm">Study Time</p>
                <p className="text-2xl font-bold">{formatTime(totalStudyTime)}</p>
                <p className="text-purple-100 text-sm">total practice</p>
              </div>
              <ClockIcon className="h-8 w-8 text-purple-100" />
            </div>
          </div>

          <div className="bg-gradient-to-r from-orange-500 to-orange-600 rounded-lg p-4 text-white">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-orange-100 text-sm">Accuracy</p>
                <p className="text-2xl font-bold">{Math.round(averageAccuracy * 100)}%</p>
                <p className="text-orange-100 text-sm">average score</p>
              </div>
              <ChartBarIcon className="h-8 w-8 text-orange-100" />
            </div>
          </div>
        </div>
      </div>

      {/* Skill Competencies */}
      <div className="bg-white rounded-lg shadow-lg">
        <div className="p-6 border-b border-gray-200">
          <button
            onClick={() => toggleSection('skills')}
            className="flex items-center justify-between w-full text-left"
          >
            <h2 className="text-xl font-semibold text-gray-900 flex items-center space-x-2">
              <AcademicCapIcon className="h-5 w-5" />
              <span>Skill Competencies</span>
            </h2>
            {expandedSections.skills ? (
              <ChevronUpIcon className="h-5 w-5 text-gray-400" />
            ) : (
              <ChevronDownIcon className="h-5 w-5 text-gray-400" />
            )}
          </button>
        </div>

        {expandedSections.skills && (
          <div className="p-6">
            <div className="grid gap-4">
              {Object.entries(skillCompetencies).map(([skill, competency]) => {
                const skillInfo = getSkillLevel(competency);
                const percentage = Math.round(competency * 100);
                
                return (
                  <div key={skill} className="space-y-2">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-medium text-gray-700">
                        {formatSkillName(skill)}
                      </span>
                      <div className="flex items-center space-x-2">
                        <span className={`px-2 py-1 rounded-full text-xs font-medium ${skillInfo.color}`}>
                          {skillInfo.level}
                        </span>
                        <span className="text-sm text-gray-500">{percentage}%</span>
                      </div>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div
                        className="bg-blue-600 h-2 rounded-full transition-all duration-300"
                        style={{ width: `${percentage}%` }}
                      />
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        )}
      </div>

      {/* Recent Activity */}
      <div className="bg-white rounded-lg shadow-lg">
        <div className="p-6 border-b border-gray-200">
          <button
            onClick={() => toggleSection('recent')}
            className="flex items-center justify-between w-full text-left"
          >
            <h2 className="text-xl font-semibold text-gray-900 flex items-center space-x-2">
              <CalendarIcon className="h-5 w-5" />
              <span>Recent Activity</span>
            </h2>
            {expandedSections.recent ? (
              <ChevronUpIcon className="h-5 w-5 text-gray-400" />
            ) : (
              <ChevronDownIcon className="h-5 w-5 text-gray-400" />
            )}
          </button>
        </div>

        {expandedSections.recent && (
          <div className="p-6">
            {recentActivity.length > 0 ? (
              <div className="space-y-4">
                {recentActivity.map((activity, index) => (
                  <div key={index} className="flex items-center space-x-4 p-3 bg-gray-50 rounded-lg">
                    <div className={`w-2 h-2 rounded-full ${
                      activity.type === 'mastered' ? 'bg-green-500' :
                      activity.type === 'practiced' ? 'bg-blue-500' :
                      'bg-orange-500'
                    }`} />
                    <div className="flex-1">
                      <p className="text-sm font-medium text-gray-900">
                        {activity.description}
                      </p>
                      <p className="text-xs text-gray-500">
                        {activity.timestamp}
                      </p>
                    </div>
                    {activity.score && (
                      <div className="text-sm font-medium text-gray-700">
                        {Math.round(activity.score * 100)}%
                      </div>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              <div className="text-center py-8">
                <CalendarIcon className="h-12 w-12 text-gray-300 mx-auto mb-4" />
                <p className="text-gray-500">No recent activity</p>
                <p className="text-sm text-gray-400">Start practicing to see your progress here!</p>
              </div>
            )}
          </div>
        )}
      </div>

      {/* Learning Recommendations */}
      <div className="bg-white rounded-lg shadow-lg p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-4 flex items-center space-x-2">
          <AcademicCapIcon className="h-5 w-5" />
          <span>Recommended Focus Areas</span>
        </h2>
        
        <div className="space-y-3">
          {Object.entries(skillCompetencies)
            .sort(([,a], [,b]) => a - b)
            .slice(0, 3)
            .map(([skill, competency]) => (
              <div key={skill} className="flex items-center justify-between p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
                <div>
                  <p className="font-medium text-gray-900">{formatSkillName(skill)}</p>
                  <p className="text-sm text-gray-600">
                    Current level: {getSkillLevel(competency).level}
                  </p>
                </div>
                <button className="px-3 py-1 bg-yellow-600 text-white text-sm font-medium rounded hover:bg-yellow-700 transition-colors">
                  Practice
                </button>
              </div>
            ))}
        </div>
      </div>
    </div>
  );
};

export default ProgressDashboard;