import { db } from '../db';
import { eq } from 'drizzle-orm';
import { coursePrerequisites, courseDefinitions } from '../db/courseV2Schema';

// ==========================================
// COURSE PREREQUISITES SERVICE
// ==========================================
// Maps course dependencies and skill requirements

export interface PrerequisiteMapping {
  courseId: string;
  courseName: string;
  prerequisites: {
    courseId: string;
    courseName: string;
    isRequired: boolean;
    skillsRequired: Record<string, number>; // { "docker": 70 }
  }[];
}

// ==========================================
// PREREQUISITES CONFIGURATION
// ==========================================

/**
 * Define course prerequisites and skill requirements
 * This maps out the learning path relationships
 */
export const COURSE_PREREQUISITES_MAP: Record<string, {
  prerequisites: string[];
  recommended?: string[];
  skillsRequired?: Record<string, number>;
}> = {
  // DevOps Track
  'kubernetes-basics': {
    prerequisites: ['docker-fundamentals'],
    recommended: ['linux-fundamentals'],
    skillsRequired: { 'docker': 70, 'linux-commands': 60 }
  },

  'kubernetes-advanced': {
    prerequisites: ['kubernetes-basics'],
    skillsRequired: { 'kubernetes': 70, 'yaml': 60 }
  },

  'docker-networking': {
    prerequisites: ['docker-fundamentals'],
    skillsRequired: { 'docker': 60 }
  },

  'docker-compose': {
    prerequisites: ['docker-fundamentals'],
    recommended: ['docker-networking'],
    skillsRequired: { 'docker': 70 }
  },

  'ci-cd-pipeline': {
    prerequisites: ['docker-fundamentals'],
    recommended: ['kubernetes-basics', 'git-fundamentals'],
    skillsRequired: { 'docker': 60, 'git': 50 }
  },

  // Programming Track
  'golang-basics': {
    recommended: ['programming-fundamentals'],
    skillsRequired: {}
  },

  'golang-microservices': {
    prerequisites: ['golang-basics'],
    recommended: ['docker-fundamentals'],
    skillsRequired: { 'golang': 70, 'http': 60 }
  },

  'python-advanced': {
    prerequisites: ['python-basics'],
    skillsRequired: { 'python': 70 }
  },

  'python-web-dev': {
    prerequisites: ['python-basics'],
    skillsRequired: { 'python': 70, 'http': 50 }
  },

  // System Administration Track
  'linux-advanced': {
    prerequisites: ['linux-fundamentals'],
    skillsRequired: { 'linux-commands': 70, 'shell-scripting': 50 }
  },

  'linux-networking': {
    prerequisites: ['linux-fundamentals'],
    recommended: ['networking-basics'],
    skillsRequired: { 'linux': 60, 'networking': 40 }
  },

  // Database Track
  'postgresql-advanced': {
    prerequisites: ['sql-basics'],
    skillsRequired: { 'sql': 70 }
  },

  'database-design': {
    prerequisites: ['sql-basics'],
    skillsRequired: { 'sql': 60, 'data-modeling': 50 }
  },
};

/**
 * Skill tags extracted from course content
 * Maps courses to the skills they teach
 */
export const COURSE_SKILL_TAGS: Record<string, string[]> = {
  'docker-fundamentals': ['docker', 'containers', 'containerization'],
  'docker-networking': ['docker', 'networking', 'docker-networks'],
  'docker-compose': ['docker', 'docker-compose', 'orchestration'],

  'kubernetes-basics': ['kubernetes', 'k8s', 'container-orchestration', 'pods', 'deployments'],
  'kubernetes-advanced': ['kubernetes', 'k8s', 'helm', 'networking', 'security'],

  'linux-fundamentals': ['linux', 'linux-commands', 'shell', 'bash'],
  'linux-advanced': ['linux', 'shell-scripting', 'system-admin', 'bash'],
  'linux-networking': ['linux', 'networking', 'tcp-ip', 'firewall'],

  'golang-basics': ['golang', 'go', 'programming'],
  'golang-microservices': ['golang', 'microservices', 'http', 'rest-api'],

  'python-basics': ['python', 'programming'],
  'python-advanced': ['python', 'oop', 'design-patterns'],
  'python-web-dev': ['python', 'flask', 'django', 'web-development'],

  'git-fundamentals': ['git', 'version-control', 'github'],
  'ci-cd-pipeline': ['ci-cd', 'devops', 'automation', 'jenkins', 'github-actions'],

  'sql-basics': ['sql', 'databases', 'queries'],
  'postgresql-advanced': ['postgresql', 'sql', 'database-admin'],
  'database-design': ['database-design', 'data-modeling', 'normalization'],
};

/**
 * Learning paths for different career goals
 */
export const LEARNING_PATHS: Record<string, {
  name: string;
  description: string;
  courses: string[];
  coreSkills: string[];
}> = {
  'devops-engineer': {
    name: 'DevOps Engineer',
    description: 'Master containers, orchestration, and CI/CD',
    courses: [
      'linux-fundamentals',
      'git-fundamentals',
      'docker-fundamentals',
      'docker-networking',
      'kubernetes-basics',
      'kubernetes-advanced',
      'ci-cd-pipeline'
    ],
    coreSkills: ['docker', 'kubernetes', 'linux', 'ci-cd', 'automation']
  },

  'backend-developer': {
    name: 'Backend Developer',
    description: 'Build robust server-side applications',
    courses: [
      'python-basics',
      'sql-basics',
      'python-web-dev',
      'database-design',
      'docker-fundamentals',
      'git-fundamentals'
    ],
    coreSkills: ['python', 'sql', 'web-development', 'rest-api', 'databases']
  },

  'go-developer': {
    name: 'Go Developer',
    description: 'Master Go for backend and cloud applications',
    courses: [
      'golang-basics',
      'sql-basics',
      'golang-microservices',
      'docker-fundamentals',
      'kubernetes-basics'
    ],
    coreSkills: ['golang', 'microservices', 'docker', 'rest-api']
  },

  'sysadmin': {
    name: 'System Administrator',
    description: 'Manage and maintain Linux servers',
    courses: [
      'linux-fundamentals',
      'linux-advanced',
      'linux-networking',
      'sql-basics',
      'docker-fundamentals'
    ],
    coreSkills: ['linux', 'shell-scripting', 'networking', 'system-admin']
  },

  'full-stack-developer': {
    name: 'Full Stack Developer',
    description: 'Build complete web applications',
    courses: [
      'python-basics',
      'sql-basics',
      'python-web-dev',
      'git-fundamentals',
      'docker-fundamentals'
    ],
    coreSkills: ['python', 'javascript', 'sql', 'web-development', 'rest-api']
  }
};

// ==========================================
// PUBLIC API
// ==========================================

/**
 * Get prerequisites for a specific course
 */
export async function getCoursePrerequisites(courseId: string): Promise<PrerequisiteMapping | null> {
  const course = await db
    .select()
    .from(courseDefinitions)
    .where(eq(courseDefinitions.id, courseId))
    .limit(1);

  if (course.length === 0) {
    return null;
  }

  const prereqs = await db
    .select()
    .from(coursePrerequisites)
    .where(eq(coursePrerequisites.courseId, courseId));

  const prerequisiteDetails = await Promise.all(
    prereqs.map(async (p) => {
      const prereqCourse = await db
        .select()
        .from(courseDefinitions)
        .where(eq(courseDefinitions.id, p.prerequisiteCourseId))
        .limit(1);

      return {
        courseId: p.prerequisiteCourseId,
        courseName: prereqCourse.length > 0 ? prereqCourse[0].title : p.prerequisiteCourseId,
        isRequired: p.isRequired || false,
        skillsRequired: (p.skillsRequired as Record<string, number>) || {}
      };
    })
  );

  return {
    courseId: course[0].id,
    courseName: course[0].title,
    prerequisites: prerequisiteDetails
  };
}

/**
 * Check if user meets prerequisites for a course
 */
export function meetsPrerequisites(
  courseId: string,
  userSkills: Record<string, number>
): { meets: boolean; missing: string[]; skillGaps: Record<string, { current: number; required: number }> } {
  const config = COURSE_PREREQUISITES_MAP[courseId];

  if (!config) {
    return { meets: true, missing: [], skillGaps: {} };
  }

  const missing: string[] = [];
  const skillGaps: Record<string, { current: number; required: number }> = {};

  // Check skill requirements
  if (config.skillsRequired) {
    for (const [skill, required] of Object.entries(config.skillsRequired)) {
      const current = userSkills[skill] || 0;
      if (current < required) {
        skillGaps[skill] = { current, required };
      }
    }
  }

  // Check required prerequisite courses
  if (config.prerequisites) {
    for (const prereqId of config.prerequisites) {
      const skills = COURSE_SKILL_TAGS[prereqId] || [];
      const hasCoreSkill = skills.some(skill => (userSkills[skill] || 0) >= 60);
      if (!hasCoreSkill) {
        missing.push(prereqId);
      }
    }
  }

  return {
    meets: missing.length === 0 && Object.keys(skillGaps).length === 0,
    missing,
    skillGaps
  };
}

/**
 * Get recommended learning path for a goal
 */
export function getLearningPath(goalId: string): typeof LEARNING_PATHS[keyof typeof LEARNING_PATHS] | null {
  return LEARNING_PATHS[goalId] || null;
}

/**
 * Get skill tags for a course
 */
export function getCourseSkills(courseId: string): string[] {
  return COURSE_SKILL_TAGS[courseId] || [];
}

/**
 * Initialize prerequisites in database (run once on setup)
 */
export async function initializePrerequisites(): Promise<void> {
  for (const [courseId, config] of Object.entries(COURSE_PREREQUISITES_MAP)) {
    // Add required prerequisites
    if (config.prerequisites) {
      for (const prereqId of config.prerequisites) {
        await db.insert(coursePrerequisites).values({
          courseId,
          prerequisiteCourseId: prereqId,
          isRequired: true,
          skillsRequired: config.skillsRequired || {}
        }).onConflictDoNothing();
      }
    }

    // Add recommended prerequisites
    if (config.recommended) {
      for (const prereqId of config.recommended) {
        await db.insert(coursePrerequisites).values({
          courseId,
          prerequisiteCourseId: prereqId,
          isRequired: false,
          skillsRequired: {}
        }).onConflictDoNothing();
      }
    }
  }
}

export default {
  getCoursePrerequisites,
  meetsPrerequisites,
  getLearningPath,
  getCourseSkills,
  initializePrerequisites,
  COURSE_PREREQUISITES_MAP,
  COURSE_SKILL_TAGS,
  LEARNING_PATHS
};
