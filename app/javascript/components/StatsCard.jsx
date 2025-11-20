import React from 'react';

export function StatsCard({ icon: Icon, value, label, gradient }) {
  return (
    <div className={`${gradient} text-white rounded-xl p-6 shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1`}>
      <div className="flex items-center gap-4">
        <div className="text-4xl opacity-90">
          <Icon size={40} strokeWidth={2} />
        </div>
        <div className="flex-1">
          <div className="text-3xl font-bold mb-1">{value}</div>
          <div className="text-sm font-medium opacity-90 uppercase tracking-wide">{label}</div>
        </div>
      </div>
    </div>
  );
}
