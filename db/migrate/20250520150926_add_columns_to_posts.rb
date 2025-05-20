class AddColumnsToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :category, :string, null: false
    add_column :posts, :price_range, :string, null: false
    add_column :posts, :uv_cut_rate, :string, null: false
  end
end
