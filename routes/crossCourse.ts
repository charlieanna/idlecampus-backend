import { Router } from 'express';
import {
  getSkillProfile,
  refreshSkillProfile,
  setLearningGoals,
  getRecommendations,
  generateRecommendations,
  dismissRecommendation,
  acceptRecommendation,
  getLearningPaths,
  getLearningPath,
  getCoursePrerequisites
} from '../controllers/crossCourseController';
import { requireAuth, optionalAuth } from '../security';
import { validateRequest } from '../security';
import { z } from 'zod';

// ==========================================
// CROSS-COURSE TRACKING ROUTES
// ==========================================

const router = Router();

// Validation schemas
const learningGoalsSchema = z.object({
  goals: z.array(z.string()).min(1).max(5)
});

// ==========================================
// SKILL PROFILE ROUTES
// ==========================================

// Get user's global skill profile
router.get('/profile', requireAuth, getSkillProfile);

// Refresh/recalculate skill profile
router.post('/profile/refresh', requireAuth, refreshSkillProfile);

// Set learning goals
router.put(
  '/goals',
  requireAuth,
  validateRequest(learningGoalsSchema),
  setLearningGoals
);

// ==========================================
// RECOMMENDATION ROUTES
// ==========================================

// Get course recommendations
router.get('/recommendations', requireAuth, getRecommendations);

// Force generate new recommendations
router.post('/recommendations/generate', requireAuth, generateRecommendations);

// Dismiss a recommendation
router.post('/recommendations/:courseId/dismiss', requireAuth, dismissRecommendation);

// Accept a recommendation
router.post('/recommendations/:courseId/accept', requireAuth, acceptRecommendation);

// ==========================================
// LEARNING PATH ROUTES
// ==========================================

// Get all learning paths
router.get('/paths', getLearningPaths);

// Get specific learning path
router.get('/paths/:goalId', getLearningPath);

// ==========================================
// PREREQUISITES ROUTES
// ==========================================

// Get course prerequisites (with optional user check)
router.get('/courses/:courseId/prerequisites', optionalAuth, getCoursePrerequisites);

export default router;
