class CreateCoursems < ActiveRecord::Migration
  def change
    create_table :coursems do |t|
      t.string :professor
      t.integer :course_id
      t.integer :semester_id

      t.timestamps
    end
  end
end
