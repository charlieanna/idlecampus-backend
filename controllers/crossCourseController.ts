import { Request, Response } from 'express';
import * as skillAggService from '../services/skillAggregationService';
import * as recommendationEngine from '../services/recommendationEngine';
import * as coursePrereqService from '../services/coursePrerequisitesService';

// ==========================================
// CROSS-COURSE TRACKING CONTROLLERS
// ==========================================

/**
 * GET /api/learning/profile
 * Get user's global skill profile
 */
export const getSkillProfile = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    let profile = await skillAggService.getSkillProfile(userId);

    if (!profile) {
      // Generate profile if doesn't exist
      profile = await skillAggService.updateUserSkillProfile(userId);
    }

    res.json({ profile });
  } catch (error) {
    console.error('Error fetching skill profile:', error);
    res.status(500).json({ error: 'Failed to fetch skill profile' });
  }
};

/**
 * POST /api/learning/profile/refresh
 * Recalculate and update user's skill profile
 */
export const refreshSkillProfile = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const profile = await skillAggService.updateUserSkillProfile(userId);

    res.json({ profile, updated: true });
  } catch (error) {
    console.error('Error refreshing skill profile:', error);
    res.status(500).json({ error: 'Failed to refresh skill profile' });
  }
};

/**
 * PUT /api/learning/goals
 * Set user's learning goals
 */
export const setLearningGoals = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const { goals } = req.body;

    if (!Array.isArray(goals)) {
      return res.status(400).json({ error: 'Goals must be an array' });
    }

    await skillAggService.setLearningGoals(userId, goals);

    // Regenerate recommendations with new goals
    await recommendationEngine.generateRecommendations(userId);

    res.json({ success: true, goals });
  } catch (error) {
    console.error('Error setting learning goals:', error);
    res.status(500).json({ error: 'Failed to set learning goals' });
  }
};

/**
 * GET /api/learning/recommendations
 * Get personalized course recommendations
 */
export const getRecommendations = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const recommendations = await recommendationEngine.getRecommendations(userId);

    res.json({ recommendations, count: recommendations.length });
  } catch (error) {
    console.error('Error fetching recommendations:', error);
    res.status(500).json({ error: 'Failed to fetch recommendations' });
  }
};

/**
 * POST /api/learning/recommendations/generate
 * Force regenerate recommendations
 */
export const generateRecommendations = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    // First update skill profile
    await skillAggService.updateUserSkillProfile(userId);

    // Then generate recommendations
    const recommendations = await recommendationEngine.generateRecommendations(userId);

    res.json({ recommendations, count: recommendations.length, generated: true });
  } catch (error) {
    console.error('Error generating recommendations:', error);
    res.status(500).json({ error: 'Failed to generate recommendations' });
  }
};

/**
 * POST /api/learning/recommendations/:courseId/dismiss
 * Dismiss a course recommendation
 */
export const dismissRecommendation = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;
    const { courseId } = req.params;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    await recommendationEngine.dismissRecommendation(userId, courseId);

    res.json({ success: true });
  } catch (error) {
    console.error('Error dismissing recommendation:', error);
    res.status(500).json({ error: 'Failed to dismiss recommendation' });
  }
};

/**
 * POST /api/learning/recommendations/:courseId/accept
 * Accept a recommendation (student starts the course)
 */
export const acceptRecommendation = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;
    const { courseId } = req.params;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    await recommendationEngine.acceptRecommendation(userId, courseId);

    res.json({ success: true, courseId });
  } catch (error) {
    console.error('Error accepting recommendation:', error);
    res.status(500).json({ error: 'Failed to accept recommendation' });
  }
};

/**
 * GET /api/learning/paths
 * Get available learning paths
 */
export const getLearningPaths = async (req: Request, res: Response) => {
  try {
    const paths = coursePrereqService.LEARNING_PATHS;

    res.json({ paths });
  } catch (error) {
    console.error('Error fetching learning paths:', error);
    res.status(500).json({ error: 'Failed to fetch learning paths' });
  }
};

/**
 * GET /api/learning/paths/:goalId
 * Get specific learning path details
 */
export const getLearningPath = async (req: Request, res: Response) => {
  try {
    const { goalId } = req.params;

    const path = coursePrereqService.getLearningPath(goalId);

    if (!path) {
      return res.status(404).json({ error: 'Learning path not found' });
    }

    res.json({ path });
  } catch (error) {
    console.error('Error fetching learning path:', error);
    res.status(500).json({ error: 'Failed to fetch learning path' });
  }
};

/**
 * GET /api/learning/courses/:courseId/prerequisites
 * Get prerequisites for a specific course
 */
export const getCoursePrerequisites = async (req: Request, res: Response) => {
  try {
    const { courseId } = req.params;
    const userId = (req.session as any)?.userId;

    const prerequisites = await coursePrereqService.getCoursePrerequisites(courseId);

    if (!prerequisites) {
      return res.status(404).json({ error: 'Course not found' });
    }

    // If user is logged in, check if they meet prerequisites
    let meetsRequirements = null;
    if (userId) {
      const profile = await skillAggService.getSkillProfile(userId);
      if (profile) {
        meetsRequirements = coursePrereqService.meetsPrerequisites(
          courseId,
          profile.skills
        );
      }
    }

    res.json({ prerequisites, meetsRequirements });
  } catch (error) {
    console.error('Error fetching prerequisites:', error);
    res.status(500).json({ error: 'Failed to fetch prerequisites' });
  }
};
