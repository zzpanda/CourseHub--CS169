class AddUsersWhoLikedToComment < ActiveRecord::Migration
  def change
    add_column :comments, :users_who_liked, :string
  end
end
