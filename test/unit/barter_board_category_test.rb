require 'test_helper'

class BarterBoardCategoryTest < ActiveSupport::TestCase
	# Replace this with your real tests.
	test "should not save a barter_board_category without name" do
		category = BarterBoardCategory.new
		assert !category.save, "Saved a new BarterBoardCategory without a name"
	end
	
	test "should create barter_board_category" do
		assert_difference "BarterBoardCategory.count" do
			category = BarterBoardCategory.new(:name => "The Awesomest Category")
			assert category.save
		end
	end
end
