class NewsletterObserver < ActiveRecord::Observer
  def after_create(newsletter)
    if newsletter.mail?
      newsletter.deliver
    end
  end
end
