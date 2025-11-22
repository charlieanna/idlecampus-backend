import { db } from '../db';
import { eq, sql, inArray } from 'drizzle-orm';
import {
  userSkillProfile,
  userCourseProgress,
  courseDefinitions,
  UserSkillProfile
} from '../db/courseV2Schema';
import * as coursePrereqService from './coursePrerequisitesService';

// ==========================================
// SKILL AGGREGATION SERVICE
// ==========================================
// Calculates global skill levels from course progress

export interface SkillCalculation {
  skill: string;
  level: number; // 0-100
  sources: { courseId: string; contribution: number }[];
}

export interface GlobalSkillProfile {
  userId: string;
  skills: Record<string, number>;
  weakAreas: string[];
  strongAreas: string[];
  totalCoursesStarted: number;
  totalCoursesCompleted: number;
  overallLevel: number;
  totalPoints: number;
  learningGoals: string[];
}

// ==========================================
// SKILL CALCULATION LOGIC
// ==========================================

/**
 * Calculate skill level from course progress
 * - 0-30%: Basic understanding
 * - 31-60%: Moderate proficiency
 * - 61-85%: Strong skills
 * - 86-100%: Expert level
 */
function calculateSkillLevel(courseProgress: number, courseComplexity: number = 1): number {
  // Course complexity multiplier (1 = basic, 1.5 = intermediate, 2 = advanced)
  const baseLevel = courseProgress * courseComplexity;

  // Cap at 100
  return Math.min(Math.round(baseLevel), 100);
}

/**
 * Determine course complexity from difficulty level
 */
function getCourseComplexity(difficulty: string): number {
  const complexityMap: Record<string, number> = {
    'beginner': 1.0,
    'intermediate': 1.3,
    'advanced': 1.6
  };
  return complexityMap[difficulty] || 1.0;
}

/**
 * Aggregate skills from multiple courses
 * Uses weighted average based on recency and completion
 */
function aggregateSkills(skillContributions: Map<string, SkillCalculation>): Record<string, number> {
  const aggregated: Record<string, number> = {};

  for (const [skill, calculation] of skillContributions.entries()) {
    // Weight by number of courses (more courses = more confident in skill level)
    const courseCount = calculation.sources.length;
    const averageLevel = calculation.level;

    // Confidence multiplier (1-3 courses = 0.9, 4+ courses = 1.0)
    const confidenceMultiplier = courseCount >= 4 ? 1.0 : 0.9 + (courseCount * 0.03);

    aggregated[skill] = Math.round(averageLevel * confidenceMultiplier);
  }

  return aggregated;
}

/**
 * Identify weak and strong areas
 */
function categorizeSkills(skills: Record<string, number>): {
  weakAreas: string[];
  strongAreas: string[];
} {
  const weakAreas: string[] = [];
  const strongAreas: string[] = [];

  for (const [skill, level] of Object.entries(skills)) {
    if (level < 40) {
      weakAreas.push(skill);
    } else if (level >= 75) {
      strongAreas.push(skill);
    }
  }

  return { weakAreas, strongAreas };
}

// ==========================================
// PUBLIC API
// ==========================================

/**
 * Calculate and update global skill profile for a user
 */
export async function updateUserSkillProfile(userId: string): Promise<GlobalSkillProfile> {
  // Get all courses the user has progress in
  const allProgress = await db
    .select()
    .from(userCourseProgress)
    .where(eq(userCourseProgress.userId, userId));

  if (allProgress.length === 0) {
    // No progress yet, return empty profile
    return createEmptyProfile(userId);
  }

  // Get course details
  const courseIds = allProgress.map(p => p.courseId);
  const courses = courseIds.length > 0
    ? await db
        .select()
        .from(courseDefinitions)
        .where(inArray(courseDefinitions.id, courseIds))
    : [];

  const courseMap = new Map(courses.map(c => [c.id, c]));

  // Calculate skill contributions from each course
  const skillContributions = new Map<string, SkillCalculation>();

  let totalPoints = 0;
  let coursesCompleted = 0;

  for (const progress of allProgress) {
    const course = courseMap.get(progress.courseId);
    if (!course) continue;

    // Calculate course completion percentage
    const modules = course.modules as any[];
    const totalItems = modules.reduce((sum, m) => sum + (m.items?.length || 0), 0);
    const completedItems = (progress.completedItems as string[] || []).length;
    const courseProgress = totalItems > 0 ? (completedItems / totalItems) * 100 : 0;

    // Determine if course is completed (>90%)
    if (courseProgress > 90) {
      coursesCompleted++;
    }

    // Add to total points
    totalPoints += progress.points || 0;

    // Get skills taught by this course
    const courseSkills = coursePrereqService.getCourseSkills(progress.courseId);
    const courseComplexity = getCourseComplexity(course.difficulty);

    // Calculate skill level for each skill
    for (const skill of courseSkills) {
      const skillLevel = calculateSkillLevel(courseProgress, courseComplexity);

      if (!skillContributions.has(skill)) {
        skillContributions.set(skill, {
          skill,
          level: skillLevel,
          sources: [{ courseId: progress.courseId, contribution: skillLevel }]
        });
      } else {
        const existing = skillContributions.get(skill)!;
        existing.sources.push({ courseId: progress.courseId, contribution: skillLevel });

        // Update to highest level seen
        existing.level = Math.max(existing.level, skillLevel);
      }
    }
  }

  // Aggregate all skills
  const aggregatedSkills = aggregateSkills(skillContributions);

  // Categorize skills
  const { weakAreas, strongAreas } = categorizeSkills(aggregatedSkills);

  // Calculate overall level (based on total points across all courses)
  const overallLevel = Math.floor(totalPoints / 100) + 1;

  // Get existing profile to preserve learning goals
  const existingProfile = await getSkillProfile(userId);
  const learningGoals = existingProfile?.learningGoals || [];

  // Create profile
  const profile: GlobalSkillProfile = {
    userId,
    skills: aggregatedSkills,
    weakAreas,
    strongAreas,
    totalCoursesStarted: allProgress.length,
    totalCoursesCompleted: coursesCompleted,
    overallLevel,
    totalPoints,
    learningGoals
  };

  // Save to database
  await saveSkillProfile(profile);

  return profile;
}

/**
 * Get user's global skill profile
 */
export async function getSkillProfile(userId: string): Promise<GlobalSkillProfile | null> {
  const profile = await db
    .select()
    .from(userSkillProfile)
    .where(eq(userSkillProfile.userId, userId))
    .limit(1);

  if (profile.length === 0) {
    return null;
  }

  const p = profile[0];
  return {
    userId: p.userId,
    skills: (p.skills as Record<string, number>) || {},
    weakAreas: (p.weakAreas as string[]) || [],
    strongAreas: (p.strongAreas as string[]) || [],
    totalCoursesStarted: p.totalCoursesStarted || 0,
    totalCoursesCompleted: p.totalCoursesCompleted || 0,
    overallLevel: p.overallLevel || 1,
    totalPoints: p.totalPoints || 0,
    learningGoals: (p.learningGoals as string[]) || []
  };
}

/**
 * Set user's learning goals
 */
export async function setLearningGoals(userId: string, goals: string[]): Promise<void> {
  const existing = await db
    .select()
    .from(userSkillProfile)
    .where(eq(userSkillProfile.userId, userId))
    .limit(1);

  if (existing.length > 0) {
    await db
      .update(userSkillProfile)
      .set({
        learningGoals: goals,
        lastUpdated: new Date()
      })
      .where(eq(userSkillProfile.userId, userId));
  } else {
    // Create new profile with goals
    await db.insert(userSkillProfile).values({
      userId,
      learningGoals: goals,
      skills: {},
      weakAreas: [],
      strongAreas: []
    });
  }
}

/**
 * Get skill level for a specific skill
 */
export async function getSkillLevel(userId: string, skill: string): Promise<number> {
  const profile = await getSkillProfile(userId);
  if (!profile) return 0;

  return profile.skills[skill] || 0;
}

// ==========================================
// PRIVATE HELPERS
// ==========================================

function createEmptyProfile(userId: string): GlobalSkillProfile {
  return {
    userId,
    skills: {},
    weakAreas: [],
    strongAreas: [],
    totalCoursesStarted: 0,
    totalCoursesCompleted: 0,
    overallLevel: 1,
    totalPoints: 0,
    learningGoals: []
  };
}

async function saveSkillProfile(profile: GlobalSkillProfile): Promise<void> {
  const existing = await db
    .select()
    .from(userSkillProfile)
    .where(eq(userSkillProfile.userId, profile.userId))
    .limit(1);

  if (existing.length > 0) {
    await db
      .update(userSkillProfile)
      .set({
        skills: profile.skills,
        weakAreas: profile.weakAreas,
        strongAreas: profile.strongAreas,
        totalCoursesStarted: profile.totalCoursesStarted,
        totalCoursesCompleted: profile.totalCoursesCompleted,
        overallLevel: profile.overallLevel,
        totalPoints: profile.totalPoints,
        lastUpdated: new Date()
      })
      .where(eq(userSkillProfile.userId, profile.userId));
  } else {
    await db.insert(userSkillProfile).values({
      userId: profile.userId,
      skills: profile.skills,
      weakAreas: profile.weakAreas,
      strongAreas: profile.strongAreas,
      learningGoals: profile.learningGoals,
      totalCoursesStarted: profile.totalCoursesStarted,
      totalCoursesCompleted: profile.totalCoursesCompleted,
      overallLevel: profile.overallLevel,
      totalPoints: profile.totalPoints
    });
  }
}

export default {
  updateUserSkillProfile,
  getSkillProfile,
  setLearningGoals,
  getSkillLevel
};
