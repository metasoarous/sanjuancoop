require 'test_helper'

class BarterBoardEntryTest < ActiveSupport::TestCase
  
  params = {:wanted_category_id => 1, :offered_category_id => 1}

  test "should create barter_board_entries" do
    assert_difference "BarterBoardEntry.count" do
      entry = BarterBoardEntry.new(barter_board_entries(:one).attributes.merge(:id => nil))
      assert entry.save, "New Barter Board Entry should save"
    end
  end
end
