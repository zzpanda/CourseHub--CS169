class CourseSemester < ActiveRecord::Base
  attr_accessible :professor, :course_id, :semester_id

  #validates :professor, presence: true

  has_and_belongs_to_many :users
  belongs_to :semester
  belongs_to :course
    
    def getSemester
        s = Semester.where("id = ?", semester_id)
        return s[0]["term"] + " " + s[0]["year"].to_s
    end

    def getSemesterID
        return semester_id
    end


end
