class CreateBarterBoardEntries < ActiveRecord::Migration
  def self.up
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

  def self.down
    drop_table :barter_board_entries
  end
end
