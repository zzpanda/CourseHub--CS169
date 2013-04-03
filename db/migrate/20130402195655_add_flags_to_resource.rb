class AddFlagsToResource < ActiveRecord::Migration
  def change
    add_column :resources, :flags, :integer
  end
end
