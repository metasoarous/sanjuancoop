class Newsletter < ActiveRecord::Base
  has_many :comments, :as => :commentable
  
  def deliver(group = :all)
    case group
    when :all
      emails = []
      Member.all.each do |member|
        CoopMailer.deliver_newsletter(member, self)
        emails << member.email
      end
      Membership.all.each do |membership|
        CoopMailer.deliver_newsletter(membership, self) unless emails.include? membership.email
      end
    when :members
      Member.all.each do |member|
        CoopMailer.deliver_newsletter(member, self)
      end
    when :memberships
      Membership.all.each do |membership|
        CoopMailer.deliver_newsletter(membership, self)
      end
    when Array
      group.each do |member|
        CoopMailer.deliver_newsletter(member,self)
      end
    end
  end
end
