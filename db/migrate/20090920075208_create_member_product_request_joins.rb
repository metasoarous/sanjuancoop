class CreateMemberProductRequestJoins < ActiveRecord::Migration
	def self.up
		create_table :member_product_request_joins do |t|
			t.integer :member_id
			t.integer :product_request_id

			t.timestamps
		end
	end

	def self.down
		drop_table :member_product_request_joins
	end
end
