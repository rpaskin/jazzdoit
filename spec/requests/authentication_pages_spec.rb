require 'spec_helper'

describe "Authentication" do
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "ListItems" do
        describe "can't post unless logged in" do
          before { post list_items_path }
          specify { expect(response).to redirect_to(login_path) }
        end

        describe "can't delete unless logged in" do
          before { delete list_item_path(FactoryGirl.create(:list_item)) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end
    end
  end
end
