import React from 'react';

export function CodeBlock({ code }) {
  return (
    <div className="bg-slate-900 rounded-lg p-4 overflow-x-auto border border-slate-700">
      <code className="text-cyan-400 font-mono text-sm whitespace-pre">{code}</code>
    </div>
  );
}
