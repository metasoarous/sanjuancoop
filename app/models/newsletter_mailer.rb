class NewsletterMailer < ActionMailer::Base
  def newsletter(member, newsletter, sent_at = Time.now)
    @recipients = member.email
    @subject = newsletter.subject
    @sent_on = sent_at
    @from = "San Juan Islands Food Coop"
    @headers = {}
    @body[:body] = newsletter.body
    content_type "text/html"
    puts @body.class
  end
end
