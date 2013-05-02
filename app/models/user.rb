class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :encrypted_password, :karma
  #other fields include id, karma

  validates :username, :presence => true, :uniqueness => true

  has_and_belongs_to_many :coursems, :uniq => true
  has_many :resources, :inverse_of => :user
  has_many :comments, :inverse_of => :user
  has_one :favorite, :dependent => :destroy


  #ERROR CODES
  SUCCESS = 1
  RESOURCE_EXIST = -1
  BAD_RESOURCENAME = -2
  BAD_LINK = -3

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

  def valid(uri)
    begin
      !!URI.parse(uri)
    rescue URI::InvalidURIError
      return false
    end
  end

  def addResource(resourceName, type, resourceLink, user_id, coursem_id)
    #create! = .new followed by .save, and an exception is raised if it fails
    #create = .new followed by .save, no exception
    #resources.create!(:name => resourceName, :type => type, :link => resourceLink, :flags => 0, :users_who_flagged => "")
    @resource = Resource.where(:type => type, :link => resourceLink).first
    if resourceName.nil? or not resourceName.is_a?(String) or resourceName.length == 0
      return BAD_RESOURCENAME
    end
    if not valid(resourceLink)
       return BAD_LINK
    end
    if @resource.nil?
      resourceName = resourceName.downcase.split(' ').map {|w| w.capitalize }.join(' ')
      @user = User.find_by_id(user_id)
      if @user.karma == nil
        @user.karma = 1
        @user.save
      else
        @user.karma += 1
        @user.save
      end
      return type.constantize.create!(:name => resourceName, :link => resourceLink, :user_id => user_id, :coursem_id => coursem_id, :flags => 0, :users_who_flagged => "")
    else
      return RESOURCE_EXIST
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

  #User is able to flag a resource if it is not accurate. +
  #If the treshold is reached, the resource is removed. Threshold = 3 for now.
  def flagResource(user_id, resource_id)
    threshold = 3
    resource = Resource.find(resource_id)
    users = resource.users_who_flagged
    #Prevent a user from flagging a non-resource or a valid resource twice
    if resource and (users.nil? or not users.split(",").include?(user_id.to_s))
      resource.flags += 1
      if resource.flags < threshold
        users += "," + user_id.to_s
        resource.users_who_flagged = users
        resource.save
      else
        resource.destroy
      end
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
