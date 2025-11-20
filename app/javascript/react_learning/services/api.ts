import type {
  Module,
  LearningSession,
  CommandMastery,
  CommandValidationResponse,
  ApiResponse,
  ModulesResponse
} from '../types';

// Get CSRF token for Rails
function getCSRFToken(): string {
  const metaTag = document.querySelector('meta[name="csrf-token"]');
  return metaTag ? metaTag.getAttribute('content') || '' : '';
}

// Base API client
class ApiClient {
  private baseURL: string;

  constructor(baseURL: string = '/api/v1') {
    this.baseURL = baseURL;
  }

  private async request<T>(
    endpoint: string,
    options: RequestInit = {}
  ): Promise<ApiResponse<T>> {
    const url = `${this.baseURL}${endpoint}`;
    const headers: HeadersInit = {
      'Content-Type': 'application/json',
      'X-CSRF-Token': getCSRFToken(),
      ...options.headers
    };

    try {
      const response = await fetch(url, {
        ...options,
        headers,
        credentials: 'same-origin'
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
      }

      const data = await response.json();
      return {
        data: data.data || data,
        success: true,
        message: data.message
      };
    } catch (error) {
      console.error(`API request failed: ${endpoint}`, error);
      return {
        data: null as any,
        success: false,
        message: error instanceof Error ? error.message : 'Unknown error',
        errors: [error instanceof Error ? error.message : 'Unknown error']
      };
    }
  }

  async get<T>(endpoint: string, params?: Record<string, any>): Promise<ApiResponse<T>> {
    const queryString = params
      ? '?' + new URLSearchParams(params).toString()
      : '';
    return this.request<T>(`${endpoint}${queryString}`, { method: 'GET' });
  }

  async post<T>(endpoint: string, data?: any): Promise<ApiResponse<T>> {
    return this.request<T>(endpoint, {
      method: 'POST',
      body: data ? JSON.stringify(data) : undefined
    });
  }

  async put<T>(endpoint: string, data?: any): Promise<ApiResponse<T>> {
    return this.request<T>(endpoint, {
      method: 'PUT',
      body: data ? JSON.stringify(data) : undefined
    });
  }

  async delete<T>(endpoint: string): Promise<ApiResponse<T>> {
    return this.request<T>(endpoint, { method: 'DELETE' });
  }
}

// Create singleton instance
const api = new ApiClient();

// ============================================
// LEARNING API METHODS
// ============================================

export const learningApi = {
  /**
   * Get current learning session and modules
   */
  async getSession(track: string = 'docker'): Promise<ApiResponse<ModulesResponse>> {
    return api.get<ModulesResponse>(`/learning/session`, { track });
  },

  /**
   * Get all modules with lessons, labs, and quizzes
   */
  async getModules(track: string = 'docker'): Promise<ApiResponse<Module[]>> {
    return api.get<Module[]>(`/learning/modules`, { track });
  },

  /**
   * Get a specific lesson by ID
   */
  async getLesson(lessonId: string): Promise<ApiResponse<any>> {
    return api.get<any>(`/learning/lesson/${lessonId}`);
  },

  /**
   * Validate a command submission
   */
  async validateCommand(command: string, context?: {
    lessonId?: string;
    expectedCommand?: string;
    labId?: string;
    taskId?: string;
  }): Promise<ApiResponse<CommandValidationResponse>> {
    return api.post<CommandValidationResponse>(`/learning/command`, {
      command,
      ...context
    });
  },

  /**
   * Mark a command as complete
   */
  async completeCommand(lessonId: string, commandIndex: number): Promise<ApiResponse<any>> {
    return api.post<any>(`/learning/complete/command`, {
      lessonId,
      commandIndex
    });
  },

  /**
   * Mark a lesson as complete
   */
  async completeLesson(lessonId: string): Promise<ApiResponse<any>> {
    return api.post<any>(`/learning/complete/lesson`, {
      lessonId
    });
  },

  /**
   * Mark a task as complete
   */
  async completeTask(taskId: string, command: string): Promise<ApiResponse<any>> {
    return api.post<any>(`/learning/complete/task`, {
      taskId,
      command
    });
  },

  /**
   * Get command mastery scores
   */
  async getMasteryScores(): Promise<ApiResponse<Record<string, CommandMastery>>> {
    return api.get<Record<string, CommandMastery>>(`/learning/mastery`);
  },

  /**
   * Restart current session
   */
  async restartSession(resetProgress: boolean = false): Promise<ApiResponse<any>> {
    return api.post<any>(`/learning/restart`, { resetProgress });
  }
};

export default api;
