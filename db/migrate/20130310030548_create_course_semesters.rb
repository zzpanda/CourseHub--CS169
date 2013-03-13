class CreateCourseSemesters < ActiveRecord::Migration
  def change
    create_table :semester_courses do |t|
      t.string :professor
      t.integer :course_id  ,  :null => false
      t.integer :semester_id, :null => false
      #id created automatically
      t.timestamps
    end
  end
end
