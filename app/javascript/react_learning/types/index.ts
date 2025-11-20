// ============================================
// CORE TYPES
// ============================================

export interface Command {
  command: string;
  description: string;
  example: string;
}

export interface LessonItem {
  type: 'content' | 'command';
  markdown?: string;
  command?: Command;
}

export interface Lesson {
  id: string;
  title: string;
  slug: string;
  content?: string;
  items?: LessonItem[];
  commands?: Command[];
  contentType: 'lesson' | 'lab' | 'quiz';
}

export interface Task {
  id: string;
  description: string;
  hint: string;
  validation: (command: string) => boolean;
  solution: string;
}

export interface Lab {
  id: string;
  title: string;
  description: string;
  tasks: Task[];
  slug: string;
}

export type QuizQuestion =
  | {
      id: string;
      type: 'mcq';
      question: string;
      options: string[];
      correctAnswer: number;
      explanation: string;
    }
  | {
      id: string;
      type: 'command';
      question: string;
      expectedCommand: string;
      hint: string;
      explanation: string;
    };

export interface Quiz {
  id: string;
  title: string;
  description: string;
  questions: QuizQuestion[];
}

export interface Module {
  id: string | number;
  title: string;
  icon: string;
  description?: string;
  lessons: Lesson[];
  labs: Lab[];
  quizzes?: Quiz[];
  lessonCount?: number;
  labCount?: number;
}

// ============================================
// SESSION & PROGRESS TYPES
// ============================================

export interface LearningSession {
  id: number;
  sessionId: string;
  userId: number;
  stateData: {
    currentState: string;
    currentItemId: string | null;
    currentItemType: string | null;
    currentChapter: string | null;
    currentMicro: string | null;
    completedMicros: Record<string, string[]>;
    responses: Array<{
      itemId: string;
      correct: boolean;
      responseTime: number;
      timestamp: string;
    }>;
    weaknessAreas: string[];
    reviewItems: string[];
    completedItems: string[];
    skippedItems: string[];
  };
  itemsPresented: number;
  itemsCorrect: number;
  itemsFailed: number;
  accuracyRate: number;
  currentStreak: number;
  lastActivityAt: string;
  completedAt: string | null;
}

export interface CommandMastery {
  id: number;
  canonicalCommand: string;
  proficiencyScore: number;
  totalAttempts: number;
  successfulAttempts: number;
  lastUsedAt: string | null;
  consecutiveSuccesses: number;
  consecutiveFailures: number;
}

// ============================================
// API RESPONSE TYPES
// ============================================

export interface ApiResponse<T> {
  data: T;
  success: boolean;
  message?: string;
  errors?: string[];
}

export interface ModulesResponse {
  modules: Module[];
  session: LearningSession;
  masteryScores: Record<string, CommandMastery>;
}

export interface CommandValidationResponse {
  correct: boolean;
  message: string;
  hint?: string;
  nextContent?: Lesson;
  commandCompleted?: boolean;
  lessonCompleted?: boolean;
}

// ============================================
// COMPONENT PROP TYPES
// ============================================

export interface TerminalProps {
  onCommand?: (command: string) => Promise<string | null> | string | null;
  expectedCommand?: string | null;
}

export interface LessonViewerProps {
  lesson: Lesson;
  isCompleted: boolean;
  completedCommands: Set<string>;
  onGoToLab?: () => void;
}

export interface LabExerciseProps {
  lab: Lab;
  onTaskComplete: (taskId: string, command: string) => void;
  completedTasks: Set<string>;
  onCommand: (command: string) => string | null;
}

export interface QuizViewerProps {
  quiz: Quiz;
  onComplete: () => void;
  isCompleted: boolean;
  onRegisterCommandHandler: (handler: (command: string) => { correct: boolean; message: string } | null) => void;
  onGoToLab?: () => void;
}

export interface SidebarProps {
  modules: Module[];
  selectedModule: string;
  selectedLesson: string;
  onSelectLesson: (moduleId: string, lessonId: string) => void;
  completedLessons: Set<string>;
  completedCommands: Set<string>;
}

// ============================================
// STATE TYPES
// ============================================

export interface AppState {
  // Navigation
  selectedModule: string;
  selectedLesson: string;

  // Completion tracking
  completedLessons: Set<string>;
  completedCommands: Set<string>;
  completedTasks: Set<string>;

  // Data
  modules: Module[];
  session: LearningSession | null;
  masteryScores: Record<string, CommandMastery>;

  // Loading states
  isLoading: boolean;
  error: string | null;
}

export interface AppActions {
  // Navigation
  setSelectedModule: (moduleId: string) => void;
  setSelectedLesson: (lessonId: string) => void;
  onSelectLesson: (moduleId: string, lessonId: string) => void;

  // Completion
  markCommandComplete: (lessonId: string, commandIndex: number) => void;
  markLessonComplete: (lessonId: string) => void;
  markTaskComplete: (taskId: string) => void;

  // Data
  loadModules: () => Promise<void>;
  submitCommand: (command: string) => Promise<CommandValidationResponse>;

  // Utility
  resetState: () => void;
}

// ============================================
// UTILITY TYPES
// ============================================

export type ContentType = 'lesson' | 'lab' | 'quiz';

export type LessonStatus = 'completed' | 'current' | 'locked' | 'in-progress' | 'next';

export type IconName = 'box' | 'layers' | 'network' | 'file-key' | 'book-open' | 'flask' | 'clipboard-check';
