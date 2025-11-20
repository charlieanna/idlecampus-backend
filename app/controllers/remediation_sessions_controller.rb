class RemediationSessionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_enrollment
  before_action :set_session, only: [:show, :complete_item, :skip]
  
  # GET /courses/:course_id/remediation_session
  def show
    @remediation_session = @enrollment.remediation_sessions.active.first
    
    unless @remediation_session
      redirect_to course_path(@enrollment.course), alert: 'No active remediation session found.'
      return
    end
    
    @next_item = @remediation_session.next_item
    
    if @next_item
      # Load the actual item
      case @next_item['type']
      when 'InteractiveLearningUnit'
        @current_item = InteractiveLearningUnit.find(@next_item['id'])
        @item_type = 'unit'
      when 'QuizQuestion'
        @current_item = QuizQuestion.find(@next_item['id'])
        @item_type = 'question'
      end
    else
      # All items completed
      @remediation_session.complete!
      redirect_to course_path(@enrollment.course), notice: 'Remediation session completed! You can now continue.'
    end
  end
  
  # POST /courses/:course_id/remediation_session/complete_item
  def complete_item
    item_type = params[:item_type]
    item_id = params[:item_id].to_i
    
    # Mark the item as completed in the remediation session
    @session.complete_item!(item_type, item_id)
    
    # Award points
    current_user.user_stat&.add_xp(25)
    
    respond_to do |format|
      format.html { redirect_to course_remediation_session_path(@enrollment.course) }
      format.json { 
        render json: { 
          success: true, 
          progress: @session.progress_percentage,
          completed: @session.all_items_completed?
        } 
      }
    end
  end
  
  # POST /courses/:course_id/remediation_session/skip
  def skip
    # Allow skipping but track it
    @session.abandon!
    redirect_to course_path(@enrollment.course), 
                notice: 'Remediation session skipped. We recommend completing it later for better understanding.'
  end
  
  private
  
  def authenticate_user!
    unless current_user
      redirect_to root_path, alert: 'Please sign in to continue.'
    end
  end
  
  def set_enrollment
    course = Course.find_by(slug: params[:course_id]) || Course.find(params[:course_id])
    @enrollment = current_user.course_enrollments.find_by!(course: course)
  end
  
  def set_session
    @session = @enrollment.remediation_sessions.active.first
    unless @session
      redirect_to course_path(@enrollment.course), alert: 'No active remediation session.'
    end
  end
end
