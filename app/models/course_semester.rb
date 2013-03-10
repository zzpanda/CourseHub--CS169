class CourseSemester < ActiveRecord::Base
  attr_accessible :professor

  #validates :professor, presence: true

  belongs_to :semester
  belongs_to :course

end
