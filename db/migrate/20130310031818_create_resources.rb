class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :resourceType
      t.string :name
      t.string :link
      t.integer :coursem_id
      t.integer :user_id

      t.timestamps
    end
  end
end
