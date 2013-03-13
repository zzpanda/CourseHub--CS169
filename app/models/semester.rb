class Semester < ActiveRecord::Base
  attr_accessible :term, :year

  validates :term, presence: true
  validates :year, presence: true

  has_many :semester_courses
  has_many :courses, :through => :course_semesters



end
