source 'http://rubygems.org'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'rails', '3.0.0'


gem "haml"
gem "factory_girl_generator", ">= 0.0.1", :group => [:test, :development]
gem "hamltastic", :git => 'git://github.com/metasoarous/hamltastic.git'
gem "RedCloth"
gem "will_paginate"
gem "sass-on-heroku"
gem "contentable", :git => 'git://github.com/metasoarous/contentable.git'
gem "formtastic"
gem "hoptoad_notifier"


# Forget what this is for - should look into later.
gem "aasm"


group :test, :development do
	gem 'sqlite3-ruby', :require => 'sqlite3'
	gem 'ruby-debug'
	gem "factory_girl_rails", ">= 1.0.0"
	gem 'capybara'
	gem 'database_cleaner'
	gem 'cucumber-rails'
	gem 'cucumber'
	gem 'rspec-rails', ">= 2.0.0"
	gem 'launchy'
	gem "pickle", ">= 0.4.0"
end

group :production do
	gem "sass-on-heroku"
end
