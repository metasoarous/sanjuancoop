class DestroyDistribuitors < ActiveRecord::Migration
  def self.up
    drop_table :distributors
  end

  def self.down
    create_table :distributors do |t|
      t.string :name
      t.string :address
      t.string :website

      t.timestamps
    end
  end
end
