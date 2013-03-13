class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :resource_type
      t.string :name
      t.string :link
      t.integer :user_id
      t.timestamps

    end
  end
end
