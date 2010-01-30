class Newsletter < ActiveRecord::Base
  has_many :comments, :as => :commentable
  serialize :delivered, Array
  
  def deliver(deliver_to = :memberships)
    self.delivered = [] if delivered.nil?
    case deliver_to
    when Array
      # carry on
    when String, Member, Membership
      deliver_to = [deliver_to]
    when :members
      deliver_to = Member.all
    when :memberships
      deliver_to = Membership.all
    else
      # Should throw or raise here?
    end
    
    deliver_to.each do |contact|
      case contact
      when String
        self.delivered << contact
      when Membership, Member
        next unless (contact.accepts_newsletters? and !contact.email.nil? and !contact.email.empty?)
        self.delivered << contact.email
        self.save
      end
      CoopMailer.deliver_newsletter(contact, self)
    end
  end
end
