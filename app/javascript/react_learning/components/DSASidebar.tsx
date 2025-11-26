import React, { useState, useMemo } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import * as LucideIcons from 'lucide-react';
import type {
  DSAModule,
  DSALesson,
  DSADifficulty,
  DSAPattern,
  LessonProgress,
  DailyChallenge,
  UserStreak,
} from '../types';

interface DSASidebarProps {
  modules: DSAModule[];
  currentLessonId: string | null;
  completedLessons: Set<string>;
  masteryScores: Record<string, number>;
  onLessonSelect: (lessonId: string) => void;
  dailyChallenge?: DailyChallenge;
  userStreak?: UserStreak;
  totalProblems?: number;
  completedProblems?: number;
}

// Pattern icons mapping
const patternIcons: Record<string, React.ComponentType<any>> = {
  'two-pointers': LucideIcons.ArrowLeftRight,
  'sliding-window': LucideIcons.PanelLeftClose,
  'binary-search': LucideIcons.Search,
  'hash-map': LucideIcons.Hash,
  'tree-traversal': LucideIcons.GitBranch,
  'bfs-dfs': LucideIcons.Network,
  'dynamic-programming': LucideIcons.Grid3X3,
  'backtracking': LucideIcons.Undo2,
  'greedy': LucideIcons.Zap,
  'heap': LucideIcons.Triangle,
  'stack-queue': LucideIcons.Layers,
  'linked-list': LucideIcons.Link,
  'graph': LucideIcons.Share2,
  'bit-manipulation': LucideIcons.Binary,
  'math': LucideIcons.Calculator,
  'recursion': LucideIcons.Repeat,
  'default': LucideIcons.BookOpen,
};

// Difficulty colors and labels
const difficultyConfig: Record<DSADifficulty, { color: string; bg: string; label: string }> = {
  easy: { color: 'text-green-600', bg: 'bg-green-100', label: 'Easy' },
  medium: { color: 'text-yellow-600', bg: 'bg-yellow-100', label: 'Medium' },
  hard: { color: 'text-red-600', bg: 'bg-red-100', label: 'Hard' },
};

// Status icons and colors
const statusConfig: Record<LessonProgress, { icon: React.ComponentType<any>; color: string }> = {
  'not-started': { icon: LucideIcons.Circle, color: 'text-gray-400' },
  'in-progress': { icon: LucideIcons.CircleDot, color: 'text-blue-500' },
  'completed': { icon: LucideIcons.CheckCircle2, color: 'text-green-500' },
};

export default function DSASidebar({
  modules,
  currentLessonId,
  completedLessons,
  masteryScores,
  onLessonSelect,
  dailyChallenge,
  userStreak,
  totalProblems = 107,
  completedProblems = 0,
}: DSASidebarProps) {
  // State
  const [searchQuery, setSearchQuery] = useState('');
  const [expandedModules, setExpandedModules] = useState<Set<string>>(
    new Set(modules.slice(0, 2).map((m) => String(m.id)))
  );
  const [filterDifficulty, setFilterDifficulty] = useState<DSADifficulty | 'all'>('all');
  const [filterStatus, setFilterStatus] = useState<LessonProgress | 'all'>('all');
  const [showFilters, setShowFilters] = useState(false);

  // Calculate overall progress
  const overallProgress = useMemo(() => {
    if (totalProblems === 0) return 0;
    const completed = completedProblems || completedLessons.size;
    return Math.round((completed / totalProblems) * 100);
  }, [totalProblems, completedProblems, completedLessons]);

  // Get lesson progress status
  const getLessonProgress = (lesson: DSALesson): LessonProgress => {
    if (completedLessons.has(lesson.id)) return 'completed';
    if (lesson.id === currentLessonId) return 'in-progress';
    if (masteryScores[lesson.id] > 0) return 'in-progress';
    return 'not-started';
  };

  // Filter and search modules/lessons
  const filteredModules = useMemo(() => {
    return modules.map((module) => {
      const filteredLessons = module.lessons.filter((lesson) => {
        // Search filter
        if (searchQuery) {
          const query = searchQuery.toLowerCase();
          const matchesTitle = lesson.title.toLowerCase().includes(query);
          const matchesPattern = lesson.pattern?.toLowerCase().includes(query);
          if (!matchesTitle && !matchesPattern) return false;
        }

        // Difficulty filter
        if (filterDifficulty !== 'all' && lesson.difficulty !== filterDifficulty) {
          return false;
        }

        // Status filter
        if (filterStatus !== 'all') {
          const progress = getLessonProgress(lesson);
          if (progress !== filterStatus) return false;
        }

        return true;
      });

      return { ...module, lessons: filteredLessons };
    }).filter((module) => module.lessons.length > 0);
  }, [modules, searchQuery, filterDifficulty, filterStatus, completedLessons, currentLessonId, masteryScores]);

  // Calculate module progress
  const getModuleProgress = (module: DSAModule): number => {
    if (!module.lessons || module.lessons.length === 0) return 0;
    const completed = module.lessons.filter((l) => completedLessons.has(l.id)).length;
    return Math.round((completed / module.lessons.length) * 100);
  };

  // Toggle module expansion
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

  // Get pattern icon
  const getPatternIcon = (pattern?: string) => {
    if (!pattern) return patternIcons.default;
    return patternIcons[pattern] || patternIcons.default;
  };

  return (
    <div className="h-full flex flex-col bg-slate-50 border-r border-slate-200">
      {/* Header with Progress */}
      <div className="p-4 bg-gradient-to-r from-indigo-600 to-purple-600 text-white">
        <div className="flex items-center gap-2 mb-2">
          <LucideIcons.Brain className="w-6 h-6" />
          <h2 className="text-lg font-bold">DSA Learning Path</h2>
        </div>
        <p className="text-indigo-100 text-sm mb-3">Master algorithms & data structures</p>

        {/* Overall Progress */}
        <div className="bg-white/20 rounded-lg p-3">
          <div className="flex justify-between items-center mb-2">
            <span className="text-sm font-medium">Progress</span>
            <span className="text-sm font-bold">{completedLessons.size}/{totalProblems}</span>
          </div>
          <div className="w-full bg-white/30 rounded-full h-2.5">
            <motion.div
              initial={{ width: 0 }}
              animate={{ width: `${overallProgress}%` }}
              transition={{ duration: 0.5, ease: 'easeOut' }}
              className="h-full bg-white rounded-full"
            />
          </div>
          <div className="text-right text-xs mt-1 text-indigo-100">{overallProgress}% complete</div>
        </div>
      </div>

      {/* Search Bar */}
      <div className="p-3 border-b border-slate-200 bg-white">
        <div className="relative">
          <LucideIcons.Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
          <input
            type="text"
            placeholder="Search topics, patterns..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-9 pr-4 py-2 text-sm bg-slate-100 border border-slate-200 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          />
          {searchQuery && (
            <button
              onClick={() => setSearchQuery('')}
              className="absolute right-3 top-1/2 -translate-y-1/2"
            >
              <LucideIcons.X className="w-4 h-4 text-slate-400 hover:text-slate-600" />
            </button>
          )}
        </div>

        {/* Filter Toggle */}
        <button
          onClick={() => setShowFilters(!showFilters)}
          className="flex items-center gap-2 mt-2 text-sm text-slate-600 hover:text-indigo-600 transition-colors"
        >
          <LucideIcons.SlidersHorizontal className="w-4 h-4" />
          <span>Filters</span>
          <motion.div
            animate={{ rotate: showFilters ? 180 : 0 }}
            transition={{ duration: 0.2 }}
          >
            <LucideIcons.ChevronDown className="w-4 h-4" />
          </motion.div>
        </button>

        {/* Filter Options */}
        <AnimatePresence>
          {showFilters && (
            <motion.div
              initial={{ height: 0, opacity: 0 }}
              animate={{ height: 'auto', opacity: 1 }}
              exit={{ height: 0, opacity: 0 }}
              className="overflow-hidden"
            >
              <div className="grid grid-cols-2 gap-2 mt-3">
                {/* Difficulty Filter */}
                <div>
                  <label className="text-xs font-medium text-slate-500 mb-1 block">Difficulty</label>
                  <select
                    value={filterDifficulty}
                    onChange={(e) => setFilterDifficulty(e.target.value as DSADifficulty | 'all')}
                    className="w-full px-2 py-1.5 text-sm bg-slate-100 border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
                  >
                    <option value="all">All Levels</option>
                    <option value="easy">Easy</option>
                    <option value="medium">Medium</option>
                    <option value="hard">Hard</option>
                  </select>
                </div>

                {/* Status Filter */}
                <div>
                  <label className="text-xs font-medium text-slate-500 mb-1 block">Status</label>
                  <select
                    value={filterStatus}
                    onChange={(e) => setFilterStatus(e.target.value as LessonProgress | 'all')}
                    className="w-full px-2 py-1.5 text-sm bg-slate-100 border border-slate-200 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500"
                  >
                    <option value="all">All Status</option>
                    <option value="not-started">Not Started</option>
                    <option value="in-progress">In Progress</option>
                    <option value="completed">Completed</option>
                  </select>
                </div>
              </div>

              {/* Clear Filters */}
              {(filterDifficulty !== 'all' || filterStatus !== 'all') && (
                <button
                  onClick={() => {
                    setFilterDifficulty('all');
                    setFilterStatus('all');
                  }}
                  className="mt-2 text-xs text-indigo-600 hover:text-indigo-700 flex items-center gap-1"
                >
                  <LucideIcons.X className="w-3 h-3" />
                  Clear filters
                </button>
              )}
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {/* Modules List */}
      <div className="flex-1 overflow-y-auto p-2">
        {filteredModules.length === 0 ? (
          <div className="text-center py-8 text-slate-500">
            <LucideIcons.SearchX className="w-12 h-12 mx-auto mb-3 text-slate-300" />
            <p className="text-sm">No lessons match your filters</p>
            <button
              onClick={() => {
                setSearchQuery('');
                setFilterDifficulty('all');
                setFilterStatus('all');
              }}
              className="mt-2 text-sm text-indigo-600 hover:underline"
            >
              Clear all filters
            </button>
          </div>
        ) : (
          filteredModules.map((module) => {
            const ModuleIcon = getPatternIcon(module.pattern);
            const isExpanded = expandedModules.has(String(module.id));
            const progress = getModuleProgress(module);

            return (
              <div key={module.id} className="mb-2">
                {/* Module Header */}
                <button
                  onClick={() => toggleModule(String(module.id))}
                  className="w-full flex items-center gap-3 p-3 rounded-lg hover:bg-slate-100 transition-colors group"
                >
                  <div className="w-8 h-8 rounded-lg bg-indigo-100 flex items-center justify-center group-hover:bg-indigo-200 transition-colors">
                    <ModuleIcon className="w-4 h-4 text-indigo-600" />
                  </div>
                  <div className="flex-1 text-left">
                    <div className="flex items-center justify-between">
                      <span className="font-semibold text-slate-800 text-sm">{module.title}</span>
                      <span className="text-xs text-slate-500">{progress}%</span>
                    </div>
                    {/* Mini progress bar */}
                    <div className="w-full bg-slate-200 rounded-full h-1 mt-1.5">
                      <motion.div
                        initial={{ width: 0 }}
                        animate={{ width: `${progress}%` }}
                        className={`h-full rounded-full ${
                          progress === 100 ? 'bg-green-500' : 'bg-indigo-500'
                        }`}
                      />
                    </div>
                  </div>
                  <motion.div
                    animate={{ rotate: isExpanded ? 90 : 0 }}
                    transition={{ duration: 0.2 }}
                  >
                    <LucideIcons.ChevronRight className="w-4 h-4 text-slate-400" />
                  </motion.div>
                </button>

                {/* Lessons List */}
                <AnimatePresence>
                  {isExpanded && (
                    <motion.div
                      initial={{ height: 0, opacity: 0 }}
                      animate={{ height: 'auto', opacity: 1 }}
                      exit={{ height: 0, opacity: 0 }}
                      transition={{ duration: 0.2 }}
                      className="overflow-hidden"
                    >
                      <div className="ml-4 pl-4 border-l-2 border-slate-200 space-y-1 py-1">
                        {module.lessons.map((lesson) => {
                          const progress = getLessonProgress(lesson);
                          const StatusIcon = statusConfig[progress].icon;
                          const isActive = currentLessonId === lesson.id;
                          const difficulty = lesson.difficulty || 'medium';
                          const diffConfig = difficultyConfig[difficulty];
                          const mastery = masteryScores[lesson.id] || 0;

                          return (
                            <motion.button
                              key={lesson.id}
                              onClick={() => onLessonSelect(lesson.id)}
                              whileHover={{ x: 2 }}
                              className={`w-full flex items-start gap-2 p-2 rounded-lg text-left transition-all ${
                                isActive
                                  ? 'bg-indigo-100 border-l-2 border-indigo-500 -ml-0.5'
                                  : 'hover:bg-slate-100'
                              }`}
                            >
                              {/* Status Icon */}
                              <StatusIcon className={`w-4 h-4 mt-0.5 flex-shrink-0 ${statusConfig[progress].color}`} />

                              {/* Lesson Info */}
                              <div className="flex-1 min-w-0">
                                <div className="flex items-center gap-2">
                                  <span
                                    className={`text-sm font-medium truncate ${
                                      isActive ? 'text-indigo-900' : 'text-slate-700'
                                    }`}
                                  >
                                    {lesson.title}
                                  </span>
                                </div>

                                {/* Meta info */}
                                <div className="flex items-center gap-2 mt-1">
                                  {/* Difficulty badge */}
                                  <span
                                    className={`text-[10px] font-semibold px-1.5 py-0.5 rounded ${diffConfig.bg} ${diffConfig.color}`}
                                  >
                                    {diffConfig.label}
                                  </span>

                                  {/* Time estimate */}
                                  {lesson.estimatedMinutes && (
                                    <span className="text-[10px] text-slate-500 flex items-center gap-0.5">
                                      <LucideIcons.Clock className="w-3 h-3" />
                                      {lesson.estimatedMinutes}m
                                    </span>
                                  )}

                                  {/* Mastery score */}
                                  {mastery > 0 && progress !== 'completed' && (
                                    <span className="text-[10px] text-blue-600 font-medium">
                                      {mastery}%
                                    </span>
                                  )}
                                </div>
                              </div>

                              {/* Completion checkmark */}
                              {progress === 'completed' && (
                                <LucideIcons.CheckCircle2 className="w-4 h-4 text-green-500 flex-shrink-0" />
                              )}
                            </motion.button>
                          );
                        })}
                      </div>
                    </motion.div>
                  )}
                </AnimatePresence>
              </div>
            );
          })
        )}
      </div>

      {/* Daily Challenge Section */}
      {dailyChallenge && (
        <div className="p-3 border-t border-slate-200 bg-gradient-to-r from-amber-50 to-orange-50">
          <div className="flex items-center gap-2 mb-2">
            <LucideIcons.Trophy className="w-5 h-5 text-amber-500" />
            <span className="font-semibold text-sm text-slate-800">Daily Challenge</span>
          </div>
          <button
            onClick={() => onLessonSelect(dailyChallenge.id)}
            className="w-full p-3 bg-white rounded-lg border border-amber-200 hover:border-amber-300 hover:shadow-sm transition-all text-left"
          >
            <div className="font-medium text-slate-800 text-sm mb-1">{dailyChallenge.title}</div>
            <div className="flex items-center gap-2 text-xs">
              <span
                className={`px-1.5 py-0.5 rounded ${
                  difficultyConfig[dailyChallenge.difficulty].bg
                } ${difficultyConfig[dailyChallenge.difficulty].color} font-semibold`}
              >
                {difficultyConfig[dailyChallenge.difficulty].label}
              </span>
              <span className="text-slate-500 flex items-center gap-1">
                <LucideIcons.Clock className="w-3 h-3" />
                {dailyChallenge.estimatedMinutes} min
              </span>
            </div>
            {dailyChallenge.isCompleted ? (
              <div className="mt-2 flex items-center gap-1 text-green-600 text-xs font-medium">
                <LucideIcons.CheckCircle2 className="w-4 h-4" />
                Completed!
              </div>
            ) : (
              <div className="mt-2 text-indigo-600 text-xs font-medium flex items-center gap-1">
                Start Challenge
                <LucideIcons.ArrowRight className="w-3 h-3" />
              </div>
            )}
          </button>
        </div>
      )}

      {/* Streak Section */}
      {userStreak && (
        <div className="p-3 border-t border-slate-200 bg-white">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-2">
              <div className="w-10 h-10 rounded-full bg-gradient-to-r from-orange-400 to-red-500 flex items-center justify-center">
                <LucideIcons.Flame className="w-5 h-5 text-white" />
              </div>
              <div>
                <div className="text-2xl font-bold text-slate-800">{userStreak.currentStreak}</div>
                <div className="text-xs text-slate-500">day streak</div>
              </div>
            </div>
            <div className="text-right">
              <div className="text-xs text-slate-500">Weekly Goal</div>
              <div className="flex items-center gap-1">
                <div className="flex gap-0.5">
                  {[...Array(7)].map((_, i) => (
                    <div
                      key={i}
                      className={`w-2 h-2 rounded-full ${
                        i < userStreak.weeklyProgress ? 'bg-green-500' : 'bg-slate-200'
                      }`}
                    />
                  ))}
                </div>
                <span className="text-xs font-medium text-slate-600">
                  {userStreak.weeklyProgress}/{userStreak.weeklyGoal}
                </span>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
