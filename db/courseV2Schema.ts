import { sql } from 'drizzle-orm';
import { pgTable, varchar, text, jsonb, timestamp, boolean, integer, primaryKey, unique } from 'drizzle-orm/pg-core';

// ==========================================
// COURSE V2 SCHEMA
// ==========================================

// Course definitions table
export const courseDefinitions = pgTable('course_definitions_v2', {
  id: varchar('id', { length: 255 }).primaryKey(),
  title: varchar('title', { length: 255 }).notNull(),
  description: text('description').notNull(),
  difficulty: varchar('difficulty', { length: 50 }).notNull(), // beginner, intermediate, advanced
  estimatedHours: integer('estimated_hours'),
  tags: jsonb('tags').$type<string[]>().default([]),
  color: varchar('color', { length: 50 }).notNull(),
  icon: varchar('icon', { length: 50 }),
  modules: jsonb('modules').notNull(), // Full course structure
  metadata: jsonb('metadata'), // Additional course info
  isPublished: boolean('is_published').default(false),
  createdAt: timestamp('created_at').defaultNow(),
  updatedAt: timestamp('updated_at').defaultNow(),
});

// User course progress table
export const userCourseProgress = pgTable('user_course_progress_v2', {
  userId: varchar('user_id', { length: 255 }).notNull(),
  courseId: varchar('course_id', { length: 255 }).notNull(),
  currentModuleIndex: integer('current_module_index').default(0),
  currentItemIndex: integer('current_item_index').default(0),
  completedItems: jsonb('completed_items').$type<string[]>().default([]),
  expandedModules: jsonb('expanded_modules').$type<string[]>().default([]),
  startedAt: timestamp('started_at').defaultNow(),
  lastActiveAt: timestamp('last_active_at').defaultNow(),
  completedAt: timestamp('completed_at'),
  totalTimeSpent: integer('total_time_spent').default(0), // in seconds
  streak: integer('streak').default(0),
  level: integer('level').default(1),
  points: integer('points').default(0),
}, (table) => ({
  pk: primaryKey({ columns: [table.userId, table.courseId] }),
}));

// Exercise completions table
export const exerciseCompletions = pgTable('exercise_completions_v2', {
  id: varchar('id', { length: 255 }).primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar('user_id', { length: 255 }).notNull(),
  courseId: varchar('course_id', { length: 255 }).notNull(),
  moduleId: varchar('module_id', { length: 255 }).notNull(),
  itemId: varchar('item_id', { length: 255 }).notNull(),
  exerciseType: varchar('exercise_type', { length: 50 }).notNull(),
  userAnswer: jsonb('user_answer'), // Store any type of answer
  isCorrect: boolean('is_correct'),
  score: integer('score'),
  timeSpent: integer('time_spent'), // in seconds
  attempts: integer('attempts').default(1),
  hints: jsonb('hints').$type<string[]>().default([]),
  completedAt: timestamp('completed_at').defaultNow(),
}, (table) => ({
  userItemUnique: unique().on(table.userId, table.itemId),
}));

// User preferences for layout
export const userLayoutPreferences = pgTable('user_layout_preferences_v2', {
  userId: varchar('user_id', { length: 255 }).primaryKey(),
  defaultLayout: varchar('default_layout', { length: 50 }).default('split'), // focused, split, triple, zen
  editorPosition: varchar('editor_position', { length: 50 }).default('right'), // left, right, bottom
  sidebarCollapsed: boolean('sidebar_collapsed').default(false),
  fontSize: integer('font_size').default(14),
  theme: varchar('theme', { length: 50 }).default('light'),
  preferences: jsonb('preferences'), // Additional user preferences
  updatedAt: timestamp('updated_at').defaultNow(),
});

// Course analytics table
export const courseAnalytics = pgTable('course_analytics_v2', {
  id: varchar('id', { length: 255 }).primaryKey().default(sql`gen_random_uuid()`),
  courseId: varchar('course_id', { length: 255 }).notNull(),
  userId: varchar('user_id', { length: 255 }).notNull(),
  eventType: varchar('event_type', { length: 50 }).notNull(), // start, complete, abandon, retry
  moduleId: varchar('module_id', { length: 255 }),
  itemId: varchar('item_id', { length: 255 }),
  metadata: jsonb('metadata'), // Additional event data
  timestamp: timestamp('timestamp').defaultNow(),
});

// AI Tutor messages table
export const tutorMessages = pgTable('tutor_messages_v2', {
  id: varchar('id', { length: 255 }).primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar('user_id', { length: 255 }).notNull(),
  courseId: varchar('course_id', { length: 255 }),
  messageType: varchar('message_type', { length: 50 }).notNull(), // welcome, motivation, celebration, hint, nudge
  trigger: varchar('trigger', { length: 100 }).notNull(), // what caused this message
  message: text('message').notNull(),
  metadata: jsonb('metadata'), // Additional context
  isDismissed: boolean('is_dismissed').default(false),
  isRead: boolean('is_read').default(false),
  createdAt: timestamp('created_at').defaultNow(),
});

// User tutor preferences table
export const userTutorPreferences = pgTable('user_tutor_preferences_v2', {
  userId: varchar('user_id', { length: 255 }).primaryKey(),
  enabled: boolean('enabled').default(true),
  tone: varchar('tone', { length: 50 }).default('friendly'), // friendly, professional, enthusiastic
  frequency: varchar('frequency', { length: 50 }).default('normal'), // minimal, normal, frequent
  mutedUntil: timestamp('muted_until'),
  preferences: jsonb('preferences'), // Additional settings
  updatedAt: timestamp('updated_at').defaultNow(),
});

// ==========================================
// CROSS-COURSE KNOWLEDGE TRACKING
// ==========================================

// Global skill profile table (tracks knowledge across ALL courses)
export const userSkillProfile = pgTable('user_skill_profile_v2', {
  userId: varchar('user_id', { length: 255 }).primaryKey(),
  skills: jsonb('skills').$type<Record<string, number>>().default({}), // { "docker": 85, "kubernetes": 30, ... }
  weakAreas: jsonb('weak_areas').$type<string[]>().default([]),
  strongAreas: jsonb('strong_areas').$type<string[]>().default([]),
  learningGoals: jsonb('learning_goals').$type<string[]>().default([]), // ["DevOps Engineer", "Backend Developer"]
  totalCoursesStarted: integer('total_courses_started').default(0),
  totalCoursesCompleted: integer('total_courses_completed').default(0),
  overallLevel: integer('overall_level').default(1),
  totalPoints: integer('total_points').default(0),
  lastUpdated: timestamp('last_updated').defaultNow(),
});

// Course prerequisites mapping (defines course relationships)
export const coursePrerequisites = pgTable('course_prerequisites_v2', {
  courseId: varchar('course_id', { length: 255 }).notNull(),
  prerequisiteCourseId: varchar('prerequisite_course_id', { length: 255 }).notNull(),
  isRequired: boolean('is_required').default(true), // true = required, false = recommended
  skillsRequired: jsonb('skills_required').$type<Record<string, number>>().default({}), // { "docker": 70 }
}, (table) => ({
  pk: primaryKey({ columns: [table.courseId, table.prerequisiteCourseId] }),
}));

// Learning path recommendations (AI-suggested next courses)
export const learningRecommendations = pgTable('learning_recommendations_v2', {
  id: varchar('id', { length: 255 }).primaryKey().default(sql`gen_random_uuid()`),
  userId: varchar('user_id', { length: 255 }).notNull(),
  recommendedCourseId: varchar('recommended_course_id', { length: 255 }).notNull(),
  reason: text('reason').notNull(), // AI-generated explanation
  priority: integer('priority').default(0), // Higher = more urgent
  confidence: integer('confidence').default(0), // 0-100 how confident the recommendation is
  metadata: jsonb('metadata'), // Additional context
  isAccepted: boolean('is_accepted'),
  isDismissed: boolean('is_dismissed').default(false),
  createdAt: timestamp('created_at').defaultNow(),
});

// Types for TypeScript
export type CourseDefinition = typeof courseDefinitions.$inferSelect;
export type UserCourseProgress = typeof userCourseProgress.$inferSelect;
export type ExerciseCompletion = typeof exerciseCompletions.$inferSelect;
export type UserLayoutPreference = typeof userLayoutPreferences.$inferSelect;
export type CourseAnalytic = typeof courseAnalytics.$inferSelect;
export type TutorMessage = typeof tutorMessages.$inferSelect;
export type UserTutorPreference = typeof userTutorPreferences.$inferSelect;
export type UserSkillProfile = typeof userSkillProfile.$inferSelect;
export type CoursePrerequisite = typeof coursePrerequisites.$inferSelect;
export type LearningRecommendation = typeof learningRecommendations.$inferSelect;

// Helper types
export type CourseModule = {
  id: string;
  title: string;
  description?: string;
  items: CourseItem[];
  prerequisites?: string[];
};

export type CourseItem =
  | { type: 'lesson'; id: string; title: string; content: string; estimatedMinutes?: number; }
  | { type: 'quiz'; id: string; question: string; options: string[]; correct: number; explanation?: string; }
  | { type: 'code'; id: string; title: string; task: string; hint: string; starterCode?: string; solution?: string; testCases?: any[]; }
  | { type: 'terminal'; id: string; title: string; task: string; command: string; expectedOutput: string; hints?: string[]; }
  | { type: 'descriptive'; id: string; title: string; question: string; sampleAnswer: string; minWords?: number; }
  | { type: 'checkpoint'; id: string; message: string; achievements?: string[]; };