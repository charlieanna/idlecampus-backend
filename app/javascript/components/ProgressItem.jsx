import React from 'react';
import { Lock, CheckCircle2, Circle, ArrowRight } from 'lucide-react';

export function ProgressItem({ title, subtitle, status, progress }) {
  const getStatusIcon = () => {
    switch (status) {
      case 'completed':
        return <CheckCircle2 className="w-5 h-5 text-green-600" />;
      case 'current':
        return <ArrowRight className="w-5 h-5 text-blue-600" />;
      case 'available':
        return <Circle className="w-5 h-5 text-slate-400" />;
      case 'locked':
        return <Lock className="w-5 h-5 text-slate-300" />;
      default:
        return <Circle className="w-5 h-5 text-slate-400" />;
    }
  };

  const getStatusClass = () => {
    switch (status) {
      case 'completed':
        return 'bg-green-50 border-green-200 hover:bg-green-100';
      case 'current':
        return 'bg-blue-50 border-blue-300 hover:bg-blue-100 shadow-sm';
      case 'available':
        return 'bg-white border-slate-200 hover:bg-slate-50';
      case 'locked':
        return 'bg-slate-50 border-slate-200 opacity-50';
      default:
        return 'bg-white border-slate-200 hover:bg-slate-50';
    }
  };

  return (
    <div
      className={`p-3 rounded-lg border transition-all duration-200 cursor-pointer ${getStatusClass()}`}
    >
      <div className="flex items-center gap-3">
        <div className="flex-shrink-0">{getStatusIcon()}</div>
        <div className="flex-1 min-w-0">
          <div className="text-sm font-semibold text-slate-900 truncate">{title}</div>
          {subtitle && <div className="text-xs text-slate-500 mt-0.5">{subtitle}</div>}
          {progress !== undefined && status !== 'locked' && (
            <div className="mt-2">
              <div className="h-1.5 bg-slate-200 rounded-full overflow-hidden">
                <div
                  className={`h-full transition-all duration-300 ${
                    status === 'completed' ? 'bg-green-500' : 'bg-blue-500'
                  }`}
                  style={{ width: `${progress}%` }}
                />
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
