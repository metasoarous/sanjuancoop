class AddActiveToForumCategorySubscriptions < ActiveRecord::Migration
  def self.up
    add_column :forum_category_subscriptions, :active, :boolean
  end

  def self.down
    remove_column :forum_category_subscriptions, :active
  end
end
