class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      #t.string :resourceType
      t.string :type
      t.string :name
      t.string :link
      t.integer :coursem_id
      t.integer :user_id
      t.integer :flags
      t.string  :users_who_flagged

      t.timestamps
    end
  end
end
