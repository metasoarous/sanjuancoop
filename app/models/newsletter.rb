class Newsletter < ActiveRecord::Base
	has_many :comments, :as => :commentable
	serialize :delivered, Array
	
	def deliver(deliver_to = :all)
		self.delivered = [] if delivered.nil?
		case deliver_to
		when Array
			# carry on
		when String, User, Membership
			deliver_to = [deliver_to]
		when :users
			deliver_to = User.all
		when :memberships
			deliver_to = Membership.all
		when :all
			deliver_to = Membership.all + User.all
		else
			# Should throw or raise here?
		end
		
		deliver_to.each do |contact|
			case contact
			when String
				unless self.delivered.include? contact
					self.delivered << contact
				else
					next
				end
			when Membership, User
				next unless (contact.accepts_newsletters? and !contact.email.nil? and !contact.email.empty? and !self.delivered.include?(contact.email))
				self.delivered << contact.email
				self.save
			end
			CoopMailer.newsletter(contact, self).deliver
		end
	end
end
