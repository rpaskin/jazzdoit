require "spec_helper"

describe SessionsHelper do
  let(:user) { FactoryGirl.build(:user) }

  it { signed_in?.should be_false }
	it { current_user.should_not be_present }

	describe "#current_user=" do
		before { self.current_user = user }
	  it { @current_user.should == user }
	end

	describe "#current_user" do
		before { user.save! }
	  it "should get current user from cookie" do
	    cookies[:remember_token] = "foobar"
	    User.stub(:encrypt_token).and_return(user.remember_token)
	    current_user.should == user
	  end
	end

	describe "#sign_in" do
		before do
	  	user.save!
	  	sign_in user
		end

  	it { cookies[:remember_token].should be_present }
		it { current_user.should == user }
	  it { signed_in?.should be_true }
	end
end