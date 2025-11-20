import React, { useState, useEffect } from 'react';
import { NumericalQuestion, EquationBalanceQuestion, SequenceQuestion, MultiCorrectMCQ } from './ChemistryQuestionTypes';
import { CheckCircleIcon, XCircleIcon, BeakerIcon, ArrowRightIcon, ArrowLeftIcon } from '@heroicons/react/24/solid';

const ChemistryQuizViewer = ({ quizId }) => {
  const [quiz, setQuiz] = useState(null);
  const [questions, setQuestions] = useState([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [answers, setAnswers] = useState({});
  const [results, setResults] = useState({});
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [quizCompleted, setQuizCompleted] = useState(false);
  const [totalScore, setTotalScore] = useState(0);
  const [maxScore, setMaxScore] = useState(0);

  useEffect(() => {
    fetchQuizQuestions();
  }, [quizId]);

  const fetchQuizQuestions = async () => {
    try {
      setLoading(true);
      const response = await fetch(`/api/v1/chemistry/quizzes/${quizId}/questions`);
      const data = await response.json();

      if (data.success) {
        setQuiz(data.quiz);
        setQuestions(data.questions);
        setMaxScore(data.questions.reduce((sum, q) => sum + q.points, 0));
      } else {
        setError(data.error || 'Failed to load quiz');
      }
    } catch (err) {
      setError('Failed to fetch quiz questions');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleAnswer = async (answer) => {
    const currentQuestion = questions[currentQuestionIndex];

    // Store the answer
    setAnswers(prev => ({
      ...prev,
      [currentQuestion.id]: answer
    }));

    // Submit to backend for validation
    try {
      const response = await fetch(
        `/api/v1/chemistry/quizzes/${quizId}/questions/${currentQuestion.id}/submit`,
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ answer })
        }
      );

      const data = await response.json();

      if (data.success) {
        setResults(prev => ({
          ...prev,
          [currentQuestion.id]: {
            correct: data.correct,
            explanation: data.explanation,
            correctAnswer: data.correct_answer,
            pointsEarned: data.points_earned
          }
        }));

        if (data.correct) {
          setTotalScore(prev => prev + data.points_earned);
        }
      }
    } catch (err) {
      console.error('Failed to submit answer:', err);
    }
  };

  const goToNextQuestion = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
    } else {
      setQuizCompleted(true);
    }
  };

  const goToPreviousQuestion = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
    }
  };

  const renderQuestion = (question) => {
    const hasAnswered = answers[question.id] !== undefined;
    const result = results[question.id];
    const isCorrect = result?.correct || false;
    const disabled = hasAnswered;

    const commonProps = {
      question,
      onAnswer: handleAnswer,
      disabled,
      showResult: hasAnswered,
      isCorrect
    };

    switch (question.question_type) {
      case 'numerical':
        return <NumericalQuestion {...commonProps} />;
      case 'equation_balance':
        return <EquationBalanceQuestion {...commonProps} />;
      case 'sequence':
        return <SequenceQuestion {...commonProps} />;
      case 'mcq':
        if (question.multiple_correct) {
          return <MultiCorrectMCQ {...commonProps} />;
        } else {
          return <SingleMCQ {...commonProps} />;
        }
      case 'fill_blank':
        return <FillBlankQuestion {...commonProps} />;
      case 'true_false':
        return <TrueFalseQuestion {...commonProps} />;
      default:
        return <div className="text-gray-500">Unknown question type: {question.question_type}</div>;
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
        <div className="text-center">
          <BeakerIcon className="h-16 w-16 text-blue-600 mx-auto animate-pulse" />
          <p className="mt-4 text-lg text-gray-700">Loading quiz...</p>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex items-center justify-center min-h-screen bg-gradient-to-br from-red-50 to-pink-100">
        <div className="text-center">
          <XCircleIcon className="h-16 w-16 text-red-600 mx-auto" />
          <p className="mt-4 text-lg text-gray-700">{error}</p>
        </div>
      </div>
    );
  }

  if (quizCompleted) {
    const percentage = Math.round((totalScore / maxScore) * 100);
    const passed = percentage >= (quiz.passing_score || 70);

    return (
      <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-12 px-4">
        <div className="max-w-3xl mx-auto">
          <div className="bg-white rounded-2xl shadow-2xl p-8">
            <div className="text-center">
              {passed ? (
                <CheckCircleIcon className="h-24 w-24 text-green-500 mx-auto" />
              ) : (
                <XCircleIcon className="h-24 w-24 text-orange-500 mx-auto" />
              )}

              <h1 className="mt-6 text-3xl font-bold text-gray-900">
                {passed ? 'Congratulations!' : 'Quiz Completed'}
              </h1>

              <p className="mt-2 text-lg text-gray-600">
                {passed ? 'You passed the quiz!' : 'Keep practicing to improve your score'}
              </p>

              <div className="mt-8 grid grid-cols-3 gap-4">
                <div className="bg-blue-50 rounded-lg p-4">
                  <p className="text-sm text-gray-600">Score</p>
                  <p className="text-2xl font-bold text-blue-600">{totalScore}/{maxScore}</p>
                </div>
                <div className="bg-indigo-50 rounded-lg p-4">
                  <p className="text-sm text-gray-600">Percentage</p>
                  <p className="text-2xl font-bold text-indigo-600">{percentage}%</p>
                </div>
                <div className="bg-purple-50 rounded-lg p-4">
                  <p className="text-sm text-gray-600">Questions</p>
                  <p className="text-2xl font-bold text-purple-600">{questions.length}</p>
                </div>
              </div>

              <div className="mt-8 space-y-4">
                <h2 className="text-xl font-semibold text-gray-900">Question Summary</h2>
                {questions.map((question, index) => {
                  const result = results[question.id];
                  return (
                    <div
                      key={question.id}
                      className={`flex items-center justify-between p-4 rounded-lg border-2 ${
                        result?.correct ? 'border-green-300 bg-green-50' : 'border-red-300 bg-red-50'
                      }`}
                    >
                      <div className="flex items-center space-x-3">
                        {result?.correct ? (
                          <CheckCircleIcon className="h-6 w-6 text-green-500" />
                        ) : (
                          <XCircleIcon className="h-6 w-6 text-red-500" />
                        )}
                        <span className="text-gray-900">Question {index + 1}</span>
                      </div>
                      <span className="text-sm font-semibold text-gray-700">
                        {result?.pointsEarned || 0}/{question.points} pts
                      </span>
                    </div>
                  );
                })}
              </div>

              <button
                onClick={() => window.location.reload()}
                className="mt-8 px-8 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 font-semibold text-lg"
              >
                Retake Quiz
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  const currentQuestion = questions[currentQuestionIndex];
  const hasAnswered = answers[currentQuestion.id] !== undefined;
  const result = results[currentQuestion.id];
  const progress = ((currentQuestionIndex + 1) / questions.length) * 100;

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 py-8 px-4">
      <div className="max-w-4xl mx-auto">
        {/* Quiz Header */}
        <div className="bg-white rounded-t-2xl shadow-lg p-6 border-b-4 border-blue-600">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">{quiz.title}</h1>
              <p className="text-sm text-gray-600 mt-1">{quiz.description}</p>
            </div>
            <div className="text-right">
              <p className="text-sm text-gray-600">Question</p>
              <p className="text-2xl font-bold text-blue-600">
                {currentQuestionIndex + 1}/{questions.length}
              </p>
            </div>
          </div>

          {/* Progress Bar */}
          <div className="w-full bg-gray-200 rounded-full h-3">
            <div
              className="bg-blue-600 h-3 rounded-full transition-all duration-300"
              style={{ width: `${progress}%` }}
            />
          </div>
        </div>

        {/* Question Card */}
        <div className="bg-white shadow-lg p-8 mb-4">
          <div className="mb-4 flex items-center justify-between">
            <div className="flex items-center space-x-2">
              <span className="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm font-semibold">
                {currentQuestion.difficulty_level || 'Medium'}
              </span>
              <span className="px-3 py-1 bg-purple-100 text-purple-800 rounded-full text-sm font-semibold">
                {currentQuestion.points} points
              </span>
            </div>
          </div>

          {renderQuestion(currentQuestion)}

          {/* Result Display */}
          {hasAnswered && result && (
            <div className={`mt-6 p-4 rounded-lg border-2 ${
              result.correct ? 'border-green-500 bg-green-50' : 'border-red-500 bg-red-50'
            }`}>
              <div className="flex items-start space-x-3">
                {result.correct ? (
                  <CheckCircleIcon className="h-6 w-6 text-green-500 flex-shrink-0" />
                ) : (
                  <XCircleIcon className="h-6 w-6 text-red-500 flex-shrink-0" />
                )}
                <div className="flex-1">
                  <p className={`font-semibold ${result.correct ? 'text-green-900' : 'text-red-900'}`}>
                    {result.correct ? 'Correct!' : 'Incorrect'}
                  </p>
                  {result.explanation && (
                    <p className="mt-2 text-gray-700">{result.explanation}</p>
                  )}
                  {!result.correct && result.correctAnswer && (
                    <p className="mt-2 text-gray-700">
                      <span className="font-semibold">Correct answer:</span> {result.correctAnswer}
                    </p>
                  )}
                </div>
              </div>
            </div>
          )}
        </div>

        {/* Navigation */}
        <div className="bg-white rounded-b-2xl shadow-lg p-6 flex items-center justify-between">
          <button
            onClick={goToPreviousQuestion}
            disabled={currentQuestionIndex === 0}
            className="flex items-center space-x-2 px-6 py-3 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
          >
            <ArrowLeftIcon className="h-5 w-5" />
            <span>Previous</span>
          </button>

          <div className="text-center">
            <p className="text-sm text-gray-600">Current Score</p>
            <p className="text-xl font-bold text-blue-600">{totalScore}/{maxScore}</p>
          </div>

          <button
            onClick={goToNextQuestion}
            disabled={!hasAnswered}
            className="flex items-center space-x-2 px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
          >
            <span>{currentQuestionIndex === questions.length - 1 ? 'Finish' : 'Next'}</span>
            <ArrowRightIcon className="h-5 w-5" />
          </button>
        </div>
      </div>
    </div>
  );
};

// Simple MCQ Component (single correct answer)
const SingleMCQ = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [selectedOption, setSelectedOption] = useState(null);

  const handleSubmit = () => {
    if (selectedOption !== null && onAnswer) {
      onAnswer(selectedOption);
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <BeakerIcon className="h-6 w-6 text-blue-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Question diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className="space-y-2">
        {question.options?.map((option, index) => {
          const isSelected = selectedOption === index;
          const showCorrect = showResult && option.correct;
          const showWrong = showResult && isSelected && !option.correct;

          return (
            <button
              key={index}
              onClick={() => !disabled && setSelectedOption(index)}
              disabled={disabled}
              className={`w-full text-left p-4 rounded-lg border-2 transition ${
                showCorrect
                  ? 'border-green-500 bg-green-50'
                  : showWrong
                  ? 'border-red-500 bg-red-50'
                  : isSelected
                  ? 'border-blue-500 bg-blue-50'
                  : 'border-gray-200 hover:border-blue-300 bg-white'
              } ${disabled ? 'cursor-default' : 'cursor-pointer'}`}
            >
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-3 flex-1">
                  <div className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                    isSelected ? 'border-blue-500' : 'border-gray-300'
                  }`}>
                    {isSelected && <div className="w-3 h-3 rounded-full bg-blue-500" />}
                  </div>
                  <span className={`${
                    showCorrect ? 'text-green-900' : showWrong ? 'text-red-900' : 'text-gray-900'
                  }`}>
                    {option.text}
                  </span>
                </div>
                {showCorrect && <CheckCircleIcon className="h-6 w-6 text-green-500 flex-shrink-0" />}
                {showWrong && <XCircleIcon className="h-6 w-6 text-red-500 flex-shrink-0" />}
              </div>
            </button>
          );
        })}
      </div>

      {!disabled && (
        <button
          onClick={handleSubmit}
          disabled={selectedOption === null}
          className="w-full px-6 py-3 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
        >
          Submit Answer
        </button>
      )}
    </div>
  );
};

// Fill in the Blank Component
const FillBlankQuestion = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [answer, setAnswer] = useState('');

  const handleSubmit = () => {
    if (answer.trim() && onAnswer) {
      onAnswer(answer.trim());
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <BeakerIcon className="h-6 w-6 text-green-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Question diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className="flex items-center space-x-3">
        <input
          type="text"
          value={answer}
          onChange={(e) => setAnswer(e.target.value)}
          onKeyPress={(e) => e.key === 'Enter' && handleSubmit()}
          disabled={disabled}
          placeholder="Enter your answer..."
          className={`flex-1 px-4 py-3 text-lg border-2 rounded-lg focus:outline-none focus:ring-2 ${
            showResult
              ? isCorrect
                ? 'border-green-500 bg-green-50'
                : 'border-red-500 bg-red-50'
              : 'border-gray-300 focus:border-green-500 focus:ring-green-200'
          }`}
        />
        {!disabled && (
          <button
            onClick={handleSubmit}
            disabled={!answer.trim()}
            className="px-6 py-3 bg-green-600 text-white rounded-lg hover:bg-green-700 disabled:opacity-50 disabled:cursor-not-allowed font-semibold"
          >
            Submit
          </button>
        )}
      </div>
    </div>
  );
};

// True/False Component
const TrueFalseQuestion = ({ question, onAnswer, disabled, showResult, isCorrect }) => {
  const [answer, setAnswer] = useState(null);

  const handleSelect = (value) => {
    if (!disabled) {
      setAnswer(value);
      if (onAnswer) {
        onAnswer(value);
      }
    }
  };

  return (
    <div className="space-y-4">
      <div className="flex items-start space-x-3">
        <BeakerIcon className="h-6 w-6 text-indigo-600 flex-shrink-0 mt-1" />
        <div className="flex-1">
          <p className="text-lg text-gray-900">{question.question_text}</p>
          {question.image_url && (
            <img src={question.image_url} alt="Question diagram" className="mt-4 max-w-md rounded-lg border" />
          )}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4">
        {['true', 'false'].map((value) => {
          const isSelected = answer === value;
          const correctAnswer = question.correct_answer?.toLowerCase();
          const showCorrect = showResult && correctAnswer === value;
          const showWrong = showResult && isSelected && correctAnswer !== value;

          return (
            <button
              key={value}
              onClick={() => handleSelect(value)}
              disabled={disabled}
              className={`p-6 rounded-lg border-2 font-semibold text-lg transition ${
                showCorrect
                  ? 'border-green-500 bg-green-50 text-green-900'
                  : showWrong
                  ? 'border-red-500 bg-red-50 text-red-900'
                  : isSelected
                  ? 'border-indigo-500 bg-indigo-50 text-indigo-900'
                  : 'border-gray-200 hover:border-indigo-300 bg-white text-gray-900'
              } ${disabled ? 'cursor-default' : 'cursor-pointer'}`}
            >
              {value === 'true' ? 'True' : 'False'}
            </button>
          );
        })}
      </div>
    </div>
  );
};

export default ChemistryQuizViewer;
