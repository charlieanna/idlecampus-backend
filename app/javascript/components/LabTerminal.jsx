import React, { useState, useEffect, useRef } from 'react';
import { 
  PlayIcon, 
  StopIcon, 
  TrashIcon, 
  DocumentTextIcon,
  CheckCircleIcon,
  XCircleIcon,
  ClockIcon
} from '@heroicons/react/24/solid';

const LabTerminal = ({ currentLab, onComplete, onProgress }) => {
  const [terminalHistory, setTerminalHistory] = useState([]);
  const [currentCommand, setCurrentCommand] = useState('');
  const [isRunning, setIsRunning] = useState(false);
  const [labProgress, setLabProgress] = useState({
    currentStep: 0,
    completedSteps: [],
    startTime: Date.now(),
    timeSpent: 0
  });
  const [environment, setEnvironment] = useState({
    containers: [],
    images: [],
    networks: [],
    volumes: []
  });

  const terminalRef = useRef(null);

  // Update timer
  useEffect(() => {
    const timer = setInterval(() => {
      setLabProgress(prev => ({
        ...prev,
        timeSpent: Math.floor((Date.now() - prev.startTime) / 1000)
      }));
    }, 1000);

    return () => clearInterval(timer);
  }, []);

  // Auto-scroll terminal
  useEffect(() => {
    if (terminalRef.current) {
      terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
    }
  }, [terminalHistory]);

  // Initialize lab environment
  useEffect(() => {
    if (currentLab) {
      addToHistory('system', `Starting lab: ${currentLab.title}`);
      addToHistory('system', `Difficulty: ${currentLab.difficulty}/5`);
      addToHistory('system', `Estimated time: ${currentLab.estimated_time} minutes`);
      addToHistory('system', '');
      addToHistory('system', currentLab.description);
      addToHistory('system', '');
      addToHistory('system', 'Type "help" for available commands or "instructions" to see lab steps.');
      addToHistory('system', '');
    }
  }, [currentLab]);

  const addToHistory = (type, content, metadata = {}) => {
    const timestamp = new Date().toLocaleTimeString();
    setTerminalHistory(prev => [...prev, {
      type,
      content,
      timestamp,
      ...metadata
    }]);
  };

  const executeCommand = async (command) => {
    const trimmedCommand = command.trim();
    if (!trimmedCommand) return;

    setIsRunning(true);
    addToHistory('command', `$ ${trimmedCommand}`);

    // Simulate command execution delay
    await new Promise(resolve => setTimeout(resolve, 500 + Math.random() * 1000));

    try {
      const result = await simulateDockerCommand(trimmedCommand);
      
      if (result.success) {
        addToHistory('output', result.output);
        
        // Update environment state
        if (result.environmentUpdate) {
          setEnvironment(prev => ({
            ...prev,
            ...result.environmentUpdate
          }));
        }

        // Check if this command completes a lab step
        if (result.stepCompleted !== undefined) {
          const newCompletedSteps = [...labProgress.completedSteps, result.stepCompleted];
          setLabProgress(prev => ({
            ...prev,
            completedSteps: newCompletedSteps,
            currentStep: Math.max(prev.currentStep, result.stepCompleted + 1)
          }));
          
          addToHistory('success', `✓ Step ${result.stepCompleted + 1} completed!`);
          
          // Check if lab is complete
          if (currentLab && newCompletedSteps.length >= currentLab.steps.length) {
            addToHistory('success', '🎉 Lab completed successfully!');
            setTimeout(() => {
              onComplete({
                labId: currentLab.id,
                timeSpent: labProgress.timeSpent,
                completedSteps: newCompletedSteps.length,
                totalSteps: currentLab.steps.length
              });
            }, 2000);
          }
        }
      } else {
        addToHistory('error', result.output);
      }
    } catch (error) {
      addToHistory('error', `Error: ${error.message}`);
    }

    setIsRunning(false);
    setCurrentCommand('');
  };

  const simulateDockerCommand = async (command) => {
    const parts = command.split(' ');
    const mainCommand = parts[0];
    const subCommand = parts[1];

    // Handle help command
    if (command === 'help') {
      return {
        success: true,
        output: `Available commands:
  docker ps                 - List running containers
  docker images            - List images
  docker run <image>       - Run a container
  docker build <options>   - Build an image
  docker stop <container>  - Stop a container
  docker rm <container>    - Remove a container
  docker rmi <image>       - Remove an image
  instructions            - Show lab instructions
  clear                   - Clear terminal
  env                     - Show current environment`
      };
    }

    // Handle instructions command
    if (command === 'instructions') {
      if (!currentLab) {
        return { success: false, output: 'No lab loaded' };
      }
      
      let output = `Lab Instructions:\n\n`;
      currentLab.steps.forEach((step, index) => {
        const isCompleted = labProgress.completedSteps.includes(index);
        const isCurrent = index === labProgress.currentStep;
        const status = isCompleted ? '✓' : isCurrent ? '→' : ' ';
        output += `${status} Step ${index + 1}: ${step}\n`;
      });
      
      return { success: true, output };
    }

    // Handle clear command
    if (command === 'clear') {
      setTerminalHistory([]);
      return { success: true, output: '' };
    }

    // Handle env command
    if (command === 'env') {
      return {
        success: true,
        output: `Current Environment:
Containers: ${environment.containers.length}
Images: ${environment.images.length}
Networks: ${environment.networks.length}
Volumes: ${environment.volumes.length}`
      };
    }

    // Handle Docker commands
    if (mainCommand !== 'docker') {
      return {
        success: false,
        output: `Command not found: ${mainCommand}. This is a Docker lab environment.`
      };
    }

    switch (subCommand) {
      case 'ps':
        if (environment.containers.length === 0) {
          return {
            success: true,
            output: 'CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES'
          };
        }
        
        let psOutput = 'CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES\n';
        environment.containers.forEach(container => {
          psOutput += `${container.id}   ${container.image}   "${container.command}"   ${container.created}   ${container.status}   ${container.ports}   ${container.name}\n`;
        });
        
        return { success: true, output: psOutput };

      case 'images':
        if (environment.images.length === 0) {
          return {
            success: true,
            output: 'REPOSITORY   TAG       IMAGE ID       CREATED       SIZE'
          };
        }
        
        let imagesOutput = 'REPOSITORY   TAG       IMAGE ID       CREATED       SIZE\n';
        environment.images.forEach(image => {
          imagesOutput += `${image.repository}   ${image.tag}   ${image.id}   ${image.created}   ${image.size}\n`;
        });
        
        return { success: true, output: imagesOutput };

      case 'run':
        const imageName = parts[2];
        if (!imageName) {
          return {
            success: false,
            output: 'Error: "docker run" requires at least 1 argument.'
          };
        }

        // Simulate container creation
        const containerId = Math.random().toString(36).substr(2, 12);
        const containerName = `${imageName.replace(':', '_')}_${Math.random().toString(36).substr(2, 4)}`;
        
        const newContainer = {
          id: containerId,
          image: imageName,
          command: parts.slice(3).join(' ') || 'default',
          created: 'Just now',
          status: 'Up',
          ports: '',
          name: containerName
        };

        // Check if this completes a lab step
        let stepCompleted;
        if (currentLab) {
          currentLab.steps.forEach((step, index) => {
            if (!labProgress.completedSteps.includes(index) && 
                step.toLowerCase().includes('run') && 
                step.toLowerCase().includes(imageName.toLowerCase())) {
              stepCompleted = index;
            }
          });
        }

        return {
          success: true,
          output: `${containerId}`,
          environmentUpdate: {
            containers: [...environment.containers, newContainer]
          },
          stepCompleted
        };

      case 'build':
        const buildContext = parts.includes('-t') ? parts[parts.indexOf('-t') + 1] : 'my-app:latest';
        const imageId = Math.random().toString(36).substr(2, 12);
        
        const newImage = {
          repository: buildContext.split(':')[0],
          tag: buildContext.split(':')[1] || 'latest',
          id: imageId,
          created: 'Just now',
          size: `${Math.floor(Math.random() * 500 + 100)}MB`
        };

        // Check if this completes a lab step
        let buildStepCompleted;
        if (currentLab) {
          currentLab.steps.forEach((step, index) => {
            if (!labProgress.completedSteps.includes(index) && 
                step.toLowerCase().includes('build')) {
              buildStepCompleted = index;
            }
          });
        }

        return {
          success: true,
          output: `Successfully built ${imageId}\nSuccessfully tagged ${buildContext}`,
          environmentUpdate: {
            images: [...environment.images, newImage]
          },
          stepCompleted: buildStepCompleted
        };

      case 'stop':
        const stopTarget = parts[2];
        const containerToStop = environment.containers.find(c => 
          c.id.startsWith(stopTarget) || c.name === stopTarget
        );
        
        if (!containerToStop) {
          return {
            success: false,
            output: `Error: No such container: ${stopTarget}`
          };
        }

        return {
          success: true,
          output: stopTarget,
          environmentUpdate: {
            containers: environment.containers.map(c => 
              c.id === containerToStop.id ? { ...c, status: 'Exited' } : c
            )
          }
        };

      default:
        return {
          success: false,
          output: `docker: '${subCommand}' is not a docker command.\nSee 'docker --help'`
        };
    }
  };

  const handleKeyPress = (e) => {
    if (e.key === 'Enter' && !isRunning) {
      executeCommand(currentCommand);
    }
  };

  const formatTime = (seconds) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs.toString().padStart(2, '0')}`;
  };

  const getStepStatus = (stepIndex) => {
    if (labProgress.completedSteps.includes(stepIndex)) {
      return { icon: CheckCircleIcon, color: 'text-green-500' };
    }
    if (stepIndex === labProgress.currentStep) {
      return { icon: ClockIcon, color: 'text-yellow-500' };
    }
    return { icon: XCircleIcon, color: 'text-gray-300' };
  };

  if (!currentLab) {
    return (
      <div className="flex items-center justify-center h-64 bg-gray-100 rounded-lg">
        <p className="text-gray-500">No lab selected</p>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-lg shadow-lg overflow-hidden">
      {/* Header */}
      <div className="bg-gray-800 text-white p-4">
        <div className="flex items-center justify-between">
          <div>
            <h2 className="text-lg font-semibold">{currentLab.title}</h2>
            <p className="text-gray-300 text-sm">Interactive Docker Lab Environment</p>
          </div>
          <div className="flex items-center space-x-4 text-sm">
            <div className="flex items-center space-x-1">
              <ClockIcon className="h-4 w-4" />
              <span>{formatTime(labProgress.timeSpent)}</span>
            </div>
            <div>
              Progress: {labProgress.completedSteps.length}/{currentLab.steps?.length || 0}
            </div>
          </div>
        </div>
      </div>

      <div className="flex h-96">
        {/* Terminal */}
        <div className="flex-1 bg-black text-green-400 font-mono text-sm">
          <div 
            ref={terminalRef}
            className="h-full overflow-y-auto p-4 space-y-1"
          >
            {terminalHistory.map((entry, index) => (
              <div key={index} className={`${
                entry.type === 'system' ? 'text-blue-400' :
                entry.type === 'command' ? 'text-white' :
                entry.type === 'output' ? 'text-green-400' :
                entry.type === 'error' ? 'text-red-400' :
                entry.type === 'success' ? 'text-yellow-400' :
                'text-gray-400'
              }`}>
                {entry.content}
              </div>
            ))}
            
            {/* Command input */}
            <div className="flex items-center space-x-2">
              <span className="text-blue-400">$</span>
              <input
                type="text"
                value={currentCommand}
                onChange={(e) => setCurrentCommand(e.target.value)}
                onKeyPress={handleKeyPress}
                disabled={isRunning}
                className="flex-1 bg-transparent text-white outline-none"
                placeholder={isRunning ? "Running command..." : "Enter Docker command..."}
                autoFocus
              />
              {isRunning && <span className="text-yellow-400 animate-pulse">●</span>}
            </div>
          </div>
        </div>

        {/* Lab Instructions Panel */}
        <div className="w-80 bg-gray-50 border-l border-gray-200 overflow-y-auto">
          <div className="p-4">
            <h3 className="font-semibold text-gray-900 mb-3 flex items-center space-x-2">
              <DocumentTextIcon className="h-5 w-5" />
              <span>Lab Steps</span>
            </h3>
            
            <div className="space-y-3">
              {currentLab.steps?.map((step, index) => {
                const status = getStepStatus(index);
                const StatusIcon = status.icon;
                
                return (
                  <div 
                    key={index}
                    className={`flex items-start space-x-3 p-3 rounded-lg ${
                      index === labProgress.currentStep ? 'bg-blue-50 border border-blue-200' : 'bg-white'
                    }`}
                  >
                    <StatusIcon className={`h-5 w-5 mt-0.5 ${status.color}`} />
                    <div className="flex-1">
                      <p className={`text-sm ${
                        labProgress.completedSteps.includes(index) ? 'text-gray-500 line-through' : 'text-gray-700'
                      }`}>
                        <span className="font-medium">Step {index + 1}:</span> {step}
                      </p>
                    </div>
                  </div>
                );
              })}
            </div>

            {/* Environment Status */}
            <div className="mt-6 pt-4 border-t border-gray-200">
              <h4 className="text-sm font-medium text-gray-700 mb-2">Environment</h4>
              <div className="space-y-1 text-xs text-gray-600">
                <div>Containers: {environment.containers.length}</div>
                <div>Images: {environment.images.length}</div>
                <div>Networks: {environment.networks.length}</div>
                <div>Volumes: {environment.volumes.length}</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Terminal Controls */}
      <div className="bg-gray-100 px-4 py-2 flex items-center justify-between">
        <div className="flex items-center space-x-2">
          <button
            onClick={() => setTerminalHistory([])}
            className="flex items-center space-x-1 px-2 py-1 text-xs text-gray-600 hover:text-gray-800"
          >
            <TrashIcon className="h-3 w-3" />
            <span>Clear</span>
          </button>
        </div>
        
        <div className="text-xs text-gray-500">
          Use "help" for commands • "instructions" for lab steps
        </div>
      </div>
    </div>
  );
};

export default LabTerminal;