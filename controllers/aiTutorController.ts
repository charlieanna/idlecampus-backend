import { Request, Response } from 'express';
import * as aiTutorService from '../services/aiTutorService';
import * as ollamaService from '../services/ollamaService';

// ==========================================
// AI TUTOR CONTROLLERS
// ==========================================

/**
 * GET /api/tutor/messages
 * Get unread tutor messages for the current user
 */
export const getMessages = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const messages = await aiTutorService.getUnreadMessages(userId);

    res.json({
      messages,
      count: messages.length
    });
  } catch (error) {
    console.error('Error fetching tutor messages:', error);
    res.status(500).json({ error: 'Failed to fetch tutor messages' });
  }
};

/**
 * POST /api/tutor/messages/:id/read
 * Mark a tutor message as read
 */
export const markAsRead = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    await aiTutorService.markMessageAsRead(id);

    res.json({ success: true });
  } catch (error) {
    console.error('Error marking message as read:', error);
    res.status(500).json({ error: 'Failed to mark message as read' });
  }
};

/**
 * POST /api/tutor/messages/:id/dismiss
 * Dismiss a tutor message
 */
export const dismissMessage = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    await aiTutorService.dismissMessage(id);

    res.json({ success: true });
  } catch (error) {
    console.error('Error dismissing message:', error);
    res.status(500).json({ error: 'Failed to dismiss message' });
  }
};

/**
 * POST /api/tutor/hint
 * Request a hint for an exercise
 */
export const getHint = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const { courseId, exerciseId, exerciseTitle, exerciseType } = req.body;

    if (!courseId || !exerciseId || !exerciseTitle || !exerciseType) {
      return res.status(400).json({
        error: 'Missing required fields: courseId, exerciseId, exerciseTitle, exerciseType'
      });
    }

    const hint = await aiTutorService.generateHintForExercise(
      userId,
      courseId,
      exerciseId,
      exerciseTitle,
      exerciseType
    );

    res.json({
      hint,
      exerciseId,
      generatedAt: new Date()
    });
  } catch (error) {
    console.error('Error generating hint:', error);
    res.status(500).json({ error: 'Failed to generate hint' });
  }
};

/**
 * GET /api/tutor/preferences
 * Get user tutor preferences
 */
export const getPreferences = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    // This will be implemented when we add the service method
    res.json({
      enabled: true,
      tone: 'friendly',
      frequency: 'normal'
    });
  } catch (error) {
    console.error('Error fetching preferences:', error);
    res.status(500).json({ error: 'Failed to fetch preferences' });
  }
};

/**
 * PUT /api/tutor/preferences
 * Update user tutor preferences
 */
export const updatePreferences = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const { enabled, tone, frequency, mutedUntil } = req.body;

    await aiTutorService.updateUserTutorPreferences(userId, {
      enabled,
      tone,
      frequency,
      mutedUntil: mutedUntil ? new Date(mutedUntil) : null
    });

    res.json({ success: true });
  } catch (error) {
    console.error('Error updating preferences:', error);
    res.status(500).json({ error: 'Failed to update preferences' });
  }
};

/**
 * GET /api/tutor/status
 * Check if Ollama service is available
 */
export const getStatus = async (req: Request, res: Response) => {
  try {
    const available = await ollamaService.isAvailable();
    const models = available ? await ollamaService.listModels() : [];

    res.json({
      available,
      models,
      url: process.env.OLLAMA_URL || 'http://localhost:11434',
      model: process.env.OLLAMA_MODEL || 'llama3.2',
      status: available ? 'online' : 'offline'
    });
  } catch (error) {
    console.error('Error checking Ollama status:', error);
    res.status(500).json({ error: 'Failed to check Ollama status' });
  }
};

/**
 * POST /api/tutor/trigger
 * Manually trigger a tutor message check (for testing or manual triggers)
 */
export const triggerCheck = async (req: Request, res: Response) => {
  try {
    const userId = (req.session as any)?.userId;

    if (!userId) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    const { courseId, action, metadata } = req.body;

    if (!courseId || !action) {
      return res.status(400).json({
        error: 'Missing required fields: courseId, action'
      });
    }

    const message = await aiTutorService.checkForTutorMessage(
      userId,
      courseId,
      action,
      metadata
    );

    res.json({
      messageGenerated: !!message,
      message: message || null
    });
  } catch (error) {
    console.error('Error triggering tutor check:', error);
    res.status(500).json({ error: 'Failed to trigger tutor check' });
  }
};
