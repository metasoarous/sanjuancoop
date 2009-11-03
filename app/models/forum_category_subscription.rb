class ForumCategorySubscription < ActiveRecord::Base
  belongs_to :member
  belongs_to :forum_category
  
  FREQUENCIES = ["weekly", "daily"]
end
