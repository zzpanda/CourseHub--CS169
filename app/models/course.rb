class Course < ActiveRecord::Base
  attr_accessible :name, :course_info, :department, :course_number

  validates :name, presence: true
  validates :course_info, presence: true
  validates :department, presence: true
  validates :course_number, presence: true
  #self.primary_keys = :department, :course_number

  has_many :coursesemesters
  has_many :semesters, :through => :coursesemesters

  #ERROR CODES
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
  def addCourse(name=nil, course_info=nil, department=nil, course_number=nil)
	if name.nil? or not name.is_a?(String) or name.length == 0
		return BAD_NAME
	elsif course_info.nil? or not course_info.is_a?(String) or course_info.length == 0
		return BAD_COURSE_INFO
	elsif department.nil? or not department.is_a?(String) or department.length == 0
		return BAD_DEPARTMENT
	elsif course_number.nil? or not course_number.is_a?(Integer)
		return BAD_COURSE_NUMBER
	end
	
	name.downcase
	department.downcase
	course_info.downcase
	course = Course.where(:department => department, :course_number => course_number)
	if course.any?
		return COURSE_EXISTS
	else
		new_course = Course.new(:name => name, :course_info => course_info, 
		:department => department, :course_number => course_number)
		new_course.save
		return SUCCESS
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
 
 

  
   '''Function that runs unit tests on all the functions in the class
   '''
  def unitTests
	totalFailed = 0
     	

  	return 0
  end

  
end
