class AddMailToNewsletters < ActiveRecord::Migration
	def self.up
		add_column :newsletters, :mail, :boolean
	end

	def self.down
		remove_column :newsletters, :mail
	end
end
