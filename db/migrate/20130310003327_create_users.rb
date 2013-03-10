class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.int :karma
      #t.int :id
      #id is created automatically

      t.timestamps
    end
  end
end
