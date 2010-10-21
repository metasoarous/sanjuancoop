class MembersProductRequest < ActiveRecord::Base
	belongs_to :member
	belongs_to :product_requests
end
