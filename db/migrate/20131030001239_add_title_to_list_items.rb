class AddTitleToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :title, :string

    ListItem.all.each do |i|
    	i.update_attribute(:title, i.description)
    end
  end
end
