class CourseSemester < ActiveRecord::Base
  attr_accessible :professor

  #validates :professor, presence: true

  has_and_belongs_to_many :users
  belongs_to :semester
  belongs_to :course

end
