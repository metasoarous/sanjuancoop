Feature: User Interface
	In order get the most out of the website
	As a coop member and website user
	I want be able to agilely navigate the site
	
	Scenario: Singing up for account
	
	Scenario: Logging in to account
		Given a member exists with login: "bob", password: "secret", password_confirmation: "secret", state: "active", email: "bob@foo.com"
		And I am on the home page
		And I follow "Login"
		Then I should be on the login page
		When I fill in "bob" for "Login"
		And I fill in "secret" for "Password"
		And I press "Log in"
		Then I should see "Logged in successfully"
		
	Scenario: Accessing user profile

		
	