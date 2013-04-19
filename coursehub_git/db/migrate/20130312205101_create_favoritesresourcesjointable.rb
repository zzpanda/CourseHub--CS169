class CreateFavoritesresourcesjointable < ActiveRecord::Migration
	def change
		create_table :favorites_resources, :id => false do |t|
  			t.integer :favorite_id, :null => false
  			t.integer :resource_id, :null => false
		end
		add_index(:favorites_resources, [:favorite_id, :resource_id])
	end

	#def down
	#	drop_table :favorites_resources
	#end
end	
