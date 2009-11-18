class Membership < ActiveRecord::Base
  validates_uniqueness_of(:email, 
          :message => "That email already exists in the system.",
          :allow_nil => true,
          :allow_blank => true)
end
