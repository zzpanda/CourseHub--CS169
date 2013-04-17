class AddNumLikesToComment < ActiveRecord::Migration
  def change
    add_column :comments, :numlikes, :integer
  end
end
