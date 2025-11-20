class StudyPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_plan, only: [:show, :update, :pause, :resume]
  
  def index
    @active_plans = current_user.study_plans.active.includes(:course)
    @completed_plans = current_user.study_plans.completed.includes(:course)
  end
  
  def show
    @study_plan.check_and_update_milestones!
    @study_plan.update_progress!
    
    @enrollment = current_user.course_enrollments.find_by(course: @study_plan.course)
    @recent_activity = get_recent_activity
    @daily_progress = get_daily_progress
  end
  
  def new
    @course = Course.find(params[:course_id])
    @study_plan = current_user.study_plans.build(course: @course)
    
    # Set defaults based on course
    @study_plan.daily_target = suggest_daily_target(@course)
    @study_plan.weekly_target = 5 # Default 5 days per week
    @study_plan.estimated_completion_date = calculate_completion_date(@course, @study_plan.daily_target, @study_plan.weekly_target)
  end
  
  def create
    @study_plan = current_user.study_plans.build(study_plan_params)
    
    if @study_plan.save
      @study_plan.generate_milestones!
      
      # Enroll in course if not already enrolled
      unless current_user.enrolled_in?(@study_plan.course)
        current_user.course_enrollments.create!(course: @study_plan.course)
      end
      
      redirect_to @study_plan, notice: 'Study plan created successfully!'
    else
      @course = @study_plan.course
      render :new
    end
  end
  
  def update
    if @study_plan.update(study_plan_params)
      redirect_to @study_plan, notice: 'Study plan updated successfully!'
    else
      render :show
    end
  end
  
  def pause
    @study_plan.update!(status: 'paused')
    redirect_to @study_plan, notice: 'Study plan paused'
  end
  
  def resume
    @study_plan.update!(status: 'active')
    redirect_to @study_plan, notice: 'Study plan resumed'
  end
  
  private
  
  def set_study_plan
    @study_plan = current_user.study_plans.find(params[:id])
  end
  
  def study_plan_params
    params.require(:study_plan).permit(:title, :description, :daily_target, :weekly_target, :estimated_completion_date)
  end
  
  def suggest_daily_target(course)
    # Suggest daily target based on course difficulty and length
    case course.difficulty_level
    when 'beginner'
      30 # 30 minutes per day
    when 'intermediate'
      45 # 45 minutes per day
    when 'advanced'
      60 # 60 minutes per day
    else
      30
    end
  end
  
  def calculate_completion_date(course, daily_minutes, weekly_days)
    total_hours = course.estimated_hours || 20
    total_minutes = total_hours * 60
    study_minutes_per_week = daily_minutes * weekly_days
    weeks_needed = (total_minutes.to_f / study_minutes_per_week).ceil
    
    Date.today + weeks_needed.weeks
  end
  
  def get_recent_activity
    # Get learning activity for this course in last 7 days
    current_user.learning_events
      .where('created_at >= ?', 7.days.ago)
      .where("json_extract(event_data, '$.course_id') = ?", @study_plan.course.id.to_s)
      .order(created_at: :desc)
      .limit(10)
  end
  
  def get_daily_progress
    # Get minutes studied per day for last 7 days
    daily_data = {}
    
    7.times do |i|
      date = i.days.ago.to_date
      minutes = current_user.learning_events
        .where('DATE(created_at) = ?', date)
        .where("json_extract(event_data, '$.course_id') = ?", @study_plan.course.id.to_s)
        .sum(:time_spent_seconds) / 60
      
      daily_data[date] = {
        minutes: minutes,
        target: @study_plan.daily_target,
        met_target: minutes >= @study_plan.daily_target
      }
    end
    
    daily_data
  end
end
