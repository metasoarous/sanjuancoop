class CreateVolunteerTasks < ActiveRecord::Migration
	def self.up
		create_table :volunteer_tasks do |t|
			t.string :name
			t.text :description

			t.timestamps
		end
	end

	def self.down
		drop_table :volunteer_tasks
	end
end
