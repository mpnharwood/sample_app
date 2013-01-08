FactoryGirl.define do 
	factory :user do
		name		"Matt Harwood"
		email		"random@example.com"
		password	"foobar"
		password_confirmation	"foobar"
	end	
end