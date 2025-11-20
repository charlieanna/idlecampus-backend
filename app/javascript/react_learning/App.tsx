import React, { useState, useEffect } from 'react';
import { Panel, PanelGroup, PanelResizeHandle } from 'react-resizable-panels';
import type { Module, LearningSession, CommandMastery, Lesson, Lab, Quiz } from './types';
import { learningApi } from './services/api';

// Components
import Terminal from './components/Terminal';
import Sidebar from './components/Sidebar';
import LessonViewer from './components/LessonViewer';
import LabExercise from './components/LabExercise';
import QuizViewer from './components/QuizViewer';

interface AppProps {
  track?: 'docker' | 'kubernetes';
}

export default function App({ track = 'docker' }: AppProps) {
  // State
  const [modules, setModules] = useState<Module[]>([]);
  const [session, setSession] = useState<LearningSession | null>(null);
  const [masteryScores, setMasteryScores] = useState<Record<string, CommandMastery>>({});
  const [selectedLessonId, setSelectedLessonId] = useState<string | null>(null);
  const [completedCommands, setCompletedCommands] = useState<Set<string>>(new Set());
  const [completedTasks, setCompletedTasks] = useState<Set<string>>(new Set());
  const [currentCommandIndex, setCurrentCommandIndex] = useState<number>(0);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Load initial data
  useEffect(() => {
    loadSessionData();
  }, [track]);

  const loadSessionData = async () => {
    try {
      setIsLoading(true);
      const response = await learningApi.getSession(track);

      if (response.success && response.data) {
        setModules(response.data.modules || []);
        setSession(response.data.session || null);
        setMasteryScores(response.data.masteryScores || {});

        // Set initial selection to current lesson from session or first lesson
        const currentLessonId = response.data.session?.stateData.current_item_id;
        if (currentLessonId) {
          setSelectedLessonId(currentLessonId);
        } else if (response.data.modules && response.data.modules.length > 0) {
          const firstModule = response.data.modules[0];
          if (firstModule.lessons && firstModule.lessons.length > 0) {
            setSelectedLessonId(firstModule.lessons[0].id);
          }
        }

        // Initialize completed commands from mastery scores
        if (response.data.masteryScores) {
          const completed = new Set(Object.keys(response.data.masteryScores));
          setCompletedCommands(completed);
        }
      } else {
        setError(response.message || 'Failed to load session');
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
    } finally {
      setIsLoading(false);
    }
  };

  // Get current lesson object
  const getCurrentLesson = (): Lesson | Lab | Quiz | null => {
    if (!selectedLessonId) return null;

    for (const module of modules) {
      // Check lessons
      if (module.lessons) {
        const lesson = module.lessons.find((l) => l.id === selectedLessonId);
        if (lesson) return lesson;
      }

      // Check labs
      if (module.labs) {
        const lab = module.labs.find((l) => l.id === selectedLessonId);
        if (lab) return lab;
      }
    }

    return null;
  };

  // Handlers
  const handleLessonSelect = (lessonId: string) => {
    setSelectedLessonId(lessonId);
    setCurrentCommandIndex(0); // Reset command index when switching lessons
  };

  const handleCommandValidated = async (command: string, isCorrect: boolean, feedback: string) => {
    if (!isCorrect) return; // Only handle correct answers

    const currentLesson = getCurrentLesson();
    if (!currentLesson || !currentLesson.commands) return;

    // Mark command as completed
    const newCompletedCommands = new Set(completedCommands);
    newCompletedCommands.add(command);
    setCompletedCommands(newCompletedCommands);

    // Advance to next command
    if (currentCommandIndex < currentLesson.commands.length - 1) {
      setCurrentCommandIndex(currentCommandIndex + 1);
    } else {
      // All commands completed - mark as fully unlocked
      setCurrentCommandIndex(-1);
    }

    // Persist to backend
    try {
      await learningApi.completeCommand(command, {
        lessonId: selectedLessonId,
        track,
      });
    } catch (err) {
      console.error('Failed to persist command completion:', err);
    }

    // Reload mastery scores
    const masteryResponse = await learningApi.getMasteryScores();
    if (masteryResponse.success && masteryResponse.data) {
      setMasteryScores(masteryResponse.data);
    }
  };

  const handleCommandComplete = (command: string) => {
    // This is called from LessonViewer when user completes a command
    const newCompletedCommands = new Set(completedCommands);
    newCompletedCommands.add(command);
    setCompletedCommands(newCompletedCommands);

    // Advance command index
    const currentLesson = getCurrentLesson();
    if (currentLesson && currentLesson.commands) {
      if (currentCommandIndex < currentLesson.commands.length - 1) {
        setCurrentCommandIndex(currentCommandIndex + 1);
      } else {
        setCurrentCommandIndex(-1); // All complete
      }
    }
  };

  const handleTaskComplete = async (taskId: string) => {
    const newCompletedTasks = new Set(completedTasks);
    newCompletedTasks.add(taskId);
    setCompletedTasks(newCompletedTasks);

    // Persist to backend
    try {
      await learningApi.completeTask(taskId);
    } catch (err) {
      console.error('Failed to persist task completion:', err);
    }
  };

  const handleQuizComplete = async (score: number) => {
    // Handle quiz completion - could trigger next lesson, show badge, etc.
    console.log('Quiz completed with score:', score);

    // Persist to backend
    try {
      if (selectedLessonId) {
        await learningApi.completeLesson(selectedLessonId);
      }
    } catch (err) {
      console.error('Failed to persist quiz completion:', err);
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-screen bg-white">
        <div className="text-center">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600 mx-auto mb-4"></div>
          <p className="text-gray-600">Loading {track} learning content...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center h-screen bg-white">
        <div className="text-center p-8 bg-red-50 rounded-lg border border-red-200 max-w-md">
          <h2 className="text-xl font-bold text-red-800 mb-2">Error Loading Content</h2>
          <p className="text-red-600 mb-4">{error}</p>
          <button
            onClick={loadSessionData}
            className="px-6 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition-colors"
          >
            Retry
          </button>
        </div>
      </div>
    );
  }

  const currentLesson = getCurrentLesson();
  const currentCommand = currentLesson?.commands?.[currentCommandIndex];

  return (
    <div className="h-screen flex bg-gray-50">
      {/* Sidebar */}
      <div className="w-80 flex-shrink-0">
        <Sidebar
          modules={modules}
          currentLessonId={selectedLessonId}
          completedCommands={completedCommands}
          masteryScores={masteryScores}
          onLessonSelect={handleLessonSelect}
        />
      </div>

      {/* Main Content with Resizable Panels */}
      <div className="flex-1">
        <PanelGroup direction="horizontal">
          {/* Content Panel */}
          <Panel defaultSize={60} minSize={40}>
            <div className="h-full">
              {!currentLesson ? (
                <div className="h-full flex items-center justify-center">
                  <div className="text-center text-gray-500">
                    <p className="text-lg">Select a lesson from the sidebar to begin</p>
                  </div>
                </div>
              ) : currentLesson.contentType === 'lab' ? (
                <LabExercise
                  lab={currentLesson as Lab}
                  onTaskComplete={handleTaskComplete}
                  completedTasks={completedTasks}
                />
              ) : currentLesson.contentType === 'quiz' ? (
                <QuizViewer
                  quiz={currentLesson as Quiz}
                  onQuizComplete={handleQuizComplete}
                />
              ) : (
                <LessonViewer
                  lesson={currentLesson as Lesson}
                  completedCommands={completedCommands}
                  currentCommandIndex={currentCommandIndex}
                  onCommandComplete={handleCommandComplete}
                />
              )}
            </div>
          </Panel>

          {/* Resize Handle */}
          <PanelResizeHandle className="w-2 bg-gray-300 hover:bg-blue-400 transition-colors cursor-col-resize" />

          {/* Terminal Panel */}
          <Panel defaultSize={40} minSize={30}>
            <div className="h-full">
              <Terminal
                onCommandValidated={handleCommandValidated}
                currentCommand={currentCommand?.command}
                lessonId={selectedLessonId || undefined}
                disabled={!currentCommand}
              />
            </div>
          </Panel>
        </PanelGroup>
      </div>
    </div>
  );
}
