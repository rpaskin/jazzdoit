require 'spec_helper'

describe "AuthenticationPages" do

  subject { page }

  describe "sign-in page" do
    before do
      # debugger
      visit signin_path
    end

    it { should have_content('Log in') }
  end
end
