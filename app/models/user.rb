class User < ActiveRecord::Base

  attr_accessible :email, :password, :username
  #other fields include id, karma

  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true

  has_and_belongs_to_many :classes  #classes has_and_belongs_to_many :users
  has_many :comments   #comments belongs_to :user, comments belongs_to :resources
  has_many :resources   #resources belongs_to :user,


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
