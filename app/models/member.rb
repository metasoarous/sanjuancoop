require 'digest/sha1'
require "aasm"

class Member < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Authorization::AasmRoles
  
  has_and_belongs_to_many :product_requests
  has_many :comments
  has_many :forum_posts
  has_many :barter_baord_entries
  has_many :volunteer_offerings
  has_many :volunteer_tasks, :through => :volunteer_offerings
  has_many :forum_topic_subscriptions
  has_many :subscribed_forum_topics, :class_name => "ForumTopic", :through => :forum_topic_subscriptions, :source => :forum_topic
  has_many :forum_category_subscriptions
  has_many :subscribed_categories, :class_name => "ForumCategory", :through => :forum_category_subscriptions
  
  accepts_nested_attributes_for :forum_category_subscriptions, :allow_destroy => true
  

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :first_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :first_name,     :maximum => 100
  
  validates_format_of       :last_name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :last_name,     :within => 2..80

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :message => "That email already exists in the system - contact the administrator about this so that we can fix the issue."
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :last_name, :first_name, :password, :password_confirmation, :forum_category_subscriptions_attributes, :phone_number, :accepts_newsletters, :password_reset_code
  # Should just need this is attr_accessible, but not working - hmmm...
  attr_reader :password_reset_code
  attr_writer :password_reset_code


  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  def name
    return first_name + " " + last_name
  end
  
  def self.subscribe_all
    ForumCategory.all.each do |cat|
      self.all.each do |mem|
        if ForumCategorySubscription.where(:member_id => mem.id, :forum_category_id => cat.id).empty?
          sub = ForumCategorySubscription.new(:member_id => mem.id, :forum_category_id => cat.id, :frequency => "weekly")
          sub.save
        end
      end
    end
  end
  
  
  # THE FOLLOWING METHODS WERE TAKEN FROM THE RAILSONEDGE.BLOGSPOT POST ON RESTFUL AUTH
  # They are for the purpose of password reset (etc) - that is, all before the protected
  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the 
    # reset_password flag to avoid duplicate email notifications.
    update_attributes(:password_reset_code => nil)
    @reset_password = true
  end  

  #used in user_observer
  def recently_forgot_password?
    @forgotten_password
  end
  
  def recently_reset_password?
    @reset_password
  end
  
  def recently_activated?
    @recent_active
  end

  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end
    
    # From RAILSONEDGE.BLOGSPOT Post
    def make_password_reset_code
      self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
    end

end
