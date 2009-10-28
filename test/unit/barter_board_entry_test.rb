require 'test_helper'

class BarterBoardEntryTest < ActiveSupport::TestCase

  test "should create barter_board_entries" do
    assert_difference "BarterBoardEntry.count" do
      entry = create_barter_board_entry(barter_board_entries(:one))
    end
  end
end
