class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :course_info
      t.string :department
      t.integer :course_number

      #id is created automatically
      t.timestamps
    end
  end
end
