require File.dirname(__FILE__) + '/../spec_helper'

describe MembersController do
	before(:each) do
		@member1 = Factory.build :member, :id => 1
		@member2 = Factory.build :member, :id => 2
		
	end
	
	describe "view member page" do
		it "should work when the signed in member is trying to get their own profile" do
			controller.send(:current_member=, @member1)
			controller.send(:current_member).should == @member1
		end
		
		it "should fail gracefully when trying to access another members page (when not admin)" do
			puts @member1.login.class
		end
		
		it "should always succeed for admins" do
			
		end
		
		it "should fail gracefully when not signed in" do
			
		end
	end
	
end
