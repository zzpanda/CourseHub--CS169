class User < ActiveRecord::Base

  attr_accessible :email, :password, :username
  #other fields include id, karma

  validates_presence_of :email
  validates :password, presence: true
  validates :username, presence: true

  has_and_belongs_to_many :course_semesters
  has_many :resources
  #has_many :comments, :order => ""

  def subscribeToCourseSemester(cs_id)
    cs = course_semesters.find_by_id(cs_id)   #using find_by_id instead of find means won't throw exception                            #cs.users.push(self.id)
    self.course_semesters << cs_id
    #course_semesters_users.create!(:user_id => self.id, :course_semesters_id => cs_id)
  end

  def unsubscribeFromCourseSemester(cs_id)
    cs = course_semesters.find_by_id(cs_id)
    cs.users.delete(self.id)
    self.course_semesters.delete(cs_id)
  end

  #can be used in controller to give option to subscribe/unsubscribe
  def subscribedToCourseSemester?(cs_id)
    self.course_semesters.include?(cs_id)
  end

  def editProfile(email, username)
    self.email = email
    self.username = username
  end

  def addResource(resourceName, type, resourceLink)
    #create! = .new followed by .save, and an exception is raised if it fails
    #create = .new followed by .save, no exception
    resources.create!(:name => resourceName, :resource_type => type, :link => resourceLink)
  end

  #controller should take care of checking that the resource belongs to the user?
  def deleteResource(resourceName, resourceLink)
    r = resources.find_by_name_and_link(resourceName, resourceLink)
    if r
      r.destroy
    end
  end

  #controller can check if user posted resource (users can only delete resources they posted)
  def postedResource?(resourceName, resourceLink)
    r = resources.find_by_name_and_link(resourceName, resourceLink)
    if r
      self.id == r.user_id
    end
  end


  #get all the comments by the other user
  #def commentsBy(user)
  #  comments.find_by_user
  #end


  #def addComment(comment)
  #  comments.create!(:content => comment)
  #end


end
