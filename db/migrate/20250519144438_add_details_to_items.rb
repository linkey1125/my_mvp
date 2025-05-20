class AddDetailsToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :uv_cut_rate, :string, null: false
    add_column :items, :category, :string, null: false
    add_column :items, :price_range, :string, null: false
  end
end

