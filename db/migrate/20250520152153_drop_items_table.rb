class DropItemsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :items
  end
end

