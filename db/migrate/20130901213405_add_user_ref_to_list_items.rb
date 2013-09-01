class AddUserRefToListItems < ActiveRecord::Migration
  def change
    remove_column :list_items, :user_id
    add_reference :list_items, :user, index: true
  end
end
