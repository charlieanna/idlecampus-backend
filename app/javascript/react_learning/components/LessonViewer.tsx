import React, { useState, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import * as LucideIcons from 'lucide-react';
import { Lesson, Command } from '../types';
import ReactMarkdown from 'react-markdown';

interface LessonViewerProps {
  lesson: Lesson;
  completedCommands: Set<string>;
  currentCommandIndex: number;
  onCommandComplete: (command: string) => void;
}

export default function LessonViewer({
  lesson,
  completedCommands,
  currentCommandIndex,
  onCommandComplete,
}: LessonViewerProps) {
  const [showHint, setShowHint] = useState(false);

  // Progressive unlocking logic
  const isFullyUnlocked = currentCommandIndex === -1 || !lesson.commands || lesson.commands.length === 0;

  // For lessons with commands, split content by command sections
  const getVisibleContent = () => {
    if (isFullyUnlocked || !lesson.content) {
      return lesson.content || '';
    }

    // Show content progressively based on completed commands
    // For simplicity, show all content but with locked indicators for future commands
    return lesson.content;
  };

  const getCurrentCommand = (): Command | null => {
    if (!lesson.commands || currentCommandIndex === -1 || currentCommandIndex >= lesson.commands.length) {
      return null;
    }
    return lesson.commands[currentCommandIndex];
  };

  const currentCommand = getCurrentCommand();

  return (
    <div className="h-full overflow-y-auto bg-white">
      {/* Lesson Header */}
      <div className="sticky top-0 bg-white border-b border-gray-200 p-6 z-10">
        <div className="flex items-start gap-4">
          <div className="flex-1">
            <h1 className="text-3xl font-bold text-gray-900">{lesson.title}</h1>
            {lesson.description && (
              <p className="text-gray-600 mt-2">{lesson.description}</p>
            )}
          </div>

          {/* Progress indicator */}
          {lesson.commands && lesson.commands.length > 0 && (
            <div className="flex items-center gap-2 bg-gray-100 px-4 py-2 rounded-lg">
              <LucideIcons.Target className="w-5 h-5 text-blue-600" />
              <span className="text-sm font-medium text-gray-700">
                {completedCommands.size} / {lesson.commands.length} Commands
              </span>
            </div>
          )}
        </div>
      </div>

      {/* Lesson Content */}
      <div className="p-6">
        {/* Current Command Card (if there is one) */}
        <AnimatePresence>
          {currentCommand && (
            <motion.div
              initial={{ opacity: 0, y: -20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -20 }}
              className="mb-6 bg-blue-50 border-2 border-blue-200 rounded-lg p-6"
            >
              <div className="flex items-start gap-3">
                <LucideIcons.Target className="w-6 h-6 text-blue-600 flex-shrink-0 mt-1" />
                <div className="flex-1">
                  <h3 className="text-lg font-semibold text-blue-900 mb-2">
                    Current Challenge
                  </h3>
                  <p className="text-blue-800 mb-3">{currentCommand.description}</p>
                  <div className="bg-white rounded-md p-3 border border-blue-200">
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-xs font-semibold text-gray-500 uppercase">
                        Command to practice:
                      </span>
                      <button
                        onClick={() => setShowHint(!showHint)}
                        className="text-xs text-blue-600 hover:text-blue-800 flex items-center gap-1"
                      >
                        <LucideIcons.HelpCircle className="w-3 h-3" />
                        {showHint ? 'Hide' : 'Show'} Hint
                      </button>
                    </div>
                    <code className="text-sm text-gray-900 font-mono break-all">
                      {currentCommand.command}
                    </code>

                    {/* Hint Section */}
                    <AnimatePresence>
                      {showHint && currentCommand.example && (
                        <motion.div
                          initial={{ height: 0, opacity: 0 }}
                          animate={{ height: 'auto', opacity: 1 }}
                          exit={{ height: 0, opacity: 0 }}
                          className="mt-3 pt-3 border-t border-gray-200 overflow-hidden"
                        >
                          <p className="text-xs text-gray-600 mb-1">Example:</p>
                          <code className="text-xs text-gray-700 font-mono">
                            {currentCommand.example}
                          </code>
                        </motion.div>
                      )}
                    </AnimatePresence>
                  </div>
                </div>
              </div>
            </motion.div>
          )}
        </AnimatePresence>

        {/* Main Lesson Content */}
        <div className="prose prose-slate max-w-none">
          <ReactMarkdown
            components={{
              // Customize markdown rendering
              h1: ({ node, ...props }) => (
                <h1 className="text-2xl font-bold text-gray-900 mt-8 mb-4" {...props} />
              ),
              h2: ({ node, ...props }) => (
                <h2 className="text-xl font-bold text-gray-900 mt-6 mb-3" {...props} />
              ),
              h3: ({ node, ...props }) => (
                <h3 className="text-lg font-semibold text-gray-900 mt-4 mb-2" {...props} />
              ),
              p: ({ node, ...props }) => (
                <p className="text-gray-700 leading-relaxed mb-4" {...props} />
              ),
              code: ({ node, inline, ...props }: any) =>
                inline ? (
                  <code
                    className="bg-gray-100 text-red-600 px-1.5 py-0.5 rounded text-sm font-mono"
                    {...props}
                  />
                ) : (
                  <code
                    className="block bg-gray-900 text-gray-100 p-4 rounded-lg overflow-x-auto font-mono text-sm"
                    {...props}
                  />
                ),
              pre: ({ node, ...props }) => (
                <pre className="bg-gray-900 rounded-lg overflow-hidden mb-4" {...props} />
              ),
              ul: ({ node, ...props }) => (
                <ul className="list-disc list-inside text-gray-700 mb-4 space-y-2" {...props} />
              ),
              ol: ({ node, ...props }) => (
                <ol className="list-decimal list-inside text-gray-700 mb-4 space-y-2" {...props} />
              ),
              blockquote: ({ node, ...props }) => (
                <blockquote
                  className="border-l-4 border-blue-500 pl-4 py-2 bg-blue-50 text-gray-700 italic my-4"
                  {...props}
                />
              ),
            }}
          >
            {getVisibleContent()}
          </ReactMarkdown>
        </div>

        {/* Locked Content Indicator */}
        {!isFullyUnlocked && lesson.commands && currentCommandIndex < lesson.commands.length - 1 && (
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            className="mt-8 p-6 bg-gray-50 border-2 border-dashed border-gray-300 rounded-lg text-center"
          >
            <LucideIcons.Lock className="w-12 h-12 text-gray-400 mx-auto mb-3" />
            <h3 className="text-lg font-semibold text-gray-700 mb-2">
              More content to unlock!
            </h3>
            <p className="text-gray-600">
              Complete the current command to unlock the next section.
            </p>
            <div className="mt-4 flex items-center justify-center gap-2">
              <div className="flex gap-1">
                {lesson.commands.map((_, idx) => (
                  <div
                    key={idx}
                    className={`w-2 h-2 rounded-full ${
                      idx <= currentCommandIndex
                        ? 'bg-blue-500'
                        : 'bg-gray-300'
                    }`}
                  />
                ))}
              </div>
              <span className="text-sm text-gray-600">
                {currentCommandIndex + 1} / {lesson.commands.length}
              </span>
            </div>
          </motion.div>
        )}

        {/* Completion Badge */}
        {isFullyUnlocked && lesson.commands && lesson.commands.length > 0 && (
          <motion.div
            initial={{ scale: 0.8, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            className="mt-8 p-6 bg-green-50 border-2 border-green-200 rounded-lg text-center"
          >
            <LucideIcons.CheckCircle2 className="w-12 h-12 text-green-600 mx-auto mb-3" />
            <h3 className="text-lg font-semibold text-green-900 mb-2">
              Lesson Complete!
            </h3>
            <p className="text-green-700">
              You've mastered all commands in this lesson. Great job!
            </p>
          </motion.div>
        )}

        {/* Commands Reference (always visible) */}
        {lesson.commands && lesson.commands.length > 0 && (
          <div className="mt-8 border-t border-gray-200 pt-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-4 flex items-center gap-2">
              <LucideIcons.List className="w-5 h-5" />
              Commands in this Lesson
            </h3>
            <div className="space-y-3">
              {lesson.commands.map((cmd, idx) => {
                const isCompleted = completedCommands.has(cmd.command);
                const isCurrent = idx === currentCommandIndex;

                return (
                  <motion.div
                    key={idx}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ delay: idx * 0.1 }}
                    className={`flex items-start gap-3 p-4 rounded-lg border-2 ${
                      isCurrent
                        ? 'border-blue-300 bg-blue-50'
                        : isCompleted
                        ? 'border-green-300 bg-green-50'
                        : 'border-gray-200 bg-gray-50'
                    }`}
                  >
                    {/* Status Icon */}
                    <div className="flex-shrink-0 mt-1">
                      {isCompleted ? (
                        <LucideIcons.CheckCircle2 className="w-5 h-5 text-green-600" />
                      ) : isCurrent ? (
                        <LucideIcons.Circle className="w-5 h-5 text-blue-600" />
                      ) : (
                        <LucideIcons.Circle className="w-5 h-5 text-gray-400" />
                      )}
                    </div>

                    {/* Command Details */}
                    <div className="flex-1 min-w-0">
                      <code className="text-sm font-mono text-gray-900 break-all">
                        {cmd.command}
                      </code>
                      {cmd.description && (
                        <p className="text-sm text-gray-600 mt-1">{cmd.description}</p>
                      )}
                    </div>

                    {/* Index Badge */}
                    <span className="text-xs font-semibold text-gray-500">
                      {idx + 1}/{lesson.commands.length}
                    </span>
                  </motion.div>
                );
              })}
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
