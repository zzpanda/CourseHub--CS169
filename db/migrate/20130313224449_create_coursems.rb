class CreateCoursems < ActiveRecord::Migration
  def change
    create_table :coursems do |t|
        t.string :professor
        t.integer :course_id
        t.integer :semester_id
        #id created automatically
        t.timestamps
    end
  end
end
