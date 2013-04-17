class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.integer :coursem_id
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.datetime :start_at
      t.datetime :end_at
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
