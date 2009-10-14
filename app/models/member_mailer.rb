class MemberMailer < ActionMailer::Base
  def signup_notification(member)
    setup_email(member)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://#{WEBSITEURL}/activate/#{member.activation_code}"
  end
  
  def activation(member)
    setup_email(member)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://#{WEBSITEURL}/"
  end
  
  protected
    def setup_email(member)
      @recipients  = "#{member.email}"
      @from        = "SJI-COOP"
      @subject     = "Website Registration: "
      @sent_on     = Time.now
      @body[:member] = member
    end
end
