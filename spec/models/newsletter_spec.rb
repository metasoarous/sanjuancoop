require File.dirname(__FILE__) + '/../spec_helper'

describe Newsletter do
	before(:each) do
		[Member, Membership, Newsletter].each {|model| model.delete_all}
		# Should not have to do this, but oh well...
		12.times do |n|
			member = Factory.create(:member, :login => "member#{n}", :email => "member#{n}@ex.com")
			ship = Factory.create(:membership, :email => "ship#{n}@ex.com")
		end
		@newsletter = Factory.create(:newsletter)
		@members = Member.all
		@memberships = Membership.all
	end
	
	describe "sending emails" do
		
		it "should know who has recieved emails"
		it "should know who hasn't recieved emails" do
			# select some members and ships who have recieved emails already
			members_delivered_to = @members[0...6]
			memberships_delivered_to = @members[0...6]
			memberish_delivered_to = members_delivered_to + memberships_delivered_to
			# everyone who could possibly get an email
			all_memberish = @members + @memberships
			# map each of the afore mentioned arrays to their constituent emails
			emails_delivered_to = memberish_delivered_to.map {|m| m.email}
			all_emails = all_memberish.map {|m| m.email}
			# declare who has recived emails
			@newsletter.delivered = emails_delivered_to
			@newsletter.save
			# remaining deliveries method should give everyone who is not amount
			to_deliver = @newsletter.remaining_deliveries
			to_deliver_emails = to_deliver.map {|m| m.email}
			to_deliver_emails.should == all_emails - emails_delivered_to
			should_be_emails_to_deliver == all_emails - emails_delivered_to
			to_deliver.should == should_be_emails_to_deliver.map {|e| Member.find_by_email(e) || Membership.find_by_email(e)}
			# Hmmm, starting to realize this is a bit messy and recreates the logic 
			#of the method to be. Also, noticing that this may let slip weird things 
			#where a Membership and a Member have the same email. At least the last 
			#bit. I'll have to be careful
		end
		
		
		it "should send emails"
		it "should not send emails to people who don't want them"
	end
end
