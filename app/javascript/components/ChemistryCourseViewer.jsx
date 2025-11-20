import React, { useState, useEffect } from 'react';
import ChemistryQuizViewer from './ChemistryQuizViewer';
import {
  BeakerIcon,
  BookOpenIcon,
  AcademicCapIcon,
  ChevronRightIcon,
  ChevronDownIcon,
  PlayCircleIcon,
  CheckCircleIcon,
  ClockIcon
} from '@heroicons/react/24/solid';

const ChemistryCourseViewer = ({ courseSlug }) => {
  const [course, setCourse] = useState(null);
  const [modules, setModules] = useState([]);
  const [selectedModule, setSelectedModule] = useState(null);
  const [selectedLesson, setSelectedLesson] = useState(null);
  const [selectedQuiz, setSelectedQuiz] = useState(null);
  const [expandedModules, setExpandedModules] = useState(new Set());
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [view, setView] = useState('course'); // 'course', 'lesson', 'quiz', 'review'
  const [dueReviews, setDueReviews] = useState([]);
  const [reviewsLoading, setReviewsLoading] = useState(false);

  useEffect(() => {
    fetchCourse();
    fetchDueReviews();
  }, [courseSlug]);

  const fetchCourse = async () => {
    try {
      setLoading(true);
      const response = await fetch(`/api/v1/chemistry/courses/${courseSlug}`);
      const data = await response.json();

      if (data.success) {
        setCourse(data.course);
        setModules(data.course.modules || []);
      } else {
        setError(data.error || 'Failed to load course');
      }
    } catch (err) {
      setError('Failed to fetch course data');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const fetchDueReviews = async () => {
    try {
      setReviewsLoading(true);
      const response = await fetch('/reviews');
      const html = await response.text();

      // Parse the response to extract quiz question reviews count
      // Since /reviews returns HTML, we'll make a simple assumption
      // In production, you'd want a JSON API endpoint
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');

      // For now, we'll just set a placeholder
      // TODO: Create /api/v1/reviews endpoint that returns JSON
      setDueReviews([]);
    } catch (err) {
      console.error('Failed to fetch due reviews:', err);
      setDueReviews([]);
    } finally {
      setReviewsLoading(false);
    }
  };

  const fetchModuleDetails = async (moduleSlug) => {
    try {
      const response = await fetch(`/api/v1/chemistry/courses/${courseSlug}/modules/${moduleSlug}`);
      const data = await response.json();

      if (data.success) {
        setSelectedModule(data.module);
        setExpandedModules(prev => new Set([...prev, moduleSlug]));
      }
    } catch (err) {
      console.error('Failed to fetch module details:', err);
    }
  };

  const fetchLesson = async (lessonId) => {
    try {
      const response = await fetch(`/api/v1/chemistry/lessons/${lessonId}`);
      const data = await response.json();

      if (data.success) {
        setSelectedLesson(data.lesson);
        setView('lesson');
      }
    } catch (err) {
      console.error('Failed to fetch lesson:', err);
    }
  };

  const toggleModule = (moduleSlug) => {
    const newExpanded = new Set(expandedModules);
    if (newExpanded.has(moduleSlug)) {
      newExpanded.delete(moduleSlug);
    } else {
      newExpanded.add(moduleSlug);
      fetchModuleDetails(moduleSlug);
    }
    setExpandedModules(newExpanded);
  };

  const startQuiz = (quizId) => {
    setSelectedQuiz(quizId);
    setView('quiz');
  };

  const backToCourse = () => {
    setView('course');
    setSelectedLesson(null);
    setSelectedQuiz(null);
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
        <div className="text-center">
          <BeakerIcon className="h-16 w-16 text-blue-600 mx-auto animate-pulse" />
          <p className="mt-4 text-lg text-gray-700">Loading course...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-red-50 to-pink-100">
        <div className="text-center">
          <p className="text-lg text-red-700">{error}</p>
        </div>
      </div>
    );
  }

  // Render Quiz View
  if (view === 'quiz' && selectedQuiz) {
    return (
      <div>
        <button
          onClick={backToCourse}
          className="fixed top-4 left-4 z-50 px-4 py-2 bg-white text-gray-700 rounded-lg shadow-lg hover:bg-gray-100 font-semibold"
        >
          ← Back to Course
        </button>
        <ChemistryQuizViewer quizId={selectedQuiz} />
      </div>
    );
  }

  // Render Lesson View
  if (view === 'lesson' && selectedLesson) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8 px-4">
        <div className="max-w-4xl mx-auto">
          <button
            onClick={backToCourse}
            className="mb-6 px-4 py-2 bg-white text-gray-700 rounded-lg shadow hover:bg-gray-100 font-semibold"
          >
            ← Back to Course
          </button>

          <div className="bg-white rounded-2xl shadow-2xl overflow-hidden">
            {/* Lesson Header */}
            <div className="bg-gradient-to-r from-blue-600 to-indigo-700 p-8 text-white">
              <div className="flex items-center space-x-3 mb-4">
                <BookOpenIcon className="h-8 w-8" />
                <span className="text-sm font-semibold opacity-90">Lesson</span>
              </div>
              <h1 className="text-3xl font-bold mb-2">{selectedLesson.title}</h1>
              {selectedLesson.reading_time_minutes && (
                <div className="flex items-center space-x-2 text-blue-100">
                  <ClockIcon className="h-5 w-5" />
                  <span>{selectedLesson.reading_time_minutes} min read</span>
                </div>
              )}
            </div>

            {/* Lesson Content */}
            <div className="p-8">
              {selectedLesson.video_url && (
                <div className="mb-8">
                  <div className="aspect-w-16 aspect-h-9 bg-gray-900 rounded-lg overflow-hidden">
                    <iframe
                      src={selectedLesson.video_url}
                      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                      allowFullScreen
                      className="w-full h-full"
                    />
                  </div>
                </div>
              )}

              <div className="prose prose-lg max-w-none">
                <div dangerouslySetInnerHTML={{ __html: selectedLesson.content }} />
              </div>

              {selectedLesson.key_concepts && selectedLesson.key_concepts.length > 0 && (
                <div className="mt-8 p-6 bg-blue-50 rounded-xl border-2 border-blue-200">
                  <h3 className="text-xl font-bold text-blue-900 mb-4 flex items-center">
                    <AcademicCapIcon className="h-6 w-6 mr-2" />
                    Key Concepts
                  </h3>
                  <ul className="space-y-2">
                    {selectedLesson.key_concepts.map((concept, index) => (
                      <li key={index} className="flex items-start">
                        <CheckCircleIcon className="h-5 w-5 text-blue-600 mr-2 mt-0.5 flex-shrink-0" />
                        <span className="text-gray-700">{concept}</span>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              <div className="mt-8 flex justify-end">
                <button
                  onClick={backToCourse}
                  className="px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-semibold"
                >
                  Continue to Next Topic
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  // Render Course Overview
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Course Header */}
        <div className="bg-white rounded-2xl shadow-2xl overflow-hidden mb-8">
          <div className="bg-gradient-to-r from-blue-600 to-indigo-700 p-8 text-white">
            <div className="flex items-center space-x-4 mb-4">
              <BeakerIcon className="h-12 w-12" />
              <div>
                <h1 className="text-4xl font-bold">{course.title}</h1>
                <p className="text-blue-100 mt-2">{course.description}</p>
              </div>
            </div>

            <div className="mt-6 grid grid-cols-3 gap-4">
              <div className="bg-white bg-opacity-20 rounded-lg p-4">
                <p className="text-sm opacity-90">Difficulty</p>
                <p className="text-xl font-bold capitalize">{course.difficulty_level}</p>
              </div>
              <div className="bg-white bg-opacity-20 rounded-lg p-4">
                <p className="text-sm opacity-90">Duration</p>
                <p className="text-xl font-bold">{course.estimated_hours} hours</p>
              </div>
              <div className="bg-white bg-opacity-20 rounded-lg p-4">
                <p className="text-sm opacity-90">Modules</p>
                <p className="text-xl font-bold">{modules.length}</p>
              </div>
            </div>
          </div>

          {/* Learning Objectives */}
          {course.learning_objectives && course.learning_objectives.length > 0 && (
            <div className="p-8 border-b">
              <h2 className="text-2xl font-bold text-gray-900 mb-4 flex items-center">
                <AcademicCapIcon className="h-7 w-7 text-blue-600 mr-2" />
                Learning Objectives
              </h2>
              <ul className="grid grid-cols-2 gap-4">
                {course.learning_objectives.map((objective, index) => (
                  <li key={index} className="flex items-start">
                    <CheckCircleIcon className="h-5 w-5 text-green-500 mr-2 mt-0.5 flex-shrink-0" />
                    <span className="text-gray-700">{objective}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}

          {/* Prerequisites */}
          {course.prerequisites && course.prerequisites.length > 0 && (
            <div className="p-8 bg-yellow-50">
              <h2 className="text-xl font-bold text-gray-900 mb-3">Prerequisites</h2>
              <ul className="space-y-2">
                {course.prerequisites.map((prereq, index) => (
                  <li key={index} className="flex items-start">
                    <span className="text-yellow-600 mr-2">•</span>
                    <span className="text-gray-700">{prereq}</span>
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>

        {/* Daily Formula Review Banner */}
        {!reviewsLoading && dueReviews.length > 0 && (
          <div className="bg-gradient-to-r from-yellow-50 to-orange-50 border-2 border-yellow-400 rounded-2xl shadow-lg p-6 mb-8">
            <div className="flex items-start justify-between">
              <div className="flex items-start space-x-4 flex-1">
                <div className="bg-yellow-400 rounded-full p-3">
                  <BeakerIcon className="h-8 w-8 text-yellow-900" />
                </div>
                <div className="flex-1">
                  <h3 className="text-2xl font-bold text-yellow-900 mb-2">
                    📅 Daily Formula Review
                  </h3>
                  <p className="text-yellow-800 text-lg mb-1">
                    You have <span className="font-bold text-2xl text-yellow-900">{dueReviews.length}</span> formulas due for review today!
                  </p>
                  <p className="text-yellow-700 text-sm">
                    Review them now to maintain your mastery and prevent forgetting
                  </p>
                </div>
              </div>
              <button
                onClick={() => window.location.href = '/reviews'}
                className="px-6 py-3 bg-yellow-600 text-white rounded-lg hover:bg-yellow-700 font-semibold shadow-md hover:shadow-lg transition flex items-center space-x-2"
              >
                <span>Start Review</span>
                <ChevronRightIcon className="h-5 w-5" />
              </button>
            </div>

            <div className="mt-4 grid grid-cols-3 gap-3">
              <div className="bg-white bg-opacity-70 rounded-lg p-3">
                <p className="text-xs text-gray-600">Today's Reviews</p>
                <p className="text-xl font-bold text-gray-900">{dueReviews.length}</p>
              </div>
              <div className="bg-white bg-opacity-70 rounded-lg p-3">
                <p className="text-xs text-gray-600">Avg. Time</p>
                <p className="text-xl font-bold text-gray-900">~{dueReviews.length * 2} min</p>
              </div>
              <div className="bg-white bg-opacity-70 rounded-lg p-3">
                <p className="text-xs text-gray-600">Streak</p>
                <p className="text-xl font-bold text-gray-900">🔥 0 days</p>
              </div>
            </div>
          </div>
        )}

        {/* Formula Drill Info Banner */}
        <div className="bg-gradient-to-r from-blue-50 to-indigo-50 border-2 border-blue-300 rounded-2xl shadow-lg p-6 mb-8">
          <div className="flex items-start space-x-4">
            <div className="bg-blue-400 rounded-full p-3">
              <AcademicCapIcon className="h-8 w-8 text-blue-900" />
            </div>
            <div className="flex-1">
              <h3 className="text-xl font-bold text-blue-900 mb-2">
                💡 Master 147 Essential IIT JEE Formulas
              </h3>
              <p className="text-blue-800 mb-3">
                Our Formula Drill system uses <span className="font-semibold">spaced repetition (FSRS)</span> to help you remember formulas long-term
              </p>
              <div className="flex items-center space-x-2 text-sm text-blue-700">
                <CheckCircleIcon className="h-5 w-5 text-green-600" />
                <span>Take quizzes → Failed formulas automatically added to daily review → Never forget again!</span>
              </div>
            </div>
          </div>
        </div>

        {/* Course Modules */}
        <div className="space-y-4">
          <h2 className="text-2xl font-bold text-gray-900 mb-4">Course Content</h2>

          {modules.map((module, moduleIndex) => (
            <div key={module.id} className="bg-white rounded-xl shadow-lg overflow-hidden">
              {/* Module Header */}
              <button
                onClick={() => toggleModule(module.slug)}
                className="w-full p-6 flex items-center justify-between hover:bg-gray-50 transition"
              >
                <div className="flex items-center space-x-4 flex-1">
                  <div className="bg-blue-100 rounded-lg p-3">
                    <span className="text-2xl font-bold text-blue-600">
                      {moduleIndex + 1}
                    </span>
                  </div>
                  <div className="text-left">
                    <h3 className="text-xl font-bold text-gray-900">{module.title}</h3>
                    <p className="text-sm text-gray-600 mt-1">{module.description}</p>
                    {module.duration_minutes && (
                      <div className="flex items-center space-x-2 mt-2 text-sm text-gray-500">
                        <ClockIcon className="h-4 w-4" />
                        <span>{module.duration_minutes} minutes</span>
                      </div>
                    )}
                  </div>
                </div>
                {expandedModules.has(module.slug) ? (
                  <ChevronDownIcon className="h-6 w-6 text-gray-400" />
                ) : (
                  <ChevronRightIcon className="h-6 w-6 text-gray-400" />
                )}
              </button>

              {/* Module Items (Lessons & Quizzes) */}
              {expandedModules.has(module.slug) && selectedModule && selectedModule.slug === module.slug && (
                <div className="border-t bg-gray-50 p-6">
                  <div className="space-y-3">
                    {selectedModule.items?.map((item, itemIndex) => (
                      <ModuleItem
                        key={item.id}
                        item={item}
                        itemIndex={itemIndex}
                        onLessonClick={fetchLesson}
                        onQuizClick={startQuiz}
                      />
                    ))}
                  </div>
                </div>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

// Module Item Component (Lesson or Quiz)
const ModuleItem = ({ item, itemIndex, onLessonClick, onQuizClick }) => {
  const isLesson = item.item_type === 'CourseLesson';
  const isQuiz = item.item_type === 'Quiz';

  const handleClick = () => {
    if (isLesson) {
      onLessonClick(item.item_id);
    } else if (isQuiz) {
      onQuizClick(item.item_id);
    }
  };

  return (
    <button
      onClick={handleClick}
      className="w-full flex items-center justify-between p-4 bg-white rounded-lg hover:shadow-md transition border border-gray-200 hover:border-blue-300"
    >
      <div className="flex items-center space-x-4">
        <div className="flex-shrink-0">
          {isLesson ? (
            <BookOpenIcon className="h-6 w-6 text-blue-600" />
          ) : (
            <AcademicCapIcon className="h-6 w-6 text-purple-600" />
          )}
        </div>
        <div className="text-left">
          <p className="font-semibold text-gray-900">{item.title}</p>
          {item.description && (
            <p className="text-sm text-gray-600 mt-1">{item.description}</p>
          )}
          {item.reading_time_minutes && (
            <div className="flex items-center space-x-2 mt-1 text-xs text-gray-500">
              <ClockIcon className="h-3 w-3" />
              <span>{item.reading_time_minutes} min</span>
            </div>
          )}
        </div>
      </div>
      <div className="flex items-center space-x-2">
        {isQuiz && item.question_count && (
          <span className="text-sm text-gray-600">{item.question_count} questions</span>
        )}
        <PlayCircleIcon className="h-5 w-5 text-gray-400" />
      </div>
    </button>
  );
};

export default ChemistryCourseViewer;
