class WholesaleOrder < ActiveRecord::Base
  belongs_to :distributor
  belongs_to :member
end
