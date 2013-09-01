FactoryGirl.define do
  factory :user do
    email                 "foo@bar.com"
    password              "foobar"
    password_confirmation "foobar"
  end


	factory :list_item do
    description "foobar foobar"
    url "http://foo/bar/1"
	  user
	end

end
