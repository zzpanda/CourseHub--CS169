class CreateCoursems < ActiveRecord::Migration
  def change
    create_table :coursems do |t|
        t.string :professor
        #id created automatically
        t.timestamps
    end
  end
end
