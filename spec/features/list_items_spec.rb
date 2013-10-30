require 'spec_helper'

describe "ListItemPages" do

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
    it { should_not have_link('X', href: list_item_path(user)) }

    describe "add invalid item" do
      before do
        expect { click_button "Post" }.not_to change(ListItem, :count)
      end
      it { should have_content "Unable to create" }
    end

    describe "add item" do
      before do
        @sentence1 = Faker::Lorem.sentence(8)
        fill_in "list_item_title", with: @sentence1
        expect { click_button "Post" }.to change(ListItem, :count).by(1)

        @sentence2 = Faker::Lorem.sentence(8)
        fill_in "list_item_title", with: @sentence2
        expect { click_button "Post" }.to change(ListItem, :count).by(1)
      end

      it { current_path.should == user_todo_list_path(user) }

      it { should_not have_content "Unable to create" }
      it { should     have_content @sentence1 }
      it { should     have_content @sentence2 }
      it { should     have_content "Add a description here" }

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

      describe "update descriptions" do
        before do
          @sentence4 = Faker::Lorem.sentence(12)
          within "#edit_list_item_1" do
            fill_in "list_item_description", with: @sentence4
            click_button "Update"
          end
        end
        it { user.list_items.last.description.should == @sentence4 }
        it { should have_content @sentence4 }

        context "update all descriptions" do
          before do
            @sentence5 = Faker::Lorem.sentence(12)
            within "#edit_list_item_2" do
              fill_in "list_item_description", with: @sentence5
              click_button "Update"
            end
          end
          it { should     have_content @sentence5 }
          it { should_not have_content "Add a description here" }
        end
      end

      describe "delete item" do
        before do
          within "#edit_list_item_2" do
            expect { click_link "X" }.to change(ListItem, :count).by(-1)
          end
        end
        it { should_not have_content @sentence2 }
      end

      context "reordering" do
        describe "initial positions" do
          it { ListItem.first.position.should == 2 }
          it { ListItem.first.title.should == @sentence2 }

          it { ListItem.last.position.should == 1 }
          it { ListItem.last.title.should == @sentence1 }
        end

        describe "move down" do
          before do
            within "#edit_list_item_1" do
              click_link "Move Down"
            end
          end
          it { ListItem.first.position.should == 1 }
          it { ListItem.last.position.should == 2 }
        end

        describe "move up" do
          before do
            within "#edit_list_item_2" do
              click_link "Move Up"
            end
          end
          it { ListItem.first.position.should == 1 }
          it { ListItem.last.position.should == 2 }
        end
      end

      describe "delete all done" do
        before do
          @sentence3 = Faker::Lorem.sentence(8)
          fill_in "list_item_title", with: @sentence3
          click_button "Post"

          within "#edit_list_item_1" do
            fill_in "list_item_percent_done", with: 100
            click_button "Update"
          end

          within "#edit_list_item_2" do
            fill_in "list_item_percent_done", with: 100
            click_button "Update"
          end

          expect { click_button "Delete All Done" }.to change(ListItem, :count).by(-2)
        end
        it { should_not have_content @sentence1 }
        it { should_not have_content @sentence2 }
        it { should_not have_content @sentence3 }
      end

    end
  end

end
