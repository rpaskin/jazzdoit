require 'spec_helper'

describe "AuthenticationPages" do

  let(:created_user)     { FactoryGirl.create(:user) }
  let(:built_user)       { FactoryGirl.build(:user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  subject { page }

  describe "login page" do
    before { visit login_path }
    it { should have_content('Log In') }

    describe "with invalid information" do
      before { click_button "Log in" }
      it { should have_selector('div.error', text: 'email missing, password missing') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.error') }
      end
    end

		describe "with valid information" do
      before do
        fill_in "Email",    with: created_user.email.upcase
        fill_in "Password", with: created_user.password
        click_button "Log in"
      end

      it { should     have_link('Log out', href: logout_path) }
      it { should_not have_link('Log in',  href: login_path) }

      describe "log out" do
        before { click_link "Log out" }

        it { should_not have_link('Log out',       href: logout_path) }
        it { should     have_link('Log in',        href: login_path) }
        it { should     have_link('Sign up here',  href: signup_users_path) }
      end
    end
  end

end
