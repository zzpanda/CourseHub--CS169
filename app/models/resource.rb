class Resource < ActiveRecord::Base
  attr_accessible :name, :type, :link, :user_id, :coursem_id, :flags, :users_who_flagged

  validates :name, presence: true
  #validates :type, presence: true

  belongs_to :coursem, :inverse_of => :resources
  belongs_to :user, :inverse_of => :resources
  has_many :comments, :inverse_of => :resource#, :dependent => :destroy
  has_and_belongs_to_many :favorites, :uniq => true

  #RETURN CODES
  SUCCESS = 1
  FAILED = 0


  # think about parameters to make more robust/secure against duplication
  def self.id(name, link)
    r = Resource.find_by_name_and_link(name, link)
    r.id
  end

  #return all the comments for this resource
  def comments
    c = Comment.where(:resource_id => self.id).all
    if c
      return c
    end
  end

  # delete a resource with too many flags
  def deleteResource(resourceId)
    r = Resource.find_by_id(resourceId)
    if r
      if not r.comments.empty?
        r.comments.each do |comment|
          comment.destroy
        end
      end
      r.destroy
    end
  end

end
