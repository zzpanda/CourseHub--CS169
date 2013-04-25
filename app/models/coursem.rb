class Coursem < ActiveRecord::Base

  attr_accessible :course_id, :professor, :semester_id, :coursem_info, :coursem_id

  #validates :professor, presence: true
  validates :course_id, :presence => true
  validates :semester_id, :presence => true

  has_many :events, :inverse_of => :coursem
  has_many :resources, :inverse_of => :coursem
  belongs_to :semester
  belongs_to :course
  has_and_belongs_to_many :users, :uniq => true
  
  # Different situations correspond to different errcodes
  SUCCESS = 1
  ERR_BAD_COURSEM = -1
  BAD_COURSEM_INFO = -8
  BAD_PROFESSOR = -9
  COURSEM_EXISTS = -10
  DEPARTMENT_NOT_CHOSEN = -11
  COURSEM_DELETE_FAILED = -22

  # Helper function to create new coursems at the start of each semester
  def self.createCourseSemesters(professor, course_id, semester_id, coursem_info)
    @coursem = Coursem.create!(:professor => professor, :course_id => course_id, :semester_id => semester_id, :coursem_info => coursem_info)
    return @coursem
  end

  # Given coursem, give a list of users subscribes to this coursem, the course and semester information and resources
  def self.getCoursemInformation(coursem_id)
    @coursem = Coursem.find_by_id(coursem_id)
    if @coursem.nil?
      return ERR_BAD_COURSEM
    else
      @coursem[:users] = @coursem.users
      @coursem[:courses] = @coursem.course
      @coursem[:semester] = @coursem.semester
      @coursem[:resources] = @coursem.resources
      return @coursem
    end
  end

  # Users can create their own coursems that is not contains in the Coursem database like decals, should write n/a if no such field
  def self.createCoursemByUser(name, coursem_info, department, course_number, term, year, professor)
    if department == "Please select below"
      return  DEPARTMENT_NOT_CHOSEN
    end
    @semester = Semester.checkSemester(term, year.to_i)
    if @semester.class != Fixnum
      @course = Course.new.createCourse(name, department, course_number)
      
      if @course.class != Fixnum
        
        if coursem_info.nil? or not coursem_info.is_a?(String) or coursem_info.length == 0
          return BAD_COURSEM_INFO
        elsif professor.nil? or not professor.is_a?(String) or professor.length == 0
          return BAD_PROFESSOR
        end

        coursem_info.downcase
        coursem_info.split(' ').map {|w| w.capitalize }.join(' ')
        professor.upcase
        @coursem = Coursem.where(:course_id => @course.id, :semester_id => @semester.id).first
        logger.debug "suck: #{@coursem}"
        if @coursem.nil?
          return Coursem.createCourseSemesters(professor, @course.id, @semester.id, coursem_info)
        else
          return COURSEM_EXISTS
        end

      else
        return @course
      end
    
    else
      return @semester
    end
  end

  #Return id of coursem giving semester name and course name if it exists in DB.
  #Otherwise return nil

  def get_id(course_name, term, year)
    course = Course.find_by_name(course_name)
    semester = Semester.where(:term => term, :year => year).first
    if course and semester
      course_id = course.id
      semester_id = semester.id
      coursem = Coursem.where(:course_id => course.id, :semester_id => semester.id).first
      if coursem
        return coursem.id
      end
    end
    return nil

  end

  # User can delete a coursem
  def destroyCoursem(coursem_id)
    @coursem = Coursem.find_by_id(coursem_id)
    if @coursem.nil?
      return COURSEM_DELETE_FAILED
    else
      @coursem.destroy
      return SUCCESS
    end
  end

end
