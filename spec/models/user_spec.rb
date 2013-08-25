require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(password: "foobar", email: "foo@bar.com")
  end

  subject { @user }

  it { should respond_to(:password) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when password is not present" do
    before { @user.password = "" }
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

  describe "when email is invalid" do
    before do
      @user.save!
      @user = User.new(password: "foobar", email: "foo@bar.com")
    end
    it { should_not be_valid }
  end
end
