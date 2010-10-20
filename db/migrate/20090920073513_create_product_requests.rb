class CreateProductRequests < ActiveRecord::Migration
	def self.up
		create_table :product_requests do |t|
			t.string :description
			t.boolean :ordered
			t.boolean :failed

			t.timestamps
		end
	end

	def self.down
		drop_table :product_requests
	end
end
