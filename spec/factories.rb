
#
# Factory sequences...
#

Factory.sequence :email do |n|
	"person#{n}@example.com"
end

Factory.sequence :login do |n|
	"member#{n}"
end



#
# Model factories...
#

Factory.define :member do |m|
	m.first_name "John"
	m.last_name "Doh"
	m.login {|n| "member#{n}"}
	m.email {|n| "member#{n}@example.com"}
	m.password "password"
	m.password_confirmation "password"
	m.accepts_newsletters true
end

Factory.define :membership do |m|
	m.email {|n| "ship#{n}@example.com"}
end

Factory.define :newsletter do |nl|
	nl.subject "Weekly Newsletter!"
	nl.body "A bunch of crap - yay..."
	nl.mail false
	#delivered
	#next_delivery
end

Factory.define :forum_category do |c|
end

Factory.define :forum_topic do |t|
	t.subject "Something to do with Aliens"
	t.forum_category_id 1
end

Factory.define :forum_post do |p|
	p.body "Some text"
	p.forum_topic_id 1
	p.member_id 1
end
