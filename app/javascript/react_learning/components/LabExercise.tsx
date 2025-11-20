import React, { useState } from 'react';
import { motion } from 'framer-motion';
import * as LucideIcons from 'lucide-react';
import { Lab } from '../types';
import ReactMarkdown from 'react-markdown';

interface LabExerciseProps {
  lab: Lab;
  onTaskComplete: (taskId: string) => void;
  completedTasks: Set<string>;
}

export default function LabExercise({
  lab,
  onTaskComplete,
  completedTasks,
}: LabExerciseProps) {
  const [currentTaskIndex, setCurrentTaskIndex] = useState(0);
  const [showHint, setShowHint] = useState(false);

  const currentTask = lab.tasks && lab.tasks[currentTaskIndex];
  const progress = lab.tasks ? (completedTasks.size / lab.tasks.length) * 100 : 0;

  const handleTaskComplete = (taskId: string) => {
    onTaskComplete(taskId);

    // Move to next task if available
    if (lab.tasks && currentTaskIndex < lab.tasks.length - 1) {
      setCurrentTaskIndex(currentTaskIndex + 1);
      setShowHint(false);
    }
  };

  return (
    <div className="h-full overflow-y-auto bg-gradient-to-br from-purple-50 to-blue-50">
      {/* Lab Header */}
      <div className="sticky top-0 bg-white border-b border-gray-200 p-6 z-10 shadow-sm">
        <div className="flex items-start gap-4">
          <div className="flex-shrink-0">
            <div className="w-16 h-16 bg-purple-100 rounded-lg flex items-center justify-center">
              <LucideIcons.FlaskConical className="w-8 h-8 text-purple-600" />
            </div>
          </div>

          <div className="flex-1">
            <div className="flex items-center gap-2 mb-2">
              <span className="px-3 py-1 bg-purple-100 text-purple-700 text-xs font-semibold rounded-full uppercase">
                Hands-On Lab
              </span>
              {lab.difficulty && (
                <span
                  className={`px-3 py-1 text-xs font-semibold rounded-full uppercase ${
                    lab.difficulty === 'easy'
                      ? 'bg-green-100 text-green-700'
                      : lab.difficulty === 'medium'
                      ? 'bg-yellow-100 text-yellow-700'
                      : 'bg-red-100 text-red-700'
                  }`}
                >
                  {lab.difficulty}
                </span>
              )}
              {lab.estimatedMinutes && (
                <span className="flex items-center gap-1 text-sm text-gray-600">
                  <LucideIcons.Clock className="w-4 h-4" />
                  {lab.estimatedMinutes} min
                </span>
              )}
            </div>

            <h1 className="text-3xl font-bold text-gray-900">{lab.title}</h1>

            {lab.description && (
              <p className="text-gray-600 mt-2">{lab.description}</p>
            )}
          </div>
        </div>

        {/* Progress Bar */}
        {lab.tasks && lab.tasks.length > 0 && (
          <div className="mt-4">
            <div className="flex items-center justify-between mb-2">
              <span className="text-sm font-medium text-gray-700">
                Progress: {completedTasks.size} / {lab.tasks.length} tasks
              </span>
              <span className="text-sm font-semibold text-purple-600">
                {Math.round(progress)}%
              </span>
            </div>
            <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
              <motion.div
                initial={{ width: 0 }}
                animate={{ width: `${progress}%` }}
                transition={{ duration: 0.5 }}
                className="h-full bg-gradient-to-r from-purple-600 to-blue-600 rounded-full"
              />
            </div>
          </div>
        )}
      </div>

      {/* Lab Content */}
      <div className="p-6">
        {/* Lab Objective */}
        {lab.objective && (
          <div className="mb-6 p-6 bg-white rounded-lg border-2 border-purple-200 shadow-sm">
            <div className="flex items-start gap-3">
              <LucideIcons.Target className="w-6 h-6 text-purple-600 flex-shrink-0 mt-1" />
              <div>
                <h3 className="text-lg font-semibold text-purple-900 mb-2">
                  Lab Objective
                </h3>
                <p className="text-gray-700">{lab.objective}</p>
              </div>
            </div>
          </div>
        )}

        {/* Current Task Card */}
        {currentTask && (
          <motion.div
            key={currentTaskIndex}
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -20 }}
            className="mb-6"
          >
            <div className="bg-white rounded-lg border-2 border-blue-300 shadow-lg overflow-hidden">
              {/* Task Header */}
              <div className="bg-gradient-to-r from-blue-500 to-purple-600 p-4">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 bg-white rounded-full flex items-center justify-center">
                    <span className="text-lg font-bold text-blue-600">
                      {currentTaskIndex + 1}
                    </span>
                  </div>
                  <div className="flex-1">
                    <h3 className="text-xl font-bold text-white">
                      {currentTask.title || `Task ${currentTaskIndex + 1}`}
                    </h3>
                    {currentTask.type && (
                      <span className="text-sm text-blue-100 uppercase">
                        {currentTask.type}
                      </span>
                    )}
                  </div>
                  {completedTasks.has(currentTask.id) && (
                    <LucideIcons.CheckCircle2 className="w-8 h-8 text-green-300" />
                  )}
                </div>
              </div>

              {/* Task Content */}
              <div className="p-6">
                {currentTask.description && (
                  <div className="prose prose-slate max-w-none mb-4">
                    <ReactMarkdown>{currentTask.description}</ReactMarkdown>
                  </div>
                )}

                {/* Command/Validation Section */}
                {currentTask.validation && (
                  <div className="bg-gray-50 rounded-lg p-4 border border-gray-200">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-sm font-semibold text-gray-700">
                        Expected Command:
                      </span>
                      <button
                        onClick={() => setShowHint(!showHint)}
                        className="text-sm text-blue-600 hover:text-blue-800 flex items-center gap-1"
                      >
                        <LucideIcons.HelpCircle className="w-4 h-4" />
                        {showHint ? 'Hide' : 'Show'} Hint
                      </button>
                    </div>
                    <code className="text-sm text-gray-900 font-mono">
                      {currentTask.validation.expectedOutput || 'Type the command in the terminal'}
                    </code>

                    {/* Hint Section */}
                    {showHint && currentTask.hint && (
                      <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: 'auto', opacity: 1 }}
                        className="mt-4 pt-4 border-t border-gray-200"
                      >
                        <div className="flex items-start gap-2">
                          <LucideIcons.Lightbulb className="w-5 h-5 text-yellow-600 flex-shrink-0 mt-1" />
                          <div>
                            <p className="text-sm font-medium text-gray-700 mb-1">Hint:</p>
                            <p className="text-sm text-gray-600">{currentTask.hint}</p>
                          </div>
                        </div>
                      </motion.div>
                    )}
                  </div>
                )}

                {/* Mark Complete Button (for tasks without validation) */}
                {!currentTask.validation && !completedTasks.has(currentTask.id) && (
                  <button
                    onClick={() => handleTaskComplete(currentTask.id)}
                    className="mt-4 w-full px-6 py-3 bg-green-600 text-white font-semibold rounded-lg hover:bg-green-700 transition-colors flex items-center justify-center gap-2"
                  >
                    <LucideIcons.CheckCircle2 className="w-5 h-5" />
                    Mark Task Complete
                  </button>
                )}
              </div>
            </div>
          </motion.div>
        )}

        {/* All Tasks List */}
        {lab.tasks && lab.tasks.length > 0 && (
          <div className="bg-white rounded-lg border border-gray-200 shadow-sm p-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
              <LucideIcons.ListChecks className="w-5 h-5" />
              All Lab Tasks
            </h3>
            <div className="space-y-3">
              {lab.tasks.map((task, idx) => {
                const isCompleted = completedTasks.has(task.id);
                const isCurrent = idx === currentTaskIndex;

                return (
                  <motion.button
                    key={task.id}
                    onClick={() => setCurrentTaskIndex(idx)}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: idx * 0.1 }}
                    className={`w-full flex items-start gap-3 p-4 rounded-lg border-2 text-left transition-all ${
                      isCurrent
                        ? 'border-blue-400 bg-blue-50 shadow-md'
                        : isCompleted
                        ? 'border-green-300 bg-green-50'
                        : 'border-gray-200 bg-gray-50 hover:bg-gray-100'
                    }`}
                  >
                    {/* Status Icon */}
                    <div className="flex-shrink-0 mt-1">
                      {isCompleted ? (
                        <LucideIcons.CheckCircle2 className="w-6 h-6 text-green-600" />
                      ) : isCurrent ? (
                        <div className="w-6 h-6 rounded-full border-4 border-blue-600" />
                      ) : (
                        <div className="w-6 h-6 rounded-full border-2 border-gray-400" />
                      )}
                    </div>

                    {/* Task Info */}
                    <div className="flex-1 min-w-0">
                      <h4 className="font-semibold text-gray-900">
                        {task.title || `Task ${idx + 1}`}
                      </h4>
                      {task.description && (
                        <p className="text-sm text-gray-600 mt-1 line-clamp-2">
                          {task.description}
                        </p>
                      )}
                    </div>

                    {/* Task Number */}
                    <span className="text-sm font-semibold text-gray-500">
                      {idx + 1}/{lab.tasks.length}
                    </span>
                  </motion.button>
                );
              })}
            </div>
          </div>
        )}

        {/* Lab Complete */}
        {lab.tasks && completedTasks.size === lab.tasks.length && (
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="mt-6 p-8 bg-gradient-to-r from-green-50 to-blue-50 border-2 border-green-300 rounded-lg text-center"
          >
            <motion.div
              animate={{ rotate: 360 }}
              transition={{ duration: 1, ease: 'easeInOut' }}
            >
              <LucideIcons.Trophy className="w-16 h-16 text-yellow-500 mx-auto mb-4" />
            </motion.div>
            <h3 className="text-2xl font-bold text-green-900 mb-2">
              Lab Complete! 🎉
            </h3>
            <p className="text-green-700">
              Congratulations! You've successfully completed all tasks in this lab.
            </p>
          </motion.div>
        )}
      </div>
    </div>
  );
}
