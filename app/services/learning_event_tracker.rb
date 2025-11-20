class LearningEventTracker
  # Convenience wrapper for LearningEvent tracking
  
  def self.quiz_started(user:, quiz:, context: {})
    LearningEvent.track(
      user: user,
      type: 'quiz_started',
      category: 'assessment',
      data: {
        quiz_id: quiz.id,
        quiz_title: quiz.title,
        question_count: quiz.total_questions,
        **context
      }
    )
  end
  
  def self.quiz_question_answered(user:, question:, answer:, correct:, time_taken: nil, context: {})
    LearningEvent.track(
      user: user,
      type: 'quiz_question_answered',
      category: 'assessment',
      data: {
        question_id: question.id,
        question_type: question.question_type,
        topic: question.topic,
        answer: answer,
        correct: correct,
        time_taken_seconds: time_taken,
        **context
      },
      skill_dimensions: question.skill_dimension ? [question.skill_dimension] : nil,
      performance_score: correct ? 1.0 : 0.0,
      time_spent_seconds: time_taken
    )
  end
  
  def self.quiz_completed(user:, quiz:, attempt:, context: {})
    LearningEvent.track(
      user: user,
      type: 'quiz_completed',
      category: 'assessment',
      data: {
        quiz_id: quiz.id,
        attempt_id: attempt.id,
        score: attempt.score,
        passed: attempt.passed,
        time_spent_seconds: attempt.time_spent_seconds,
        questions_count: attempt.answers&.count || 0,
        **context
      },
      performance_score: attempt.score / 100.0,
      time_spent_seconds: attempt.time_spent_seconds
    )
  end
  
  def self.lesson_started(user:, lesson:, context: {})
    LearningEvent.track(
      user: user,
      type: 'lesson_started',
      category: 'learning',
      data: {
        lesson_id: lesson.id,
        lesson_title: lesson.title,
        reading_time_minutes: lesson.reading_time_minutes,
        **context
      }
    )
  end
  
  def self.lesson_completed(user:, lesson:, time_spent: nil, context: {})
    LearningEvent.track(
      user: user,
      type: 'lesson_completed',
      category: 'learning',
      data: {
        lesson_id: lesson.id,
        lesson_title: lesson.title,
        **context
      },
      time_spent_seconds: time_spent
    )
  end
  
  def self.lab_started(user:, lab:, session:, context: {})
    LearningEvent.track(
      user: user,
      type: 'lab_started',
      category: 'practice',
      data: {
        lab_id: lab.id,
        lab_title: lab.title,
        session_id: session.id,
        difficulty: lab.difficulty,
        estimated_minutes: lab.estimated_minutes,
        **context
      },
      skill_dimensions: [lab.category]
    )
  end
  
  def self.lab_step_completed(user:, lab:, session:, step_number:, time_taken: nil, context: {})
    LearningEvent.track(
      user: user,
      type: 'lab_step_completed',
      category: 'practice',
      data: {
        lab_id: lab.id,
        session_id: session.id,
        step_number: step_number,
        steps_total: lab.step_count,
        **context
      },
      performance_score: 1.0,
      time_spent_seconds: time_taken
    )
  end
  
  def self.lab_hint_used(user:, lab:, session:, step_number:, context: {})
    LearningEvent.track(
      user: user,
      type: 'lab_hint_used',
      category: 'practice',
      data: {
        lab_id: lab.id,
        session_id: session.id,
        step_number: step_number,
        hints_used_total: session.hints_used,
        **context
      },
      performance_score: -0.1 # Penalty for using hint
    )
  end
  
  def self.lab_completed(user:, lab:, session:, context: {})
    LearningEvent.track(
      user: user,
      type: 'lab_completed',
      category: 'practice',
      data: {
        lab_id: lab.id,
        session_id: session.id,
        score: session.score,
        passed: session.passed,
        time_spent_seconds: session.time_spent_seconds,
        steps_completed: session.steps_completed,
        hints_used: session.hints_used,
        attempts_used: session.attempts_used,
        **context
      },
      skill_dimensions: [lab.category],
      performance_score: session.score / 100.0,
      time_spent_seconds: session.time_spent_seconds
    )
  end
  
  def self.module_started(user:, course_module:, context: {})
    LearningEvent.track(
      user: user,
      type: 'module_started',
      category: 'learning',
      data: {
        module_id: course_module.id,
        module_title: course_module.title,
        course_id: course_module.course_id,
        **context
      }
    )
  end
  
  def self.module_completed(user:, course_module:, progress:, context: {})
    LearningEvent.track(
      user: user,
      type: 'module_completed',
      category: 'learning',
      data: {
        module_id: course_module.id,
        module_title: course_module.title,
        course_id: course_module.course_id,
        completion_percentage: progress.completion_percentage,
        **context
      },
      performance_score: progress.completion_percentage / 100.0
    )
  end
  
  def self.course_enrolled(user:, course:, context: {})
    LearningEvent.track(
      user: user,
      type: 'course_enrolled',
      category: 'learning',
      data: {
        course_id: course.id,
        course_title: course.title,
        difficulty: course.difficulty_level,
        **context
      }
    )
  end
  
  def self.review_completed(user:, item:, performance:, context: {})
    LearningEvent.track(
      user: user,
      type: 'review_completed',
      category: 'review',
      data: {
        item_type: item.class.name,
        item_id: item.id,
        performance: performance,
        **context
      },
      performance_score: performance / 4.0 # FSRS scale 1-4
    )
  end
  
  def self.remediation_review_completed(user:, lesson_id:, question_id:, context: {})
    LearningEvent.track(
      user: user,
      type: 'remediation_review',
      category: 'remediation',
      data: {
        lesson_id: lesson_id,
        question_id: question_id,
        **context
      }
    )
  end
end

