module VolunteerTasksHelper
  def volunteer_signup_form(task, &block)
    return nil unless current_member
    offer = task.volunteer_offerings.build(:member_id => current_member.id)
    form_for(offer) {|f| block.call(f)}
  end
  
  def volunteer_offering(task, member)
    conditions = {:volunteer_task_id => task.id, :member_id => member.id}
    offerings = VolunteerOffering.find(:all, :conditions => conditions)
    return offerings.first
  end
end
