# Haven't tested this out yet - desperately need to before running with it.
def validates_uniqueness_of_many_to_many_join(fk_hash, message = "You have a non unique many-many join")
	validates_each fk_hash.keys.first do |record, attr, value|
		if self.class.find(:all, :conditions => fk_hash).size > 1
			record.errors.add attr, message
		end
	end
end
