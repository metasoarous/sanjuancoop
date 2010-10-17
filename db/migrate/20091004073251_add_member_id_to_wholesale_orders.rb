class AddMemberIdToWholesaleOrders < ActiveRecord::Migration
  def self.up
    add_column :wholesale_orders, :member_id, :integer
  end

  def self.down
    remove_column :wholesale_orders, :member_id
  end
end
