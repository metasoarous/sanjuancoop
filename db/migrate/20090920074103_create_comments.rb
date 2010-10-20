class CreateComments < ActiveRecord::Migration
	def self.up
		create_table :comments do |t|
			t.string :commentable_type
			t.integer :commentable_id
			t.text :body
			t.integer :member_id

			t.timestamps
		end
	end

	def self.down
		drop_table :comments
	end
end
