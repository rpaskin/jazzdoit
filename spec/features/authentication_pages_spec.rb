require 'spec_helper'

describe "AuthenticationPages" do

  let(:created_user)     { FactoryGirl.create(:user) }
  let(:built_user)       { FactoryGirl.build(:user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  subject { page }

  describe "login page" do
    before do
      visit login_path
    end
    it { should have_content('Log In') }

    describe "with invalid information" do
      before { click_button "Log in" }
      it { should have_title('Log in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

		describe "with valid information" do
      before do
        fill_in "Email",    with: created_user.email.upcase
        fill_in "Password", with: created_user.password
        click_button "Log in"
      end

      it { should have_title(user.name) }
      it { should have_link('Profile',    href: user_path(created_user)) }
      it { should have_link('Log out',    href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }
    end

  end

end
