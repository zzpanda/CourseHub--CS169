class Semester < ActiveRecord::Base
  attr_accessible :term, :year

  validates :term, presence: true
  validates :year, presence: true

  has_many :courses, :through => :coursems, :uniq => true
  has_many :coursems, :dependent => :destroy

  #ERROR CODES (written by Albert, make changes because a user can't create new semesters)
  SUCCESS = 1
  BAD_TERM = -5
  BAD_YEAR = -6
  NO_SEMESTER_EXISTS = -7
  SEMESTER_DELETE_FAILED = -21


  def self.checkSemester(term, year)
    terms = ["FALL", "SPRING", "SUMMER", "WINTER"]
    year_min = 1990
    year_max = Time.new.year

    if term.nil? or not term.is_a?(String)
      return BAD_TERM
    elsif year.nil? or not year.is_a?(Integer) or year < year_min or year > year_max
      return BAD_YEAR
    end

    term = term.upcase
    semester = Semester.where(:term => term, :year => year).first
    if semester == nil or not terms.include?(term.upcase)
      return NO_SEMESTER_EXISTS
    else
      return semester
    end

  end

  '''Function deletes semester row from database. Return values are according to the error
     values given above. Parameters are term and year which form the primary
     key of the record. The coursems according to the semester should be deleted automatically.
  '''

  def destroySemester(semester_id)
    @semester = Semester.find_by_id(semester_id)
    if @semester.nil?
      return SEMESTER_DELETE_FAILED
    else
      @semester.destroy
      return SUCCESS
    end
  end



end
