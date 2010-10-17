class CreateWholesaleOrders < ActiveRecord::Migration
  def self.up
    create_table :wholesale_orders do |t|
      t.string :product_name
      t.string :product_number
      t.integer :distributor_id
      t.string :quantity
      t.boolean :ordered
      t.boolean :arrived

      t.timestamps
    end
  end

  def self.down
    drop_table :wholesale_orders
  end
end
