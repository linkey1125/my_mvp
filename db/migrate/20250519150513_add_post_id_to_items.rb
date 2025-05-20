class AddPostIdToItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :items, :post, null: false, foreign_key: true
  end
end
