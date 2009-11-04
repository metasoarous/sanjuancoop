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
  has_many :wholesale_orders
  has_many :volunteer_offerings
  has_many :volunteer_tasks, :through => :volunteer_offerings
  has_many :forum_topic_subscriptions
  has_many :forum_topics, :through => :forum_topic_subscriptions
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
  attr_accessible :login, :email, :last_name, :first_name, :password, :password_confirmation, :forum_category_subscriptions_attributes



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
        if ForumCategorySubscription.find(:all, :conditions => {:member_id => mem.id, :forum_category_id => cat.id}).empty?
          sub = ForumCategorySubscription.new(:member_id => mem.id, :forum_category_id => cat.id, :frequency => "weekly")
          sub.save
        end
      end
    end
  end

  protected
    
    def make_activation_code
        self.deleted_at = nil
        self.activation_code = self.class.make_token
    end


end
