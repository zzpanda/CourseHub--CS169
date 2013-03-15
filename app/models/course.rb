class Course < ActiveRecord::Base
  attr_accessible :name, :course_info, :department, :course_number

  validates :name, presence: true
  validates :course_info, presence: true
  validates :department, presence: true
  validates :course_number, presence: true

  has_many :coursems
  has_many :semesters, :through => :coursems

 
  #ERROR CODES (written by Albert, make small changes, used in the later iterations when the users can create courses)
  SUCCESS = 1
  BAD_NAME = -1
  BAD_COURSE_INFO = -2
  BAD_DEPARTMENT = -3
  BAD_COURSE_NUMBER = -4
  COURSE_EXISTS = -5
  DELETE_FAILED = -6

  '''Function adds a new course row to the course database. Return values are ccording to the error codes
     given above.
  '''
  def createCourses(name=nil, course_info=nil, department=nil, course_number=nil, debug = true)
    if name.nil? or not name.is_a?(String) or name.length == 0
      return BAD_NAME
    elsif course_info.nil? or not course_info.is_a?(String) or course_info.length == 0
      return BAD_COURSE_INFO
    elsif department.nil? or not department.is_a?(String) or department.length == 0
      return BAD_DEPARTMENT
    elsif course_number.nil? or not course_number.is_a?(String) or course_number.length == 0
      return BAD_COURSE_NUMBER
    end

    name.capitalize
    department.upcase
    course_info.capitalize
    course = Course.where(:department => department, :course_number => course_number)
    if course.any?
      return COURSE_EXISTS
    else
      course = Course.create!(:name => name, :course_info => course_info, :department => department, :course_number => course_number)
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

  # For scraping (Toby)
  #should be only called once at the beginning of each semesters to generate official courses , can't be called by users
  def createAll(name, course_info, department, course_number, term, year, professor)
    @course = Course.where(:department => department, :course_number => course_number).first
    if @course.nil?
    	@course = self.createCourses(name,course_info,department,course_number,false)
    end
    @semester = Semester.where(:term => term, :year => year).first
    if @semester.nil?
      @semester = Semester.new.createSemesters(term,year,false)
    end
    @coursem = Coursem.where(:course_id => @course.id, :semester_id => @semester.id).first
    if @coursem.nil?
    	Coursem.new.createCourseSemesters(professor, @course.id, @semester.id)
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

  
end

