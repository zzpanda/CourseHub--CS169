class User < ActiveRecord::Base

  attr_accessible :email, :password, :username
  #other fields include id, karma

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true

  has_and_belongs_to_many :course_semesters
  has_many :resources
  #has_many :comments



  def subscribeToClass(class)
  end

  #need optional parameters?
  def editProfile(un, pw)
  end

  def addResource(resourceLink)
  end

  def deleteResource(resourceLink)
  end

  def addComment(comment)
  end

end
