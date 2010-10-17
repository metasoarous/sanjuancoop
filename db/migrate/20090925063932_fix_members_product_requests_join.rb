class FixMembersProductRequestsJoin < ActiveRecord::Migration
  def self.up
    drop_table :member_product_request_joins
    create_table :members_product_requests do |t|
      t.string :description
      t.integer :member_id
      t.integer :product_request_id
      t.boolean :ordered
      t.boolean :failed

      t.timestamps
    end
  end

  def self.down
    drop_table :members_product_requests
    create_table :member_product_request_joins do |t|
      t.string :description
      t.boolean :ordered
      t.boolean :failed

      t.timestamps
    end
  end
end
