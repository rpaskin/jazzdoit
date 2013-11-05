class AddFileToListItem < ActiveRecord::Migration
  def change
    add_column :list_items, :file, :string
  end
end
