class RemediationController < ApplicationController
  before_action :authenticate_user!
  
  def track_lesson_review
    service = RemediationTrackingService.new(current_user)
    
    activity = service.track_lesson_review(
      quiz_attempt_id: params[:quiz_attempt_id],
      question_id: params[:question_id],
      lesson_id: params[:lesson_id]
    )
    
    render json: { 
      status: 'tracked',
      activity_id: activity.id,
      points_awarded: 10
    }
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  
  def mini_lesson
    question = QuizQuestion.find(params[:question_id])
    generator = MiniLessonGenerator.new
    @mini_lesson = generator.generate_for_question(question)
    
    render partial: 'remediation/mini_lesson', locals: { mini_lesson: @mini_lesson }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Question not found' }, status: :not_found
  end
  
  def recommendations
    service = RemediationTrackingService.new(current_user)
    @recommendations = service.get_recommended_reviews
    
    render json: @recommendations
  end
  
  def stats
    service = RemediationTrackingService.new(current_user)
    @stats = service.get_remediation_stats
    
    render json: @stats
  end
  
  def effectiveness
    service = RemediationTrackingService.new(current_user)
    topic = params[:topic]
    since = params[:since] ? Date.parse(params[:since]) : 1.month.ago
    
    @effectiveness = service.evaluate_remediation_effectiveness(
      topic: topic,
      since: since
    )
    
    render json: @effectiveness
  end
end
