class CreateForumTopicSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :forum_topic_subscriptions do |t|
      t.integer :member_id
      t.integer :forum_topic_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_topic_subscriptions
  end
end
