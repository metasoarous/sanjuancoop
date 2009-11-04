class BarterBoardCategory < ActiveRecord::Base
  has_many :barter_board_entries
  
  validates_presence_of :name
end
