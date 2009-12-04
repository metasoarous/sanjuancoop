class CoopMailer < ActionMailer::Base
  
  helper :forum, :application
  
  # Delivers signup notifications
  def signup_notification(member)
    setup_registration_email(member)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{WEBSITEURL}/activate/#{member.activation_code}"
  end
  
  # delivers account activations
  def activation(member)
    setup_registration_email(member)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{WEBSITEURL}/"
  end
  
  # delivers newsletters
  def newsletter(member, newsletter)
    setup_multipart_email(member.email)
    @subject = newsletter.subject
    @body[:body] = newsletter.body
  end
  
  # Set this one up to send notifications/updates of a single topics new posts
  def forum_topic_update(member, forum_post)
    setup_forum_update_email(member)
    @subject = @subject += forum_post.forum_topic.subject
    @body[:post] = forum_post
  end
  
  # Set this up to send out digest style updates
  def forum_category_update(member)
    member.forum_category_subscriptions.each do |sub|
      #crap is not a method - need to work on this
      sub.forum_category.crap
    end
  end
  
  protected
    
    # Sets up multipart emails
    def setup_multipart_email(address)
      headers       {}
      recipients    address
      from          "SJIF-COOP"
      sent_on       Time.now
      content_type  "multipart/alternative"
    end
    
    def setup_forum_update_email(member)
      setup_multipart_email(member.email)
      @body[:member] = member
      @subject = "Coop Forum Update: "
    end
    
    def setup_registration_email(member)
      setup_multipart_email(member.email)
      @body[:member] = member
      @subject = "Website Registration: "
    end
end
