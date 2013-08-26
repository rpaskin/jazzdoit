require 'spec_helper'

describe UsersController do
  let(:created_user)     { FactoryGirl.create(:user) }
  let(:built_user)       { FactoryGirl.build(:user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  describe "GET users" do
    before do
      created_user
      visit users_path
    end

    subject { page }
    it { should have_content("Listing users") }
    it { should have_content(created_user.email) }
    it { should have_content(created_user.password) }
  end

  describe "GET user" do
    before do
      visit user_path(created_user)
    end
    subject { page }
    it { should have_content(created_user.email) }
    it { should have_content(created_user.password) }
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "Editing" do
    before do
      visit edit_user_path(created_user)
    end
    subject { page }
    it { should have_content "Editing user" }
    it { should have_field "user_email", with: created_user.email }
    it { should have_field "user_password", with: created_user.password }
  end

  describe "Creating" do
    describe "with valid params" do
      before do
        visit new_user_path
        fill_in "user_email", :with => built_user.email
        fill_in "user_password", :with => built_user.password
        click_button "Create User"
      end
      subject { page }
      it { current_path.should == user_path(User.last) }
      it { should have_content "User was successfully created" }
      it { should have_content(built_user.email) }
      it { should have_content(built_user.password) }
    end

    describe "with invalid params" do
      before do
        visit new_user_path
        fill_in "user_email", :with => "foo bar"
        fill_in "user_password", :with => built_user.password
        click_button "Create User"
      end
      subject { page }
      it { should have_content "Email is invalid" }
      it { should have_field "user_email", with: "foo bar" }
      it { should have_field "user_password", with: built_user.password }
    end
  end

  describe "Updating" do
    describe "with valid params" do
      before do
        visit edit_user_path(created_user)
        fill_in "user_email", :with => "foobar"+created_user.email
        fill_in "user_password", :with => "foobar"+created_user.password
        click_button "Update User"
      end
      subject { page }
      it { current_path.should == user_path(User.last) }
      it { should have_content "User was successfully updated" }
      it { should have_content("foobar"+created_user.email) }
      it { should have_content("foobar"+created_user.password) }
    end

    describe "with invalid params" do
      before do
        visit edit_user_path(created_user)
        fill_in "user_email", :with => "foo bar"
        click_button "Update User"
      end
      subject { page }
      it { current_path.should == user_path(User.last) }
      it { should have_content "Email is invalid" }
      it { should have_field "user_email", with: "foo bar" }
      it { should have_field "user_password", with: created_user.password }
    end
  end

  describe "Deleting" do
    before do
      created_user
      visit users_path
      click_link 'Destroy'
    end
    subject { page }
    it { current_path.should == users_path }
    it { should_not have_content created_user.email }
    it { should_not have_content created_user.password }
  end

  describe "Signup" do
    before do
      visit signup_users_path
      fill_in "user_email", :with => built_user.email
      fill_in "user_password", :with => built_user.password
      click_button "Create User"
      visit users_path # TODO visit post signup path for (:id => @user.id)
    end
    subject { page }
    it { should have_content(built_user.email) }
    it { should have_content(built_user.password) }
  end
end
