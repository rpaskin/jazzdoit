class AddPositionToListItems < ActiveRecord::Migration
  def change
    add_column :list_items, :position, :integer
  end
end
