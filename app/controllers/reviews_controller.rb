class ReviewsController < ApplicationController
  before_action :authenticate_user!

  # GET /reviews
  def show
    course_id = params[:course_id]
    scope = current_user.learning_unit_progresses.needs_review
    if course_id.present?
      scope = scope.joins(:interactive_learning_unit => { :course_modules => :course })
                   .where(courses: { id: course_id })
    end

    progress = scope.order(:next_review_at).first

    if progress
      unit = progress.interactive_learning_unit
      redirect_to interactive_learning_path(unit.slug), notice: "Quick review due before moving forward."
    else
      redirect_to dashboard_path, notice: "No reviews due right now."
    end
  end
end

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    # Get all review items due for current user
    @review_items = SpacedRepetitionItem
                      .where(user_id: current_user.id)
                      .due
                      .ordered_by_urgency
                      .includes(:item)
                      .limit(20)
    
    @quiz_question_reviews = @review_items.for_quiz_questions
    @total_due = @review_items.count
    
    # Group by difficulty
    @easy_reviews = @review_items.select { |item| item.difficulty < 3 }
    @medium_reviews = @review_items.select { |item| item.difficulty >= 3 && item.difficulty < 6 }
    @hard_reviews = @review_items.select { |item| item.difficulty >= 6 }
  end
  
  def practice
    # Get next item to review
    @review_item = SpacedRepetitionItem
                     .where(user_id: current_user.id)
                     .due
                     .ordered_by_urgency
                     .includes(:item)
                     .first
    
    if @review_item.nil?
      redirect_to reviews_path, notice: "No reviews due right now. Great job!"
      return
    end
    
    @item = @review_item.item
    
    # Handle different item types
    case @item
    when QuizQuestion
      render :practice_question
    else
      redirect_to reviews_path, alert: "Unsupported review item type"
    end
  end
  
  def submit
    @review_item = SpacedRepetitionItem.find(params[:id])
    
    unless @review_item.user_id == current_user.id
      redirect_to reviews_path, alert: "Unauthorized"
      return
    end
    
    # Get user's answer and correct answer
    user_answer = params[:answer]
    @item = @review_item.item
    
    if @item.is_a?(QuizQuestion)
      is_correct = @item.correct_answer?(user_answer)
      
      # Grade: 1=again, 2=hard, 3=good, 4=easy
      grade = if params[:grade].present?
                params[:grade].to_i
              else
                is_correct ? 3 : 1  # Default to good if correct, again if wrong
              end
      
      # Record review using FSRS
      fsrs_service = FSRSSchedulingService.new
      fsrs_service.schedule_review(
        user: current_user,
        item: @item,
        performance: grade
      )
      
      # Track event
      LearningEventTracker.review_completed(
        user: current_user,
        item: @item,
        performance: grade,
        context: { correct: is_correct }
      )
      
      # Get next review item
      next_item = SpacedRepetitionItem
                    .where(user_id: current_user.id)
                    .due
                    .ordered_by_urgency
                    .where.not(id: @review_item.id)
                    .first
      
      render json: {
        success: true,
        correct: is_correct,
        explanation: @item.explanation,
        correct_answer: @item.correct_answer,
        next_review_at: @review_item.next_review_at,
        has_more: next_item.present?,
        next_item_id: next_item&.id
      }
    else
      render json: { success: false, error: "Unsupported item type" }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error("Review submit error: #{e.message}")
    render json: { success: false, error: e.message }, status: :internal_server_error
  end
  
  def stats
    reviews = SpacedRepetitionItem.where(user_id: current_user.id)
    
    render json: {
      total_items: reviews.count,
      due_now: reviews.due.count,
      in_learning: reviews.in_learning.count,
      in_review: reviews.in_review.count,
      upcoming_24h: reviews.where('next_review_at <= ?', 24.hours.from_now).count,
      retention_rate: calculate_retention_rate(reviews)
    }
  end
  
  private
  
  def calculate_retention_rate(reviews)
    return 0 if reviews.empty?
    
    total_reviews = reviews.sum(:review_count)
    return 0 if total_reviews.zero?
    
    # Estimate retention based on lapses
    total_lapses = reviews.sum(:lapse_count)
    success_rate = ((total_reviews - total_lapses).to_f / total_reviews * 100).round(1)
    [success_rate, 0].max
  end
end