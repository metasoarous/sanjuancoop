class BarterBoardEntry < ActiveRecord::Base
  belongs_to :wanted_category, :class_name => "BarterBoardCategory"
  belongs_to :offered_category, :class_name => "BarterBoardCategory"
  belongs_to :member
    
  validates_associated :wanted_category
  validates_numericality_of :wanted_category_id
  
  validates_associated :offered_category
  validates_numericality_of :offered_category_id
  
  validates_presence_of :offered
  validates_presence_of :wanted
  validates_presence_of :contact_info
  
  validates_numericality_of :member_id
end
