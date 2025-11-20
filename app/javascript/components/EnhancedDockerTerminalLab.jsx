
import React, { useState, useEffect, useRef } from 'react';
import { createConsumer } from '@rails/actioncable';

const EnhancedDockerTerminalLab = ({ 
  userId, 
  labType = 'general',
  onCommandExecuted,
  initialCommands = []
}) => {
  const [terminal, setTerminal] = useState({
    history: [],
    currentInput: '',
    isConnected: false,
    isExecuting: false
  });
  
  const [session, setSession] = useState({
    id: null,
    status: 'disconnected',
    containerName: null
  });
  
  const [logs, setLogs] = useState([]);
  const cable = useRef(null);
  const channel = useRef(null);
  const terminalRef = useRef(null);
  const inputRef = useRef(null);

  useEffect(() => {
    connectToCable();
    return () => {
      disconnectFromCable();
    };
  }, [userId]);

  useEffect(() => {
    // Auto-focus input when component mounts
    if (inputRef.current) {
      inputRef.current.focus();
    }
  }, []);

  useEffect(() => {
    // Scroll terminal to bottom when new content is added
    if (terminalRef.current) {
      terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
    }
  }, [terminal.history, logs]);

  const connectToCable = () => {
    try {
      cable.current = createConsumer('/cable');
      
      channel.current = cable.current.subscriptions.create(
        { channel: 'LabExecutionChannel' },
        {
          connected: () => {
            console.log('Connected to LabExecutionChannel');
            updateTerminal({ isConnected: true });
            addToHistory('system', 'Connected to lab execution system', 'success');
          },
          
          disconnected: () => {
            console.log('Disconnected from LabExecutionChannel');
            updateTerminal({ isConnected: false });
            addToHistory('system', 'Disconnected from lab execution system', 'error');
          },
          
          received: (data) => {
            handleChannelMessage(data);
          }
        }
      );
    } catch (error) {
      console.error('Failed to connect to ActionCable:', error);
      addToHistory('system', 'Failed to connect to lab system', 'error');
    }
  };

  const disconnectFromCable = () => {
    if (channel.current) {
      channel.current.unsubscribe();
    }
    if (cable.current) {
      cable.current.disconnect();
    }
  };

  const handleChannelMessage = (data) => {
    console.log('Received message:', data);

    switch (data.type) {
      case 'session_started':
        setSession({
          id: data.session_info.session_id,
          status: 'running',
          containerName: data.session_info.container_name
        });
        addToHistory('system', `Lab session started: ${data.session_info.session_id}`, 'success');
        break;

      case 'session_stopped':
        setSession({
          id: null,
          status: 'disconnected',
          containerName: null
        });
        addToHistory('system', 'Lab session stopped', 'info');
        break;

      case 'command_acknowledged':
        updateTerminal({ isExecuting: true });
        addToHistory('system', `Executing: ${data.command}`, 'info');
        break;

      case 'execution_started':
        addToHistory('system', 'Command execution started...', 'info');
        break;

      case 'execution_completed':
        updateTerminal({ isExecuting: false });
        displayExecutionResult(data);
        
        // Notify parent component of command execution
        if (onCommandExecuted) {
          onCommandExecuted({
            command: data.command,
            result: data.result,
            timestamp: data.timestamp
          });
        }
        break;

      case 'execution_error':
        updateTerminal({ isExecuting: false });
        addToHistory('error', `Error executing command: ${data.error}`, 'error');
        break;

      case 'log_entry':
        addLogEntry(data.log);
        break;

      case 'log_stream_started':
        addToHistory('system', `Started log streaming for ${data.container_name}`, 'info');
        break;

      case 'log_stream_ended':
        addToHistory('system', `Log streaming ended for ${data.container_name}`, 'info');
        break;

      case 'session_expired':
        setSession({ id: null, status: 'expired', containerName: null });
        addToHistory('system', data.message, 'warning');
        break;

      case 'error':
        addToHistory('error', data.message, 'error');
        break;

      default:
        console.log('Unknown message type:', data.type);
    }
  };

  const updateTerminal = (updates) => {
    setTerminal(prev => ({ ...prev, ...updates }));
  };

  const addToHistory = (type, content, level = 'info') => {
    const entry = {
      id: Date.now() + Math.random(),
      type,
      content,
      level,
      timestamp: new Date().toLocaleTimeString()
    };

    setTerminal(prev => ({
      ...prev,
      history: [...prev.history, entry]
    }));
  };

  const addLogEntry = (logData) => {
    const entry = {
      id: Date.now() + Math.random(),
      ...logData,
      timestamp: new Date().toLocaleTimeString()
    };

    setLogs(prev => [...prev, entry].slice(-1000)); // Keep last 1000 log entries
  };

  const displayExecutionResult = (data) => {
    const { result } = data;
    
    // Add command echo
    addToHistory('input', `$ ${data.command}`, 'input');
    
    // Add stdout if present
    if (result.stdout && result.stdout.trim()) {
      addToHistory('output', result.stdout, 'output');
    }
    
    // Add stderr if present
    if (result.stderr && result.stderr.trim()) {
      addToHistory('error', result.stderr, 'error');
    }
    
    // Add execution summary
    const duration = result.execution_time ? ` (${result.execution_time.toFixed(2)}s)` : '';
    const status = result.exit_status === 0 ? 'success' : 'error';
    const statusText = result.exit_status === 0 ? 'completed' : `failed (exit ${result.exit_status})`;
    
    addToHistory('system', `Command ${statusText}${duration}`, status);
  };

  const startSession = () => {
    if (!channel.current) {
      addToHistory('error', 'Not connected to lab system', 'error');
      return;
    }

    channel.current.perform('start_session', {
      lab_type: labType
    });
  };

  const stopSession = () => {
    if (!channel.current || !session.id) {
      return;
    }

    channel.current.perform('stop_session', {
      session_id: session.id
    });
  };

  const executeCommand = (command) => {
    if (!command.trim()) return;
    
    if (!channel.current) {
      addToHistory('error', 'Not connected to lab system', 'error');
      return;
    }

    if (!terminal.isConnected) {
      addToHistory('error', 'Not connected to execution system', 'error');
      return;
    }

    // Add command to history
    updateTerminal({ 
      currentInput: '',
      history: [...terminal.history, {
        id: Date.now(),
        type: 'input',
        content: `$ ${command}`,
        level: 'input',
        timestamp: new Date().toLocaleTimeString()
      }]
    });

    // Send command for execution
    channel.current.perform('execute_command', {
      command: command.trim(),
      session_id: session.id,
      options: {
        timeout: 300,
        working_directory: '/workspace'
      }
    });
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') {
      executeCommand(terminal.currentInput);
    }
  };

  const handleInputChange = (e) => {
    updateTerminal({ currentInput: e.target.value });
  };

  const clearTerminal = () => {
    setTerminal(prev => ({ ...prev, history: [] }));
  };

  const getStatusColor = () => {
    switch (session.status) {
      case 'running': return 'text-green-500';
      case 'expired': return 'text-yellow-500';
      case 'disconnected': return 'text-red-500';
      default: return 'text-gray-500';
    }
  };

  const getEntryStyle = (level) => {
    switch (level) {
      case 'success': return 'text-green-400';
      case 'error': return 'text-red-400';
      case 'warning': return 'text-yellow-400';
      case 'input': return 'text-blue-400';
      case 'output': return 'text-white';
      default: return 'text-gray-300';
    }
  };

  return (
    <div className=\"enhanced-docker-terminal-lab bg-gray-900 text-white rounded-lg overflow-hidden\">
      {/* Header */}
      <div className=\"bg-gray-800 px-4 py-2 border-b border-gray-700\">
        <div className=\"flex items-center justify-between\">
          <div className=\"flex items-center space-x-4\">
            <h3 className=\"text-lg font-semibold\">Docker Terminal Lab</h3>
            <div className=\"flex items-center space-x-2\">
              <span className=\"text-sm text-gray-400\">Status:</span>
              <span className={`text-sm font-medium ${getStatusColor()}`}>
                {session.status}
              </span>
              {session.containerName && (
                <>
                  <span className=\"text-sm text-gray-400\">Container:</span>
                  <span className=\"text-sm font-mono text-blue-400\">
                    {session.containerName}
                  </span>
                </>
              )}
            </div>
          </div>
          
          <div className=\"flex items-center space-x-2\">
            {session.status !== 'running' ? (
              <button
                onClick={startSession}
                className=\"px-3 py-1 bg-green-600 hover:bg-green-700 rounded text-sm font-medium\"
                disabled={!terminal.isConnected || terminal.isExecuting}
              >
                Start Session
              </button>
            ) : (
              <button
                onClick={stopSession}
                className=\"px-3 py-1 bg-red-600 hover:bg-red-700 rounded text-sm font-medium\"
              >
                Stop Session
              </button>
            )}
            <button
              onClick={clearTerminal}
              className=\"px-3 py-1 bg-gray-600 hover:bg-gray-700 rounded text-sm font-medium\"
            >
              Clear
            </button>
          </div>
        </div>
      </div>

      {/* Terminal Output */}
      <div 
        ref={terminalRef}
        className=\"terminal-output h-96 overflow-y-auto p-4 font-mono text-sm bg-black\"
      >
        {terminal.history.map((entry) => (
          <div key={entry.id} className={`mb-1 ${getEntryStyle(entry.level)}`}>
            <span className=\"text-gray-500 text-xs mr-2\">[{entry.timestamp}]</span>
            <span className=\"whitespace-pre-wrap\">{entry.content}</span>
          </div>
        ))}
        
        {terminal.isExecuting && (
          <div className=\"text-yellow-400 animate-pulse\">
            <span className=\"text-gray-500 text-xs mr-2\">[{new Date().toLocaleTimeString()}]</span>
            Executing command...
          </div>
        )}
      </div>

      {/* Command Input */}
      <div className=\"bg-gray-800 px-4 py-2 border-t border-gray-700\">
        <div className=\"flex items-center space-x-2\">
          <span className=\"text-green-400 font-mono\">$</span>
          <input
            ref={inputRef}
      