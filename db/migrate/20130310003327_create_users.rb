class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :password, :null => false
      t.integer :karma, :default => 0
      #t.int :id
      #id is created automatically

      t.timestamps
    end
  end
end
