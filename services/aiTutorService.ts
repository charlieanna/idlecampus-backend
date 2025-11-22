import { db } from '../db';
import { eq, and, desc, sql } from 'drizzle-orm';
import {
  tutorMessages,
  userTutorPreferences,
  userCourseProgress,
  exerciseCompletions,
  courseDefinitions,
  TutorMessage
} from '../db/courseV2Schema';
import * as ollamaService from './ollamaService';

// ==========================================
// AI TUTOR SERVICE
// ==========================================
// Detects learning patterns and generates personalized tutor messages

export type TriggerType =
  | 'first_visit'
  | 'return_after_break'
  | 'struggling'
  | 'streak_milestone'
  | 'level_up'
  | 'module_complete'
  | 'course_start'
  | 'inactive_reminder'
  | 'help_request';

export type MessageType = 'welcome' | 'celebration' | 'motivation' | 'hint' | 'nudge';

interface TutorContext {
  userId: string;
  courseId?: string;
  trigger: TriggerType;
  metadata?: any;
}

interface UserBehavior {
  isFirstVisit: boolean;
  daysSinceLastActive: number;
  currentStreak: number;
  recentAttempts: number;
  recentFailures: number;
  leveledUp: boolean;
  completedModule: boolean;
}

// ==========================================
// PUBLIC API
// ==========================================

/**
 * Check if tutor should show a message for this user action
 */
export async function checkForTutorMessage(
  userId: string,
  courseId: string,
  action: string,
  metadata?: any
): Promise<TutorMessage | null> {
  // Check if user has tutor enabled
  const preferences = await getUserTutorPreferences(userId);
  if (!preferences.enabled || (preferences.mutedUntil && new Date(preferences.mutedUntil) > new Date())) {
    return null;
  }

  // Analyze user behavior
  const behavior = await analyzeUserBehavior(userId, courseId);

  // Detect trigger
  const trigger = detectTrigger(action, behavior, metadata);
  if (!trigger) {
    return null;
  }

  // Check frequency settings (don't overwhelm the user)
  const shouldShow = await shouldShowMessage(userId, preferences.frequency);
  if (!shouldShow) {
    return null;
  }

  // Generate and save tutor message
  return generateAndSaveTutorMessage({
    userId,
    courseId,
    trigger,
    metadata: { ...metadata, behavior }
  });
}

/**
 * Generate a hint for a struggling student
 */
export async function generateHintForExercise(
  userId: string,
  courseId: string,
  exerciseId: string,
  exerciseTitle: string,
  exerciseType: string
): Promise<string> {
  // Get attempt count
  const completions = await db
    .select()
    .from(exerciseCompletions)
    .where(
      and(
        eq(exerciseCompletions.userId, userId),
        eq(exerciseCompletions.itemId, exerciseId)
      )
    )
    .limit(1);

  const attempts = completions.length > 0 ? completions[0].attempts || 1 : 1;

  // Get course name
  const course = await db
    .select()
    .from(courseDefinitions)
    .where(eq(courseDefinitions.id, courseId))
    .limit(1);

  const courseName = course.length > 0 ? course[0].title : 'your course';

  // Generate hint using Ollama
  return ollamaService.generateHint({
    exerciseTitle,
    exerciseType,
    attempts,
    courseName,
    studentName: userId
  });
}

/**
 * Get unread tutor messages for user
 */
export async function getUnreadMessages(userId: string): Promise<TutorMessage[]> {
  return db
    .select()
    .from(tutorMessages)
    .where(
      and(
        eq(tutorMessages.userId, userId),
        eq(tutorMessages.isRead, false),
        eq(tutorMessages.isDismissed, false)
      )
    )
    .orderBy(desc(tutorMessages.createdAt))
    .limit(5);
}

/**
 * Mark message as read
 */
export async function markMessageAsRead(messageId: string): Promise<void> {
  await db
    .update(tutorMessages)
    .set({ isRead: true })
    .where(eq(tutorMessages.id, messageId));
}

/**
 * Dismiss a message
 */
export async function dismissMessage(messageId: string): Promise<void> {
  await db
    .update(tutorMessages)
    .set({ isDismissed: true })
    .where(eq(tutorMessages.id, messageId));
}

/**
 * Update user tutor preferences
 */
export async function updateUserTutorPreferences(
  userId: string,
  updates: {
    enabled?: boolean;
    tone?: string;
    frequency?: string;
    mutedUntil?: Date | null;
  }
): Promise<void> {
  const existing = await db
    .select()
    .from(userTutorPreferences)
    .where(eq(userTutorPreferences.userId, userId))
    .limit(1);

  if (existing.length > 0) {
    await db
      .update(userTutorPreferences)
      .set({ ...updates, updatedAt: new Date() })
      .where(eq(userTutorPreferences.userId, userId));
  } else {
    await db.insert(userTutorPreferences).values({
      userId,
      ...updates,
      enabled: updates.enabled !== undefined ? updates.enabled : true,
      tone: updates.tone || 'friendly',
      frequency: updates.frequency || 'normal'
    });
  }
}

// ==========================================
// PRIVATE HELPERS
// ==========================================

async function getUserTutorPreferences(userId: string) {
  const prefs = await db
    .select()
    .from(userTutorPreferences)
    .where(eq(userTutorPreferences.userId, userId))
    .limit(1);

  if (prefs.length > 0) {
    return prefs[0];
  }

  // Return defaults
  return {
    userId,
    enabled: true,
    tone: 'friendly',
    frequency: 'normal',
    mutedUntil: null,
    preferences: null,
    updatedAt: new Date()
  };
}

async function analyzeUserBehavior(
  userId: string,
  courseId: string
): Promise<UserBehavior> {
  // Get user progress
  const progress = await db
    .select()
    .from(userCourseProgress)
    .where(
      and(
        eq(userCourseProgress.userId, userId),
        eq(userCourseProgress.courseId, courseId)
      )
    )
    .limit(1);

  const isFirstVisit = progress.length === 0;

  if (isFirstVisit) {
    return {
      isFirstVisit: true,
      daysSinceLastActive: 0,
      currentStreak: 0,
      recentAttempts: 0,
      recentFailures: 0,
      leveledUp: false,
      completedModule: false
    };
  }

  const userProgress = progress[0];

  // Calculate days since last active
  const lastActive = userProgress.lastActiveAt ? new Date(userProgress.lastActiveAt) : new Date();
  const daysSinceLastActive = Math.floor(
    (new Date().getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24)
  );

  // Get recent exercise attempts
  const recentCompletions = await db
    .select()
    .from(exerciseCompletions)
    .where(
      and(
        eq(exerciseCompletions.userId, userId),
        eq(exerciseCompletions.courseId, courseId)
      )
    )
    .orderBy(desc(exerciseCompletions.completedAt))
    .limit(5);

  const recentAttempts = recentCompletions.reduce((sum, c) => sum + (c.attempts || 0), 0);
  const recentFailures = recentCompletions.filter(c => !c.isCorrect).length;

  return {
    isFirstVisit: false,
    daysSinceLastActive,
    currentStreak: userProgress.streak || 0,
    recentAttempts,
    recentFailures,
    leveledUp: false, // Will be set by metadata
    completedModule: false // Will be set by metadata
  };
}

function detectTrigger(
  action: string,
  behavior: UserBehavior,
  metadata?: any
): TriggerType | null {
  // First visit to course
  if (behavior.isFirstVisit && action === 'start_course') {
    return 'course_start';
  }

  // Returned after a break
  if (behavior.daysSinceLastActive >= 7 && action === 'resume_course') {
    return 'return_after_break';
  }

  // Struggling with exercises
  if (behavior.recentFailures >= 3 && action === 'complete_exercise') {
    return 'struggling';
  }

  // Level up!
  if (metadata?.leveledUp || metadata?.previousLevel < metadata?.currentLevel) {
    return 'level_up';
  }

  // Streak milestone (7, 14, 30 days)
  if ([7, 14, 30].includes(behavior.currentStreak) && action === 'daily_activity') {
    return 'streak_milestone';
  }

  // Module completed
  if (metadata?.moduleCompleted) {
    return 'module_complete';
  }

  // Inactive reminder (triggered externally, e.g., by cron job)
  if (action === 'inactive_check' && behavior.daysSinceLastActive >= 14) {
    return 'inactive_reminder';
  }

  // Help requested
  if (action === 'request_help') {
    return 'help_request';
  }

  return null;
}

async function shouldShowMessage(userId: string, frequency: string): Promise<boolean> {
  // Get last message time
  const recentMessages = await db
    .select()
    .from(tutorMessages)
    .where(eq(tutorMessages.userId, userId))
    .orderBy(desc(tutorMessages.createdAt))
    .limit(1);

  if (recentMessages.length === 0) {
    return true; // No messages yet, always show
  }

  const lastMessageTime = new Date(recentMessages[0].createdAt!);
  const hoursSinceLastMessage =
    (new Date().getTime() - lastMessageTime.getTime()) / (1000 * 60 * 60);

  // Frequency thresholds (in hours)
  const thresholds = {
    minimal: 48, // 2 days
    normal: 12, // 12 hours
    frequent: 1 // 1 hour
  };

  const threshold = thresholds[frequency as keyof typeof thresholds] || thresholds.normal;
  return hoursSinceLastMessage >= threshold;
}

async function generateAndSaveTutorMessage(
  context: TutorContext
): Promise<TutorMessage> {
  const messageType = getMessageType(context.trigger);

  // Get course name
  let courseName = 'your course';
  if (context.courseId) {
    const course = await db
      .select()
      .from(courseDefinitions)
      .where(eq(courseDefinitions.id, context.courseId))
      .limit(1);

    if (course.length > 0) {
      courseName = course[0].title;
    }
  }

  // Get user preferences for tone
  const prefs = await getUserTutorPreferences(context.userId);

  // Generate message using Ollama
  const message = await ollamaService.generateTutorMessage({
    messageType,
    trigger: getTriggerDescription(context.trigger),
    courseName,
    metadata: context.metadata,
    tone: prefs.tone
  });

  // Save to database
  const saved = await db
    .insert(tutorMessages)
    .values({
      userId: context.userId,
      courseId: context.courseId || null,
      messageType,
      trigger: context.trigger,
      message,
      metadata: context.metadata || null,
      isDismissed: false,
      isRead: false
    })
    .returning();

  return saved[0];
}

function getMessageType(trigger: TriggerType): MessageType {
  const mapping: Record<TriggerType, MessageType> = {
    first_visit: 'welcome',
    course_start: 'welcome',
    return_after_break: 'welcome',
    struggling: 'motivation',
    help_request: 'hint',
    level_up: 'celebration',
    streak_milestone: 'celebration',
    module_complete: 'celebration',
    inactive_reminder: 'nudge'
  };

  return mapping[trigger] || 'motivation';
}

function getTriggerDescription(trigger: TriggerType): string {
  const descriptions: Record<TriggerType, string> = {
    first_visit: 'started learning for the first time',
    course_start: 'started a new course',
    return_after_break: 'came back after taking a break',
    struggling: 'attempted several exercises with difficulty',
    help_request: 'requested help',
    level_up: 'leveled up',
    streak_milestone: 'reached a learning streak milestone',
    module_complete: 'completed a module',
    inactive_reminder: 'has been inactive for a while'
  };

  return descriptions[trigger] || 'made progress';
}

export default {
  checkForTutorMessage,
  generateHintForExercise,
  getUnreadMessages,
  markMessageAsRead,
  dismissMessage,
  updateUserTutorPreferences
};
