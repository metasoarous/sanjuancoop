module BoardMemberHelper
	def last_name(name)
		name.split("").last
	end
	def sort_board_members(collection, by = :last_name)
		case by
		when :last_name
			collection.sort! {|a,b| last_name(a.name) <=> last_name(b.name)}
		end
		return	collection
	end
end
