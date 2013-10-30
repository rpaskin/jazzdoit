FactoryGirl.define do
  factory :admin_user do
    email                 "admin@admin.com"
    password              "foobar"
    password_confirmation "foobar"
  end

  factory :user do
    email                 "foo@bar.com"
    password              "foobar"
    password_confirmation "foobar"
  end

	factory :list_item do
    title "foobar foobar"
    description "barfoo barfoo"
    url "http://foo/bar/1"
	  user
	end

end
