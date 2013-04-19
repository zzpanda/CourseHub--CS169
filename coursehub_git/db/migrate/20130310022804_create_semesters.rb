class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :term, :null => false
      t.integer :year, :null => false
      #id is created automatically
      t.timestamps
    end
  end
end