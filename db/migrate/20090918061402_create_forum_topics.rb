class CreateForumTopics < ActiveRecord::Migration
  def self.up
    create_table :forum_topics do |t|
      t.string :subject
      t.integer :forum_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forum_topics
  end
end
