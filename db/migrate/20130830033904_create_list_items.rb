class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :description
      t.string :url
      t.integer :percent_done
      t.datetime :percent_updated_at

      t.timestamps
    end
  end
end
