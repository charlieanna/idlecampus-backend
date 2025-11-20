class Api::V1::KubernetesContentController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!, only: [:modules, :lesson, :complete_lesson, :progress, :labs]
  before_action :set_current_user
  
  # GET /api/kubernetes/modules
  # Returns all Kubernetes modules with lessons and progress
  def modules
    content_library = KubernetesContentLibrary
    learning_path = if content_library.respond_to?(:learning_path_order)
                      content_library.learning_path_order
                    else
                      content_library::LEARNING_PATH_ORDER
                    end
    
    # Group lessons by module (every ~3-5 lessons is a module)
    modules_data = organize_into_modules(learning_path, content_library)
    
    render json: {
      success: true,
      modules: modules_data,
      total_lessons: learning_path.length
    }
  end
  
  # GET /api/kubernetes/lessons/:id
  # Returns a single lesson with all details
  def lesson
    lesson_id = params[:id]
    content_library = KubernetesContentLibrary
    
    # Get lesson from content library
    lesson = get_lesson_from_library(lesson_id, content_library)
    
    unless lesson
      return render json: { success: false, error: 'Lesson not found' }, status: :not_found
    end
    
    # Add user progress data
    lesson_with_progress = lesson.merge(
      completed: lesson_completed?(lesson_id),
      mastery_score: get_mastery_score(lesson_id)
    )
    
    render json: {
      success: true,
      lesson: lesson_with_progress
    }
  end
  
  # POST /api/kubernetes/lessons/:id/complete
  # Mark a lesson as complete and update mastery
  def complete_lesson
    lesson_id = params[:id]
    content_library = KubernetesContentLibrary
    
    unless @current_user
      return render json: { success: false, error: 'Not authenticated' }, status: :unauthorized
    end
    
    # Get lesson from content library
    lesson = get_lesson_from_library(lesson_id, content_library)
    unless lesson
      return render json: { success: false, error: 'Lesson not found' }, status: :not_found
    end
    
    # Mark as complete in session
    session = LearningSession.find_or_create_active(@current_user)
    session.mark_micro_complete(lesson_id, lesson_id)
    
    # Update mastery score
    mastery = @current_user.command_masteries.find_or_create_by(canonical_command: lesson_id)
    mastery.update!(
      proficiency_score: 100,
      last_used_at: Time.current,
      total_attempts: mastery.total_attempts + 1,
      successful_attempts: mastery.successful_attempts + 1
    )
    
    render json: {
      success: true,
      lesson_id: lesson_id,
      mastery_score: mastery.proficiency_score
    }
  end
  
  # GET /api/kubernetes/progress
  # Get user's overall progress
  def progress
    unless @current_user
      return render json: { success: false, error: 'Not authenticated' }, status: :unauthorized
    end
    
    content_library = KubernetesContentLibrary
    learning_path = if content_library.respond_to?(:learning_path_order)
                      content_library.learning_path_order
                    else
                      content_library::LEARNING_PATH_ORDER
                    end
    
    # Count completed lessons
    completed_lessons = @current_user.command_masteries
      .where(canonical_command: learning_path)
      .where('proficiency_score >= ?', 50)
      .count
    
    total_lessons = learning_path.length
    progress_percentage = total_lessons > 0 ? ((completed_lessons.to_f / total_lessons) * 100).round : 0
    
    render json: {
      success: true,
      completed_lessons: completed_lessons,
      total_lessons: total_lessons,
      progress_percentage: progress_percentage,
      masteries: @current_user.command_masteries
        .where(canonical_command: learning_path)
        .map { |m| { command: m.canonical_command, score: m.proficiency_score } }
    }
  end
  
  # GET /api/kubernetes/labs
  # Get all available labs
  def labs
    content_library = KubernetesContentLibrary
    labs_data = (content_library.labs || []).map do |lab|
      prerequisites_met = prerequisites_met?(lab[:requires_mastery] || [])
      {
        id: lab[:id],
        title: lab[:title],
        description: lab[:description],
        requires_mastery: lab[:requires_mastery],
        prerequisites_met: prerequisites_met,
        steps: lab[:steps]&.length || 0
      }
    end
    
    render json: {
      success: true,
      labs: labs_data
    }
  end
  
  private
  
  def set_current_user
    @current_user = current_user if respond_to?(:current_user)
    @current_user ||= User.first
  end
  
  def organize_into_modules(learning_path, content_library)
    # Group lessons into modules of 5-7 lessons each
    module_size = 6
    modules_list = []
    
    learning_path.each_slice(module_size).with_index do |lessons_slice, module_index|
      module_data = {
        id: module_index + 1,
        name: "Module #{module_index + 1}",
        lessons: lessons_slice.map do |lesson_id|
          lesson = get_lesson_from_library(lesson_id, content_library)
          {
            id: lesson_id,
            title: lesson&.dig(:content, :title) || lesson_id.titleize,
            completed: lesson_completed?(lesson_id),
            mastery_score: get_mastery_score(lesson_id)
          }
        end
      }
      modules_list << module_data
    end
    
    modules_list
  end
  
  def get_lesson_from_library(lesson_id, content_library)
    # Search through all chapters for the lesson
    learning_path = if content_library.respond_to?(:learning_path_order)
                      content_library.learning_path_order
                    else
                      content_library::LEARNING_PATH_ORDER
                    end
    chapter_index = learning_path.index(lesson_id)
    
    if chapter_index
      first_micro = content_library.get_first_micro_for_chapter(lesson_id)
      if first_micro
        {
          id: lesson_id,
          title: first_micro[:content][:title] || lesson_id.titleize,
          content: first_micro[:content],
          hints: first_micro[:hints],
          validation: first_micro[:validation]
        }
      end
    end
  end
  
  def lesson_completed?(lesson_id)
    return false unless @current_user
    mastery = @current_user.command_masteries.find_by(canonical_command: lesson_id)
    mastery && mastery.proficiency_score >= 50
  end
  
  def get_mastery_score(lesson_id)
    return 0 unless @current_user
    mastery = @current_user.command_masteries.find_by(canonical_command: lesson_id)
    mastery ? mastery.proficiency_score : 0
  end
  
  def prerequisites_met?(prerequisites)
    return true if prerequisites.blank? || !@current_user
    
    prerequisites.all? do |cmd|
      mastery = @current_user.command_masteries.find_by(canonical_command: cmd)
      mastery && mastery.proficiency_score >= 60
    end
  end
end
