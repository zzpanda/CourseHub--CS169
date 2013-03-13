class CreateCourseSemesters < ActiveRecord::Migration
  def change
    create_table :semester_courses do |t|
      t.string :professor
      #id created automatically
      t.timestamps
    end
  end
end
