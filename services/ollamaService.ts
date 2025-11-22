import axios, { AxiosError } from 'axios';

// ==========================================
// OLLAMA SERVICE (TypeScript)
// ==========================================
// Connects to local Ollama instance for AI generation

const OLLAMA_URL = process.env.OLLAMA_URL || 'http://localhost:11434';
const OLLAMA_MODEL = process.env.OLLAMA_MODEL || 'llama3.2';
const TIMEOUT = 120000; // 2 minutes

export class OllamaError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'OllamaError';
  }
}

interface GenerateOptions {
  temperature?: number;
  top_p?: number;
  top_k?: number;
}

interface OllamaGenerateResponse {
  model: string;
  response: string;
  done: boolean;
  context?: number[];
}

// ==========================================
// PUBLIC API
// ==========================================

/**
 * Check if Ollama service is available
 */
export async function isAvailable(): Promise<boolean> {
  try {
    const response = await axios.get(`${OLLAMA_URL}/api/tags`, {
      timeout: 5000
    });
    return response.status === 200;
  } catch (error) {
    console.error('Ollama availability check failed:', error);
    return false;
  }
}

/**
 * List available models
 */
export async function listModels(): Promise<string[]> {
  try {
    const response = await axios.get(`${OLLAMA_URL}/api/tags`, {
      timeout: 5000
    });

    if (response.data.models) {
      return response.data.models.map((m: any) => m.name);
    }
    return [];
  } catch (error) {
    console.error('Failed to list models:', error);
    return [];
  }
}

/**
 * Generate text using Ollama
 */
export async function generate(
  prompt: string,
  options: GenerateOptions = {}
): Promise<string> {
  try {
    const response = await axios.post<OllamaGenerateResponse>(
      `${OLLAMA_URL}/api/generate`,
      {
        model: OLLAMA_MODEL,
        prompt,
        stream: false,
        options: {
          temperature: options.temperature || 0.7,
          top_p: options.top_p || 0.9,
          top_k: options.top_k || 40
        }
      },
      {
        timeout: TIMEOUT,
        headers: {
          'Content-Type': 'application/json'
        }
      }
    );

    if (!response.data.response) {
      throw new OllamaError('No response from Ollama');
    }

    return response.data.response;
  } catch (error) {
    if (axios.isAxiosError(error)) {
      const axiosError = error as AxiosError;
      throw new OllamaError(
        `Ollama request failed: ${axiosError.message}`
      );
    }
    throw new OllamaError(`Failed to generate response: ${error}`);
  }
}

/**
 * Generate a tutor message based on context
 */
export async function generateTutorMessage(context: {
  messageType: string;
  trigger: string;
  studentName?: string;
  courseName?: string;
  metadata?: any;
  tone?: string;
}): Promise<string> {
  const prompt = buildTutorPrompt(context);
  return generate(prompt, { temperature: 0.8 });
}

/**
 * Generate hints for students who are stuck
 */
export async function generateHint(context: {
  exerciseTitle: string;
  exerciseType: string;
  attempts: number;
  courseName: string;
  studentName?: string;
}): Promise<string> {
  const prompt = buildHintPrompt(context);
  return generate(prompt, { temperature: 0.7 });
}

/**
 * Explain a concept in simpler terms
 */
export async function explainConcept(context: {
  topic: string;
  difficulty: string;
  courseName: string;
  studentName?: string;
}): Promise<string> {
  const prompt = buildExplanationPrompt(context);
  return generate(prompt, { temperature: 0.7 });
}

// ==========================================
// PROMPT BUILDERS
// ==========================================

function buildTutorPrompt(context: {
  messageType: string;
  trigger: string;
  studentName?: string;
  courseName?: string;
  metadata?: any;
  tone?: string;
}): string {
  const tone = context.tone || 'friendly';
  const name = context.studentName || 'there';

  let basePrompt = `You are an encouraging coding tutor with a ${tone} personality. `;

  switch (context.messageType) {
    case 'welcome':
      basePrompt += `Generate a SHORT (2-3 sentences) welcoming message for ${name} who just ${context.trigger}.
Course: ${context.courseName || 'a new course'}

Make it warm and encouraging. Show excitement about their learning journey.`;
      break;

    case 'celebration':
      basePrompt += `Generate a SHORT (2-3 sentences) celebration message for ${name} who just ${context.trigger}.
Course: ${context.courseName}
Achievement: ${context.metadata?.achievement || 'progress'}

Be genuinely excited and acknowledge their accomplishment. Keep it energetic but not over the top.`;
      break;

    case 'motivation':
      basePrompt += `Generate a SHORT (2-3 sentences) motivating message for ${name}.
Situation: ${context.trigger}
Course: ${context.courseName}
Context: ${JSON.stringify(context.metadata || {})}

Be empathetic and encouraging. Acknowledge the challenge but inspire them to keep going. Suggest a constructive next step.`;
      break;

    case 'nudge':
      basePrompt += `Generate a SHORT (2-3 sentences) gentle reminder for ${name}.
Reason: ${context.trigger}
Course: ${context.courseName}
Last active: ${context.metadata?.lastActive || 'some time ago'}

Be warm and welcoming, not pushy. Express that they're missed. Make it feel like a friend checking in.`;
      break;

    case 'hint':
      basePrompt += `Generate a SHORT (2-3 sentences) helpful hint for ${name}.
Exercise: ${context.metadata?.exerciseName || 'current exercise'}
Attempts: ${context.metadata?.attempts || 'multiple'}

Provide a gentle nudge in the right direction without giving away the answer. Be encouraging.`;
      break;

    default:
      basePrompt += `Generate a SHORT supportive message for ${name} learning ${context.courseName}.`;
  }

  basePrompt += '\n\nIMPORTANT: Keep your response to 2-3 sentences maximum. Be conversational and genuine. Do not use emojis unless it fits naturally.';

  return basePrompt;
}

function buildHintPrompt(context: {
  exerciseTitle: string;
  exerciseType: string;
  attempts: number;
  courseName: string;
  studentName?: string;
}): string {
  return `You are a patient coding tutor. A student named ${context.studentName || 'a learner'} is stuck on an exercise.

Exercise: ${context.exerciseTitle}
Type: ${context.exerciseType}
Course: ${context.courseName}
Attempts so far: ${context.attempts}

Provide a helpful hint that:
1. Doesn't give away the complete answer
2. Points them in the right direction
3. Encourages them to think through the problem
4. Is 2-3 sentences maximum

Be supportive and constructive.`;
}

function buildExplanationPrompt(context: {
  topic: string;
  difficulty: string;
  courseName: string;
  studentName?: string;
}): string {
  return `You are a skilled coding tutor explaining concepts clearly.

Topic: ${context.topic}
Difficulty Level: ${context.difficulty}
Course: ${context.courseName}
Student: ${context.studentName || 'a learner'}

Explain this topic in simple, clear terms:
- Use analogies if helpful
- Break down complex ideas
- Keep it concise (3-4 sentences)
- Match the difficulty level

Make it easy to understand without being condescending.`;
}

export default {
  isAvailable,
  listModels,
  generate,
  generateTutorMessage,
  generateHint,
  explainConcept
};
