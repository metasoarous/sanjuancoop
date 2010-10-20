class CreateDistributors < ActiveRecord::Migration
	def self.up
		create_table :distributors do |t|
			t.string :name
			t.string :adress

			t.timestamps
		end
	end

	def self.down
		drop_table :distributors
	end
end
