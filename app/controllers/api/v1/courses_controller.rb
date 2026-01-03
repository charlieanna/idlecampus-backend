module Api
  module V1
    class CoursesController < ActionController::API
      # CORS headers for API access
      before_action :set_cors_headers
      before_action :current_user, only: [:enroll, :progress, :complete_lesson, :complete_module, :track_access, :resume_point, :review_session]

      # GET /api/v1/courses
      def index
        courses = CourseFileReaderService.all_courses
        render json: { courses: courses.map { |c| course_summary(c) }, total: courses.count }
      end

      # GET /api/v1/courses/:slug
      def show
        course = CourseFileReaderService.find_course(params[:slug])
        course ? render(json: { course: course_detail(course) }) : not_found
      end

      # GET /api/v1/courses/:slug/modules
      def modules
        course = CourseFileReaderService.course_with_modules(params[:slug])

        if course
          render json: {
            course: { slug: course[:slug], title: course[:title] },
            modules: course[:modules],
            total: course[:modules_count]
          }
        else
          not_found
        end
      end

      # GET /api/v1/:track/courses
      # List courses filtered by track (e.g., kubernetes, docker, linux)
      def index_by_track
        track = params[:track]
        
        # First try file-based courses
        all_courses = CourseFileReaderService.all_courses
        
        # Filter courses by track (check tags or slug prefix)
        track_courses = all_courses.select do |c|
          c[:tags]&.include?(track) || 
          c[:slug]&.include?(track) ||
          c[:track] == track
        end
        
        # Also query database courses that match the track
        db_courses = Course.where(published: true).where(
          "slug LIKE :track OR certification_track = :track",
          track: "%#{track}%"
        )
        
        # Convert database courses to hash format and add if not already in file-based courses
        db_courses.each do |c|
          next if track_courses.any? { |tc| tc[:slug] == c.slug }
          track_courses << db_course_to_hash(c)
        end
        
        render json: { courses: track_courses.map { |c| course_summary(c) }, total: track_courses.count }
      end

      # GET /api/v1/:track/courses/:slug
      # Get course details filtered by track
      def show_by_track
        track = params[:track]
        
        # First try file-based course
        course = CourseFileReaderService.find_course(params[:slug])
        
        # Verify course belongs to the track
        if course && (course[:tags]&.include?(track) || course[:slug]&.include?(track) || course[:track] == track)
          render json: { course: course_detail(course) }
        else
          # Fallback to database course
          db_course = Course.find_by(slug: params[:slug], published: true)
          if db_course && (db_course.slug.include?(track) || db_course.certification_track == track)
            render json: { course: course_detail(db_course_to_hash(db_course)) }
          else
            not_found
          end
        end
      end

      # GET /api/v1/:track/courses/:course_slug/modules
      # Get modules for a course filtered by track
      def modules_by_track
        track = params[:track]

        # First try file-based course
        course = CourseFileReaderService.course_with_modules(params[:course_slug])

        # Verify course belongs to the track
        if course && (course[:tags]&.include?(track) || course[:slug]&.include?(track) || course[:track] == track)
          render json: {
            course: { slug: course[:slug], title: course[:title] },
            modules: course[:modules],
            total: course[:modules_count]
          }
        else
          # Fallback to database course
          db_course = Course.includes(course_modules: { module_items: :item }).find_by(slug: params[:course_slug], published: true)
          if db_course && (db_course.slug.include?(track) || db_course.certification_track == track)
            course_hash = db_course_with_modules_to_hash(db_course)
            render json: {
              course: { slug: course_hash[:slug], title: course_hash[:title] },
              modules: course_hash[:modules],
              total: course_hash[:modules_count]
            }
          else
            not_found
          end
        end
      end

      # GET /api/v1/:track/courses/:course_slug/modules/:module_slug
      # Get a specific module for a course filtered by track
      def module_by_track
        track = params[:track]
        course_slug = params[:course_slug]
        module_slug = params[:module_slug]

        # First try file-based course
        course = CourseFileReaderService.course_with_modules(course_slug)

        if course && (course[:tags]&.include?(track) || course[:slug]&.include?(track) || course[:track] == track)
          # Find the specific module
          mod = course[:modules]&.find { |m| m[:slug] == module_slug }
          if mod
            render json: { module: mod }
          else
            render json: { error: 'Module not found' }, status: :not_found
          end
        else
          # Fallback to database course
          db_course = Course.includes(course_modules: { module_items: :item }).find_by(slug: course_slug, published: true)
          if db_course && (db_course.slug.include?(track) || db_course.certification_track == track)
            db_module = db_course.course_modules.find_by(slug: module_slug)
            if db_module
              render json: { module: db_module_to_hash(db_module) }
            else
              render json: { error: 'Module not found' }, status: :not_found
            end
          else
            not_found
          end
        end
      end

      # POST /api/v1/courses/:slug/enroll
      # Enroll user in a course
      def enroll
        course_data = CourseFileReaderService.find_course(params[:slug])
        return not_found unless course_data

        # Find or create Course record for enrollment tracking
        course = Course.find_or_create_by!(slug: params[:slug]) do |c|
          c.title = course_data[:title]
          c.description = course_data[:description]
          c.difficulty_level = course_data[:difficulty_level] || 'beginner'
          c.estimated_hours = course_data[:estimated_hours]
          c.published = true
        end

        enrollment = course.course_enrollments.find_or_create_by!(user: @current_user) do |e|
          e.enrolled_at = Time.current
          e.status = 'enrolled'
        end

        render json: {
          message: 'Successfully enrolled',
          enrollment: {
            course_slug: course.slug,
            enrolled_at: enrollment.enrolled_at,
            status: enrollment.status
          }
        }
      end

      # GET /api/v1/courses/:slug/progress
      # Get user's progress in a course (ENHANCED with resume point and review status)
      def progress
        course = Course.find_by(slug: params[:slug])
        return not_found unless course

        enrollment = course.course_enrollments.find_by(user: @current_user)
        return render(json: { enrolled: false, progress: 0 }) unless enrollment

        # Track that user is accessing this course
        tracker = ProgressTrackerService.new(@current_user, enrollment)
        progress_details = tracker.get_progress_details

        # Get course data from files
        course_data = CourseFileReaderService.find_course(params[:slug])

        render json: {
          enrolled: true,
          enrollment_date: enrollment.enrolled_at,
          status: enrollment.status,
          completion_percentage: enrollment.completion_percentage,
          total_points: enrollment.total_points,
          last_accessed_at: enrollment.last_accessed_at,
          days_since_last_access: enrollment.calculate_time_away,
          course: {
            slug: course.slug,
            title: course.title,
            total_modules: course_data[:modules_count],
            total_lessons: course_data[:total_lessons]
          },
          resume_point: progress_details[:resume_point],
          review_status: progress_details[:review_status],
          current_position: progress_details[:current_position],
          module_progress: progress_details[:modules]
        }
      end

      # POST /api/v1/courses/:slug/track_access
      # Track that user is accessing the course (updates last_accessed_at)
      def track_access
        course = Course.find_by(slug: params[:slug])
        return not_found unless course

        enrollment = course.course_enrollments.find_by(user: @current_user)
        return render(json: { error: 'Not enrolled' }, status: :forbidden) unless enrollment

        tracker = ProgressTrackerService.new(@current_user, enrollment)
        tracker.track_access!

        render json: {
          message: 'Access tracked',
          last_accessed_at: enrollment.reload.last_accessed_at,
          needs_review: enrollment.needs_review
        }
      end

      # GET /api/v1/courses/:slug/resume_point
      # Get where user should resume in the course
      def resume_point
        course = Course.find_by(slug: params[:slug])
        return not_found unless course

        enrollment = course.course_enrollments.find_by(user: @current_user)
        return render(json: { error: 'Not enrolled' }, status: :forbidden) unless enrollment

        tracker = ProgressTrackerService.new(@current_user, enrollment)
        resume_data = tracker.get_resume_point

        render json: {
          resume_point: resume_data,
          days_since_last_access: enrollment.calculate_time_away
        }
      end

      # POST /api/v1/courses/:slug/review_session
      # Create a review session for the user
      def review_session
        course = Course.find_by(slug: params[:slug])
        return not_found unless course

        enrollment = course.course_enrollments.find_by(user: @current_user)
        return render(json: { error: 'Not enrolled' }, status: :forbidden) unless enrollment

        tracker = ProgressTrackerService.new(@current_user, enrollment)
        review_session = tracker.create_review_session_if_needed

        if review_session
          render json: {
            message: 'Review session created',
            review_session: {
              id: review_session.id,
              review_type: review_session.review_type,
              days_since_last_visit: review_session.days_since_last_visit,
              total_items: review_session.total_items,
              review_modules: review_session.review_modules,
              items_to_review: review_session.items_to_review
            }
          }
        else
          render json: {
            message: 'No review needed',
            needs_review: false
          }
        end
      end

      # POST /api/v1/courses/:slug/lessons/:lesson_slug/complete
      # Mark a lesson as complete
      def complete_lesson
        course = Course.find_by(slug: params[:slug])
        return not_found unless course

        enrollment = course.course_enrollments.find_by(user: @current_user)
        return render(json: { error: 'Not enrolled' }, status: :forbidden) unless enrollment

        # Create or find lesson record
        lesson = CourseLesson.find_or_create_by!(title: params[:lesson_slug].titleize)

        # Mark as complete (you can track this in a join table)
        # For now, just increment completion percentage
        course_data = CourseFileReaderService.find_course(params[:slug])
        total_lessons = course_data[:total_lessons]

        # Simple progress calculation (you can make this more sophisticated)
        enrollment.update(
          completion_percentage: [(enrollment.completion_percentage + (100.0 / total_lessons)), 100].min,
          total_points: enrollment.total_points + 10 # Award points
        )

        render json: {
          message: 'Lesson completed',
          completion_percentage: enrollment.completion_percentage,
          total_points: enrollment.total_points
        }
      end

      private

      def set_cors_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
        headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
      end

      def current_user
        # Simple user identification - adjust based on your auth system
        # Option 1: From auth token in header
        # token = request.headers['Authorization']&.gsub('Bearer ', '')
        # @current_user = User.find_by(auth_token: token)

        # Option 2: From user_id parameter (for testing/MVP)
        @current_user = User.find_by(id: params[:user_id] || request.headers['X-User-Id'])

        unless @current_user
          render json: { error: 'User not authenticated' }, status: :unauthorized
          return false
        end
      end

      def not_found
        render json: { error: 'Course not found' }, status: :not_found
      end

      # Simplified serializers
      def course_summary(c)
        c.slice(:slug, :title, :description, :difficulty_level, :estimated_hours,
                :modules_count, :total_lessons, :tags)
      end

      def course_detail(c)
        c.slice(:slug, :title, :description, :difficulty_level, :estimated_hours,
                :learning_objectives, :prerequisites, :tags, :related_courses,
                :recommended_next, :modules_count, :total_lessons).merge(
          modules: c[:modules].map { |m| module_summary(m) }
        )
      end

      def module_summary(m)
        m.slice(:slug, :title, :description, :sequence_order, :estimated_hours,
                :estimated_minutes, :lessons_count)
      end

      # Convert database Course to hash format compatible with file-based courses
      def db_course_to_hash(course)
        {
          slug: course.slug,
          title: course.title,
          description: course.description,
          difficulty_level: course.difficulty_level,
          estimated_hours: course.estimated_hours,
          tags: [course.slug.split('-').first, course.certification_track].compact,
          modules_count: course.course_modules.count,
          total_lessons: course.course_modules.sum { |m| m.module_items.where(item_type: 'CourseLesson').count },
          learning_objectives: JSON.parse(course.learning_objectives || '[]'),
          prerequisites: JSON.parse(course.prerequisites || '[]'),
          related_courses: [],
          recommended_next: nil,
          modules: []
        }
      end

      # Convert database Course with modules to hash format
      def db_course_with_modules_to_hash(course)
        base = db_course_to_hash(course)
        base[:modules] = course.course_modules.order(:sequence_order).map do |m|
          db_module_to_hash(m)
        end
        base
      end

      # Convert database module to hash format
      def db_module_to_hash(m)
        {
          slug: m.slug,
          title: m.title,
          description: m.description,
          sequence_order: m.sequence_order,
          estimated_hours: m.estimated_minutes.to_f / 60,
          estimated_minutes: m.estimated_minutes,
          lessons_count: m.module_items.where(item_type: 'CourseLesson').count,
          items: m.module_items.order(:sequence_order).includes(:item).map do |mi|
            {
              id: mi.id,
              sequence_order: mi.sequence_order,
              item_type: mi.item_type,
              title: mi.item&.respond_to?(:title) ? mi.item.title : "Item #{mi.id}",
              description: mi.item&.respond_to?(:description) ? mi.item.description : nil,
              content: mi.item&.respond_to?(:content) ? mi.item.content : nil,
              estimated_minutes: mi.item&.respond_to?(:reading_time_minutes) ? mi.item.reading_time_minutes : nil
            }
          end
        }
      end
    end
  end
end
