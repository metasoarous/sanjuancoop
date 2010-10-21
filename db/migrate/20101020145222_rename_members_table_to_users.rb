class RenameMembersTableToUsers < ActiveRecord::Migration
	def self.up
		rename_table :members, :users
		rename_table :members_product_requests, :users_product_requests
		
		rename_column :comments, :member_id, :user_id
		rename_column :forum_category_subscriptions, :member_id, :user_id
		rename_column :forum_posts, :member_id, :user_id
		rename_column :forum_topic_subscriptions, :member_id, :user_id
		rename_column :users_product_requests, :member_id, :user_id
		rename_column :volunteer_offerings, :member_id, :user_id
		
	end

	def self.down
		rename_table :users, :members
		rename_table :users_product_requests, :members_product_requests
		
		rename_column :comments, :user_id, :member_id
		rename_column :forum_category_subscriptions, :user_id, :member_id
		rename_column :forum_posts, :user_id, :member_id
		rename_column :forum_topic_subscriptions, :user_id, :member_id
		rename_column :members_product_requests, :user_id, :member_id
		rename_column :volunteer_offerings, :user_id, :member_id
	end
end
