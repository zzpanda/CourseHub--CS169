class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :resource_id

  belongs_to :user, :inverse_of => :comments
  belongs_to :resource, :inverse_of => :comments
end
