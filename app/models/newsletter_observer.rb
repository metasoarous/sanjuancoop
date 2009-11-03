class NewsletterObserver < ActiveRecord::Observer
  def after_create(newsletter)
    if newsletter.mail?
      Member.all.each do |member|
        CoopMailer.deliver_newsletter(member, newsletter)
      end
    end
  end
end
