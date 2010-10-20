class DropWholesaleOrders < ActiveRecord::Migration
	def self.up
		drop_table :wholesale_orders
	end

	def self.down
		create_table :wholesale_orders do |t|
			t.string :product_name
			t.string :product_number
			t.integer :distributor_id
			t.string :quantity
			t.boolean :ordered
			t.boolean :arrived
			t.integer :member_id

			t.timestamps
		end
	end
end


	
