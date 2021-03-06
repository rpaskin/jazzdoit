require 'spec_helper'

describe ListItem do
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    @list_item = ListItem.new(description: "abcdefgh", user_id: user.id, title: "foobar" )
  end

  subject { @list_item }

  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:percent_done) }
  it { should respond_to(:percent_updated_at) }
  it { should respond_to(:position) }
  it { should respond_to(:move_lower) }
  it { should respond_to(:move_higher) }
  it { should respond_to(:set_list_position) }

  it { should be_valid }

  describe "validations" do
  	describe "description is not present" do
  		before { @list_item.description = "" }
  		it { should be_valid }
  	end

    describe "title is under 500 chars" do
      before { @list_item.url = "M" * 501 }
      it { should_not be_valid }
    end

  	describe "description can take at least 501 chars" do
  		before { @list_item.description = "M" * 501 }
  		it { should be_valid }
  	end

  	describe "url is under 500 chars" do
  		before { @list_item.url = "M" * 501 }
  		it { should_not be_valid }
  	end

  	describe "belongs to a user" do
  		before { @list_item.user_id = nil }
  		it { should_not be_valid }
  	end
  end

	describe "when user_id is not present" do
    before { @list_item.user_id = nil }
    it { should_not be_valid }
  end

  describe "when title is not present" do
    before { @list_item.title = "" }
    it { should_not be_valid }
  end
end
