class CreateVolunteerOfferings < ActiveRecord::Migration
	def self.up
		create_table :volunteer_offerings do |t|
			t.integer :member_id
			t.integer :volunteer_task_id
			t.string :alt_contact

			t.timestamps
		end
	end

	def self.down
		drop_table :volunteer_offerings
	end
end
