import React, { useState } from 'react';
import { Terminal, Play } from 'lucide-react';
import { CodeBlock } from './CodeBlock';

export function TryItCard({ title, description, command }) {
  const [output, setOutput] = useState('');
  const [isExecuting, setIsExecuting] = useState(false);

  const handleExecute = async () => {
    setIsExecuting(true);
    setOutput('Executing...');

    // Simulate command execution - in production, this would call an API
    setTimeout(() => {
      setOutput(`$ ${command}\n\nCommand executed successfully!`);
      setIsExecuting(false);
    }, 1000);
  };

  return (
    <div className="bg-gradient-to-br from-purple-50 to-blue-50 rounded-xl p-6 border-2 border-purple-200">
      <div className="flex items-start gap-3 mb-4">
        <Terminal className="w-6 h-6 text-purple-600 mt-1" />
        <div className="flex-1">
          <h3 className="text-lg font-bold text-slate-900 mb-2">{title}</h3>
          <p className="text-slate-600 text-sm mb-4">{description}</p>
        </div>
      </div>

      <div className="space-y-3">
        <div className="bg-white rounded-lg p-3 border border-purple-200">
          <code className="text-sm font-mono text-purple-700">{command}</code>
        </div>

        <button
          onClick={handleExecute}
          disabled={isExecuting}
          className="w-full flex items-center justify-center gap-2 bg-gradient-to-r from-purple-600 to-blue-600 text-white py-3 px-4 rounded-lg font-semibold hover:from-purple-700 hover:to-blue-700 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <Play className="w-4 h-4" />
          {isExecuting ? 'Executing...' : 'Run Command'}
        </button>

        {output && (
          <div className="mt-3">
            <CodeBlock code={output} />
          </div>
        )}
      </div>
    </div>
  );
}
