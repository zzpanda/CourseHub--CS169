class Coursem < ActiveRecord::Base
  attr_accessible :professor, :course_id, :semester_id

  #validates :professor, presence: true
  validates :course_id, :presence => true
  validates :semester_id, :presence => true

  has_and_belongs_to_many :users
  belongs_to :course
  belongs_to :semester


  def self.createCoursems(professor, course_id, semester_id)
    Coursem.create!(:professor => professor, :course_id => course_id, :semester_id => semester_id)
  end

    # Grab all the relevant information for a Coursems that will be passed
    # into the "View Course Semester Page" as a JSON object
    def self.getCoursems(id)
        # to be implemented 

        course = Coursem.find_by_id(id)
        if not course.nil?
            course[:semester] = course.semester
            course[:course] = course.course
            course[:users] = course.users
        end
        return course
    end

end
