require 'spec_helper'

describe "AuthenticationPages" do

  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  describe "to do page" do
    before do
      visit login_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end

    it { current_path.should == user_todo_list_path(user) }
    it { should_not have_link('Delete', href: list_item_path(user)) }

    describe "add invalid item" do
      before do
        expect { click_button "Post" }.not_to change(ListItem, :count)
        save_and_open_page
      end
      it { should have_content "Unable to create" }
    end

    describe "add item" do
      before do
        @sentence1 = Faker::Lorem.sentence(8)
        fill_in "list_item_description", with: @sentence1
        expect { click_button "Post" }.to change(ListItem, :count).by(1)

        @sentence2 = Faker::Lorem.sentence(8)
        fill_in "list_item_description", with: @sentence2
        expect { click_button "Post" }.to change(ListItem, :count).by(1)
      end

      it { current_path.should == user_todo_list_path(user) }

      it { should_not have_content "Unable to create" }
      it { should     have_content @sentence1 }
      it { should     have_content @sentence2 }

      describe "update item" do
        before do
          within "#edit_list_item_1" do
            fill_in "list_item_percent_done", with: 33
            click_button "Update"
          end
        end
        it { find('#edit_list_item_1').find('#list_item_percent_done').value.should == "33" }
        it { user.list_items.last.percent_done.should == 33 }
      end

      describe "update item as done" do
        before do
          within "#edit_list_item_1" do
            click_link "Done"
          end
        end
        it { should have_content "100%" }
        it { user.list_items.last.percent_done.should == 100 }
      end

      describe "delete item" do
        before do
          within "#edit_list_item_2" do
            expect { click_link "Delete" }.to change(ListItem, :count).by(-1)
          end
        end
        it { should_not have_content @sentence2 }
      end
    end
  end

end
