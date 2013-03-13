class Course < ActiveRecord::Base
  attr_accessible :name, :course_info, :department, :course_number

  validates :name, presence: true
  validates :course_info, presence: true
  validates :department, presence: true
  validates :course_number, presence: true

  has_many :semester_courses
  has_many :semesters, :through => :course_semesters

end
