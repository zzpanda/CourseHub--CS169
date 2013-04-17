class Resource < ActiveRecord::Base
  attr_accessible :name, :type, :link, :user_id, :coursem_id

  validates :name, presence: true
  #validates :type, presence: true
  validates :link, presence: true

  belongs_to :coursem, :inverse_of => :resources
  belongs_to :user, :inverse_of => :resources
  has_many :comments, :inverse_of => :resource
  has_and_belongs_to_many :favorites, :uniq => true


  # think about parameters to make more robust/secure against duplication
  def self.id(name, link)
    r = Resource.find_by_name_and_link(name, link)
    r.id
  end

  #return all the comments for this resource
  def comments
    c = Comment.where(:resource_id => self.id).all
    if c
      c
    end
  end

  # delete a resource with too many flags
  def deleteResource(resourceId)
    r = resources.find_by_id(resourceId)
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
