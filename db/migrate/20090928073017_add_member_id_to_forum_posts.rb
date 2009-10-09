class AddMemberIdToForumPosts < ActiveRecord::Migration
  def self.up
    add_column :forum_posts, :member_id, :integer
  end

  def self.down
    remove_column :forum_posts, :member_id
  end
end
