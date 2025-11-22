import { db } from '../db';
import { eq, and, not, inArray, desc } from 'drizzle-orm';
import {
  learningRecommendations,
  courseDefinitions,
  userCourseProgress
} from '../db/courseV2Schema';
import * as skillAggService from './skillAggregationService';
import * as coursePrereqService from './coursePrerequisitesService';
import * as ollamaService from './ollamaService';

// ==========================================
// RECOMMENDATION ENGINE
// ==========================================
// AI-powered course recommendations based on global skill profile

export interface CourseRecommendation {
  courseId: string;
  courseName: string;
  courseDescription: string;
  reason: string; // AI-generated explanation
  priority: number; // 1-10
  confidence: number; // 0-100
  metadata: {
    prerequisitesMet: boolean;
    fillsKnowledgeGap: boolean;
    alignsWithGoals: boolean;
    difficulty: string;
  };
}

export interface RecommendationContext {
  userId: string;
  skillProfile: skillAggService.GlobalSkillProfile;
  completedCourses: string[];
  inProgressCourses: string[];
  learningGoals: string[];
}

// ==========================================
// RECOMMENDATION LOGIC
// ==========================================

/**
 * Generate personalized course recommendations
 */
export async function generateRecommendations(userId: string): Promise<CourseRecommendation[]> {
  // Get user's skill profile
  let skillProfile = await skillAggService.getSkillProfile(userId);

  if (!skillProfile) {
    // Update profile if it doesn't exist
    skillProfile = await skillAggService.updateUserSkillProfile(userId);
  }

  // Get user's course progress
  const progress = await db
    .select()
    .from(userCourseProgress)
    .where(eq(userCourseProgress.userId, userId));

  const completedCourses = progress
    .filter(p => p.completedAt !== null)
    .map(p => p.courseId);

  const inProgressCourses = progress
    .filter(p => p.completedAt === null)
    .map(p => p.courseId);

  // Get all available courses
  const allCourses = await db
    .select()
    .from(courseDefinitions)
    .where(eq(courseDefinitions.isPublished, true));

  // Filter out already completed or in-progress courses
  const availableCourses = allCourses.filter(
    c => !completedCourses.includes(c.id) && !inProgressCourses.includes(c.id)
  );

  // Build context
  const context: RecommendationContext = {
    userId,
    skillProfile,
    completedCourses,
    inProgressCourses,
    learningGoals: skillProfile.learningGoals
  };

  // Evaluate each available course
  const recommendations: CourseRecommendation[] = [];

  for (const course of availableCourses) {
    const recommendation = await evaluateCourse(course, context);
    if (recommendation && recommendation.confidence > 30) {
      recommendations.push(recommendation);
    }
  }

  // Sort by priority (highest first)
  recommendations.sort((a, b) => b.priority - a.priority);

  // Take top 5
  const topRecommendations = recommendations.slice(0, 5);

  // Save to database
  await saveRecommendations(userId, topRecommendations);

  return topRecommendations;
}

/**
 * Evaluate if a course should be recommended
 */
async function evaluateCourse(
  course: any,
  context: RecommendationContext
): Promise<CourseRecommendation | null> {
  const { skillProfile, learningGoals } = context;

  // Check prerequisites
  const prereqCheck = coursePrereqService.meetsPrerequisites(
    course.id,
    skillProfile.skills
  );

  // Calculate priority score
  let priority = 0;
  let confidence = 0;

  const metadata = {
    prerequisitesMet: prereqCheck.meets,
    fillsKnowledgeGap: false,
    alignsWithGoals: false,
    difficulty: course.difficulty
  };

  // Priority: Prerequisites met (+3)
  if (prereqCheck.meets) {
    priority += 3;
    confidence += 30;
  } else if (prereqCheck.missing.length === 0) {
    // No missing courses, just skill gaps
    priority += 1;
    confidence += 15;
  }

  // Priority: Fills knowledge gap (+4)
  const courseSkills = coursePrereqService.getCourseSkills(course.id);
  const hasGapSkills = courseSkills.some(skill => {
    const level = skillProfile.skills[skill] || 0;
    return level < 60; // Weak or non-existent
  });

  if (hasGapSkills) {
    priority += 4;
    confidence += 25;
    metadata.fillsKnowledgeGap = true;
  }

  // Priority: Aligns with learning goals (+5)
  if (learningGoals.length > 0) {
    for (const goal of learningGoals) {
      const learningPath = coursePrereqService.getLearningPath(goal);
      if (learningPath && learningPath.courses.includes(course.id)) {
        priority += 5;
        confidence += 35;
        metadata.alignsWithGoals = true;
        break;
      }
    }
  }

  // Priority: Natural progression (+2)
  // If user recently completed a prerequisite
  const isNaturalNext = coursePrereqService.COURSE_PREREQUISITES_MAP[course.id]?.prerequisites?.some(
    prereq => context.completedCourses.includes(prereq)
  );

  if (isNaturalNext) {
    priority += 2;
    confidence += 10;
  }

  // Don't recommend if confidence too low
  if (confidence < 30) {
    return null;
  }

  // Generate AI explanation
  const reason = await generateRecommendationReason(course, context, metadata);

  return {
    courseId: course.id,
    courseName: course.title,
    courseDescription: course.description,
    reason,
    priority,
    confidence,
    metadata
  };
}

/**
 * Generate AI-powered explanation for recommendation
 */
async function generateRecommendationReason(
  course: any,
  context: RecommendationContext,
  metadata: any
): Promise<string> {
  const { skillProfile, learningGoals } = context;

  // Build context for Ollama
  const prompt = `You are a personalized learning advisor. Generate a SHORT (2-3 sentences) recommendation explanation.

STUDENT PROFILE:
- Overall Level: ${skillProfile.overallLevel}
- Courses Completed: ${skillProfile.totalCoursesCompleted}
- Strong Skills: ${skillProfile.strongAreas.slice(0, 3).join(', ') || 'None yet'}
- Weak Areas: ${skillProfile.weakAreas.slice(0, 3).join(', ') || 'None'}
- Learning Goals: ${learningGoals.join(', ') || 'Not set'}

RECOMMENDED COURSE:
- Title: ${course.title}
- Description: ${course.description}
- Difficulty: ${course.difficulty}

RECOMMENDATION CONTEXT:
- Prerequisites Met: ${metadata.prerequisitesMet ? 'Yes' : 'No'}
- Fills Knowledge Gap: ${metadata.fillsKnowledgeGap ? 'Yes' : 'No'}
- Aligns With Goals: ${metadata.alignsWithGoals ? 'Yes' : 'No'}

Generate a compelling, personalized reason why they should take this course next. Focus on:
1. How it builds on their current skills
2. Why it's the right time to learn it
3. How it helps their goals (if applicable)

Keep it motivating and specific. 2-3 sentences maximum.`;

  try {
    const reason = await ollamaService.generate(prompt, { temperature: 0.8 });
    return reason.trim();
  } catch (error) {
    console.error('Failed to generate AI recommendation reason:', error);
    // Fallback to template-based reason
    return generateFallbackReason(course, metadata);
  }
}

/**
 * Fallback recommendation reason (if Ollama fails)
 */
function generateFallbackReason(course: any, metadata: any): string {
  const reasons: string[] = [];

  if (metadata.prerequisitesMet) {
    reasons.push(`You have the prerequisites for ${course.title}.`);
  }

  if (metadata.fillsKnowledgeGap) {
    reasons.push(`This course will strengthen areas where you need more practice.`);
  }

  if (metadata.alignsWithGoals) {
    reasons.push(`This aligns with your learning goals.`);
  }

  if (reasons.length === 0) {
    reasons.push(`${course.title} is a great next step in your learning journey.`);
  }

  return reasons.join(' ');
}

/**
 * Save recommendations to database
 */
async function saveRecommendations(
  userId: string,
  recommendations: CourseRecommendation[]
): Promise<void> {
  // Clear old recommendations
  await db
    .delete(learningRecommendations)
    .where(
      and(
        eq(learningRecommendations.userId, userId),
        eq(learningRecommendations.isDismissed, false)
      )
    );

  // Insert new recommendations
  for (const rec of recommendations) {
    await db.insert(learningRecommendations).values({
      userId,
      recommendedCourseId: rec.courseId,
      reason: rec.reason,
      priority: rec.priority,
      confidence: rec.confidence,
      metadata: rec.metadata,
      isDismissed: false
    });
  }
}

/**
 * Get saved recommendations for a user
 */
export async function getRecommendations(userId: string): Promise<CourseRecommendation[]> {
  const saved = await db
    .select()
    .from(learningRecommendations)
    .where(
      and(
        eq(learningRecommendations.userId, userId),
        eq(learningRecommendations.isDismissed, false)
      )
    )
    .orderBy(desc(learningRecommendations.priority));

  if (saved.length === 0) {
    // Generate new recommendations
    return generateRecommendations(userId);
  }

  // Get course details
  const courseIds = saved.map(r => r.recommendedCourseId);
  const courses = await db
    .select()
    .from(courseDefinitions)
    .where(inArray(courseDefinitions.id, courseIds));

  const courseMap = new Map(courses.map(c => [c.id, c]));

  return saved.map(r => {
    const course = courseMap.get(r.recommendedCourseId);
    return {
      courseId: r.recommendedCourseId,
      courseName: course?.title || r.recommendedCourseId,
      courseDescription: course?.description || '',
      reason: r.reason,
      priority: r.priority || 0,
      confidence: r.confidence || 0,
      metadata: (r.metadata as any) || {}
    };
  }).reverse(); // Highest priority first
}

/**
 * Dismiss a recommendation
 */
export async function dismissRecommendation(userId: string, courseId: string): Promise<void> {
  await db
    .update(learningRecommendations)
    .set({ isDismissed: true })
    .where(
      and(
        eq(learningRecommendations.userId, userId),
        eq(learningRecommendations.recommendedCourseId, courseId)
      )
    );
}

/**
 * Accept a recommendation (mark as started)
 */
export async function acceptRecommendation(userId: string, courseId: string): Promise<void> {
  await db
    .update(learningRecommendations)
    .set({ isAccepted: true })
    .where(
      and(
        eq(learningRecommendations.userId, userId),
        eq(learningRecommendations.recommendedCourseId, courseId)
      )
    );
}

export default {
  generateRecommendations,
  getRecommendations,
  dismissRecommendation,
  acceptRecommendation
};
