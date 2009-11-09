class CoopMailer < ActionMailer::Base
  def signup_notification(member)
    setup_registration_email(member)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{WEBSITEURL}/activate/#{member.activation_code}"
  end
  
  def activation(member)
    setup_registration_email(member)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{WEBSITEURL}/"
  end
  
  def newsletter(member, newsletter)
    setup_email(member)
    @subject = newsletter.subject
    @headers = {}
    @body[:body] = newsletter.body
  end
  
  # Set this one up to send notifications/updates of a single topics new posts
  def forum_topic_update(member)
    # Fill in
  end
  
  # Set this up to send out digest style updates
  def forum_category_update(member)
    member.forum_category_subscriptions.each do |sub|
      sub.forum_category.
    end
    @
  end
  
  protected
    def setup_email(member)
      @recipients  = "#{member.email}"
      @from        = "SJI-COOP"
      @sent_on     = Time.now
      @body[:member] = member
      content_type "text/html"
    end
    
    def setup_registration_email(member)
      setup_email(member)
      @subject = "Website Registration: "
    end
end
