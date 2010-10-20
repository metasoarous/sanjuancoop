class CreateBoardMembers < ActiveRecord::Migration
	def self.up
		create_table :board_members do |t|
			t.string :name
			t.string :role
			t.text :description
			t.string :image_url
			t.boolean :active

			t.timestamps
		end
	end

	def self.down
		drop_table :board_members
	end
end
