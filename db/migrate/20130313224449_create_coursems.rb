class CreateCoursems < ActiveRecord::Migration
  def change
    create_table :coursems do |t|
        t.string :professor
        t.integer :course_id, :null => false
        t.integer :semester_id, :null => false
        t.text :coursem_info
        #id created automatically
        t.timestamps
    end
  end
end
