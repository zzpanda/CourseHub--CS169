class Semester < ActiveRecord::Base
  attr_accessible :term, :year

  validates :term, presence: true
  validates :year, presence: true

  has_many :coursems
  has_many :courses, :through => :coursems

  #ERROR CODES (written by Albert, make changes because a user can't create new semesters)
  SUCCESS = 1
  BAD_TERM = -5
  BAD_YEAR = -6
  NO_SEMESTER_EXISTS = -7
  DELETE_FAILED = -21


  def self.checkSemester(term, year, debug = true)
    terms = ["FALL", "SPRING", "SUMMER", "WINTER"]
    year_min = 1990
    year_max = Time.new.year

    if term.nil? or not term.is_a?(String) or not terms.include?(term.upcase)
      return BAD_TERM
    elsif year.nil? or not year.is_a?(Integer) or year < year_min or year > year_max
      return BAD_YEAR
    end

    term = term.upcase
    semester = Semester.where(:term => term, :year => year).first
    if semester.nil?
      return NO_SEMESTER_EXISTS
    else
      return semester
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



end
