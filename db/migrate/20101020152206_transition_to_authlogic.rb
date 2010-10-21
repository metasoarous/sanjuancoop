class TransitionToAuthlogic < ActiveRecord::Migration
	def self.up
		change_column :users, :crypted_password, :string, :limit => 128
		change_column :users, :salt, :string, :limit => 128
	end
	
	# Is this dangerous leaving this blank? Seems like it shouldn't be - If we leave 
	# extra space in this column, we leave extra space.
	def self.down
	end
end
