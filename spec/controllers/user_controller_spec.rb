require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
	before(:each) do
		@user1 = Factory.build :user, :id => 1
		@user2 = Factory.build :user, :id => 2
		
	end
	
	describe "view user page" do
		it "should work when the signed in user is trying to get their own profile" do
			controller.send(:current_user=, @user1)
			controller.send(:current_user).should == @user1
		end
		
		it "should fail gracefully when trying to access another members page (when not admin)" do
			puts @user1.login.class
		end
		
		it "should always succeed for admins" do
			
		end
		
		it "should fail gracefully when not signed in" do
			
		end
	end
	
end
