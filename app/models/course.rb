class Course < ActiveRecord::Base
  attr_accessible :name, :department, :course_number

  validates :name, presence: true
  validates :department, presence: true

  has_many :coursems
  has_many :semesters, :through => :coursems

  # For scraping (Toby)
  # should be only called once at the beginning of each semesters to generate official courses , can't be called by users
  def createAll(name, coursem_info, department, course_number, term, year, professor)
    @course = Course.where(:department => department, :course_number => course_number).first
    if @course.nil?
      @course = Course.create!(:name => name, :department => department, :course_number => course_number)
    end
    @semester = Semester.where(:term => term, :year => year).first
    if @semester.nil?
      @semester = Semester.create!(:term => term, :year => year)
    end
    @coursem = Coursem.where(:course_id => @course.id, :semester_id => @semester.id).first
    if @coursem.nil?
      Coursem.createCourseSemesters(professor, @course.id, @semester.id, coursem_info)
    end
  end

  # Grabs information to be used for displaying "Browse Courses Page"
  def self.getCourseInformation(department)
    if department == nil
      courses = Course.all
    else
      courses = Course.where(:department => department)
    end

    return courses
  end
 
  #ERROR CODES (written by Albert, make small change)
  SUCCESS = 1
  BAD_NAME = -1
  BAD_DEPARTMENT = -2
  BAD_COURSE_NUMBER = -3
  COURSE_EXISTS = -4
  DELETE_FAILED = -20

  '''Function adds a new course row to the course database. Return values are ccording to the error codes
     given above.
  '''
  def createCourse(name, department, course_number, debug = true)
    if name.nil? or not name.is_a?(String) or name.length == 0
      return BAD_NAME
    elsif department.nil? or not department.is_a?(String) or department.length == 0
      return BAD_DEPARTMENT
    elsif course_number.nil? or not course_number.is_a?(String) or course_number.length == 0
      return BAD_COURSE_NUMBER
    end

    name.capitalize
    department.upcase
    course = Course.where(:department => department, :name => name).first
    if not course.nil?
      return COURSE_EXISTS
    else
      course = Course.create!(:name => name, :department => department, :course_number => course_number)
      #debug=true is when the function is called by a test function, otherwise it is false
      if debug
      	return SUCCESS
      else
	      return course
      end
    end

  end

  '''Function deletes course row from database. Return values are according to the error
     values given above. Parameters are department and course_number which form the primary
     key of the record.
  '''

  def deleteCourse(department, course_number)
    course = Course.where(:department => department, :course_number => course_number)
    if not course.any?
      return DELETE_FAILED
    else
      course[0].destroy
      return SUCCESS
    end
  end

  
end

