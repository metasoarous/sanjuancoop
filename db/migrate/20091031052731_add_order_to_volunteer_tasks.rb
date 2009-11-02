class AddOrderToVolunteerTasks < ActiveRecord::Migration
  def self.up
    add_column :volunteer_tasks, :order, :integer
    VolunteerTask.all.each {|task| task.order = task.id }
  end

  def self.down
    remove_column :volunteer_tasks, :order
  end
end
