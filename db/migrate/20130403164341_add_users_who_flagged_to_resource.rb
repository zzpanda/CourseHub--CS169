class AddUsersWhoFlaggedToResource < ActiveRecord::Migration
  def change
    add_column :resources, :users_who_flagged, :string
  end
end
