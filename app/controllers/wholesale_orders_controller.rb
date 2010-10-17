class WholesaleOrdersController < ApplicationController
  # GET /wholesale_orders
  # GET /wholesale_orders.xml
  def index
    @content = Hash.new
    [:wholesale_ordering_preamble, 
      :wholesale_ordering_unfi, 
      :wholesale_ordering_azures, 
      :wholesale_ordering_rest].each do |item|
        @content[item] = ContentItem.find_or_create_by_tag(item.to_s)
    end
  end
end
