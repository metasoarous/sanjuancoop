class VolunteerTask < ActiveRecord::Base
	has_many :volunteer_offerings
	has_many :users, :through => :volunteer_offerings
end
