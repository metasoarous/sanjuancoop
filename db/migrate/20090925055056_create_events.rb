class CreateEvents < ActiveRecord::Migration
	def self.up
		create_table :events do |t|
			t.string :description
			t.text :details
			t.date :date
			t.time :time
			t.integer :event_category_id

			t.timestamps
		end
	end

	def self.down
		drop_table :events
	end
end
