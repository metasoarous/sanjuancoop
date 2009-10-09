class BarterBoardEntry < ActiveRecord::Base
  belongs_to :barter_board_category
  
  validates_associated :barter_board_category
  validates_numericality_of :barter_board_category_id
  
  validates_presence_of :offered
  validates_presence_of :wanted
  validates_presence_of :contact_info
end
