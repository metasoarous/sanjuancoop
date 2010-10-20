class AddStatusToProductRequests < ActiveRecord::Migration
	def self.up
		add_column :product_requests, :product_request_status_id, :integer
		remove_column :product_requests, :ordered
		remove_column :product_requests, :failed
		remove_column :product_requests, :in_stock
	end

	def self.down
		remove_column :product_requests, :product_request_status_id
		add_column :product_requests, :ordered, :boolean
		add_column :product_requests, :failed, :boolean
		add_column :product_requests, :in_stock, :boolean
	end
end
