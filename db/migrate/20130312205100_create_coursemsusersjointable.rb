class CreateCoursemsusersjointable < ActiveRecord::Migration
	def change
		create_table :coursems_users, :id => false do |t|
  			t.integer :coursem_id, :null => false
  			t.integer :user_id, :null => false
		end
		add_index(:coursems_users, [:coursem_id, :user_id])
	end

	#def down
	#	drop_table :coursems_users
	#end
end	
