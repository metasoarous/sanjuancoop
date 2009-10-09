class Distributor < ActiveRecord::Base
  has_many :wholesale_orders
  has_many :product_suggestions
end
