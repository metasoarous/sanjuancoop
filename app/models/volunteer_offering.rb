class VolunteerOffering < ActiveRecord::Base
	require "validations"
	
	belongs_to :user
	belongs_to :volunteer_task
	
	# Add validation that check to make sure that such a join doesn't already exist in the table.
	#validates_uniqueness_of_many_to_many_join(fk_hash, message = "You have a non unique many-many join")
end
