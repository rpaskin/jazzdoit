require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(email: "foo@bar.com", password_hash: "foobar")
  end

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password_hash) }

  it { should be_valid }

  describe "when password_hash is not present" do
    before { @user.password_hash = "" }
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
      @user = User.new(password_hash: "foobar", email: "foo@bar.com")
    end
    it { should_not be_valid }
  end

  describe "when email is uppercase" do
    before do
      @user = User.new(password_hash: "foobar", email: "AAA@Bbb.com")
      @user.save!
    end
    it { @user.email.should == "aaa@bbb.com" }
  end
end
