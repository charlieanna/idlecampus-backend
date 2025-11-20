import React from 'react';

export function Badge({ children, className = '' }) {
  return (
    <span
      className={`inline-flex items-center px-3 py-1 rounded-md text-xs font-semibold ${className}`}
    >
      {children}
    </span>
  );
}
