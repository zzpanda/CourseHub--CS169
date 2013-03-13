class User < ActiveRecord::Base

  attr_accessible :email, :password, :username
  #other fields include id, karma

  validates_presence_of :email
  validates :password, presence: true
  validates :username, presence: true

  has_and_belongs_to_many :course_semesters
  has_many :resources, :order => "posted_on"
  #has_many :comments, :order => ""

  def subscribeToCourseSemester(cs)

  end

  def unsubscribeFromCourseSemester(cs)

  end


  #need optional parameters?
  def editProfile(un, pw)
  end

  def addResource(resourceName, type, resourceLink)
    #create! = .new followed by .save, and an exception is raised if it fails
    #create = .new followed by .save, no exception
    resources.create!(:name => resourceName, :resource_type => type, :link => resourceLink)
  end

  #controller should take care of checking that the resource belongs to the user?
  def deleteResource(resourceName, resourceLink)
    resources.find_by_name_and_link(:name => resourceName, :link => resourceLink).destroy
  end


  #get all the comments by the other user
  #def commentsBy(user)
  #  comments.find_by_user
  #end


  #def addComment(comment)
  #  comments.create!(:content => comment)
  #end


end
