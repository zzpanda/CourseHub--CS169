class Coursem < ActiveRecord::Base
  attr_accessible :course_id, :professor, :semester_id
  #validates :professor, presence: true
  validates :course_id, :presence => true
  validates :semester_id, :presence => true

  has_and_belongs_to_many :users
  belongs_to :semester
  belongs_to :course

  def createCourseSemesters(professor, course_id, semester_id)
    Coursem.create!(:professor => professor, :course_id => course_id, :semester_id => semester_id)
  end
end
