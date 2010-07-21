class DropBarterBoardEntries < ActiveRecord::Migration
  def self.up
    drop_table :barter_board_entries
    drop_table :barter_board_categories
  end

  def self.down
    create_table :barter_board_categories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    create_table :barter_board_entries do |t|
      t.integer :wanted_category_id
      t.integer :offered_category_id
      t.string :wanted
      t.string :offered
      t.text :details
      t.string :contact_info
      t.integer :member_id

      t.timestamps
    end
  end
end

