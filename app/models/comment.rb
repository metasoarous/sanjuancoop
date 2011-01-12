class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :commentables, :polymorphic => :true
end
