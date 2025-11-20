import { Router } from 'express';
import {
  getCourses,
  getCourseById,
  getUserProgress,
  updateProgress,
  validateExercise,
  getLayoutPreferences,
  updateLayoutPreferences,
  runCode,
  runTerminal
} from '../controllers/courseV2Controller';
import { requireAuth, optionalAuth } from '../security';
import { validateRequest } from '../security';
import { z } from 'zod';

// ==========================================
// COURSE V2 ROUTES
// ==========================================

const router = Router();

// Validation schemas
const updateProgressSchema = z.object({
  currentModuleIndex: z.number().optional(),
  currentItemIndex: z.number().optional(),
  completedItemId: z.string().optional(),
  expandedModules: z.array(z.string()).optional()
});

const validateExerciseSchema = z.object({
  courseId: z.string(),
  moduleId: z.string(),
  itemId: z.string(),
  exerciseType: z.enum(['lesson', 'quiz', 'code', 'terminal', 'descriptive', 'checkpoint']),
  userAnswer: z.any()
});

const layoutPreferencesSchema = z.object({
  defaultLayout: z.enum(['focused', 'split', 'triple', 'zen']).optional(),
  editorPosition: z.enum(['left', 'right', 'bottom']).optional(),
  sidebarCollapsed: z.boolean().optional(),
  fontSize: z.number().min(10).max(24).optional(),
  theme: z.enum(['light', 'dark']).optional()
});

const runCodeSchema = z.object({
  code: z.string().min(1).max(10000),
  language: z.enum(['python', 'javascript', 'typescript']),
  testCases: z.array(z.object({
    input: z.string(),
    expectedOutput: z.string()
  })).optional()
});

const runTerminalSchema = z.object({
  command: z.string().min(1).max(500)
});

// ==========================================
// PUBLIC ROUTES
// ==========================================

// Get all courses (with optional auth for progress)
router.get('/courses', optionalAuth, getCourses);

// Get specific course (with optional auth for progress)
router.get('/courses/:id', optionalAuth, getCourseById);

// ==========================================
// PROTECTED ROUTES
// ==========================================

// Get user progress for a course
router.get('/courses/:id/progress', requireAuth, getUserProgress);

// Update user progress
router.post(
  '/courses/:id/progress',
  requireAuth,
  validateRequest(updateProgressSchema),
  updateProgress
);

// Validate exercise answer
router.post(
  '/exercises/validate',
  requireAuth,
  validateRequest(validateExerciseSchema),
  validateExercise
);

// Get user layout preferences
router.get('/preferences/layout', requireAuth, getLayoutPreferences);

// Update user layout preferences
router.put(
  '/preferences/layout',
  requireAuth,
  validateRequest(layoutPreferencesSchema),
  updateLayoutPreferences
);

// Run code in sandbox
router.post(
  '/exercises/run-code',
  requireAuth,
  validateRequest(runCodeSchema),
  runCode
);

// Run terminal command
router.post(
  '/exercises/run-terminal',
  requireAuth,
  validateRequest(runTerminalSchema),
  runTerminal
);

// ==========================================
// ANALYTICS ROUTES (optional)
// ==========================================

// Track course events
router.post('/analytics/track', requireAuth, async (req, res) => {
  // Simple analytics tracking
  const { courseId, eventType, metadata } = req.body;
  const userId = (req.session as any)?.userId;

  // In production, this would save to analytics
  console.log('Analytics:', { userId, courseId, eventType, metadata });
  res.json({ success: true });
});

// Health check
router.get('/health', (req, res) => {
  res.json({ status: 'ok', version: '2.0' });
});

export default router;