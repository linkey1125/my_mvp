class AddResetTokenToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :reset_token, :string
  end
end
