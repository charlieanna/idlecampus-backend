import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import * as LucideIcons from 'lucide-react';
import { Quiz } from '../types';
import ReactMarkdown from 'react-markdown';

interface QuizViewerProps {
  quiz: Quiz;
  onQuizComplete: (score: number) => void;
}

export default function QuizViewer({ quiz, onQuizComplete }: QuizViewerProps) {
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [selectedAnswers, setSelectedAnswers] = useState<Record<number, string | string[]>>({});
  const [showFeedback, setShowFeedback] = useState(false);
  const [quizCompleted, setQuizCompleted] = useState(false);

  const currentQuestion = quiz.questions && quiz.questions[currentQuestionIndex];
  const progress = quiz.questions ? ((currentQuestionIndex + 1) / quiz.questions.length) * 100 : 0;

  const handleAnswerSelect = (answer: string) => {
    if (showFeedback) return; // Don't allow changes after submission

    if (currentQuestion?.type === 'multiple-select') {
      const current = (selectedAnswers[currentQuestionIndex] as string[]) || [];
      const updated = current.includes(answer)
        ? current.filter((a) => a !== answer)
        : [...current, answer];
      setSelectedAnswers({ ...selectedAnswers, [currentQuestionIndex]: updated });
    } else {
      setSelectedAnswers({ ...selectedAnswers, [currentQuestionIndex]: answer });
    }
  };

  const handleSubmitAnswer = () => {
    setShowFeedback(true);
  };

  const handleNextQuestion = () => {
    if (quiz.questions && currentQuestionIndex < quiz.questions.length - 1) {
      setCurrentQuestionIndex(currentQuestionIndex + 1);
      setShowFeedback(false);
    } else {
      // Quiz completed
      const score = calculateScore();
      setQuizCompleted(true);
      onQuizComplete(score);
    }
  };

  const calculateScore = (): number => {
    if (!quiz.questions) return 0;

    let correct = 0;
    quiz.questions.forEach((q, idx) => {
      const userAnswer = selectedAnswers[idx];
      if (q.type === 'multiple-select') {
        const correctAnswers = q.options?.filter((opt) => opt.correct).map((opt) => opt.text) || [];
        const userAnswers = (userAnswer as string[]) || [];
        if (
          correctAnswers.length === userAnswers.length &&
          correctAnswers.every((ans) => userAnswers.includes(ans))
        ) {
          correct++;
        }
      } else {
        const correctAnswer = q.options?.find((opt) => opt.correct)?.text;
        if (userAnswer === correctAnswer) {
          correct++;
        }
      }
    });

    return Math.round((correct / quiz.questions.length) * 100);
  };

  const isAnswerCorrect = (): boolean => {
    if (!currentQuestion) return false;

    const userAnswer = selectedAnswers[currentQuestionIndex];

    if (currentQuestion.type === 'multiple-select') {
      const correctAnswers = currentQuestion.options?.filter((opt) => opt.correct).map((opt) => opt.text) || [];
      const userAnswers = (userAnswer as string[]) || [];
      return (
        correctAnswers.length === userAnswers.length &&
        correctAnswers.every((ans) => userAnswers.includes(ans))
      );
    } else {
      const correctAnswer = currentQuestion.options?.find((opt) => opt.correct)?.text;
      return userAnswer === correctAnswer;
    }
  };

  if (!currentQuestion && !quizCompleted) {
    return (
      <div className="h-full flex items-center justify-center bg-white">
        <div className="text-center">
          <LucideIcons.AlertCircle className="w-16 h-16 text-gray-400 mx-auto mb-4" />
          <p className="text-gray-600">No questions available</p>
        </div>
      </div>
    );
  }

  if (quizCompleted) {
    const score = calculateScore();

    return (
      <motion.div
        initial={{ opacity: 0, scale: 0.9 }}
        animate={{ opacity: 1, scale: 1 }}
        className="h-full flex items-center justify-center bg-gradient-to-br from-green-50 to-blue-50 p-6"
      >
        <div className="max-w-2xl w-full bg-white rounded-lg shadow-lg p-8 text-center">
          <motion.div
            animate={{ rotate: score >= 80 ? 360 : 0 }}
            transition={{ duration: 1 }}
          >
            {score >= 80 ? (
              <LucideIcons.Trophy className="w-20 h-20 text-yellow-500 mx-auto mb-4" />
            ) : score >= 60 ? (
              <LucideIcons.Award className="w-20 h-20 text-blue-500 mx-auto mb-4" />
            ) : (
              <LucideIcons.Target className="w-20 h-20 text-gray-500 mx-auto mb-4" />
            )}
          </motion.div>

          <h2 className="text-3xl font-bold text-gray-900 mb-2">Quiz Complete!</h2>
          <p className="text-gray-600 mb-6">You've finished all questions.</p>

          <div className="mb-6">
            <div className="text-6xl font-bold text-blue-600 mb-2">{score}%</div>
            <p className="text-gray-600">
              {quiz.questions && `${Math.round((score / 100) * quiz.questions.length)} out of ${quiz.questions.length} correct`}
            </p>
          </div>

          {score >= 80 ? (
            <p className="text-green-700 font-semibold">
              Excellent work! You've mastered this topic. 🎉
            </p>
          ) : score >= 60 ? (
            <p className="text-blue-700 font-semibold">
              Good job! You're making great progress. 👍
            </p>
          ) : (
            <p className="text-orange-700 font-semibold">
              Keep practicing! Review the material and try again. 💪
            </p>
          )}
        </div>
      </motion.div>
    );
  }

  const isAnswered = !!selectedAnswers[currentQuestionIndex];
  const correctAnswer = isAnswerCorrect();

  return (
    <div className="h-full overflow-y-auto bg-white">
      {/* Quiz Header */}
      <div className="sticky top-0 bg-white border-b border-gray-200 p-6 z-10 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <div>
            <span className="px-3 py-1 bg-blue-100 text-blue-700 text-xs font-semibold rounded-full uppercase">
              Quiz
            </span>
            <h1 className="text-2xl font-bold text-gray-900 mt-2">{quiz.title}</h1>
          </div>

          <div className="text-right">
            <div className="text-sm text-gray-600 mb-1">
              Question {currentQuestionIndex + 1} of {quiz.questions?.length || 0}
            </div>
            <div className="text-2xl font-bold text-blue-600">
              {Math.round(progress)}%
            </div>
          </div>
        </div>

        {/* Progress Bar */}
        <div className="w-full bg-gray-200 rounded-full h-2 overflow-hidden">
          <motion.div
            initial={{ width: 0 }}
            animate={{ width: `${progress}%` }}
            transition={{ duration: 0.3 }}
            className="h-full bg-blue-600 rounded-full"
          />
        </div>
      </div>

      {/* Question Content */}
      <div className="p-6 max-w-3xl mx-auto">
        <AnimatePresence mode="wait">
          <motion.div
            key={currentQuestionIndex}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.3 }}
          >
            {/* Question */}
            <div className="mb-6">
              <h2 className="text-xl font-semibold text-gray-900 mb-4">
                {currentQuestion.question}
              </h2>

              {currentQuestion.type === 'multiple-select' && (
                <p className="text-sm text-gray-600 mb-4">
                  <LucideIcons.Info className="w-4 h-4 inline mr-1" />
                  Select all correct answers
                </p>
              )}

              {currentQuestion.code && (
                <div className="mb-4 bg-gray-900 text-gray-100 p-4 rounded-lg overflow-x-auto">
                  <code className="text-sm font-mono">{currentQuestion.code}</code>
                </div>
              )}
            </div>

            {/* Answer Options */}
            <div className="space-y-3 mb-6">
              {currentQuestion.options?.map((option, idx) => {
                const isSelected = currentQuestion.type === 'multiple-select'
                  ? ((selectedAnswers[currentQuestionIndex] as string[]) || []).includes(option.text)
                  : selectedAnswers[currentQuestionIndex] === option.text;

                const showCorrect = showFeedback && option.correct;
                const showIncorrect = showFeedback && isSelected && !option.correct;

                return (
                  <motion.button
                    key={idx}
                    onClick={() => handleAnswerSelect(option.text)}
                    disabled={showFeedback}
                    whileHover={{ scale: showFeedback ? 1 : 1.02 }}
                    whileTap={{ scale: showFeedback ? 1 : 0.98 }}
                    className={`w-full p-4 rounded-lg border-2 text-left transition-all ${
                      showCorrect
                        ? 'border-green-500 bg-green-50'
                        : showIncorrect
                        ? 'border-red-500 bg-red-50'
                        : isSelected
                        ? 'border-blue-500 bg-blue-50'
                        : 'border-gray-200 bg-white hover:border-blue-300'
                    } ${showFeedback ? 'cursor-default' : 'cursor-pointer'}`}
                  >
                    <div className="flex items-start gap-3">
                      {/* Checkbox/Radio */}
                      <div className="flex-shrink-0 mt-0.5">
                        {currentQuestion.type === 'multiple-select' ? (
                          <div
                            className={`w-5 h-5 rounded border-2 flex items-center justify-center ${
                              showCorrect
                                ? 'border-green-600 bg-green-600'
                                : showIncorrect
                                ? 'border-red-600 bg-red-600'
                                : isSelected
                                ? 'border-blue-600 bg-blue-600'
                                : 'border-gray-400'
                            }`}
                          >
                            {(isSelected || showCorrect) && (
                              <LucideIcons.Check className="w-4 h-4 text-white" />
                            )}
                          </div>
                        ) : (
                          <div
                            className={`w-5 h-5 rounded-full border-2 flex items-center justify-center ${
                              showCorrect
                                ? 'border-green-600'
                                : showIncorrect
                                ? 'border-red-600'
                                : isSelected
                                ? 'border-blue-600'
                                : 'border-gray-400'
                            }`}
                          >
                            {isSelected && (
                              <div
                                className={`w-3 h-3 rounded-full ${
                                  showCorrect
                                    ? 'bg-green-600'
                                    : showIncorrect
                                    ? 'bg-red-600'
                                    : 'bg-blue-600'
                                }`}
                              />
                            )}
                          </div>
                        )}
                      </div>

                      {/* Option Text */}
                      <span className="flex-1 text-gray-900">{option.text}</span>

                      {/* Feedback Icon */}
                      {showCorrect && (
                        <LucideIcons.CheckCircle2 className="w-5 h-5 text-green-600 flex-shrink-0" />
                      )}
                      {showIncorrect && (
                        <LucideIcons.XCircle className="w-5 h-5 text-red-600 flex-shrink-0" />
                      )}
                    </div>

                    {/* Explanation (shown after submission if available) */}
                    {showFeedback && option.explanation && (isSelected || option.correct) && (
                      <motion.div
                        initial={{ height: 0, opacity: 0 }}
                        animate={{ height: 'auto', opacity: 1 }}
                        className="mt-3 pt-3 border-t border-gray-200 text-sm text-gray-700"
                      >
                        {option.explanation}
                      </motion.div>
                    )}
                  </motion.button>
                );
              })}
            </div>

            {/* Feedback Section */}
            {showFeedback && (
              <motion.div
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                className={`p-4 rounded-lg mb-6 ${
                  correctAnswer ? 'bg-green-50 border-2 border-green-300' : 'bg-red-50 border-2 border-red-300'
                }`}
              >
                <div className="flex items-start gap-3">
                  {correctAnswer ? (
                    <LucideIcons.CheckCircle2 className="w-6 h-6 text-green-600 flex-shrink-0" />
                  ) : (
                    <LucideIcons.XCircle className="w-6 h-6 text-red-600 flex-shrink-0" />
                  )}
                  <div>
                    <h3 className={`font-semibold mb-1 ${correctAnswer ? 'text-green-900' : 'text-red-900'}`}>
                      {correctAnswer ? 'Correct!' : 'Incorrect'}
                    </h3>
                    {currentQuestion.explanation && (
                      <div className="prose prose-sm max-w-none">
                        <ReactMarkdown>{currentQuestion.explanation}</ReactMarkdown>
                      </div>
                    )}
                  </div>
                </div>
              </motion.div>
            )}

            {/* Action Buttons */}
            <div className="flex gap-3">
              {!showFeedback ? (
                <button
                  onClick={handleSubmitAnswer}
                  disabled={!isAnswered}
                  className="flex-1 px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
                >
                  Submit Answer
                </button>
              ) : (
                <button
                  onClick={handleNextQuestion}
                  className="flex-1 px-6 py-3 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors flex items-center justify-center gap-2"
                >
                  {quiz.questions && currentQuestionIndex < quiz.questions.length - 1 ? (
                    <>
                      Next Question
                      <LucideIcons.ArrowRight className="w-5 h-5" />
                    </>
                  ) : (
                    <>
                      Finish Quiz
                      <LucideIcons.CheckCircle2 className="w-5 h-5" />
                    </>
                  )}
                </button>
              )}
            </div>
          </motion.div>
        </AnimatePresence>
      </div>
    </div>
  );
}
