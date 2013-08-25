require 'spec_helper'

describe User do
  it "works" do
    User.new(email: "foo@bar.com", password: "foobar").valid?.should be_true
  end
  it "requires password" do
    User.new(email: "foo@bar.com").valid?.should be_false
  end
  it "requires email" do
    User.new(password: "foobar").valid?.should be_false
  end
  it "rejects invalid email" do
    User.new(email: "foo@@bar.com", password: "foobar").valid?.should be_false
  end
  it "rejects duplicated email" do
    User.new(email: "foo@bar.com", password: "foobar").save!
    User.new(email: "foo@bar.com", password: "barfoo").valid?.should be_false
  end
end
