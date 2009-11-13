class NewsletterObserver < ActiveRecord::Observer
  def after_create(newsletter)
    if newsletter.mail?
      emails = []
      Member.all.each do |member|
        CoopMailer.deliver_newsletter(member, newsletter)
        emails << member.email
      end
      Membership.all.each do |membership|
        CoopMailer.deliver_newsletter(membership, newsletter) unless emails.include? membership.email
      end
    end
  end
end
