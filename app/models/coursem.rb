class Coursem < ActiveRecord::Base

  attr_accessible :course_id, :professor, :semester_id

  #validates :professor, presence: true
  validates :course_id, :presence => true
  validates :semester_id, :presence => true


  has_many :resources
  belongs_to :semester
  belongs_to :course
  has_and_belongs_to_many :users, :uniq => true
  #different situations correspond to different errcodes
  ERR_BAD_COURSEM = -1


  def self.createCourseSemesters(professor, course_id, semester_id)
    Coursem.create!(:professor => professor, :course_id => course_id, :semester_id => semester_id)
  end

  #Given coursem, give a list of users subscribes to this coursem, the course and semester information and resources
  def self.getCoursemInformation(coursem_id)
    @coursem = Coursem.find_by_id(coursem_id)
    if @coursem.nil?
      return ERR_BAD_COURSEM
    else
      @coursem[:users] = @coursem.users
      @coursem[:course] = @coursem.course
      @coursem[:semester] = @coursem.semester
      @coursem[:resources] = @coursem.resources
      return @coursem
    end
  end
end
