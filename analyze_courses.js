const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

// Directories to scan
const seedsDir = './db/seeds';

// Results object
const results = {
  courses: {},
  summary: {
    totalCourses: 0,
    totalMicrolessons: 0,
    exerciseTypeCounts: {},
    coursesWithTerminal: [],
    coursesWithReflection: [],
    coursesWithCheckpoint: [],
    coursesWithMCQ: []
  }
};

function analyzeMicrolesson(filePath, courseName) {
  try {
    const content = fs.readFileSync(filePath, 'utf8');
    const data = yaml.load(content);

    if (!data || !data.exercises) return null;

    const analysis = {
      slug: data.slug,
      title: data.title,
      exercises: [],
      exerciseCounts: {}
    };

    data.exercises.forEach(exercise => {
      const type = exercise.type;
      analysis.exercises.push({
        type: type,
        slug: exercise.slug,
        hasValidation: !!exercise.validation,
        requirePass: exercise.require_pass || false
      });

      analysis.exerciseCounts[type] = (analysis.exerciseCounts[type] || 0) + 1;
    });

    return analysis;
  } catch (error) {
    console.error(`Error processing ${filePath}: ${error.message}`);
    return null;
  }
}

function scanCourseDirectory(courseDir, courseName) {
  const microlessonsDir = path.join(courseDir, 'microlessons');

  if (!fs.existsSync(microlessonsDir)) {
    return null;
  }

  const courseData = {
    name: courseName,
    path: courseDir,
    microlessons: [],
    totalExercises: 0,
    exerciseTypes: {},
    avgExercisesPerLesson: 0
  };

  try {
    const files = fs.readdirSync(microlessonsDir);
    const ymlFiles = files.filter(f => f.endsWith('.yml') || f.endsWith('.yaml'));

    ymlFiles.forEach(file => {
      const filePath = path.join(microlessonsDir, file);
      const analysis = analyzeMicrolesson(filePath, courseName);

      if (analysis) {
        courseData.microlessons.push(analysis);

        // Aggregate exercise types
        Object.entries(analysis.exerciseCounts).forEach(([type, count]) => {
          courseData.exerciseTypes[type] = (courseData.exerciseTypes[type] || 0) + count;
          courseData.totalExercises += count;
        });
      }
    });

    courseData.avgExercisesPerLesson = courseData.microlessons.length > 0
      ? (courseData.totalExercises / courseData.microlessons.length).toFixed(2)
      : 0;

    return courseData;
  } catch (error) {
    console.error(`Error scanning ${microlessonsDir}: ${error.message}`);
    return null;
  }
}

// Main scan
console.log('Scanning courses...\n');

// Get all course directories
const allDirs = fs.readdirSync(seedsDir);

allDirs.forEach(dir => {
  const fullPath = path.join(seedsDir, dir);
  const stat = fs.statSync(fullPath);

  if (stat.isDirectory()) {
    const courseData = scanCourseDirectory(fullPath, dir);

    if (courseData && courseData.microlessons.length > 0) {
      results.courses[dir] = courseData;
      results.summary.totalCourses++;
      results.summary.totalMicrolessons += courseData.microlessons.length;

      // Track which courses have which exercise types
      if (courseData.exerciseTypes.terminal) {
        results.summary.coursesWithTerminal.push(dir);
      }
      if (courseData.exerciseTypes.reflection) {
        results.summary.coursesWithReflection.push(dir);
      }
      if (courseData.exerciseTypes.checkpoint) {
        results.summary.coursesWithCheckpoint.push(dir);
      }
      if (courseData.exerciseTypes.mcq) {
        results.summary.coursesWithMCQ.push(dir);
      }

      // Aggregate exercise type counts
      Object.entries(courseData.exerciseTypes).forEach(([type, count]) => {
        results.summary.exerciseTypeCounts[type] = (results.summary.exerciseTypeCounts[type] || 0) + count;
      });
    }
  }
});

// Generate report
console.log('='.repeat(80));
console.log('COURSE EXERCISE ANALYSIS REPORT');
console.log('='.repeat(80));
console.log();

console.log(`Total Courses: ${results.summary.totalCourses}`);
console.log(`Total Microlessons: ${results.summary.totalMicrolessons}`);
console.log();

console.log('EXERCISE TYPE DISTRIBUTION:');
console.log('-'.repeat(80));
Object.entries(results.summary.exerciseTypeCounts).sort((a, b) => b[1] - a[1]).forEach(([type, count]) => {
  console.log(`  ${type.padEnd(20)}: ${count}`);
});
console.log();

console.log('COURSES BY FEATURE:');
console.log('-'.repeat(80));
console.log(`\nCourses with TERMINAL exercises (${results.summary.coursesWithTerminal.length}):`);
results.summary.coursesWithTerminal.forEach(course => {
  const data = results.courses[course];
  console.log(`  - ${course} (${data.exerciseTypes.terminal} terminal exercises)`);
});

console.log(`\nCourses with REFLECTION exercises (${results.summary.coursesWithReflection.length}):`);
results.summary.coursesWithReflection.slice(0, 10).forEach(course => {
  console.log(`  - ${course}`);
});
if (results.summary.coursesWithReflection.length > 10) {
  console.log(`  ... and ${results.summary.coursesWithReflection.length - 10} more`);
}

console.log(`\nCourses with CHECKPOINT exercises (${results.summary.coursesWithCheckpoint.length}):`);
results.summary.coursesWithCheckpoint.slice(0, 10).forEach(course => {
  console.log(`  - ${course}`);
});
if (results.summary.coursesWithCheckpoint.length > 10) {
  console.log(`  ... and ${results.summary.coursesWithCheckpoint.length - 10} more`);
}

console.log();
console.log('DETAILED COURSE BREAKDOWN:');
console.log('='.repeat(80));

// Identify command-based courses (should have terminal exercises)
const commandBasedCourses = ['docker', 'kubernetes', 'linux', 'bash', 'networking', 'security', 'git'];

Object.entries(results.courses).sort((a, b) => b[1].totalExercises - a[1].totalExercises).forEach(([courseName, data]) => {
  console.log();
  console.log(`Course: ${courseName}`);
  console.log(`  Microlessons: ${data.microlessons.length}`);
  console.log(`  Total Exercises: ${data.totalExercises}`);
  console.log(`  Avg Exercises/Lesson: ${data.avgExercisesPerLesson}`);
  console.log(`  Exercise Types:`);

  Object.entries(data.exerciseTypes).sort((a, b) => b[1] - a[1]).forEach(([type, count]) => {
    console.log(`    - ${type}: ${count}`);
  });

  // Check if command-based course has terminal exercises
  const isCommandBased = commandBasedCourses.some(keyword => courseName.toLowerCase().includes(keyword));
  if (isCommandBased) {
    if (!data.exerciseTypes.terminal || data.exerciseTypes.terminal === 0) {
      console.log(`  ⚠️  WARNING: Command-based course but NO terminal exercises!`);
    } else {
      const ratio = (data.exerciseTypes.terminal / data.microlessons.length).toFixed(2);
      console.log(`  ✓ Terminal exercises: ${data.exerciseTypes.terminal} (${ratio} per lesson)`);
    }
  }

  // Check for MCQ presence
  if (!data.exerciseTypes.mcq || data.exerciseTypes.mcq === 0) {
    console.log(`  ⚠️  WARNING: No MCQ exercises!`);
  }
});

console.log();
console.log('='.repeat(80));
console.log('RECOMMENDATIONS:');
console.log('='.repeat(80));

// Find courses that need more exercises
Object.entries(results.courses).forEach(([courseName, data]) => {
  const isCommandBased = commandBasedCourses.some(keyword => courseName.toLowerCase().includes(keyword));

  if (isCommandBased && (!data.exerciseTypes.terminal || data.exerciseTypes.terminal === 0)) {
    console.log(`\n❌ ${courseName}:`);
    console.log(`   - Add TERMINAL/command practice exercises`);
    console.log(`   - Current: ${data.totalExercises} exercises, but 0 terminal`);
  }

  if (!data.exerciseTypes.mcq || data.exerciseTypes.mcq < data.microlessons.length) {
    console.log(`\n⚠️  ${courseName}:`);
    console.log(`   - Add more MCQ exercises`);
    console.log(`   - Current: ${data.exerciseTypes.mcq || 0} MCQs for ${data.microlessons.length} lessons`);
  }
});

// Save to JSON
fs.writeFileSync('./course-analysis-report.json', JSON.stringify(results, null, 2));
console.log('\n\nDetailed report saved to: course-analysis-report.json');
