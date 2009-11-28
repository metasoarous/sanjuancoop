class Newsletter < ActiveRecord::Base
  has_many :comments, :as => :commentable
  serialize :delivered, Array
  
  def deliver(group = :all)
    self.delivered = [] if delivered.nil?
    case group
    when Array
      puts "See me?"
    when :all
      group = Member.all
      emails = group.map {|m| m.email.downcase}
      Membership.all.each do |membership|
        group << membership unless emails.include? membership.email.downcase
        emails << membership.email
      end
    when :members
      group = Member.all
    when :memberships
      group = Membership.all
    end
    
    group.each do |memb|
      if memb.accepts_newsletters and !memb.email.nil? and !memb.email.empty?
        next_delivery = memb.email
        self.save
        CoopMailer.deliver_newsletter(memb, self)
        self.delivered = delivered << memb.email
        self.save
      end
    end
    
    next_delivery = nil
    self.save
  end
end
