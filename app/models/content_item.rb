class ContentItem < ActiveRecord::Base
	validates_uniqueness_of :tag
	validates_presence_of :content
	
	def self.find_or_create_by_tag(value, options = {})
		puts "see me?"
		hash = {:tag => value.to_s, :content => "This content has yet to be created."}
		super(hash.merge options)
	end
end
