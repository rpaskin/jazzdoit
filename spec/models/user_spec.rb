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
end
