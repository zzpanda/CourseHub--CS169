class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :encrypted_password
  #other fields include id, karma

  validates_presence_of :email
  #validates_presence_of :username
  #validates_presence_of :password

  has_and_belongs_to_many :coursems, :uniq => true
  has_many :resources, :inverse_of => :user
  has_many :comments, :inverse_of => :user
  has_one :favorite

  #ERROR CODES
  SUCCESS = 1
  RESOURCE_EXIST = -1

  def addToFavorite(resource_id)
    if self.favorite.nil?
      @favorite = self.create_favorite!()
    else
      @favorite = self.favorite
    end
    @favorite.resources << Resource.find_by_id(resource_id)
  end

  def deleteFavorite(resource_id)
    @resource = self.favorite.resources.find_by_id(resource_id)
    if not @resource.nil?
      self.favorite.resources.delete(@resource)
      @resource.favorites.delete(self.favorite)
    end
  end

  def subscribe(coursemid)
    cs = Coursem.find_by_id(coursemid)   #using find_by_id instead of find means won't throw exception
    if cs != nil
      cs.users << self
      self.coursems << cs      #the above line
    end
  end

  def unsubscribe(coursemid)
    cs = Coursem.find_by_id(coursemid)
    if cs != nil
      self.coursems.delete(cs)
      cs.users.delete(self)	#user not being deleted from coursem?
    end
  end

  #can be used in controller to give option to subscribe/unsubscribe
  def subscribed?(coursemid)
    cs = Coursem.find_by_id(coursemid)
    if cs != nil
      self.coursems.include?(cs)
    end
  end

  def subscribed
    self.coursems
  end

  def editProfile(email, username)
    self.email = email
    self.username = username
  end

  def addResource(resourceName, type, resourceLink, user_id, coursem_id)
    #create! = .new followed by .save, and an exception is raised if it fails
    #create = .new followed by .save, no exception
    @resource = Resource.where(:user_id => user_id, :coursem_id => coursem_id).first
    if @resource.nil?
      return type.downcase.capitalize.constantize.create!(:name => resourceName, :link => resourceLink, :user_id => user_id, :coursem_id => coursem_id)
    else
      return RESOURCE_EXIST
    end
  end

  def deleteResource(resourceId)
    r = resources.find_by_id(resourceId)
    if r
      r.destroy
    end
  end

  def postedResource?(resourceId)
    r = resources.find_by_id(resourceId)
    if r
      self.id == r.user_id
    else
      false
    end
  end

  def postedResources
    r = resources.where(:user_id => self.id).all
    if r
      r
    end
  end

  #later iteration (have to update migration file and resource.rb)
  #def flagResource(resourceId)
  #  r = resources.find_by_id(resourceId)
  #  if r
  #    r.flag = r.flag + 1
  #  end
  #end

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