class Course < ActiveRecord::Base
  attr_accessible :name, :course_info, :department, :course_number

  validates :name, presence: true
  validates :course_info, presence: true
  validates :department, presence: true
  validates :course_number, presence: true

  has_many :semester_courses
  has_many :semesters, :through => :course_semesters

    # Grabs information to be used for displaying "Browse Courses Page"
    def self.getCourseInformation(dept)
        courses = nil
        if dept == nil
            courses = Course.all
        else
            courses = Course.where("department = ?", dept)
        end

        courses.each do |course|
            course[:course_semester] = getSemesterClasses(course.id)
        end

        return courses
    end

    # Returns a list of all semester classes associated with the given course
    def self.getSemesterClasses(course_id)
        semesters = []
        courses = CourseSemester.where("course_id = ?", course_id)
        courses.each do |i|
            semesters << i.getSemester
        end
        return semesters
        return CourseSemester.where("course_id = ?", course_id)
    end

end
