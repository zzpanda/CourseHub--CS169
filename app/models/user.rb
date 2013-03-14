class User < ActiveRecord::Base

  attr_accessible :email, :password, :username
  #other fields include id, karma

  validates_presence_of :email
  validates_presence_of :username
  validates_presence_of :password

  has_and_belongs_to_many :course_semesters
  has_many :resources
  has_many :comments


 #################################3

  #COURSESEMESTER METHODS DO NOT WORK YET (due to course_semester underscore naming convention?)

  def subscribe(cs_id)
    cs = course_semesters.find_by_id(cs_id)   #using find_by_id instead of find means won't throw exception                            #cs.users.push(self.id)
    self.course_semesters << cs_id
    #course_semesters_users.create!(:user_id => self.id, :course_semesters_id => cs_id)
  end

  def unsubscribe(cs_id)
    cs = course_semesters.find_by_id(cs_id)
    cs.users.delete(self.id)
    self.course_semesters.delete(cs_id)
  end

  #can be used in controller to give option to subscribe/unsubscribe
  def subscribed?(cs_id)
    self.course_semesters.include?(cs_id)
  end

  def subscribed

  end

  ##################################

  def editProfile(email, username)
    self.email = email
    self.username = username
  end

  def addResource(resourceName, type, resourceLink)
    #create! = .new followed by .save, and an exception is raised if it fails
    #create = .new followed by .save, no exception
    resources.create!(:name => resourceName, :resourceType => type, :link => resourceLink)
  end

  def deleteResource(resourceId)
    r = resources.find_by_id(resourceId)
    if r
      r.destroy
    end
  end

  #controller should take care of checking that the resource belongs to the user?
  #def deleteResource(resourceName, resourceLink)
  #  r = resources.find_by_name_and_link(resourceName, resourceLink)
  #  if r
  #    r.destroy
  #  end
  #  #should return true/false or something signifying success/failure?
  #end

  #controller can check if user posted resource (users can only delete resources they posted)
  #def postedResource?(resourceName, resourceLink)
  #  r = resources.find_by_name_and_link(resourceName, resourceLink)
  #  if r
  #    self.id == r.user_id
  #  else
  #    false
  #  end
  #end

  def postedResource?(resourceId)
    r = resources.find_by_id(resourceId)
    if r
      self.id == r.user_id
    else
      false
    end
  end

  #returns all the resources the user has posted
  def postedResources
    r = resources.where(:user_id => self.id).all
    if r
      r
    end
  end

  def addComment(resourceId, content)
    comments.create!(:user_id => self.id, :resource_id =>resourceId, :content => content)
  end

  #returns all the comments the user has commented
  def commentsBy
    c = comments.where(:user_id => self.id).all
    if c
      c
    end
  end

end
