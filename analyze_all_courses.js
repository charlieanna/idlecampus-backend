const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

// Results
const results = {
  mainCourses: {},
  convertedCourses: {},
  summary: {
    totalCourses: 0,
    totalMicrolessons: 0,
    exerciseTypeCounts: {},
    coursesWithTerminal: [],
    coursesWithoutTerminal: [],
    commandBasedCoursesWithoutTerminal: [],
    coursesNeedingMCQs: []
  }
};

// Command-based courses that should have terminal exercises
const commandBasedKeywords = ['docker', 'kubernetes', 'linux', 'bash', 'git', 'cli', 'command', 'shell', 'aws', 'terminal'];

function analyzeMicrolesson(filePath) {
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
        slug: exercise.slug
      });

      analysis.exerciseCounts[type] = (analysis.exerciseCounts[type] || 0) + 1;
    });

    return analysis;
  } catch (error) {
    return null;
  }
}

function scanCourse(courseDir, courseName) {
  const microlessonsDir = path.join(courseDir, 'microlessons');

  if (!fs.existsSync(microlessonsDir)) {
    return null;
  }

  const courseData = {
    name: courseName,
    microlessons: [],
    totalExercises: 0,
    exerciseTypes: {},
    avgExercisesPerLesson: 0,
    isCommandBased: false
  };

  // Check if it's a command-based course
  courseData.isCommandBased = commandBasedKeywords.some(keyword =>
    courseName.toLowerCase().includes(keyword)
  );

  try {
    const files = fs.readdirSync(microlessonsDir);
    const ymlFiles = files.filter(f => f.endsWith('.yml') || f.endsWith('.yaml'));

    ymlFiles.forEach(file => {
      const filePath = path.join(microlessonsDir, file);
      const analysis = analyzeMicrolesson(filePath);

      if (analysis) {
        courseData.microlessons.push(analysis);

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
    return null;
  }
}

// Scan main courses
console.log('Scanning main courses...');
const mainCoursesDir = './db/seeds';
const mainDirs = fs.readdirSync(mainCoursesDir).filter(d => {
  const fullPath = path.join(mainCoursesDir, d);
  return fs.statSync(fullPath).isDirectory() && d !== 'converted_microlessons';
});

mainDirs.forEach(dir => {
  const courseData = scanCourse(path.join(mainCoursesDir, dir), dir);
  if (courseData && courseData.microlessons.length > 0) {
    results.mainCourses[dir] = courseData;
  }
});

// Scan converted courses
console.log('Scanning converted courses...');
const convertedCoursesDir = './db/seeds/converted_microlessons';
if (fs.existsSync(convertedCoursesDir)) {
  const convertedDirs = fs.readdirSync(convertedCoursesDir);

  convertedDirs.forEach(dir => {
    const courseData = scanCourse(path.join(convertedCoursesDir, dir), dir);
    if (courseData && courseData.microlessons.length > 0) {
      results.convertedCourses[dir] = courseData;
    }
  });
}

// Aggregate statistics
const allCourses = { ...results.mainCourses, ...results.convertedCourses };

Object.entries(allCourses).forEach(([courseName, data]) => {
  results.summary.totalCourses++;
  results.summary.totalMicrolessons += data.microlessons.length;

  Object.entries(data.exerciseTypes).forEach(([type, count]) => {
    results.summary.exerciseTypeCounts[type] = (results.summary.exerciseTypeCounts[type] || 0) + count;
  });

  if (data.exerciseTypes.terminal) {
    results.summary.coursesWithTerminal.push(courseName);
  } else {
    results.summary.coursesWithoutTerminal.push(courseName);

    if (data.isCommandBased) {
      results.summary.commandBasedCoursesWithoutTerminal.push(courseName);
    }
  }

  if (!data.exerciseTypes.mcq || data.exerciseTypes.mcq < data.microlessons.length) {
    results.summary.coursesNeedingMCQs.push({
      name: courseName,
      mcqs: data.exerciseTypes.mcq || 0,
      lessons: data.microlessons.length
    });
  }
});

// Generate report
console.log('\n' + '='.repeat(80));
console.log('COMPREHENSIVE COURSE EXERCISE ANALYSIS');
console.log('='.repeat(80));
console.log();

console.log(`Total Courses: ${results.summary.totalCourses}`);
console.log(`  - Main Courses: ${Object.keys(results.mainCourses).length}`);
console.log(`  - Converted Courses: ${Object.keys(results.convertedCourses).length}`);
console.log(`Total Microlessons: ${results.summary.totalMicrolessons}`);
console.log();

console.log('EXERCISE TYPE DISTRIBUTION:');
console.log('-'.repeat(80));
Object.entries(results.summary.exerciseTypeCounts)
  .sort((a, b) => b[1] - a[1])
  .forEach(([type, count]) => {
    console.log(`  ${type.padEnd(20)}: ${count.toString().padStart(5)}`);
  });
console.log();

console.log('TERMINAL/COMMAND EXERCISES:');
console.log('-'.repeat(80));
console.log(`Courses WITH terminal exercises: ${results.summary.coursesWithTerminal.length}`);
console.log(`Courses WITHOUT terminal exercises: ${results.summary.coursesWithoutTerminal.length}`);
console.log();

console.log('⚠️  COMMAND-BASED COURSES WITHOUT TERMINAL EXERCISES:');
console.log('-'.repeat(80));
if (results.summary.commandBasedCoursesWithoutTerminal.length === 0) {
  console.log('  ✓ All command-based courses have terminal exercises!');
} else {
  results.summary.commandBasedCoursesWithoutTerminal.forEach(course => {
    console.log(`  ❌ ${course}`);
  });
}
console.log();

console.log('DETAILED BREAKDOWN - MAIN COURSES:');
console.log('='.repeat(80));

Object.entries(results.mainCourses)
  .sort((a, b) => b[1].totalExercises - a[1].totalExercises)
  .forEach(([courseName, data]) => {
    console.log(`\n${courseName}:`);
    console.log(`  Microlessons: ${data.microlessons.length}`);
    console.log(`  Total Exercises: ${data.totalExercises} (avg ${data.avgExercisesPerLesson} per lesson)`);
    console.log(`  Exercise Types: ${Object.entries(data.exerciseTypes).map(([type, count]) => `${type}(${count})`).join(', ')}`);

    if (data.isCommandBased) {
      if (!data.exerciseTypes.terminal) {
        console.log(`  ❌ NEEDS: Terminal/command exercises`);
      } else {
        const ratio = (data.exerciseTypes.terminal / data.microlessons.length).toFixed(2);
        console.log(`  ✓ Terminal exercises: ${data.exerciseTypes.terminal} (${ratio} per lesson)`);
      }
    }
  });

console.log('\n\nDETAILED BREAKDOWN - CONVERTED COURSES (showing top 20):');
console.log('='.repeat(80));

Object.entries(results.convertedCourses)
  .sort((a, b) => b[1].totalExercises - a[1].totalExercises)
  .slice(0, 20)
  .forEach(([courseName, data]) => {
    console.log(`\n${courseName}:`);
    console.log(`  Microlessons: ${data.microlessons.length}`);
    console.log(`  Total Exercises: ${data.totalExercises} (avg ${data.avgExercisesPerLesson} per lesson)`);
    console.log(`  Exercise Types: ${Object.entries(data.exerciseTypes).map(([type, count]) => `${type}(${count})`).join(', ')}`);

    if (data.isCommandBased) {
      if (!data.exerciseTypes.terminal) {
        console.log(`  ❌ NEEDS: Terminal/command exercises`);
      } else {
        const ratio = (data.exerciseTypes.terminal / data.microlessons.length).toFixed(2);
        console.log(`  ✓ Terminal exercises: ${data.exerciseTypes.terminal} (${ratio} per lesson)`);
      }
    }
  });

console.log('\n\n' + '='.repeat(80));
console.log('KEY RECOMMENDATIONS:');
console.log('='.repeat(80));

console.log('\n1. COMMAND-BASED COURSES NEEDING TERMINAL EXERCISES:');
if (results.summary.commandBasedCoursesWithoutTerminal.length === 0) {
  console.log('   ✓ All command-based courses already have terminal exercises!');
} else {
  results.summary.commandBasedCoursesWithoutTerminal.forEach(course => {
    const data = allCourses[course];
    console.log(`   ❌ ${course} (${data.microlessons.length} lessons, 0 terminal exercises)`);
  });
}

console.log('\n2. COURSES NEEDING MORE MCQs (showing top 10):');
results.summary.coursesNeedingMCQs
  .sort((a, b) => (b.lessons - b.mcqs) - (a.lessons - a.mcqs))
  .slice(0, 10)
  .forEach(item => {
    console.log(`   ⚠️  ${item.name}: ${item.mcqs} MCQs for ${item.lessons} lessons (need ${item.lessons - item.mcqs} more)`);
  });

console.log('\n3. EXERCISE COVERAGE SUMMARY:');
console.log(`   - Courses with reflection: ${Object.values(allCourses).filter(c => c.exerciseTypes.reflection).length}/${results.summary.totalCourses}`);
console.log(`   - Courses with checkpoint: ${Object.values(allCourses).filter(c => c.exerciseTypes.checkpoint).length}/${results.summary.totalCourses}`);
console.log(`   - Courses with MCQ: ${Object.values(allCourses).filter(c => c.exerciseTypes.mcq).length}/${results.summary.totalCourses}`);
console.log(`   - Courses with terminal: ${results.summary.coursesWithTerminal.length}/${results.summary.totalCourses}`);

// Save detailed report
fs.writeFileSync('./complete-course-analysis.json', JSON.stringify(results, null, 2));
console.log('\n\nDetailed JSON report saved to: complete-course-analysis.json');
