class ProductRequest < ActiveRecord::Base
	has_many :comments, :as => :commentable
	belongs_to :product_request_status
	belongs_to :distributor
	
	has_many :member_product_requests
	has_many :members, :through => :member_product_requests
	
	accepts_nested_attributes_for :comments, :allow_destroy => true
end
