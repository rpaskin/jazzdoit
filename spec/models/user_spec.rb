require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(email: "foo@bar.com", password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:list_items) }

  it { should respond_to(:done_items) }
  it { should respond_to(:has_any_done_item?) }

  it { should be_valid }

  it { should respond_to(:authenticate) }

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when password_digest is not present" do
    before { @user.password_digest = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when email is invalid" do
    before { @user.email = "foo@@bar.com" }
    it { should_not be_valid }
  end

  describe "when email is duplicated" do
    before do
      @user.save!
      @user = User.new(password_digest: "foobar", email: "foo@bar.com")
    end
    it { should_not be_valid }
  end

  describe "when email is uppercase" do
    before do
      @user = User.new(email: "AAA@Bbb.com", password: "foobar", password_confirmation: "foobar")
      @user.save!
    end
    it { @user.email.should == "aaa@bbb.com" }
  end

  describe "when password is not present" do
    before do
      @user = User.new(email: "foo@bar.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password is too small" do
    before do
      @user = User.new(email: "foo@bar.com",
                       password: "12345", password_confirmation: "12345")
    end
    it { should_not be_valid }
  end

  describe "when password_confirmation doesn't match" do
    before { @user.password_confirmation = "blablabla123" }
    it { should_not be_valid }
  end

  describe "authenticate secure password" do
    before { @user.save }
    let(:test_user) { User.find_by(email: @user.email) }

    describe "with valid password" do
      it { should eq test_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:invalid_user) { test_user.authenticate("invalid") }

      it { should_not eq invalid_user }
      it { expect(invalid_user).to be_false }
    end
  end

  describe "user with no items" do
    before { @user.save }
    it { @user.done_items.should == [] }
    it { @user.has_any_done_item?.should be_false }
  end

  describe "list_items" do
    before { @user.save }

    let!(:older_item) do
      FactoryGirl.create(:list_item, user: @user, created_at: 1.day.ago, percent_done: 100)
    end
    let!(:newer_item) do
      FactoryGirl.create(:list_item, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right items in the right order" do
      expect(@user.list_items.to_a).to eq [newer_item, older_item]
    end

    it "should destroy list_items for a user" do
      saved_items = @user.list_items.to_a
      @user.destroy
      expect(saved_items).not_to be_empty
      saved_items.each do |item|
        expect(ListItem.where(id: item.id)).to be_empty
      end
    end

    it { @user.done_items.count.should == 1 }
    it { @user.has_any_done_item?.should be_true }
  end
end
