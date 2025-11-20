import React, { useState, useEffect, useRef } from 'react';
import { CodeBracketIcon, PlayIcon, StopIcon } from '@heroicons/react/24/solid';

const DockerTerminalLab = ({ unit, csrfToken, onComplete }) => {
  const [logs, setLogs] = useState([]);
  const [isRunning, setIsRunning] = useState(false);
  const [containerId, setContainerId] = useState(null);
  const [command, setCommand] = useState(unit.command_to_learn || '');
  const [userInput, setUserInput] = useState('');
  const [validationStatus, setValidationStatus] = useState(null);
  const [showHints, setShowHints] = useState(false);
  const logsEndRef = useRef(null);

  const scrollToBottom = () => {
    logsEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [logs]);

  // Simulate Docker container startup logs
  const simulateStartupLogs = () => {
    const startupLogs = [
      { type: 'info', message: `$ docker run -d -p 8080:80 --name codesprout-web nginx:alpine` },
      { type: 'info', message: 'Unable to find image \'nginx:alpine\' locally' },
      { type: 'info', message: 'alpine: Pulling from library/nginx' },
      { type: 'info', message: 'a143f3ba3f0b: Pull complete' },
      { type: 'info', message: 'b1a4b00b0afb: Pull complete' },
      { type: 'info', message: 'c1a1ebf90a81: Pull complete' },
      { type: 'info', message: 'Digest: sha256:1c13bc6de5b5...' },
      { type: 'info', message: 'Status: Downloaded newer image for nginx:alpine' },
      { type: 'success', message: 'Container started successfully!' },
      { type: 'info', message: `Container ID: ${Math.random().toString(36).substr(2, 12)}` },
      { type: 'info', message: 'nginx daemon started' },
      { type: 'info', message: 'Listening on port 80' },
    ];

    setIsRunning(true);
    startupLogs.forEach((log, index) => {
      setTimeout(() => {
        setLogs(prev => [...prev, log]);
        if (index === startupLogs.length - 1) {
          setContainerId(Math.random().toString(36).substr(2, 12));
          setTimeout(() => {
            setValidationStatus('success');
            setIsRunning(false);
            setTimeout(() => onComplete(), 1500);
          }, 1000);
        }
      }, index * 300);
    });
  };

  const handleRunCommand = async () => {
    if (!userInput.trim()) {
      setValidationStatus('error');
      setLogs(prev => [...prev, { type: 'error', message: 'Please enter a command' }]);
      return;
    }

    setLogs(prev => [...prev, { type: 'info', message: `$ ${userInput}` }]);
    
    // Validate command
    const correctCommand = unit.command_to_learn || '';
    const variations = unit.command_variations || [];
    const isCorrect = userInput.trim() === correctCommand.trim() || 
                      variations.some(v => userInput.trim() === v.trim());

    if (isCorrect) {
      setValidationStatus('success');
      setLogs(prev => [...prev, { type: 'success', message: '✓ Command validated successfully!' }]);
      simulateStartupLogs();
    } else {
      setValidationStatus('error');
      setLogs(prev => [...prev, { type: 'error', message: '✗ Command not recognized. Check the syntax and try again.' }]);
      
      // Show hints after failed attempts
      if (unit.practice_hints && unit.practice_hints.length > 0) {
        setShowHints(true);
      }
    }
  };

  const handleStop = () => {
    if (containerId) {
      setLogs(prev => [...prev, { type: 'info', message: `$ docker stop ${containerId}` }]);
      setTimeout(() => {
        setLogs(prev => [...prev, { type: 'info', message: `Container ${containerId} stopped` }]);
        setContainerId(null);
        setIsRunning(false);
      }, 500);
    }
  };

  const reset = () => {
    setLogs([]);
    setContainerId(null);
    setIsRunning(false);
    setUserInput('');
    setValidationStatus(null);
    setShowHints(false);
  };

  return (
    <div className="space-y-6">
      {/* Title */}
      <div className="flex items-center space-x-3 mb-6">
        <CodeBracketIcon className="h-8 w-8 text-cyan-600" />
        <h2 className="text-2xl font-bold text-gray-900">Apply: Run Docker Container</h2>
      </div>

      {/* Instructions */}
      <div className="bg-cyan-50 border border-cyan-200 rounded-lg p-4 mb-6">
        <p className="text-cyan-900 font-medium mb-2">
          <strong>📋 Task:</strong> {unit.scenario_description || 'Run the Docker container using the command you learned'}
        </p>
        {unit.scenario_narrative && (
          <div className="text-cyan-800 text-sm mt-2" dangerouslySetInnerHTML={{ __html: unit.scenario_narrative }} />
        )}
      </div>

      {/* Command Input */}
      <div className="bg-white border border-gray-200 rounded-lg p-6">
        <label className="block text-sm font-medium text-gray-700 mb-2">
          Enter Docker command:
        </label>
        
        {/* Command Input Field */}
        <div className="relative mb-4">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <span className="text-gray-500">$</span>
          </div>
          <input
            type="text"
            value={userInput}
            onChange={(e) => setUserInput(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleRunCommand()}
            placeholder={unit.command_to_learn || 'docker run ...'}
            className="block w-full pl-8 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:placeholder-gray-400 focus:ring-1 focus:ring-cyan-500 focus:border-cyan-500 sm:text-sm"
            disabled={isRunning || validationStatus === 'success'}
          />
        </div>
        
        {/* Action Buttons */}
        <div className="flex flex-wrap gap-2">
          <div className="relative group">
            <button
              onClick={handleRunCommand}
              disabled={isRunning || validationStatus === 'success'}
              className="inline-flex items-center px-5 py-2.5 border border-transparent text-sm font-medium rounded-md text-white bg-cyan-600 hover:bg-cyan-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-cyan-500 disabled:bg-gray-300 disabled:text-gray-500 disabled:cursor-not-allowed transition-all duration-200 shadow-sm"
              title={isRunning ? 'Command is running...' : (validationStatus === 'success' ? 'Command completed successfully' : 'Execute the Docker command')}
            >
              <PlayIcon className="h-4 w-4 mr-2" />
              <span className="font-semibold">Run Command</span>
            </button>
            {(isRunning || validationStatus === 'success') && (
              <div className="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 px-3 py-1 bg-gray-800 text-white text-xs rounded whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none z-10">
                {isRunning ? '⏳ Command is running...' : '✅ Command completed successfully'}
              </div>
            )}
          </div>
          {containerId && (
            <button
              onClick={handleStop}
              className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors"
            >
              <StopIcon className="h-4 w-4 mr-2" />
              <span className="font-semibold">Stop</span>
            </button>
          )}
          <button
            onClick={reset}
            className="inline-flex items-center px-5 py-2.5 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-cyan-500 transition-all duration-200 shadow-sm"
            title="Clear logs and reset the terminal"
          >
            <svg className="h-4 w-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
            </svg>
            <span className="font-semibold">Reset</span>
          </button>
        </div>

        {/* Hints */}
        {showHints && unit.practice_hints && unit.practice_hints.length > 0 && (
          <div className="mt-4 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
            <p className="text-sm font-semibold text-yellow-900 mb-2">💡 Hints:</p>
            <ul className="list-disc list-inside text-sm text-yellow-800 space-y-1">
              {unit.practice_hints.map((hint, idx) => (
                <li key={idx}>{hint}</li>
              ))}
            </ul>
          </div>
        )}

        {/* Success Message */}
        {validationStatus === 'success' && (
          <div className="mt-4 bg-green-50 border border-green-200 rounded-lg p-4">
            <p className="text-sm font-semibold text-green-900">
              ✓ Excellent! Container is running. Check the logs below.
            </p>
          </div>
        )}
      </div>

      {/* Terminal Output */}
      <div className="bg-gray-900 rounded-lg p-4 shadow-lg">
        <div className="flex items-center justify-between mb-2">
          <div className="flex items-center space-x-2">
            <div className="h-3 w-3 rounded-full bg-red-500"></div>
            <div className="h-3 w-3 rounded-full bg-yellow-500"></div>
            <div className="h-3 w-3 rounded-full bg-green-500"></div>
            <span className="text-gray-400 text-sm ml-2">Terminal</span>
          </div>
          {containerId && (
            <span className="text-cyan-400 text-xs font-mono">Container: {containerId}</span>
          )}
        </div>
        <div className="h-96 overflow-y-auto bg-black rounded p-4 font-mono text-sm">
          {logs.length === 0 ? (
            <div className="text-gray-500">Waiting for command...</div>
          ) : (
            logs.map((log, index) => (
              <div
                key={index}
                className={`mb-1 ${
                  log.type === 'success' ? 'text-green-400' :
                  log.type === 'error' ? 'text-red-400' :
                  'text-gray-300'
                }`}
              >
                {log.message}
              </div>
            ))
          )}
          <div ref={logsEndRef} />
        </div>
      </div>

      {/* Next Steps Info */}
      {containerId && (
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
          <p className="text-sm text-blue-900">
            <strong>🎉 Success!</strong> Your container is running. You can:
          </p>
          <ul className="list-disc list-inside text-sm text-blue-800 mt-2 space-y-1">
            <li>Visit <code className="bg-blue-100 px-1 rounded">http://localhost:8080</code> to see nginx</li>
            <li>Check container status with <code className="bg-blue-100 px-1 rounded">docker ps</code></li>
            <li>View logs with <code className="bg-blue-100 px-1 rounded">docker logs {containerId}</code></li>
            <li>Stop the container using the Stop button above</li>
          </ul>
        </div>
      )}
    </div>
  );
};

export default DockerTerminalLab;

