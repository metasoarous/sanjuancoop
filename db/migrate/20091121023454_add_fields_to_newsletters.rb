class AddFieldsToNewsletters < ActiveRecord::Migration
	def self.up
		add_column :newsletters, :delivered, :text
		add_column :newsletters, :next_delivery, :string
	end

	def self.down
		remove_column :newsletters, :next_delivery
		remove_column :newsletters, :delivered
	end
end
