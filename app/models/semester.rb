class Semester < ActiveRecord::Base
  attr_accessible :term, :year

  validates :term, presence: true
  validates :year, presence: true
  #self.primary_keys :term, :year

<<<<<<< HEAD
  has_many :coursesemesters
  has_many :courses, :through => :coursesemesters

  #ERROR CODES
  SUCCESS = 1
  BAD_TERM = -1
  BAD_YEAR = -2
  SEMESTER_EXISTS = -3
  DELETE_FAILED = -4


  def addSemester(term = nil, year = nil)
	terms = ["FALL", "SPRING", "SUMMER", "WINTER"]
	year_min = 1990
	year_max = Time.new.year + 1 #Able to add future semesters up to next year

	if term.nil? or not term.is_a?(String) or not terms.include?(term.upcase)
		return BAD_TERM
        elsif year.nil? or not year.is_a?(Integer) or year < year_min or year > year_max
		return BAD_YEAR
   	end

	term = term.upcase
	semester = Semester.where(:term => term, :year => year)
	if semester.any?
		return SEMESTER_EXISTS
	else
		semester = Semester.create(:term => term, :year => year)
		semester.save
		return SUCCESS
	end
  end
 
  def removeSemester(term = nil, year = nil)
	semester = Semester.where(:term => term.upcase, :year => year)
 	if not semester.any?
		return DELETE_FAILED
	else
		semester[0].destroy
		return SUCCESS
	end
  end

  

  
=======
  has_many :semester_courses
  has_many :courses, :through => :course_semesters


>>>>>>> 070cccca94dc7f466e9fe92ec3917c4fd6d9e440

end
