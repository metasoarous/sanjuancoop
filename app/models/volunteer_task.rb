class VolunteerTask < ActiveRecord::Base
  has_many :volunteer_offerings
  has_many :members, :through => :volunteer_offerings
  
  def setup
    if new_record?
      orders = self.class.all.map {|task| task.order}
      order = orders.max + 1
    end
    return self
  end
end
