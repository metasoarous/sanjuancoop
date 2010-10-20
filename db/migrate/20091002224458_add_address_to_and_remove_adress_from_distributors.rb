class AddAddressToAndRemoveAdressFromDistributors < ActiveRecord::Migration
	def self.up
		add_column :distributors, :address, :string
		add_column :distributors, :website, :string
		remove_column :distributors, :adress
	end

	def self.down
		remove_column :distributors, :address
		remove_column :distributors, :website
		add_column :distributors, :adress, :string
	end
end
