import { Router } from 'express';
import {
  getMessages,
  markAsRead,
  dismissMessage,
  getHint,
  getPreferences,
  updatePreferences,
  getStatus,
  triggerCheck
} from '../controllers/aiTutorController';
import { requireAuth } from '../security';
import { validateRequest } from '../security';
import { z } from 'zod';

// ==========================================
// AI TUTOR ROUTES
// ==========================================

const router = Router();

// Validation schemas
const hintRequestSchema = z.object({
  courseId: z.string().min(1),
  exerciseId: z.string().min(1),
  exerciseTitle: z.string().min(1),
  exerciseType: z.string().min(1)
});

const preferencesSchema = z.object({
  enabled: z.boolean().optional(),
  tone: z.enum(['friendly', 'professional', 'enthusiastic']).optional(),
  frequency: z.enum(['minimal', 'normal', 'frequent']).optional(),
  mutedUntil: z.string().optional()
});

const triggerCheckSchema = z.object({
  courseId: z.string().min(1),
  action: z.string().min(1),
  metadata: z.any().optional()
});

// ==========================================
// ROUTES
// ==========================================

// Get unread tutor messages
router.get('/messages', requireAuth, getMessages);

// Mark message as read
router.post('/messages/:id/read', requireAuth, markAsRead);

// Dismiss a message
router.post('/messages/:id/dismiss', requireAuth, dismissMessage);

// Request a hint for an exercise
router.post(
  '/hint',
  requireAuth,
  validateRequest(hintRequestSchema),
  getHint
);

// Get tutor preferences
router.get('/preferences', requireAuth, getPreferences);

// Update tutor preferences
router.put(
  '/preferences',
  requireAuth,
  validateRequest(preferencesSchema),
  updatePreferences
);

// Check Ollama service status
router.get('/status', getStatus);

// Trigger a tutor message check (for testing)
router.post(
  '/trigger',
  requireAuth,
  validateRequest(triggerCheckSchema),
  triggerCheck
);

export default router;
