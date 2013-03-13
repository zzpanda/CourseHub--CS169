class Resource < ActiveRecord::Base
  attr_accessible :name, :resource_type, :link, :user_id

  validates :name, presence: true
  validates :resource_type, presence: true
  validates :link, presence: true

  belongs_to :course_semester
  belongs_to :user
  #has_many :comments

end
