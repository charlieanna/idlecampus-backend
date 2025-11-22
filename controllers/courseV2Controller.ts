import { Request, Response } from 'express';
import { eq, and, sql } from 'drizzle-orm';
import { db } from '../db';
import {
  courseDefinitions,
  userCourseProgress,
  exerciseCompletions,
  userLayoutPreferences,
  courseAnalytics,
  CourseModule,
  CourseItem
} from '../db/courseV2Schema';
import * as aiTutorService from '../services/aiTutorService';

// ==========================================
// COURSE V2 CONTROLLERS
// ==========================================

// Get all published courses
export const getCourses = async (req: Request, res: Response) => {
  try {
    const courses = await db
      .select()
      .from(courseDefinitions)
      .where(eq(courseDefinitions.isPublished, true));

    // Add progress if user is authenticated
    const userId = (req.session as any)?.userId;
    if (userId) {
      const progress = await db
        .select()
        .from(userCourseProgress)
        .where(eq(userCourseProgress.userId, userId));

      const coursesWithProgress = courses.map(course => {
        const userProgress = progress.find(p => p.courseId === course.id);
        return {
          ...course,
          userProgress: userProgress ? {
            completedItems: userProgress.completedItems,
            currentModuleIndex: userProgress.currentModuleIndex,
            currentItemIndex: userProgress.currentItemIndex,
            level: userProgress.level,
            points: userProgress.points
          } : null
        };
      });

      return res.json({ courses: coursesWithProgress });
    }

    res.json({ courses });
  } catch (error) {
    console.error('Error fetching courses:', error);
    res.status(500).json({ error: 'Failed to fetch courses' });
  }
};

// Get specific course by ID
export const getCourseById = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;

    const course = await db
      .select()
      .from(courseDefinitions)
      .where(eq(courseDefinitions.id, id))
      .limit(1);

    if (course.length === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }

    // Get user progress if authenticated
    const userId = (req.session as any)?.userId;
    let userProgress = null;

    if (userId) {
      const progress = await db
        .select()
        .from(userCourseProgress)
        .where(
          and(
            eq(userCourseProgress.userId, userId),
            eq(userCourseProgress.courseId, id)
          )
        )
        .limit(1);

      if (progress.length > 0) {
        userProgress = progress[0];

        // Check for return after break
        const lastActive = userProgress.lastActiveAt ? new Date(userProgress.lastActiveAt) : new Date();
        const daysSinceLastActive = Math.floor(
          (new Date().getTime() - lastActive.getTime()) / (1000 * 60 * 60 * 24)
        );

        if (daysSinceLastActive >= 7) {
          // Returning after a break - trigger tutor message
          await aiTutorService.checkForTutorMessage(
            userId,
            id,
            'resume_course',
            { daysSinceLastActive }
          );
        }
      } else {
        // First visit to this course - trigger welcome message
        await aiTutorService.checkForTutorMessage(
          userId,
          id,
          'start_course',
          {}
        );
      }

      // Track analytics
      await db.insert(courseAnalytics).values({
        courseId: id,
        userId,
        eventType: 'view',
        metadata: { timestamp: new Date() }
      });
    }

    res.json({
      course: course[0],
      userProgress
    });
  } catch (error) {
    console.error('Error fetching course:', error);
    res.status(500).json({ error: 'Failed to fetch course' });
  }
};

// Get user progress for a course
export const getUserProgress = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const progress = await db
      .select()
      .from(userCourseProgress)
      .where(
        and(
          eq(userCourseProgress.userId, userId),
          eq(userCourseProgress.courseId, id)
        )
      )
      .limit(1);

    // Get exercise completions
    const completions = await db
      .select()
      .from(exerciseCompletions)
      .where(
        and(
          eq(exerciseCompletions.userId, userId),
          eq(exerciseCompletions.courseId, id)
        )
      );

    res.json({
      progress: progress.length > 0 ? progress[0] : null,
      completions
    });
  } catch (error) {
    console.error('Error fetching progress:', error);
    res.status(500).json({ error: 'Failed to fetch progress' });
  }
};

// Update user progress
export const updateProgress = async (req: Request, res: Response) => {
  try {
    const { id: courseId } = req.params;
    const userId = (req.session as any)?.userId;
    const {
      currentModuleIndex,
      currentItemIndex,
      completedItemId,
      expandedModules
    } = req.body;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    // Check if progress exists
    const existing = await db
      .select()
      .from(userCourseProgress)
      .where(
        and(
          eq(userCourseProgress.userId, userId),
          eq(userCourseProgress.courseId, courseId)
        )
      )
      .limit(1);

    let updatedProgress;

    if (existing.length > 0) {
      // Update existing progress
      const current = existing[0];
      const completedItems = current.completedItems as string[] || [];
      const previousLevel = current.level || 1;

      if (completedItemId && !completedItems.includes(completedItemId)) {
        completedItems.push(completedItemId);
      }

      // Calculate points (10 points per completed item)
      const points = completedItems.length * 10;
      const level = Math.floor(points / 100) + 1;

      // Detect level up
      const leveledUp = level > previousLevel;

      // Detect module completion (check if moving to next module)
      const moduleCompleted = currentModuleIndex !== undefined &&
                             currentModuleIndex > (current.currentModuleIndex || 0);

      updatedProgress = await db
        .update(userCourseProgress)
        .set({
          currentModuleIndex,
          currentItemIndex,
          completedItems,
          expandedModules: expandedModules || current.expandedModules,
          lastActiveAt: new Date(),
          points,
          level
        })
        .where(
          and(
            eq(userCourseProgress.userId, userId),
            eq(userCourseProgress.courseId, courseId)
          )
        )
        .returning();

      // Check for tutor messages
      if (leveledUp) {
        await aiTutorService.checkForTutorMessage(
          userId,
          courseId,
          'progress_update',
          { leveledUp: true, previousLevel, currentLevel: level }
        );
      } else if (moduleCompleted) {
        await aiTutorService.checkForTutorMessage(
          userId,
          courseId,
          'progress_update',
          { moduleCompleted: true, moduleIndex: currentModuleIndex }
        );
      }
    } else {
      // Create new progress
      const completedItems = completedItemId ? [completedItemId] : [];
      updatedProgress = await db
        .insert(userCourseProgress)
        .values({
          userId,
          courseId,
          currentModuleIndex: currentModuleIndex || 0,
          currentItemIndex: currentItemIndex || 0,
          completedItems,
          expandedModules: expandedModules || [],
          points: completedItems.length * 10,
          level: 1
        })
        .returning();
    }

    // Track analytics
    if (completedItemId) {
      await db.insert(courseAnalytics).values({
        courseId,
        userId,
        eventType: 'complete_item',
        itemId: completedItemId,
        metadata: { timestamp: new Date() }
      });
    }

    res.json({ progress: updatedProgress[0] });
  } catch (error) {
    console.error('Error updating progress:', error);
    res.status(500).json({ error: 'Failed to update progress' });
  }
};

// Validate exercise answer
export const validateExercise = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;
    const {
      courseId,
      moduleId,
      itemId,
      exerciseType,
      userAnswer
    } = req.body;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    // Get the course to find the exercise
    const course = await db
      .select()
      .from(courseDefinitions)
      .where(eq(courseDefinitions.id, courseId))
      .limit(1);

    if (course.length === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }

    const modules = course[0].modules as CourseModule[];
    const module = modules.find(m => m.id === moduleId);
    if (!module) {
      return res.status(404).json({ error: 'Module not found' });
    }

    const item = module.items.find(i => i.id === itemId);
    if (!item) {
      return res.status(404).json({ error: 'Exercise not found' });
    }

    let isCorrect = false;
    let feedback = '';

    // Validate based on exercise type
    switch (exerciseType) {
      case 'quiz':
        const quizItem = item as any;
        isCorrect = userAnswer === quizItem.correct;
        feedback = isCorrect ? 'Correct!' : `The correct answer is option ${quizItem.correct + 1}`;
        break;

      case 'terminal':
        const terminalItem = item as any;
        isCorrect = userAnswer.trim() === terminalItem.command.trim();
        feedback = isCorrect ? 'Perfect command!' : `Expected: ${terminalItem.command}`;
        break;

      case 'code':
        // For code exercises, we'll do basic validation
        // In a real system, this would run tests
        isCorrect = userAnswer && userAnswer.length > 10;
        feedback = 'Code submitted successfully';
        break;

      case 'descriptive':
        // Descriptive answers are always "correct" if submitted
        isCorrect = userAnswer && userAnswer.trim().length > 0;
        feedback = 'Answer submitted';
        break;

      default:
        isCorrect = true;
        feedback = 'Completed';
    }

    // Save completion
    const existing = await db
      .select()
      .from(exerciseCompletions)
      .where(
        and(
          eq(exerciseCompletions.userId, userId),
          eq(exerciseCompletions.itemId, itemId)
        )
      )
      .limit(1);

    let attempts = 1;

    if (existing.length > 0) {
      // Update attempts
      attempts = (existing[0].attempts || 0) + 1;

      await db
        .update(exerciseCompletions)
        .set({
          userAnswer,
          isCorrect,
          attempts: sql`${exerciseCompletions.attempts} + 1`,
          completedAt: new Date()
        })
        .where(
          and(
            eq(exerciseCompletions.userId, userId),
            eq(exerciseCompletions.itemId, itemId)
          )
        );
    } else {
      // Create new completion
      await db.insert(exerciseCompletions).values({
        userId,
        courseId,
        moduleId,
        itemId,
        exerciseType,
        userAnswer,
        isCorrect,
        score: isCorrect ? 100 : 0
      });
    }

    // Check if student is struggling (3+ attempts and still incorrect)
    if (!isCorrect && attempts >= 3) {
      await aiTutorService.checkForTutorMessage(
        userId,
        courseId,
        'complete_exercise',
        {
          struggling: true,
          attempts,
          exerciseId: itemId,
          exerciseTitle: (item as any).title || 'exercise'
        }
      );
    }

    res.json({
      isCorrect,
      feedback,
      sampleAnswer: exerciseType === 'descriptive' ? (item as any).sampleAnswer : null
    });
  } catch (error) {
    console.error('Error validating exercise:', error);
    res.status(500).json({ error: 'Failed to validate exercise' });
  }
};

// Get user layout preferences
export const getLayoutPreferences = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const preferences = await db
      .select()
      .from(userLayoutPreferences)
      .where(eq(userLayoutPreferences.userId, userId))
      .limit(1);

    if (preferences.length === 0) {
      // Return defaults
      return res.json({
        defaultLayout: 'split',
        editorPosition: 'right',
        sidebarCollapsed: false,
        fontSize: 14,
        theme: 'light'
      });
    }

    res.json(preferences[0]);
  } catch (error) {
    console.error('Error fetching preferences:', error);
    res.status(500).json({ error: 'Failed to fetch preferences' });
  }
};

// Update user layout preferences
export const updateLayoutPreferences = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const {
      defaultLayout,
      editorPosition,
      sidebarCollapsed,
      fontSize,
      theme,
      ...otherPreferences
    } = req.body;

    // Upsert preferences
    const existing = await db
      .select()
      .from(userLayoutPreferences)
      .where(eq(userLayoutPreferences.userId, userId))
      .limit(1);

    let updated;
    if (existing.length > 0) {
      updated = await db
        .update(userLayoutPreferences)
        .set({
          defaultLayout,
          editorPosition,
          sidebarCollapsed,
          fontSize,
          theme,
          preferences: otherPreferences,
          updatedAt: new Date()
        })
        .where(eq(userLayoutPreferences.userId, userId))
        .returning();
    } else {
      updated = await db
        .insert(userLayoutPreferences)
        .values({
          userId,
          defaultLayout,
          editorPosition,
          sidebarCollapsed,
          fontSize,
          theme,
          preferences: otherPreferences
        })
        .returning();
    }

    res.json(updated[0]);
  } catch (error) {
    console.error('Error updating preferences:', error);
    res.status(500).json({ error: 'Failed to update preferences' });
  }
};

// Run code (placeholder - would integrate with sandbox)
export const runCode = async (req: Request, res: Response) => {
  try {
    const { code, language, testCases } = req.body;

    // In production, this would run in a sandbox
    // For now, return mock results
    const results = testCases?.map((test: any) => ({
      input: test.input,
      expectedOutput: test.expectedOutput,
      actualOutput: 'Mock output',
      passed: Math.random() > 0.5
    })) || [];

    res.json({
      success: true,
      results,
      output: 'Code execution simulated',
      error: null
    });
  } catch (error) {
    console.error('Error running code:', error);
    res.status(500).json({ error: 'Failed to run code' });
  }
};

// Run terminal command (placeholder)
export const runTerminal = async (req: Request, res: Response) => {
  try {
    const { command } = req.body;

    // In production, this would run in a sandbox
    res.json({
      success: true,
      output: `$ ${command}\nCommand executed successfully (simulated)`,
      error: null
    });
  } catch (error) {
    console.error('Error running terminal:', error);
    res.status(500).json({ error: 'Failed to run terminal command' });
  }
};