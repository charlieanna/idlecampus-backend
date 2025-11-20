namespace :courses do
  desc "Reset all course enrollments and progress"
  task reset_all: :environment do
    puts "Resetting all course enrollments and progress..."
    
    CourseEnrollment.destroy_all
    ModuleProgress.destroy_all
    LearningUnitProgress.destroy_all
    LabSession.destroy_all
    
    puts "✓ All enrollments and progress cleared!"
    puts "Users can now start fresh on any course."
  end
  
  desc "Reset enrollments for a specific course"
  task :reset_course, [:course_slug] => :environment do |t, args|
    course_slug = args[:course_slug]
    unless course_slug
      puts "Usage: rails courses:reset_course[course-slug]"
      exit 1
    end
    
    course = Course.find_by(slug: course_slug)
    unless course
      puts "Course '#{course_slug}' not found!"
      exit 1
    end
    
    puts "Resetting enrollments for: #{course.title}"
    
    CourseEnrollment.where(course: course).destroy_all
    ModuleProgress.joins(:course_module).where(course_modules: { course_id: course.id }).destroy_all
    LearningUnitProgress.joins(:interactive_learning_unit => { :course_modules => :course })
                         .where(courses: { id: course.id }).destroy_all
    LabSession.joins(:hands_on_lab => { :module_items => :course_module })
              .where(course_modules: { course_id: course.id }).destroy_all
    
    puts "✓ Course reset complete!"
  end
end


