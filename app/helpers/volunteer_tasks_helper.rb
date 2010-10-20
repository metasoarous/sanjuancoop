module VolunteerTasksHelper
  # This makes setting up forms for the many-to-many relationship here much easier - factor into a helper gem?
  def volunteer_signup_form(task, &block)
    return nil unless current_member
    offer = task.volunteer_offerings.build(:member_id => current_member.id)
    form_for(offer) {|f| block.call(f)}
  end
  
  # Another one that would be good to factor into a gem - this one makes it easier to find the first join given any two objects that might participate in a many to many relationship (could factor out to have a :first or :all parameter)
  def volunteer_offering(task, member)
    offerings = VolunteerOffering.where(:volunteer_task_id => task.id, :member_id => member.id)
    return offerings.first
  end
  
  def task_order_number
    orders = VolunteerTask.all.map {|t| t.order}
    return orders.max ? orders.max + 1 : 1
  end
end
