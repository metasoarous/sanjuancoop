class ForumCategorySubscription < ActiveRecord::Base
  
  FREQUENCIES = ["weekly", "daily"]
  
  belongs_to :member
  belongs_to :forum_category
  
  validate :must_be_unique_join
  validates_numericality_of :member_id, :message => "Subscription is failing to associate itself with a member"
  validates_numericality_of :forum_category_id, :message => "Subscription is failing to associate itself with a forum_category"
  validates_presence_of :frequency, :message => "Must have a subscription frequency selected"
  
  protected 
  
  def must_be_unique_join
    member_subs = self.class.all(:conditions => {:member_id => member_id})
    pass = true
    member_subs.each do |sub| 
      if sub.forum_category_id == forum_category_id and !sub.id == self.id
        pass = false 
        break 
      end
    end
    errors.add_to_base("Must have only one sbscription between given forum_category and member") unless pass
  end 
end
