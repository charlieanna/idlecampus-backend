import React, { useState } from 'react';

const SimpleMasteryDashboard = ({ userId, initialStats = {}, learningUnits = [], dockerCommands = [] }) => {
  const [selectedDifficulty, setSelectedDifficulty] = useState('all');
  const [selectedCategory, setSelectedCategory] = useState('all');

  const getDifficultyColor = (difficulty) => {
    const colors = {
      easy: { color: '#00FF88', bg: 'rgba(0, 255, 136, 0.1)', label: 'Easy' },
      medium: { color: '#FFB835', bg: 'rgba(255, 184, 53, 0.1)', label: 'Medium' },
      hard: { color: '#FF0080', bg: 'rgba(255, 0, 128, 0.1)', label: 'Hard' }
    };
    return colors[difficulty] || colors.easy;
  };

  const getStatusColor = (completed, masteryScore) => {
    if (completed) return { level: 'Completed', color: '#00FF88', bg: 'rgba(0, 255, 136, 0.1)' };
    if (masteryScore > 0) return { level: 'In Progress', color: '#00D4FF', bg: 'rgba(0, 212, 255, 0.1)' };
    return { level: 'Not Started', color: '#94A3B8', bg: 'rgba(148, 163, 184, 0.1)' };
  };

  const filteredUnits = learningUnits.filter(u => {
    if (selectedDifficulty !== 'all' && u.difficulty !== selectedDifficulty) return false;
    if (selectedCategory !== 'all' && u.category !== selectedCategory) return false;
    return true;
  });

  const categories = [...new Set(learningUnits.map(u => u.category))];

  const StatCard = ({ title, value, color, icon }) => (
    <div style={{
      background: 'rgba(255, 255, 255, 0.05)',
      backdropFilter: 'blur(10px)',
      borderRadius: '12px',
      padding: '20px',
      border: '1px solid rgba(255, 255, 255, 0.1)',
      boxShadow: `0 0 20px ${color}40`
    }}>
      <div style={{ fontSize: '14px', color: '#94A3B8', marginBottom: '8px' }}>{icon} {title}</div>
      <div style={{ fontSize: '32px', fontWeight: '700', color: color }}>{value}</div>
    </div>
  );

  const LearningUnitCard = ({ unit }) => {
    const difficultyInfo = getDifficultyColor(unit.difficulty);
    const statusInfo = getStatusColor(unit.completed, unit.masteryScore);
    
    return (
      <div style={{
        background: statusInfo.bg,
        border: `2px solid ${statusInfo.color}40`,
        borderRadius: '12px',
        padding: '16px',
        marginBottom: '12px',
        transition: 'all 0.3s ease',
        cursor: 'pointer'
      }}
      onClick={() => window.location.href = `/interactive/learn/${unit.slug}`}
      onMouseOver={(e) => e.currentTarget.style.transform = 'translateX(4px)'}
      onMouseOut={(e) => e.currentTarget.style.transform = 'translateX(0)'}
      >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div style={{ flex: 1 }}>
            <div style={{ 
              fontSize: '18px', 
              fontWeight: '600',
              color: '#FFFFFF',
              marginBottom: '8px'
            }}>
              {unit.title}
            </div>
            <div style={{ 
              fontFamily: 'monospace', 
              fontSize: '14px', 
              color: '#00D4FF',
              marginBottom: '8px',
              background: 'rgba(0, 212, 255, 0.1)',
              padding: '4px 8px',
              borderRadius: '4px',
              display: 'inline-block'
            }}>
              $ {unit.command}
            </div>
            <div style={{ fontSize: '12px', color: '#94A3B8', marginTop: '8px' }}>
              {unit.category} • {unit.estimatedMinutes} min
            </div>
          </div>
          <div style={{ textAlign: 'right', marginLeft: '16px' }}>
            <div style={{
              fontSize: '12px',
              fontWeight: '600',
              color: difficultyInfo.color,
              background: difficultyInfo.bg,
              padding: '4px 12px',
              borderRadius: '6px',
              marginBottom: '8px'
            }}>
              {difficultyInfo.label}
            </div>
            <div style={{
              fontSize: '12px',
              fontWeight: '600',
              color: statusInfo.color
            }}>
              {statusInfo.level}
            </div>
            {unit.masteryScore > 0 && (
              <div style={{
                fontSize: '18px',
                fontWeight: '700',
                color: statusInfo.color,
                marginTop: '4px'
              }}>
                {Math.round(unit.masteryScore * 100)}%
              </div>
            )}
          </div>
        </div>
      </div>
    );
  };

  return (
    <div style={{
      minHeight: '600px',
      background: 'linear-gradient(135deg, #0a0e27 0%, #1a1f3a 100%)',
      padding: '24px',
      borderRadius: '16px'
    }}>
      <div style={{ marginBottom: '24px' }}>
        <h2 style={{
          color: '#FFFFFF',
          fontSize: '28px',
          fontWeight: '700',
          marginBottom: '8px'
        }}>
          🎯 Interactive Learning Units
        </h2>
        <p style={{ color: '#94A3B8', fontSize: '14px' }}>
          Practice Docker commands with hands-on exercises
        </p>
      </div>

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '16px',
        marginBottom: '32px'
      }}>
        <StatCard title=\"Not Started\" value={initialStats.notStarted || 0} color=\"#94A3B8\" icon=\"📝\" />
        <StatCard title=\"In Progress\" value={initialStats.inProgress || 0} color=\"#00D4FF\" icon=\"⚡\" />
        <StatCard title=\"Completed\" value={initialStats.completed || 0} color=\"#00FF88\" icon=\"✅\" />
        <StatCard title=\"Total Units\" value={initialStats.total || 0} color=\"#FFB835\" icon=\"📚\" />
      </div>

      <div style={{
        display: 'flex',
        gap: '12px',
        marginBottom: '24px',
        flexWrap: 'wrap'
      }}>
        <div>
          <label style={{ color: '#94A3B8', fontSize: '12px', marginBottom: '4px', display: 'block' }}>
            Difficulty
          </label>
          <select
            value={selectedDifficulty}
            onChange={(e) => setSelectedDifficulty(e.target.value)}
            style={{
              background: 'rgba(255, 255, 255, 0.05)',
              border: '1px solid rgba(255, 255, 255, 0.1)',
              borderRadius: '8px',
              padding: '8px 12px',
              color: '#FFFFFF',
              fontSize: '14px',
              cursor: 'pointer'
            }}
          >
            <option value=\"all\">All Levels</option>
            <option value=\"easy\">Easy</option>
            <option value=\"medium\">Medium</option>
            <option value=\"hard\">Hard</option>
          </select>
        </div>
        <div>
          <label style={{ color: '#94A3B8', fontSize: '12px', marginBottom: '4px', display: 'block' }}>
            Category
          </label>
          <select
            value={selectedCategory}
            onChange={(e) => setSelectedCategory(e.target.value)}
            style={{
              background: 'rgba(255, 255, 255, 0.05)',
              border: '1px solid rgba(255, 255, 255, 0.1)',
              borderRadius: '8px',
              padding: '8px 12px',
              color: '#FFFFFF',
              fontSize: '14px',
              cursor: 'pointer'
            }}
          >
            <option value=\"all\">All Categories</option>
            {categories.map(cat => (
              <option key={cat} value={cat}>{cat}</option>
            ))}
          </select>
        </div>
      </div>

      <div>
        {