import React, { useState, useEffect, useRef } from 'react';
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
  Legend,
  RadialBarChart,
  RadialBar,
  PolarAngleAxis
} from 'recharts';
import {
  ClockIcon,
  TrophyIcon,
  ExclamationTriangleIcon,
  ArrowTrendingDownIcon,
  ShieldCheckIcon,
  FireIcon,
  SparklesIcon,
  BoltIcon,
  StarIcon,
  RocketLaunchIcon,
  ChartBarIcon
} from '@heroicons/react/24/outline';
import { StarIcon as StarIconSolid } from '@heroicons/react/24/solid';

// Enhanced gamified component with CodeSchool-style engagement
const EnhancedDecayVisualization = ({ 
  commandMasteries = [], 
  timeRange = 30,
  showPredictions = true,
  userId 
}) => {
  const [selectedCommand, setSelectedCommand] = useState(null);
  const [decayData, setDecayData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [userStats, setUserStats] = useState({
    level: 1,
    xp: 0,
    nextLevelXp: 100,
    streak: 0,
    badges: [],
    rank: 'Novice'
  });
  const [showAchievement, setShowAchievement] = useState(false);
  const [achievementData, setAchievementData] = useState(null);
  const [animatingScore, setAnimatingScore] = useState({});
  const particleContainer = useRef(null);

  // Calculate user level and XP from masteries
  useEffect(() => {
    const totalXP = commandMasteries.reduce((sum, m) => sum + m.proficiency_score * 10, 0);
    const level = Math.floor(totalXP / 1000) + 1;
    const currentLevelXP = totalXP % 1000;
    const nextLevelXP = 1000;
    
    // Determine rank based on level
    const ranks = ['Novice', 'Apprentice', 'Journeyman', 'Expert', 'Master', 'Grandmaster', 'Legend'];
    const rankIndex = Math.min(Math.floor(level / 5), ranks.length - 1);
    
    setUserStats({
      level,
      xp: currentLevelXP,
      nextLevelXp: nextLevelXP,
      streak: calculateStreak(commandMasteries),
      badges: calculateBadges(commandMasteries),
      rank: ranks[rankIndex]
    });
  }, [commandMasteries]);

  useEffect(() => {
    fetchDecayData();
  }, [commandMasteries, timeRange]);

  // Animated score counter
  useEffect(() => {
    commandMasteries.forEach(mastery => {
      if (!animatingScore[mastery.canonical_command]) {
        animateScoreChange(mastery.canonical_command, 0, mastery.proficiency_score);
      }
    });
  }, [commandMasteries]);

  const animateScoreChange = (command, from, to) => {
    const duration = 1000;
    const steps = 30;
    const increment = (to - from) / steps;
    let current = from;
    let step = 0;

    const timer = setInterval(() => {
      step++;
      current += increment;
      
      setAnimatingScore(prev => ({
        ...prev,
        [command]: Math.round(current)
      }));

      if (step >= steps) {
        clearInterval(timer);
        setAnimatingScore(prev => ({
          ...prev,
          [command]: to
        }));
      }
    }, duration / steps);
  };

  const calculateStreak = (masteries) => {
    // Calculate daily practice streak
    const today = new Date().setHours(0, 0, 0, 0);
    const yesterday = today - 86400000;
    
    const practicedToday = masteries.some(m => {
      const practiceDate = new Date(m.last_practiced_at).setHours(0, 0, 0, 0);
      return practiceDate === today;
    });
    
    const practicedYesterday = masteries.some(m => {
      const practiceDate = new Date(m.last_practiced_at).setHours(0, 0, 0, 0);
      return practiceDate === yesterday;
    });

    if (practicedToday && practicedYesterday) return 2; // Simplified for demo
    if (practicedToday) return 1;
    return 0;
  };

  const calculateBadges = (masteries) => {
    const badges = [];
    
    // Speed Demon - Master a command in under 5 attempts
    if (masteries.some(m => m.proficiency_score >= 100 && m.total_attempts <= 5)) {
      badges.push({ id: 'speed-demon', name: 'Speed Demon', icon: BoltIcon, color: 'yellow' });
    }
    
    // Perfectionist - 100% success rate on any command
    if (masteries.some(m => m.total_attempts > 0 && m.successful_attempts === m.total_attempts)) {
      badges.push({ id: 'perfectionist', name: 'Perfectionist', icon: StarIcon, color: 'purple' });
    }
    
    // Docker Master - Master 10+ Docker commands
    const dockerMasteries = masteries.filter(m => 
      m.canonical_command.startsWith('docker') && m.proficiency_score >= 100
    );
    if (dockerMasteries.length >= 10) {
      badges.push({ id: 'docker-master', name: 'Docker Master', icon: RocketLaunchIcon, color: 'blue' });
    }
    
    return badges;
  };

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

  const generateDecayCurve = (mastery, daysAhead = 30) => {
    const MUSCLE_MEMORY_FLOOR = 40;
    const currentScore = mastery.proficiency_score;
    const strengthFactor = calculateStrengthFactor(mastery);
    
    const curve = [];
    for (let day = 0; day <= daysAhead; day++) {
      const retention = Math.exp(-day / strengthFactor);
      let decayedScore = currentScore * retention;
      
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
    if (score >= 90) return 'legendary';
    if (score >= 80) return 'epic';
    if (score >= 70) return 'rare';
    if (score >= 50) return 'common';
    return 'danger';
  };

  const getRiskStyle = (level) => {
    const styles = {
      legendary: {
        bg: 'bg-gradient-to-r from-yellow-400 via-yellow-500 to-orange-500',
        text: 'text-yellow-100',
        glow: 'shadow-lg shadow-yellow-500/50',
        border: 'border-yellow-400'
      },
      epic: {
        bg: 'bg-gradient-to-r from-purple-500 to-pink-500',
        text: 'text-purple-100',
        glow: 'shadow-lg shadow-purple-500/50',
        border: 'border-purple-400'
      },
      rare: {
        bg: 'bg-gradient-to-r from-blue-500 to-cyan-500',
        text: 'text-blue-100',
        glow: 'shadow-lg shadow-blue-500/50',
        border: 'border-blue-400'
      },
      common: {
        bg: 'bg-gradient-to-r from-green-500 to-teal-500',
        text: 'text-green-100',
        glow: 'shadow-md shadow-green-500/30',
        border: 'border-green-400'
      },
      danger: {
        bg: 'bg-gradient-to-r from-red-500 to-pink-500',
        text: 'text-red-100',
        glow: 'shadow-lg shadow-red-500/50 animate-pulse',
        border: 'border-red-400'
      }
    };
    return styles[level] || styles.common;
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

  const requestStealthReview = async (mastery) => {
    // Add particle effect
    createParticleEffect();
    
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
        // Show achievement animation
        showAchievementAnimation({
          title: 'Review Scheduled!',
          description: `${mastery.canonical_command} will appear in your next lesson`,
          icon: SparklesIcon,
          xp: 10
        });
      }
    } catch (error) {
      console.error('Failed to request stealth review:', error);
    }
  };

  const createParticleEffect = () => {
    // Create particle animation (simplified version)
    const particles = Array.from({ length: 20 }, (_, i) => ({
      id: i,
      x: Math.random() * 100,
      y: Math.random() * 100,
      size: Math.random() * 4 + 2
    }));
    
    // In a real implementation, animate these particles
    console.log('Particle effect triggered:', particles);
  };

  const showAchievementAnimation = (achievement) => {
    setAchievementData(achievement);
    setShowAchievement(true);
    
    // Play sound effect (would need actual audio file)
    // const audio = new Audio('/sounds/achievement.mp3');
    // audio.play();
    
    setTimeout(() => {
      setShowAchievement(false);
    }, 3000);
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-900 p-6">
        <div className="max-w-7xl mx-auto">
          <div className="animate-pulse space-y-6">
            <div className="h-32 bg-white/10 rounded-2xl backdrop-blur-lg"></div>
            <div className="h-96 bg-white/10 rounded-2xl backdrop-blur-lg"></div>
          </div>
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
    <div className="min-h-screen bg-gradient-to-br from-indigo-900 via-purple-900 to-pink-900 p-6">
      <div className="max-w-7xl mx-auto space-y-6">
        {/* Achievement Notification */}
        {showAchievement && achievementData && (
          <div className="fixed top-4 right-4 z-50 animate-bounce">
            <div className="bg-gradient-to-r from-yellow-400 to-orange-500 rounded-2xl p-6 shadow-2xl shadow-yellow-500/50">
              <div className="flex items-center space-x-4">
                <achievementData.icon className="w-12 h-12 text-white animate-spin" />
                <div>
                  <h3 className="text-xl font-bold text-white">{achievementData.title}</h3>
                  <p className="text-yellow-100">{achievementData.description}</p>
                  <p className="text-2xl font-bold text-white mt-1">+{achievementData.xp} XP</p>
                </div>
              </div>
            </div>
          </div>
        )}

        {/* User Header with XP Bar and Level */}
        <div className="bg-white/10 backdrop-blur-lg rounded-3xl p-6 border border-white/20">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-6">
              {/* Avatar with Level */}
              <div className="relative">
                <div className="w-20 h-20 bg-gradient-to-br from-purple-500 to-pink-500 rounded-full flex items-center justify-center">
                  <span className="text-3xl font-bold text-white">{userStats.level}</span>
                </div>
                <div className="absolute -bottom-2 left-1/2 transform -translate-x-1/2">
                  <span className="px-3 py-1 bg-gradient-to-r from-yellow-400 to-orange-500 rounded-full text-xs font-bold text-white shadow-lg">
                    {userStats.rank}
                  </span>
                </div>
              </div>

              {/* User Info */}
              <div>
                <h2 className="text-2xl font-bold text-white">Command Master</h2>
                <div className="mt-2">
                  <div className="flex items-center space-x-4">
                    <div className="text-sm text-gray-300">
                      Level {userStats.level} • {userStats.xp}/{userStats.nextLevelXp} XP
                    </div>
                  </div>
                  <div className="mt-2 w-64 h-3 bg-gray-700 rounded-full overflow-hidden">
                    <div 
                      className="h-full bg-gradient-to-r from-blue-400 to-cyan-400 transition-all duration-1000 ease-out"
                      style={{ width: `${(userStats.xp / userStats.nextLevelXp) * 100}%` }}
                    />
                  </div>
                </div>
              </div>

              {/* Streak Counter */}
              {userStats.streak > 0 && (
                <div className="flex items-center space-x-2 px-4 py-2 bg-gradient-to-r from-orange-500 to-red-500 rounded-full shadow-lg shadow-orange-500/50">
                  <FireIcon className="w-6 h-6 text-white animate-pulse" />
                  <span className="text-xl font-bold text-white">{userStats.streak} Day Streak!</span>
                </div>
              )}
            </div>

            {/* Badge Showcase */}
            <div className="flex space-x-2">
              {userStats.badges.map(badge => (
                <div
                  key={badge.id}
                  className={`w-12 h-12 rounded-full bg-gradient-to-br from-${badge.color}-400 to-${badge.color}-600 flex items-center justify-center shadow-lg hover:scale-110 transition-transform cursor-pointer`}
                  title={badge.name}
                >
                  <badge.icon className="w-6 h-6 text-white" />
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Animated Stats Cards */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
          {[
            { 
              icon: TrophyIcon, 
              label: 'Mastered', 
              value: commandMasteries.filter(m => m.proficiency_score >= 100).length,
              color: 'from-yellow-400 to-orange-500',
              glow: 'shadow-yellow-500/50'
            },
            { 
              icon: ArrowTrendingDownIcon, 
              label: 'Decaying', 
              value: commandsDecaying.length,
              color: 'from-purple-500 to-pink-500',
              glow: 'shadow-purple-500/50'
            },
            { 
              icon: ExclamationTriangleIcon, 
              label: 'At Risk', 
              value: commandsAtRisk.length,
              color: 'from-red-500 to-pink-500',
              glow: 'shadow-red-500/50'
            },
            { 
              icon: ShieldCheckIcon, 
              label: 'Protected', 
              value: commandMasteries.filter(m => m.shields?.length > 0).length,
              color: 'from-blue-500 to-cyan-500',
              glow: 'shadow-blue-500/50'
            }
          ].map((stat, index) => (
            <div 
              key={stat.label}
              className={`relative overflow-hidden bg-gradient-to-br ${stat.color} rounded-2xl p-6 shadow-lg ${stat.glow} transform hover:scale-105 transition-all duration-300`}
              style={{ animationDelay: `${index * 100}ms` }}
            >
              <div className="absolute top-0 right-0 opacity-10">
                <stat.icon className="w-24 h-24" />
              </div>
              <div className="relative">
                <stat.icon className="w-8 h-8 text-white mb-2" />
                <p className="text-sm font-medium text-white/80">{stat.label}</p>
                <p className="text-4xl font-bold text-white animate-pulse">
                  {stat.value}
                </p>
              </div>
            </div>
          ))}
        </div>

        {/* Main Visualization with Enhanced Styling */}
        <div className="bg-white/10 backdrop-blur-lg rounded-3xl border border-white/20 overflow-hidden">
          <div className="p-6 border-b border-white/10 bg-gradient-to-r from-purple-600/20 to-pink-600/20">
            <div className="flex justify-between items-center">
              <h3 className="text-2xl font-bold text-white flex items-center">
                <ChartBarIcon className="w-8 h-8 mr-3 text-cyan-400" />
                Command Power Levels
              </h3>
              <select 
                className="bg-white/10 border border-white/20 rounded-lg px-4 py-2 text-white backdrop-blur-lg focus:outline-none focus:ring-2 focus:ring-cyan-400"
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

          <div className="p-8">
            {selectedCommand ? (
              <div className="space-y-6">
                {/* Enhanced Chart with Glow Effects */}
                <div className="bg-gradient-to-br from-indigo-900/50 to-purple-900/50 rounded-2xl p-6 shadow-inner">
                  <div className="h-80">
                    <ResponsiveContainer width="100%" height="100%">
                      <AreaChart data={generateDecayCurve(commandMasteries.find(m => m.canonical_command === selectedCommand))}>
                        <defs>
                          <linearGradient id="colorScore" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="5%" stopColor="#00D4FF" stopOpacity={0.8}/>
                            <stop offset="95%" stopColor="#00D4FF" stopOpacity={0.1}/>
                          </linearGradient>
                        </defs>
                        <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.1)" />
                        <XAxis 
                          dataKey="day" 
                          stroke="rgba(255,255,255,0.5)"
                          label={{ value: 'Days', position: 'insideBottom', offset: -5, fill: 'rgba(255,255,255,0.8)' }} 
                        />
                        <YAxis 
                          domain={[0, 120]} 
                          stroke="rgba(255,255,255,0.5)"
                          label={{ value: 'Power Level', angle: -90, position: 'insideLeft', fill: 'rgba(255,255,255,0.8)' }} 
                        />
                        <Tooltip 
                          contentStyle={{ 
                            backgroundColor: 'rgba(17, 24, 39, 0.9)', 
                            border: '1px solid rgba(255,255,255,0.2)',
                            borderRadius: '12px'
                          }}
                          labelStyle={{ color: 'rgba(255,255,255,0.8)' }}
                        />
                        <ReferenceLine y={100} stroke="#00FF88" strokeDasharray="5 5" strokeWidth={2}>
                          <label value="MASTERY" fill="#00FF88" />
                        </ReferenceLine>
                        <ReferenceLine y={80} stroke="#FFB835" strokeDasharray="5 5" strokeWidth={2}>
                          <label value="WARNING" fill="#FFB835" />
                        </ReferenceLine>
                        <ReferenceLine y={40} stroke="#FF0080" strokeDasharray="5 5" strokeWidth={2}>
                          <label value="DANGER" fill="#FF0080" />
                        </ReferenceLine>
                        <Area 
                          type="monotone" 
                          dataKey="score" 
                          stroke="#00D4FF" 
                          strokeWidth={3}
                          fill="url(#colorScore)"
                        />
                      </AreaChart>
                    </ResponsiveContainer>
                  </div>
                </div>

                {/* Enhanced Command Stats Cards */}
                {(() => {
                  const mastery = commandMasteries.find(m => m.canonical_command === selectedCommand);
                  const daysSinceUse = Math.floor((Date.now() - new Date(mastery.last_practiced_at)) / (1000 * 60 * 60 * 24));
                  const riskLevel = getDecayRiskLevel(mastery.proficiency_score, daysSinceUse);
                  const riskStyle = getRiskStyle(riskLevel);

                  return (
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
                      {/* Power Level Card */}
                      <div className="bg-gradient-to-br from-indigo-600/20 to-purple-600/20 backdrop-blur-lg rounded-2xl p-6 border border-white/10">
                        <h4 className="font-bold text-white mb-4 flex items-center">
                          <BoltIcon className="w-6 h-6 mr-2 text-yellow-400" />
                          Power Status
                        </h4>
                        <div className="space-y-3">
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Level:</span>
                            <div className={`px-3 py-1 rounded-full ${riskStyle.bg} ${riskStyle.text} ${riskStyle.glow} font-bold text-lg`}>
                              {animatingScore[mastery.canonical_command] || mastery.proficiency_score}
                            </div>
                          </div>
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Last Training:</span>
                            <span className="text-white font-medium">{formatTimeAgo(mastery.last_practiced_at)}</span>
                          </div>
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Status:</span>
                            <span className={`px-3 py-1 rounded-full text-sm font-bold uppercase ${riskStyle.bg} ${riskStyle.text} ${riskStyle.glow}`}>
                              {riskLevel}
                            </span>
                          </div>
                        </div>
                      </div>

                      {/* Combat Stats Card */}
                      <div className="bg-gradient-to-br from-green-600/20 to-teal-600/20 backdrop-blur-lg rounded-2xl p-6 border border-white/10">
                        <h4 className="font-bold text-white mb-4 flex items-center">
                          <ChartBarIcon className="w-6 h-6 mr-2 text-green-400" />
                          Combat Stats
                        </h4>
                        <div className="space-y-3">
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Accuracy:</span>
                            <div className="flex items-center">
                              {[...Array(5)].map((_, i) => (
                                <StarIconSolid 
                                  key={i}
                                  className={`w-4 h-4 ${
                                    i < Math.floor((mastery.successful_attempts / Math.max(mastery.total_attempts, 1)) * 5)
                                      ? 'text-yellow-400' 
                                      : 'text-gray-600'
                                  }`}
                                />
                              ))}
                              <span className="ml-2 text-white font-medium">
                                {mastery.total_attempts > 0 
                                  ? Math.round((mastery.successful_attempts / mastery.total_attempts) * 100)
                                  : 0}%
                              </span>
                            </div>
                          </div>
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Battles:</span>
                            <span className="text-white font-medium">{mastery.total_attempts}</span>
                          </div>
                          <div className="flex justify-between items-center">
                            <span className="text-gray-300">Victories:</span>
                            <span className="text-green-400 font-medium">{mastery.successful_attempts}</span>
                          </div>
                        </div>
                      </div>

                      {/* Action Card */}
                      <div className="bg-gradient-to-br from-pink-600/20 to-red-600/20 backdrop-blur-lg rounded-2xl p-6 border border-white/10">
                        <h4 className="font-bold text-white mb-4 flex items-center">
                          <RocketLaunchIcon className="w-6 h-6 mr-2 text-pink-400" />
                          Quick Actions
                        </h4>
                        <div className="space-y-3">
                          <button
                            onClick={() => requestStealthReview(mastery)}
                            className="w-full px-4 py-3 bg-gradient-to-r from-cyan-500 to-blue-500 text-white font-bold rounded-xl hover:from-cyan-600 hover:to-blue-600 transform hover:scale-105 transition-all duration-200 shadow-lg shadow-cyan-500/50"
                          >
                            <SparklesIcon className="w-5 h-5 inline mr-2" />
                            Boost Training
                          </button>
                          <button className="w-full px-4 py-3 bg-gradient-to-r from-purple-500 to-pink-500 text-white font-bold rounded-xl hover:from-purple-600 hover:to-pink-600 transform hover:scale-105 transition-all duration-200 shadow-lg shadow-purple-500/50">
                            <ShieldCheckIcon className="w-5 h-5 inline mr-2" />
                            Apply Shield
                          </button>
                        </div>
                        <div className="mt-4 text-center">
                          <p className="text-xs text-gray-400">+10 XP per action</p>
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
                    <defs>
                      <linearGradient id="colorLine" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="5%" stopColor="#00D4FF" stopOpacity={1}/>
                        <stop offset="95%" stopColor="#00D4FF" stopOpacity={0.3}/>
                      </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" stroke="rgba(255,255,255,0.1)" />
                    <XAxis dataKey="date" stroke="rgba(255,255,255,0.5)" />
                    <YAxis domain={[0, 120]} stroke="rgba(255,255,255,0.5)" />
                    <Tooltip 
                      contentStyle={{ 
                        backgroundColor: 'rgba(17, 24, 39, 0.9)', 
                        border: '1px solid rgba(255,255,255,0.2)',
                        borderRadius: '12px'
                      }}
                    />
                    <Legend wrapperStyle={{ color: 'rgba(255,255,255,0.8)' }} />
                    <ReferenceLine y={100} stroke="#00FF88" strokeDasharray="5 5" strokeWidth={2} />
                    <ReferenceLine y={80} stroke="#FFB835" strokeDasharray="5 5" strokeWidth={2} />
                    <Line 
                      type="monotone" 
                      dataKey="average_score" 
                      stroke="url(#colorLine)"
                      strokeWidth={3}
                      name="Fleet Power"
                      dot={{ fill: '#00D4FF', strokeWidth: 2, r: 4 }}
                      activeDot={{ r: 8 }}
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            )}
          </div>
        </div>

        {/* Command Battle Arena - At Risk Commands */}
        {commandsAtRisk.length > 0 && (
          <div className="bg-white/10 backdrop-blur-lg rounded-3xl border border-white/20 overflow-hidden">
            <div className="p-6 border-b border-white/10 bg-gradient-to-r from-red-600/20 to-pink-600/20">
              <h3 className="text-2xl font-bold text-white flex items-center">
                <ExclamationTriangleIcon className="w-8 h-8 mr-3 text-red-400 animate-pulse" />
                Battle Arena - Commands Under Attack!
              </h3>
              <p className="text-gray-300 mt-1">These commands need immediate training to survive!</p>
            </div>
            <div className="p-6">
              <div className="grid gap-4">
                {commandsAtRisk.slice(0, 5).map((mastery, index) => {
                  const daysSinceUse = Math.floor((Date.now() - new Date(mastery.last_practiced_at)) / (1000 * 60 * 60 * 24));
                  const riskLevel = getDecayRiskLevel(mastery.proficiency_score, daysSinceUse);
                  const riskStyle = getRiskStyle(riskLevel);

                  return (
                    <div 
                      key={mastery.canonical_command}
                      className="group relative overflow-hidden bg-gradient-to-r from-gray-800/50 to-gray-900/50 rounded-xl p-4 border border-white/10 hover:border-cyan-400/50 transition-all duration-300"
                      style={{ animationDelay: `${index * 50}ms` }}
                    >
                      <div className="absolute inset-0 bg-gradient-to-r from-red-600/10 to-pink-600/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                      <div className="relative flex items-center justify-between">
                        <div className="flex items-center space-x-4">
                          <div className="relative">
                            <div className="w-16 h-16 rounded-full bg-gradient-to-br from-red-500 to-pink-500 flex items-center justify-center shadow-lg shadow-red-500/50">
                              <span className="text-2xl font-bold text-white">{mastery.proficiency_score}</span>
                            </div>
                            {mastery.proficiency_score < 50 && (
                              <div className="absolute -top-1 -right-1">
                                <div className="w-4 h-4 bg-red-500 rounded-full animate-ping"></div>
                              </div>
                            )}
                          </div>
                          <div>
                            <code className="font-mono text-lg text-white bg-gray-800/80 px-3 py-1 rounded">
                              {mastery.canonical_command}
                            </code>
                            <div className="flex items-center space-x-3 mt-2">
                              <span className={`px-3 py-1 rounded-full text-xs font-bold uppercase ${riskStyle.bg} ${riskStyle.text} ${riskStyle.glow}`}>
                                {riskLevel}
                              </span>
                              <span className="text-xs text-gray-400">
                                Last battle: {formatTimeAgo(mastery.last_practiced_at)}
                              </span>
                            </div>
                          </div>
                        </div>
                        
                        <div className="flex items-center space-x-3">
                          <div className="text-right">
                            <div className="text-xs text-gray-400 mb-1">Health</div>
                            <div className="w-32 h-2 bg-gray-700 rounded-full overflow-hidden">
                              <div 
                                className={`h-full ${mastery.proficiency_score < 50 ? 'bg-gradient-to-r from-red-500 to-pink-500' : 'bg-gradient-to-r from-green-500 to-teal-500'} transition-all duration-500`}
                                style={{ width: `${mastery.proficiency_score}%` }}
                              />
                            </div>
                          </div>
                          <button
                            onClick={() => requestStealthReview(mastery)}
                            className="px-6 py-3 bg-gradient-to-r from-cyan-500 to-blue-500 text-white font-bold rounded-xl hover:from-cyan-600 hover:to-blue-600 transform hover:scale-110 transition-all duration-200 shadow-lg shadow-cyan-500/50"
                          >
                            <BoltIcon className="w-5 h-5 inline mr-1" />
                            Train
                          </button>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>
          </div>
        )}

        {/* Daily Challenges */}
        <div className="bg-white/10 backdrop-blur-lg rounded-3xl border border-white/20 overflow-hidden">
          <div className="p-6 border-b border-white/10 bg-gradient-to-r from-yellow-600/20 to-orange-600/20">
            <h3 className="text-2xl font-bold text-white flex items-center">
              <TrophyIcon className="w-8 h-8 mr-3 text-yellow-400" />
              Daily Challenges
            </h3>
          </div>
          <div className="p-6">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              {[
                { name: 'Speed Runner', desc: 'Complete 5 commands in 2 minutes', xp: 50, progress: 60 },
                { name: 'Perfect Score', desc: 'Get 100% accuracy on 3 commands', xp: 75, progress: 33 },
                { name: 'Comeback Kid', desc: 'Restore a critical command to safety', xp: 100, progress: 0 }
              ].map(challenge => (
                <div key={challenge.name} className="bg-gradient-to-br from-gray-800/50 to-gray-900/50 rounded-xl p-4 border border-white/10">
                  <h4 className="font-bold text-white">{challenge.name}</h4>
                  <p className="text-xs text-gray-400 mt-1">{challenge.desc}</p>
                  <div className="mt-3">
                    <div className="flex justify-between text-xs text-gray-400 mb-1">
                      <span>Progress</span>
                      <span>{challenge.progress}%</span>
                    </div>
                    <div className="w-full h-2 bg-gray-700 rounded-full overflow-hidden">
                      <div 
                        className="h-full bg-gradient-to-r from-yellow-400 to-orange-500 transition-all duration-500"
                        style={{ width: `${challenge.progress}%` }}
                      />
                    </div>
                  </div>
                  <div className="mt-3 text-center">
                    <span className="text-lg font-bold text-yellow-400">+{challenge.xp} XP</span>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      {/* Particles Container */}
      <div ref={particleContainer} className="fixed inset-0 pointer-events-none z-40" />
    </div>
  );
};

export default EnhancedDecayVisualization;