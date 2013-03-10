class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :term
      t.int :year
      #id is created automatically
      t.timestamps
    end
  end
end
