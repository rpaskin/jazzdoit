require 'spec_helper'

describe ListItem do
  before(:each) do
    @list_item = ListItem.new(description: "abcdefgh")
  end

  subject { @list_item }

  it { should respond_to(:description) }
  it { should respond_to(:url) }
  it { should respond_to(:percent_done) }
  it { should respond_to(:percent_updated_at) }

  it { should be_valid }
end
