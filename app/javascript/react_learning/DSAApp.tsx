import React, { useState, useEffect, useMemo } from 'react';
import { Panel, PanelGroup, PanelResizeHandle } from 'react-resizable-panels';
import type {
  DSAModule,
  DSALesson,
  LearningSession,
  DailyChallenge,
  UserStreak,
} from './types';
import { learningApi } from './services/api';

// Components
import DSASidebar from './components/DSASidebar';
import LessonViewer from './components/LessonViewer';
import QuizViewer from './components/QuizViewer';

interface DSAAppProps {
  courseSlug?: string;
}

// Sample daily challenge (in production, this would come from API)
const sampleDailyChallenge: DailyChallenge = {
  id: 'daily-two-sum',
  title: 'Two Sum Variants',
  difficulty: 'medium',
  pattern: 'hash-map',
  estimatedMinutes: 20,
  isCompleted: false,
};

// Sample user streak (in production, this would come from API)
const sampleUserStreak: UserStreak = {
  currentStreak: 7,
  longestStreak: 14,
  lastActiveDate: new Date().toISOString(),
  weeklyGoal: 7,
  weeklyProgress: 5,
};

export default function DSAApp({ courseSlug = 'data-structures-algorithms' }: DSAAppProps) {
  // State
  const [modules, setModules] = useState<DSAModule[]>([]);
  const [session, setSession] = useState<LearningSession | null>(null);
  const [masteryScores, setMasteryScores] = useState<Record<string, number>>({});
  const [selectedLessonId, setSelectedLessonId] = useState<string | null>(null);
  const [completedLessons, setCompletedLessons] = useState<Set<string>>(new Set());
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [dailyChallenge, setDailyChallenge] = useState<DailyChallenge>(sampleDailyChallenge);
  const [userStreak, setUserStreak] = useState<UserStreak>(sampleUserStreak);

  // Load initial data
  useEffect(() => {
    loadCourseData();
  }, [courseSlug]);

  const loadCourseData = async () => {
    try {
      setIsLoading(true);
      // Try to load from the DSA course API endpoint
      const response = await learningApi.getSession('dsa');

      if (response.success && response.data) {
        // Transform modules to DSA format with additional metadata
        const dsaModules: DSAModule[] = (response.data.modules || []).map((module: any) => ({
          ...module,
          lessons: (module.lessons || []).map((lesson: any) => ({
            ...lesson,
            difficulty: lesson.difficulty || inferDifficulty(lesson.title),
            pattern: lesson.pattern || inferPattern(module.title),
            estimatedMinutes: lesson.estimatedMinutes || 15,
          })),
        }));

        setModules(dsaModules);
        setSession(response.data.session || null);

        // Convert mastery scores to simple number map
        const scores: Record<string, number> = {};
        if (response.data.masteryScores) {
          Object.entries(response.data.masteryScores).forEach(([key, value]: [string, any]) => {
            scores[key] = value?.proficiencyScore || 0;
          });
        }
        setMasteryScores(scores);

        // Set initial lesson selection
        const currentLessonId = response.data.session?.stateData?.current_item_id;
        if (currentLessonId) {
          setSelectedLessonId(currentLessonId);
        } else if (dsaModules.length > 0 && dsaModules[0].lessons?.length > 0) {
          setSelectedLessonId(dsaModules[0].lessons[0].id);
        }

        // Initialize completed lessons from session
        if (response.data.session?.stateData?.completedItems) {
          setCompletedLessons(new Set(response.data.session.stateData.completedItems));
        }
      } else {
        // Fallback: Load sample DSA modules
        setModules(getSampleDSAModules());
        if (getSampleDSAModules().length > 0) {
          setSelectedLessonId(getSampleDSAModules()[0].lessons[0]?.id || null);
        }
      }
    } catch (err) {
      console.error('Failed to load DSA course:', err);
      // Fallback to sample data
      setModules(getSampleDSAModules());
      if (getSampleDSAModules().length > 0) {
        setSelectedLessonId(getSampleDSAModules()[0].lessons[0]?.id || null);
      }
    } finally {
      setIsLoading(false);
    }
  };

  // Get current lesson
  const currentLesson = useMemo(() => {
    if (!selectedLessonId) return null;
    for (const module of modules) {
      const lesson = module.lessons?.find((l) => l.id === selectedLessonId);
      if (lesson) return lesson;
    }
    return null;
  }, [selectedLessonId, modules]);

  // Calculate total problems
  const totalProblems = useMemo(() => {
    return modules.reduce((acc, m) => acc + (m.lessons?.length || 0), 0);
  }, [modules]);

  // Handlers
  const handleLessonSelect = (lessonId: string) => {
    setSelectedLessonId(lessonId);
  };

  const handleLessonComplete = async (lessonId: string) => {
    setCompletedLessons((prev) => new Set([...prev, lessonId]));

    // Update streak
    setUserStreak((prev) => ({
      ...prev,
      weeklyProgress: Math.min(prev.weeklyProgress + 1, prev.weeklyGoal),
    }));

    // Persist to backend
    try {
      await learningApi.completeLesson(lessonId);
    } catch (err) {
      console.error('Failed to persist lesson completion:', err);
    }
  };

  const handleQuizComplete = async (score: number) => {
    if (selectedLessonId) {
      if (score >= 70) {
        handleLessonComplete(selectedLessonId);
      }
      // Update mastery score
      setMasteryScores((prev) => ({
        ...prev,
        [selectedLessonId]: score,
      }));
    }
  };

  // Loading state
  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-screen bg-slate-50">
        <div className="text-center">
          <div className="w-16 h-16 border-4 border-indigo-200 border-t-indigo-600 rounded-full animate-spin mx-auto mb-4" />
          <p className="text-slate-600 font-medium">Loading DSA Course...</p>
          <p className="text-slate-400 text-sm mt-1">Preparing your learning journey</p>
        </div>
      </div>
    );
  }

  // Error state
  if (error) {
    return (
      <div className="flex items-center justify-center h-screen bg-slate-50">
        <div className="text-center p-8 bg-white rounded-xl shadow-lg border border-red-100 max-w-md">
          <div className="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg className="w-8 h-8 text-red-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
            </svg>
          </div>
          <h2 className="text-xl font-bold text-slate-800 mb-2">Failed to Load Course</h2>
          <p className="text-slate-600 mb-4">{error}</p>
          <button
            onClick={loadCourseData}
            className="px-6 py-2 bg-indigo-600 text-white font-medium rounded-lg hover:bg-indigo-700 transition-colors"
          >
            Try Again
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="h-screen flex bg-slate-100">
      {/* Enhanced DSA Sidebar */}
      <div className="w-80 flex-shrink-0">
        <DSASidebar
          modules={modules}
          currentLessonId={selectedLessonId}
          completedLessons={completedLessons}
          masteryScores={masteryScores}
          onLessonSelect={handleLessonSelect}
          dailyChallenge={dailyChallenge}
          userStreak={userStreak}
          totalProblems={totalProblems}
          completedProblems={completedLessons.size}
        />
      </div>

      {/* Main Content */}
      <div className="flex-1">
        <PanelGroup direction="horizontal">
          {/* Content Panel */}
          <Panel defaultSize={100} minSize={50}>
            <div className="h-full bg-white">
              {!currentLesson ? (
                <div className="h-full flex items-center justify-center">
                  <div className="text-center">
                    <div className="w-20 h-20 bg-indigo-100 rounded-full flex items-center justify-center mx-auto mb-4">
                      <svg className="w-10 h-10 text-indigo-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                      </svg>
                    </div>
                    <h3 className="text-xl font-semibold text-slate-800 mb-2">Select a Lesson</h3>
                    <p className="text-slate-500">Choose a topic from the sidebar to begin learning</p>
                  </div>
                </div>
              ) : currentLesson.contentType === 'quiz' ? (
                <QuizViewer
                  quiz={currentLesson as any}
                  onQuizComplete={handleQuizComplete}
                />
              ) : (
                <LessonViewer
                  lesson={currentLesson}
                  completedCommands={new Set()}
                  currentCommandIndex={-1}
                  onCommandComplete={() => {}}
                />
              )}
            </div>
          </Panel>
        </PanelGroup>
      </div>
    </div>
  );
}

// Helper functions
function inferDifficulty(title: string): 'easy' | 'medium' | 'hard' {
  const lowerTitle = title.toLowerCase();
  if (lowerTitle.includes('basic') || lowerTitle.includes('intro') || lowerTitle.includes('fundamentals')) {
    return 'easy';
  }
  if (lowerTitle.includes('advanced') || lowerTitle.includes('optimization') || lowerTitle.includes('complex')) {
    return 'hard';
  }
  return 'medium';
}

function inferPattern(moduleTitle: string): string {
  const lowerTitle = moduleTitle.toLowerCase();
  if (lowerTitle.includes('array') || lowerTitle.includes('string')) return 'two-pointers';
  if (lowerTitle.includes('tree')) return 'tree-traversal';
  if (lowerTitle.includes('graph')) return 'bfs-dfs';
  if (lowerTitle.includes('dynamic') || lowerTitle.includes('dp')) return 'dynamic-programming';
  if (lowerTitle.includes('sort') || lowerTitle.includes('search')) return 'binary-search';
  if (lowerTitle.includes('hash')) return 'hash-map';
  if (lowerTitle.includes('stack') || lowerTitle.includes('queue')) return 'stack-queue';
  if (lowerTitle.includes('linked')) return 'linked-list';
  if (lowerTitle.includes('heap')) return 'heap';
  if (lowerTitle.includes('backtrack')) return 'backtracking';
  if (lowerTitle.includes('greedy')) return 'greedy';
  return 'recursion';
}

// Sample DSA modules for fallback/demo
function getSampleDSAModules(): DSAModule[] {
  return [
    {
      id: 'fundamentals',
      title: 'Fundamentals',
      icon: 'BookOpen',
      pattern: 'recursion',
      lessons: [
        {
          id: 'big-o',
          title: 'Big O Notation',
          slug: 'big-o',
          contentType: 'lesson',
          difficulty: 'easy',
          estimatedMinutes: 10,
          content: '# Big O Notation\n\nUnderstanding time and space complexity...',
        },
        {
          id: 'arrays-basics',
          title: 'Array Basics',
          slug: 'array-basics',
          contentType: 'lesson',
          difficulty: 'easy',
          estimatedMinutes: 15,
          content: '# Array Basics\n\nArrays are fundamental data structures...',
        },
      ],
      labs: [],
    },
    {
      id: 'two-pointers',
      title: 'Two Pointers',
      icon: 'ArrowLeftRight',
      pattern: 'two-pointers',
      lessons: [
        {
          id: 'two-sum',
          title: 'Two Sum',
          slug: 'two-sum',
          contentType: 'lesson',
          difficulty: 'easy',
          estimatedMinutes: 15,
          content: '# Two Sum\n\nA classic interview problem...',
        },
        {
          id: 'container-water',
          title: 'Container With Most Water',
          slug: 'container-water',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 20,
          content: '# Container With Most Water\n\nUsing two pointers to find max area...',
        },
        {
          id: 'three-sum',
          title: '3Sum',
          slug: 'three-sum',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 25,
          content: '# 3Sum\n\nFinding triplets that sum to zero...',
        },
      ],
      labs: [],
    },
    {
      id: 'sliding-window',
      title: 'Sliding Window',
      icon: 'PanelLeftClose',
      pattern: 'sliding-window',
      lessons: [
        {
          id: 'max-subarray',
          title: 'Maximum Subarray',
          slug: 'max-subarray',
          contentType: 'lesson',
          difficulty: 'easy',
          estimatedMinutes: 15,
          content: '# Maximum Subarray\n\nFinding the contiguous subarray with maximum sum...',
        },
        {
          id: 'longest-substring',
          title: 'Longest Substring Without Repeating Characters',
          slug: 'longest-substring',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 20,
          content: '# Longest Substring Without Repeating Characters\n\nUsing sliding window technique...',
        },
      ],
      labs: [],
    },
    {
      id: 'trees',
      title: 'Trees',
      icon: 'GitBranch',
      pattern: 'tree-traversal',
      lessons: [
        {
          id: 'tree-traversal',
          title: 'Binary Tree Traversal',
          slug: 'tree-traversal',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 20,
          content: '# Binary Tree Traversal\n\nInorder, Preorder, and Postorder traversals...',
        },
        {
          id: 'bst-operations',
          title: 'BST Operations',
          slug: 'bst-operations',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 25,
          content: '# BST Operations\n\nSearch, Insert, and Delete in Binary Search Trees...',
        },
      ],
      labs: [],
    },
    {
      id: 'dynamic-programming',
      title: 'Dynamic Programming',
      icon: 'Grid3X3',
      pattern: 'dynamic-programming',
      lessons: [
        {
          id: 'dp-intro',
          title: 'Introduction to DP',
          slug: 'dp-intro',
          contentType: 'lesson',
          difficulty: 'medium',
          estimatedMinutes: 20,
          content: '# Introduction to Dynamic Programming\n\nMemoization and tabulation...',
        },
        {
          id: 'climbing-stairs',
          title: 'Climbing Stairs',
          slug: 'climbing-stairs',
          contentType: 'lesson',
          difficulty: 'easy',
          estimatedMinutes: 15,
          content: '# Climbing Stairs\n\nA classic 1D DP problem...',
        },
        {
          id: 'knapsack',
          title: '0/1 Knapsack',
          slug: 'knapsack',
          contentType: 'lesson',
          difficulty: 'hard',
          estimatedMinutes: 30,
          content: '# 0/1 Knapsack\n\nThe classic knapsack problem...',
        },
      ],
      labs: [],
    },
  ];
}
