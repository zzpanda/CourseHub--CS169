class Resource < ActiveRecord::Base
  attr_accessible :name, :type, :link

  validates :name, presence: true
  validates :type, presence: true
  validates :link, presence: true

  belongs_to :course_semester
  belongs_to :user
  #has_many :comments

end
