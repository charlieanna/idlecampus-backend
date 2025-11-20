
import React, { useEffect, useState } from 'react';
import { 
  TrophyIcon,
  ShieldCheckIcon,
  StarIcon
} from '@heroicons/react/24/outline';
import { 
  TrophyIcon as TrophySolidIcon,
  ShieldCheckIcon as ShieldCheckSolidIcon,
  StarIcon as StarSolidIcon
} from '@heroicons/react/24/solid';

const MemoryShield = ({ 
  shield, 
  size = 'md',
  showLabel = false,
  showTooltip = true,
  className = '',
  animated = false
}) => {
  const getShieldConfig = (shieldType) => {
    const configs = {
      platinum: {
        icon: TrophySolidIcon,
        solidIcon: TrophySolidIcon,
        outlineIcon: TrophyIcon,
        color: 'text-purple-600',
        bg: 'bg-purple-100',
        border: 'border-purple-300',
        gradient: 'from-purple-400 to-purple-600',
        label: 'Platinum Shield',
        description: '90+ days retention - Elite mastery',
        glow: 'shadow-purple-500/25'
      },
      gold: {
        icon: TrophySolidIcon,
        solidIcon: TrophySolidIcon,
        outlineIcon: TrophyIcon,
        color: 'text-yellow-500',
        bg: 'bg-yellow-100',
        border: 'border-yellow-300',
        gradient: 'from-yellow-400 to-yellow-600',
        label: 'Gold Shield',
        description: '30-90 days retention - Advanced mastery',
        glow: 'shadow-yellow-500/25'
      },
      silver: {
        icon: ShieldCheckSolidIcon,
        solidIcon: ShieldCheckSolidIcon,
        outlineIcon: ShieldCheckIcon,
        color: 'text-gray-500',
        bg: 'bg-gray-100',
        border: 'border-gray-300',
        gradient: 'from-gray-400 to-gray-600',
        label: 'Silver Shield',
        description: '7-30 days retention - Developing mastery',
        glow: 'shadow-gray-500/25'
      },
      bronze: {
        icon: StarSolidIcon,
        solidIcon: StarSolidIcon,
        outlineIcon: StarIcon,
        color: 'text-orange-500',
        bg: 'bg-orange-100',
        border: 'border-orange-300',
        gradient: 'from-orange-400 to-orange-600',
        label: 'Bronze Shield',
        description: 'Less than 7 days retention - Fresh learning',
        glow: 'shadow-orange-500/25'
      }
    };
    return configs[shieldType] || null;
  };

  const getSizeConfig = (sizeType) => {
    const sizes = {
      xs: {
        container: 'w-4 h-4',
        icon: 'w-2.5 h-2.5',
        label: 'text-xs',
        padding: 'p-0.5'
      },
      sm: {
        container: 'w-6 h-6',
        icon: 'w-3.5 h-3.5',
        label: 'text-xs',
        padding: 'p-1'
      },
      md: {
        container: 'w-8 h-8',
        icon: 'w-5 h-5',
        label: 'text-sm',
        padding: 'p-1.5'
      },
      lg: {
        container: 'w-12 h-12',
        icon: 'w-7 h-7',
        label: 'text-base',
        padding: 'p-2'
      },
      xl: {
        container: 'w-16 h-16',
        icon: 'w-10 h-10',
        label: 'text-lg',
        padding: 'p-3'
      }
    };
    return sizes[sizeType] || sizes.md;
  };

  if (!shield) {
    return null;
  }

  const config = getShieldConfig(shield);
  const sizeConfig = getSizeConfig(size);

  if (!config) {
    return null;
  }

  const IconComponent = animated ? config.solidIcon : config.icon;

  const shieldElement = React.createElement('div', {
    className: `
      relative inline-flex items-center justify-center
      ${sizeConfig.container}
      ${config.bg}
      ${config.border}
      ${animated ? `bg-gradient-to-br ${config.gradient} ${config.glow} shadow-lg` : ''}
      ${animated ? 'animate-pulse' : ''}
      border-2 rounded-full
      ${className}
    `
  }, [
    React.createElement(IconComponent, {
      key: 'icon',
      className: `${sizeConfig.icon} ${animated ? 'text-white' : config.color}`
    }),
    animated && React.createElement('div', {
      key: 'overlay',
      className: 'absolute inset-0 rounded-full bg-gradient-to-br from-white/20 to-transparent'
    })
  ]);

  if (showLabel) {
    return React.createElement('div', {
      className: 'flex items-center space-x-2'
    }, [
      shieldElement,
      React.createElement('div', { key: 'label' }, [
        React.createElement('div', {
          key: 'title',
          className: `font-medium ${config.color} ${sizeConfig.label}`
        }, config.label),
        size !== 'xs' && size !== 'sm' && React.createElement('div', {
          key: 'desc',
          className: 'text-xs text-gray-500'
        }, config.description)
      ])
    ]);
  }

  if (showTooltip) {
    return React.createElement('div', {
      className: 'group relative'
    }, [
      shieldElement,
      React.createElement('div', {
        key: 'tooltip',
        className: `
          absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2
          opacity-0 group-hover:opacity-100 transition-opacity duration-200
          bg-black text-white text-xs rounded px-2 py-1 whitespace-nowrap
          z-10 pointer-events-none
        `
      }, [
        config.label,
        React.createElement('div', {
          key: 'desc',
          className: 'text-gray-300'
        }, config.description),
        React.createElement('div', {
          key: 'arrow',
          className: 'absolute top-full left-1/2 transform -translate-x-1/2 w-0 h-0 border-l-4 border-r-4 border-t-4 border-transparent border-t-black'
        })
      ])
    ]);
  }

  return shieldElement;
};

// Compound component for displaying multiple shields
export const MemoryShieldStack = ({ 
  shields = [], 
  maxDisplay = 3,
  size = 'sm',
  className = '' 
}) => {
  const displayShields = shields.slice(0, maxDisplay);
  const remainingCount = shields.length - maxDisplay;

  return React.createElement('div', {
    className: `flex items-center space-x-1 ${className}`
  }, [
    ...displayShields.map((shield, index) => 
      React.createElement(MemoryShield, {
        key: `${shield}-${index}`,
        shield: shield,
        size: size,
        showTooltip: true
      })
    ),
    remainingCount > 0 && React.createElement('div', {
      key: 'remaining',
      className: 'text-xs text-gray-500 ml-1'
    }, `+${remainingCount}`)
  ]);
};

// Achievement celebration component
export const ShieldEarnedCelebration = ({ 
  shield, 
  onClose,
  autoClose = true,
  autoCloseDelay = 3000
}) => {
  const [isVisible, setIsVisible] = useState(true);

  useEffect(() => {
    if (autoClose) {
      const timer = setTimeout(() => {
        setIsVisible(false);
        if (onClose) onClose();
      }, autoCloseDelay);
      return () => clearTimeout(timer);
    }
  }, [autoClose, autoCloseDelay, onClose]);

  const getShieldConfig = (shieldType) => {
    const configs = {
      platinum: {
        icon: TrophySolidIcon,
        color: 'text-purple-600',
        bg: 'bg-purple-100',
        border: 'border-purple-300',
        gradient: 'from-purple-400 to-purple-600',
        label: 'Platinum Shield',
        description: '90+ days retention - Elite mastery',
        glow: 'shadow-purple-500/25'
      },
      gold: {
        icon: TrophySolidIcon,
        color: 'text-yellow-500',
        bg: 'bg-yellow-100',
        border: 'border-yellow-300',
        gradient: 'from-yellow-400 to-yello