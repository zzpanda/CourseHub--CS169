class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.integer :resource_id
      t.integer :numlikes
      t.string  :users_who_liked

      t.timestamps
    end
  end
end
