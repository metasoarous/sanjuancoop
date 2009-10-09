class NewsletterObserver < ActiveRecord::Observer
  def after_create(newsletter)
    puts "-------- after_create called ----------"
    puts newsletter.mail
    puts newsletter.mail?
    if newsletter.mail?
      Member.all.each do |member|
        NewsletterMailer.deliver_newsletter(member, newsletter)
      end
    end
  end
  
  def after_save(newsletter)
    puts "-------- after_save called ----------"
  end
end
