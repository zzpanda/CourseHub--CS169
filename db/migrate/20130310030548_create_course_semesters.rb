class CreateCourseSemesters < ActiveRecord::Migration
  def change
    create_table :semester_courses do |t|
      t.string :professor
      t.integer :user_id
      t.integer :course_semester_id
      #id created automatically
      t.timestamps
    end
  end
end
