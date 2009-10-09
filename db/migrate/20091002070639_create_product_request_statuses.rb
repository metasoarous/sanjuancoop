class CreateProductRequestStatuses < ActiveRecord::Migration
  def self.up
    create_table :product_request_statuses do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :product_request_statuses
  end
end
