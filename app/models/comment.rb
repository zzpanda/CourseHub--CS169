class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :resource_id, :numlikes, :users_who_liked
  #LIKES SHOULD BE A VECTOR

  validates :content, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :resource, dependent: :destroy

  #RETURN CODES
  SUCCESS = 1
  FAILED = 0

  def post_comment(content = nil, user_id = nil, resource_id = nil)
      if content != nil and user_id != nil
        Comment.create!(:content => content, :user_id => user_id, :resource_id => resource_id, :numlikes => 0, :users_who_liked => 0)
        return SUCCESS
      end
      return FAILED
  end

  def delete_comment(id = nil)
    comment = Comment.where(:id => id).first
    if not comment.nil?
        comment.destroy
        return SUCCESS
    end
    return FAILED
  end

  #Arguments: id = id of the comment that is being liked, user_id = id of the user who likes the comment
  def like_comment(id = nil, user_id = nil)
    comment = Comment.where(:id => id).first
    if not comment.nil?
      #check to make sure user cant like comment more than once
      #users_who_liked is a string which is a comma-separated list of ids of users who like a comment

      users = comment.users_who_liked
      if not users.nil?
      	users = comment.users_who_liked.split(",")
      end

      if not user_id.nil? and (users.nil? or not users.include?(user_id.to_s))
	comment.numlikes += 1
	if users.nil?
		users = ""
	end
	users = users.join(",")
	users += "," + user_id.to_s
	comment.users_who_liked = users
	comment.save
	return SUCCESS
      end 
    end
    return FAILED
  end

end
