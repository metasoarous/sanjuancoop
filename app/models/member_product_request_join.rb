class MemberProductRequestJoin < ActiveRecord::Base
  has_many :members
  has_many :product_requests
end
