class Course < ActiveRecord::Base
  attr_accessible :name, :department, :course_number

  validates :name, presence: true
  validates :department, presence: true

  has_many :semesters, :through => :coursems, :uniq => true
  has_many :coursems, :dependent => :destroy

  # For scraping (Toby)
  # should be only called once at the beginning of each semesters to generate official course , can't be called by users
  def createAll(name, coursem_info, department, course_number, term, year, professor)
    name = name.downcase.split(' ').map {|w| w.capitalize }.join(' ')
    coursem_info = coursem_info.downcase.split(' ').map {|w| w.capitalize }.join(' ')
    department = department.upcase
    course_number = course_number.upcase
    term = term.upcase
    professor = professor.upcase
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
      Coursem.create!(:professor => professor, :course_id => @course.id, :semester_id => @semester.id, :coursem_info => coursem_info)
    end
  end

  # Get all possible departments in the database
  def self.getDepartments()
    dept = []
    @course = Course.all
    @course.each do |course|
      if not dept.include?(course.department)
        dept << course.department
      end
    end
    dept << "OTHERS"
    return dept
  end

  # Grabs information to be used for displaying "Browse Courses Page"
  def self.getCourseInformation(department, course)
    if not department.nil?
      department = department.upcase
    end

    if (department == nil and course == nil) || (department.length == 0 and course.length == 0)
      return Course.all
    elsif (department != nil and course == nil) || (department.length != 0 and course.length == 0)
      return Course.where(:department => department)
    elsif (department == nil and course != nil) || (department.length == 0 and course.length != 0)
      return Course.where(:course_number => course)
    elsif (department != nil and course != nil) || (department.length != 0 and course.length != 0)
      return Course.where(:department => department, :course_number => course)
    end
    return nil
  end
 
  #ERROR CODES (written by Albert, make small change)
  SUCCESS = 1
  BAD_NAME = -1
  BAD_DEPARTMENT = -2
  BAD_COURSE_NUMBER = -3
  COURSE_DELETE_FAILED = -20

  '''Function adds a new course row to the course database. Return values are according to the error codes
     given above.
  '''
  def createCourse(name, department, course_number)
    if name.nil? or not name.is_a?(String) or name.length == 0
      return BAD_NAME
    elsif department.nil? or not department.is_a?(String) or department.length == 0
      return BAD_DEPARTMENT
    elsif course_number.nil? or not course_number.is_a?(String) or course_number.length == 0
      return BAD_COURSE_NUMBER
    end

    name = name.downcase..split(' ').map {|w| w.capitalize }.join(' ')
    department = department.upcase
    course_number = course_number.upcase
    course = Course.where(:department => department, :course_number => course_number).first
    if course.nil?
      course = Course.where(:department => department, :name => name).first
    end
    if not course.nil?
      return course
    else
      course = Course.create!(:name => name, :department => department, :course_number => course_number)
      return course
    end

  end

  '''Function deletes course row from database. Return values are according to the error
     values given above. Parameters are department and name which form the primary
     key of the record. The coursems according to the course should be deleted automatically.
  '''

  def destroyCourse(course_id)
    @course = Course.find_by_id(course_id)
    if @course.nil?
      return COURSE_DELETE_FAILED
    else
      @course.destroy
      return SUCCESS
    end
  end
  
end

