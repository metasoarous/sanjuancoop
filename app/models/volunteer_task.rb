class VolunteerTask < ActiveRecord::Base
  has_many :volunteer_offerings
  has_many :members, :through => :volunteer_offerings
end
