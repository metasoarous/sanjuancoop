class CreateForumCategorySubscriptions < ActiveRecord::Migration
  def self.up
    create_table :forum_category_subscriptions do |t|
      t.integer :member_id
      t.integer :forum_category_id
      t.string :frequency
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_category_subscriptions
  end
end
