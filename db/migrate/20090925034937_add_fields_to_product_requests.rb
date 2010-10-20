class AddFieldsToProductRequests < ActiveRecord::Migration
	def self.up
		add_column :product_requests, :in_stock, :boolean
		add_column :product_requests, :product_number, :string
		add_column :product_requests, :distributor_id, :integer
	end

	def self.down
		remove_column :product_requests, :in_stock
		remove_column :product_requests, :product_number
		remove_column :product_requests, :distributor_id
	end
end
