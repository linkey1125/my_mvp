class ChangeItemToPostInFavorites < ActiveRecord::Migration[6.1]
  def change
    remove_reference :favorites, :item, foreign_key: true
    add_reference :favorites, :post, null: false, foreign_key: true
  end
end
