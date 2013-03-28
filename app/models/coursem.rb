class Coursem < ActiveRecord::Base

  attr_accessible :course_id, :professor, :semester_id, :coursem_info

  #validates :professor, presence: true
  validates :course_id, :presence => true
  validates :semester_id, :presence => true


  has_many :resources
  belongs_to :semester
  belongs_to :course
  has_and_belongs_to_many :users, :uniq => true
  
  # Different situations correspond to different errcodes
  SUCCESS = 1
  ERR_BAD_COURSEM = -1
  BAD_COURSEM_INFO = -8
  BAD_PROFESSOR = -9

  # Helper function to create new coursems at the start of each semester
  def self.createCourseSemesters(professor, course_id, semester_id, coursem_info)
    Coursem.create!(:professor => professor, :course_id => course_id, :semester_id => semester_id, :coursem_info => coursem_info)
  end

  # Given coursem, give a list of users subscribes to this coursem, the course and semester information and resources
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

  # Users can create their own coursems that is not contains in the Coursem database like decals.
  def self.createCoursemByUser(name=nil, coursem_info=nil, department=nil, course_number=nil, term=nil, year=nil, professor=nil)
    @semester = Semester.checkSemester(term, year, false)
    if @semester.class != Fixnum
      @course = Course.new.createCourse(name, department, course_number, false)
      
      if @course.class != Fixnum
        
        if coursem_info.nil? or not coursem_info.is_a?(String) or coursem_info.length == 0
          return BAD_COURSEM_INFO
        elsif professor.nil? or not professor.is_a?(String) or professor.length == 0
          return BAD_PROFESSOR
        end

        coursem_info.capitalize
        professor.upcase
        Coursem.createCourseSemesters(professor, @course.id, @semester.id, coursem_info)

      else
        return @course
      end
    
    else
      return @semester
    end
  end


end
