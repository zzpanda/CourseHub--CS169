class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, :null => false
      t.string :department, :null => false
      t.string :course_number

      #id is created automatically
      t.timestamps
    end
  end
end