import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import * as LucideIcons from 'lucide-react';
import { Module, Lesson, Command } from '../types';

interface SidebarProps {
  modules: Module[];
  currentLessonId: string | null;
  completedCommands: Set<string>;
  masteryScores: Record<string, any>;
  onLessonSelect: (lessonId: string) => void;
}

export default function Sidebar({
  modules,
  currentLessonId,
  completedCommands,
  masteryScores,
  onLessonSelect,
}: SidebarProps) {
  const [expandedModules, setExpandedModules] = useState<Set<string>>(
    new Set(modules.map((m) => m.id))
  );

  const toggleModule = (moduleId: string) => {
    setExpandedModules((prev) => {
      const next = new Set(prev);
      if (next.has(moduleId)) {
        next.delete(moduleId);
      } else {
        next.add(moduleId);
      }
      return next;
    });
  };

  const getIconComponent = (iconName: string) => {
    const Icon = (LucideIcons as any)[iconName] || LucideIcons.Container;
    return Icon;
  };

  const getLessonIcon = (lesson: Lesson) => {
    if (lesson.contentType === 'lab') {
      return LucideIcons.FlaskConical;
    } else if (lesson.contentType === 'quiz') {
      return LucideIcons.ClipboardCheck;
    } else {
      return LucideIcons.BookOpen;
    }
  };

  const calculateLessonProgress = (lesson: Lesson): number => {
    if (!lesson.commands || lesson.commands.length === 0) return 0;

    const completedCount = lesson.commands.filter((cmd) =>
      completedCommands.has(cmd.command)
    ).length;

    return Math.round((completedCount / lesson.commands.length) * 100);
  };

  const getMasteryColor = (command: string): string => {
    const mastery = masteryScores[command];
    if (!mastery) return 'gray';

    const score = mastery.proficiencyScore || 0;
    if (score >= 80) return 'green';
    if (score >= 60) return 'yellow';
    if (score >= 40) return 'orange';
    return 'red';
  };

  return (
    <div className="h-full bg-gray-50 border-r border-gray-200 overflow-y-auto">
      <div className="p-4 bg-white border-b border-gray-200">
        <h2 className="text-xl font-bold text-gray-900">Learning Path</h2>
        <p className="text-sm text-gray-500 mt-1">Track your progress</p>
      </div>

      <div className="p-2">
        {modules.map((module) => {
          const Icon = getIconComponent(module.icon);
          const isExpanded = expandedModules.has(module.id);

          return (
            <div key={module.id} className="mb-2">
              {/* Module Header */}
              <button
                onClick={() => toggleModule(module.id)}
                className="w-full flex items-center gap-2 p-3 rounded-lg hover:bg-gray-100 transition-colors"
              >
                <Icon className="w-5 h-5 text-blue-600" />
                <span className="flex-1 text-left font-semibold text-gray-900">
                  {module.title}
                </span>
                <motion.div
                  animate={{ rotate: isExpanded ? 90 : 0 }}
                  transition={{ duration: 0.2 }}
                >
                  <LucideIcons.ChevronRight className="w-4 h-4 text-gray-500" />
                </motion.div>
              </button>

              {/* Module Content */}
              <AnimatePresence>
                {isExpanded && (
                  <motion.div
                    initial={{ height: 0, opacity: 0 }}
                    animate={{ height: 'auto', opacity: 1 }}
                    exit={{ height: 0, opacity: 0 }}
                    transition={{ duration: 0.2 }}
                    className="overflow-hidden"
                  >
                    <div className="ml-4 mt-1 space-y-1">
                      {module.lessons?.map((lesson) => {
                        const LessonIcon = getLessonIcon(lesson);
                        const progress = calculateLessonProgress(lesson);
                        const isActive = currentLessonId === lesson.id;

                        return (
                          <div key={lesson.id} className="space-y-1">
                            {/* Lesson Item */}
                            <button
                              onClick={() => onLessonSelect(lesson.id)}
                              className={`w-full flex items-center gap-2 p-2 rounded-md transition-colors ${
                                isActive
                                  ? 'bg-blue-100 text-blue-900'
                                  : 'hover:bg-gray-100 text-gray-700'
                              }`}
                            >
                              <LessonIcon
                                className={`w-4 h-4 ${
                                  isActive ? 'text-blue-600' : 'text-gray-500'
                                }`}
                              />
                              <span className="flex-1 text-left text-sm font-medium truncate">
                                {lesson.title}
                              </span>

                              {/* Progress Badge */}
                              {progress > 0 && (
                                <span
                                  className={`text-xs px-2 py-0.5 rounded-full ${
                                    progress === 100
                                      ? 'bg-green-100 text-green-700'
                                      : 'bg-yellow-100 text-yellow-700'
                                  }`}
                                >
                                  {progress}%
                                </span>
                              )}
                            </button>

                            {/* Command-level Progress (shown when lesson is active) */}
                            <AnimatePresence>
                              {isActive && lesson.commands && lesson.commands.length > 0 && (
                                <motion.div
                                  initial={{ height: 0, opacity: 0 }}
                                  animate={{ height: 'auto', opacity: 1 }}
                                  exit={{ height: 0, opacity: 0 }}
                                  className="ml-6 space-y-1 overflow-hidden"
                                >
                                  {lesson.commands.map((cmd, idx) => {
                                    const isCompleted = completedCommands.has(cmd.command);
                                    const masteryColor = getMasteryColor(cmd.command);

                                    return (
                                      <div
                                        key={idx}
                                        className="flex items-start gap-2 p-2 rounded text-xs"
                                      >
                                        {/* Completion Indicator */}
                                        <div
                                          className={`w-2 h-2 rounded-full mt-1 flex-shrink-0 ${
                                            isCompleted
                                              ? masteryColor === 'green'
                                                ? 'bg-green-500'
                                                : masteryColor === 'yellow'
                                                ? 'bg-yellow-500'
                                                : masteryColor === 'orange'
                                                ? 'bg-orange-500'
                                                : 'bg-red-500'
                                              : 'bg-gray-300'
                                          }`}
                                        ></div>

                                        {/* Command Info */}
                                        <div className="flex-1 min-w-0">
                                          <code className="text-gray-700 break-all">
                                            {cmd.command.length > 40
                                              ? cmd.command.substring(0, 40) + '...'
                                              : cmd.command}
                                          </code>
                                          {cmd.description && (
                                            <p className="text-gray-500 mt-0.5">
                                              {cmd.description}
                                            </p>
                                          )}
                                        </div>

                                        {/* Mastery Score */}
                                        {isCompleted && masteryScores[cmd.command] && (
                                          <span className="text-gray-600 font-medium">
                                            {masteryScores[cmd.command].proficiencyScore || 0}%
                                          </span>
                                        )}
                                      </div>
                                    );
                                  })}
                                </motion.div>
                              )}
                            </AnimatePresence>
                          </div>
                        );
                      })}

                      {/* Labs section */}
                      {module.labs && module.labs.length > 0 && (
                        <div className="mt-2 pt-2 border-t border-gray-200">
                          <div className="text-xs font-semibold text-gray-500 px-2 mb-1">
                            Labs
                          </div>
                          {module.labs.map((lab) => {
                            const isActive = currentLessonId === lab.id;

                            return (
                              <button
                                key={lab.id}
                                onClick={() => onLessonSelect(lab.id)}
                                className={`w-full flex items-center gap-2 p-2 rounded-md transition-colors ${
                                  isActive
                                    ? 'bg-purple-100 text-purple-900'
                                    : 'hover:bg-gray-100 text-gray-700'
                                }`}
                              >
                                <LucideIcons.FlaskConical
                                  className={`w-4 h-4 ${
                                    isActive ? 'text-purple-600' : 'text-gray-500'
                                  }`}
                                />
                                <span className="flex-1 text-left text-sm font-medium truncate">
                                  {lab.title}
                                </span>
                              </button>
                            );
                          })}
                        </div>
                      )}
                    </div>
                  </motion.div>
                )}
              </AnimatePresence>
            </div>
          );
        })}
      </div>
    </div>
  );
}
