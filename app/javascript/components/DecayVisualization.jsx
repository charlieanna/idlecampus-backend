import React, { useState, useEffect } from 'react';
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
  AreaChart,
  Area,
  ReferenceLine,
  Legend
} from 'recharts';
import {
  ClockIcon,
  TrophyIcon,
  ExclamationTriangleIcon,
  ArrowTrendingDownIcon,
  ShieldCheckIcon
} from '@heroicons/react/24/outline';

const DecayVisualization = ({ 
  commandMasteries = [], 
  timeRange = 30,
  showPredictions = true,
  userId 
}) => {
  const [selectedCommand, setSelectedCommand] = useState(null);
  const [decayData, setDecayData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchDecayData();
  }, [commandMasteries, timeRange]);

  const fetchDecayData = async () => {
    setLoading(true);
    try {
      const response = await fetch(`/api/mastery/decay_visualization?time_range=${timeRange}&user_id=${userId}`);
      const data = await response.json();
      setDecayData(data.decay_timeline || []);
    } catch (error) {
      console.error('Failed to fetch decay data:', error);
    } finally {
      setLoading(false);
    }
  };

  // Calculate Ebbinghaus forgetting curve for prediction
  const generateDecayCurve = (mastery, daysAhead = 30) => {
    const MUSCLE_MEMORY_FLOOR = 40;
    const currentScore = mastery.proficiency_score;
    const strengthFactor = calculateStrengthFactor(mastery);
    
    const curve = [];
    for (let day = 0; day <= daysAhead; day++) {
      // Ebbinghaus: R = e^(-t/S)
      const retention = Math.exp(-day / strengthFactor);
      let decayedScore = currentScore * retention;
      
      // Apply muscle memory floor
      const scoreAboveFloor = decayedScore - MUSCLE_MEMORY_FLOOR;
      decayedScore = MUSCLE_MEMORY_FLOOR + (scoreAboveFloor * 0.9);
      
      curve.push({
        day,
        score: Math.max(decayedScore, MUSCLE_MEMORY_FLOOR),
        isProjection: day > 0
      });
    }
    return curve;
  };

  const calculateStrengthFactor = (mastery) => {
    const baseStrength = 7.0;
    const contextBonus = (mastery.contexts_seen?.length || 0) * 2;
    const successRate = mastery.successful_attempts > 0 
      ? (mastery.successful_attempts / mastery.total_attempts) 
      : 0;
    const successBonus = successRate * 5;
    
    return baseStrength + contextBonus + successBonus;
  };

  const getDecayRiskLevel = (score, daysSinceUse) => {
    if (score >= 90) return 'safe';
    if (score >= 70) return 'watch';
    if (score >= 50) return 'risk';
    return 'critical';
  };

  const getRiskColor = (level) => {
    switch (level) {
      case 'safe': return 'text-green-600 bg-green-50';
      case 'watch': return 'text-blue-600 bg-blue-50';
      case 'risk': return 'text-yellow-600 bg-yellow-50';
      case 'critical': return 'text-red-600 bg-red-50';
      default: return 'text-gray-600 bg-gray-50';
    }
  };

  const formatTimeAgo = (timestamp) => {
    if (!timestamp) return 'Never';
    const days = Math.floor((Date.now() - new Date(timestamp)) / (1000 * 60 * 60 * 24));
    if (days === 0) return 'Today';
    if (days === 1) return 'Yesterday';
    if (days < 7) return `${days} days ago`;
    if (days < 30) return `${Math.floor(days / 7)} weeks ago`;
    return `${Math.floor(days / 30)} months ago`;
  };

  const getShieldProtection = (mastery) => {
    if (!mastery.shields) return null;
    
    const activeShields = mastery.shields.filter(shield => {
      return !shield.active_until || new Date(shield.active_until) > new Date();
    });
    
    return activeShields.length > 0 ? activeShields[0] : null;
  };

  const requestStealthReview = async (mastery) => {
    try {
      const response = await fetch('/api/mastery/request_stealth_review', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          user_id: userId,
          canonical_command: mastery.canonical_command
        })
      });
      
      const result = await response.json();
      if (result.success) {
        console.log('Stealth review queued for next lesson');
      }
    } catch (error) {
      console.error('Failed to request stealth review:', error);
    }
  };

  if (loading) {
    return (
      <div className="bg-white rounded-lg border border-gray-200 p-6">
        <div className="animate-pulse">
          <div className="h-6 bg-gray-200 rounded w-1/3 mb-4"></div>
          <div className="h-64 bg-gray-200 rounded"></div>
        </div>
      </div>
    );
  }

  const commandsAtRisk = commandMasteries.filter(m => m.proficiency_score < 80);
  const commandsDecaying = commandMasteries.filter(m => {
    const daysSinceUse = Math.floor((Date.now() - new Date(m.last_practiced_at)) / (1000 * 60 * 60 * 24));
    return daysSinceUse > 7 && m.proficiency_score < 100;
  });

  return (
    <div className="space-y-6">
      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <div className="flex items-center">
            <TrophyIcon className="w-8 h-8 text-green-500" />
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-500">Mastered</p>
              <p className="text-2xl font-semibold text-gray-900">
                {commandMasteries.filter(m => m.proficiency_score >= 100).length}
              </p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <div className="flex items-center">
            <ArrowTrendingDownIcon className="w-8 h-8 text-yellow-500" />
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-500">Decaying</p>
              <p className="text-2xl font-semibold text-gray-900">
                {commandsDecaying.length}
              </p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <div className="flex items-center">
            <ExclamationTriangleIcon className="w-8 h-8 text-red-500" />
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-500">At Risk</p>
              <p className="text-2xl font-semibold text-gray-900">
                {commandsAtRisk.length}
              </p>
            </div>
          </div>
        </div>

        <div className="bg-white rounded-lg border border-gray-200 p-4">
          <div className="flex items-center">
            <ShieldCheckIcon className="w-8 h-8 text-blue-500" />
            <div className="ml-3">
              <p className="text-sm font-medium text-gray-500">Protected</p>
              <p className="text-2xl font-semibold text-gray-900">
                {commandMasteries.filter(m => getShieldProtection(m)).length}
              </p>
            </div>
          </div>
        </div>
      </div>

      {/* Main Visualization */}
      <div className="bg-white rounded-lg border border-gray-200">
        <div className="p-4 border-b border-gray-200">
          <div className="flex justify-between items-center">
            <h3 className="text-lg font-semibold text-gray-900">
              Command Retention Curves
            </h3>
            <div className="flex space-x-2">
              <select 
                className="border border-gray-300 rounded px-3 py-1 text-sm"
                onChange={(e) => setSelectedCommand(e.target.value || null)}
                value={selectedCommand || ''}
              >
                <option value="">All Commands</option>
                {commandMasteries.map(m => (
                  <option key={m.canonical_command} value={m.canonical_command}>
                    {m.canonical_command}
                  </option>
                ))}
              </select>
            </div>
          </div>
        </div>

        <div className="p-6">
          {selectedCommand ? (
            <div className="space-y-4">
              {/* Individual Command Chart */}
              <div className="h-80">
                <ResponsiveContainer width="100%" height="100%">
                  <AreaChart data={generateDecayCurve(commandMasteries.find(m => m.canonical_command === selectedCommand))}>
                    <CartesianGrid strokeDasharray="3 3" />
                    <XAxis dataKey="day" label={{ value: 'Days', position: 'insideBottom', offset: -5 }} />
                    <YAxis domain={[0, 120]} label={{ value: 'Proficiency Score', angle: -90, position: 'insideLeft' }} />
                    <Tooltip />
                    <ReferenceLine y={100} stroke="#10b981" strokeDasharray="5 5" label="Mastery" />
                    <ReferenceLine y={80} stroke="#f59e0b" strokeDasharray="5 5" label="Risk Threshold" />
                    <ReferenceLine y={40} stroke="#ef4444" strokeDasharray="5 5" label="Muscle Memory Floor" />
                    <Area 
                      type="monotone" 
                      dataKey="score" 
                      stroke="#6366f1" 
                      fill="#6366f1" 
                      fillOpacity={0.3}
                    />
                  </AreaChart>
                </ResponsiveContainer>
              </div>

              {/* Command Details */}
              {(() => {
                const mastery = commandMasteries.find(m => m.canonical_command === selectedCommand);
                const daysSinceUse = Math.floor((Date.now() - new Date(mastery.last_practiced_at)) / (1000 * 60 * 60 * 24));
                const riskLevel = getDecayRiskLevel(mastery.proficiency_score, daysSinceUse);
                const shield = getShieldProtection(mastery);

                return (
                  <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <div className="bg-gray-50 rounded-lg p-4">
                      <h4 className="font-medium text-gray-900 mb-2">Current Status</h4>
                      <div className="space-y-2">
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Score:</span>
                          <span className="font-medium">{mastery.proficiency_score}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Last Used:</span>
                          <span className="font-medium">{formatTimeAgo(mastery.last_practiced_at)}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Risk Level:</span>
                          <span className={`px-2 py-1 rounded-full text-xs font-medium ${getRiskColor(riskLevel)}`}>
                            {riskLevel}
                          </span>
                        </div>
                      </div>
                    </div>

                    <div className="bg-gray-50 rounded-lg p-4">
                      <h4 className="font-medium text-gray-900 mb-2">Learning Stats</h4>
                      <div className="space-y-2">
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Success Rate:</span>
                          <span className="font-medium">
                            {mastery.total_attempts > 0 
                              ? Math.round((mastery.successful_attempts / mastery.total_attempts) * 100)
                              : 0}%
                          </span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Contexts:</span>
                          <span className="font-medium">{mastery.contexts_seen?.length || 0}</span>
                        </div>
                        <div className="flex justify-between">
                          <span className="text-sm text-gray-600">Attempts:</span>
                          <span className="font-medium">{mastery.total_attempts}</span>
                        </div>
                      </div>
                    </div>

                    <div className="bg-gray-50 rounded-lg p-4">
                      <h4 className="font-medium text-gray-900 mb-2">Actions</h4>
                      <div className="space-y-2">
                        {shield && (
                          <div className="flex items-center text-sm text-blue-600">
                            <ShieldCheckIcon className="w-4 h-4 mr-1" />
                            Protected until {new Date(shield.active_until).toLocaleDateString()}
                          </div>
                        )}
                        <button
                          onClick={() => requestStealthReview(mastery)}
                          className="w-full px-3 py-2 bg-indigo-600 text-white text-sm rounded hover:bg-indigo-700"
                        >
                          Request Review
                        </button>
                      </div>
                    </div>
                  </div>
                );
              })()}
            </div>
          ) : (
            <div className="h-80">
              <ResponsiveContainer width="100%" height="100%">
                <LineChart data={decayData}>
                  <CartesianGrid strokeDasharray="3 3" />
                  <XAxis dataKey="date" />
                  <YAxis domain={[0, 120]} />
                  <Tooltip />
                  <Legend />
                  <ReferenceLine y={100} stroke="#10b981" strokeDasharray="5 5" />
                  <ReferenceLine y={80} stroke="#f59e0b" strokeDasharray="5 5" />
                  <Line 
                    type="monotone" 
                    dataKey="average_score" 
                    stroke="#6366f1" 
                    strokeWidth={2}
                    name="Average Score"
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
          )}
        </div>
      </div>

      {/* At-Risk Commands List */}
      {commandsAtRisk.length > 0 && (
        <div className="bg-white rounded-lg border border-gray-200">
          <div className="p-4 border-b border-gray-200">
            <h3 className="text-lg font-semibold text-gray-900">Commands Needing Attention</h3>
          </div>
          <div className="p-4">
            <div className="grid gap-3">
              {commandsAtRisk.slice(0, 10).map(mastery => {
                const daysSinceUse = Math.floor((Date.now() - new Date(mastery.last_practiced_at)) / (1000 * 60 * 60 * 24));
                const riskLevel = getDecayRiskLevel(mastery.proficiency_score, daysSinceUse);
                const shield = getShieldProtection(mastery);

                return (
                  <div key={mastery.canonical_command} className="flex items-center justify-between p-3 bg-gray-50 rounded">
                    <div className="flex items-center space-x-3">
                      <code className="font-mono text-sm bg-gray-200 px-2 py-1 rounded">
                        {mastery.canonical_command}
                      </code>
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${getRiskColor(riskLevel)}`}>
                        {riskLevel}
                      </span>
                      {shield && <ShieldCheckIcon className="w-4 h-4 text-blue-500" />}
                    </div>
                    <div className="flex items-center space-x-4">
                      <div className="text-right">
                        <div className="text-sm font-medium">{mastery.proficiency_score}</div>
                        <div className="text-xs text-gray-500">{formatTimeAgo(mastery.last_practiced_at)}</div>
                      </div>
                      <button
                        onClick={() => requestStealthReview(mastery)}
                        className="px-3 py-1 bg-indigo-600 text-white text-xs rounded hover:bg-indigo-700"
                      >
                        Review
                      </button>
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default DecayVisualization;