class Resource < ActiveRecord::Base
  attr_accessible :name, :resource_type, :link, :user_id

  validates :name, presence: true
  validates :resource_type, presence: true
  validates :link, presence: true

  belongs_to :course_semester
  belongs_to :user
  has_many :comments


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

end
