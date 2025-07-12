class AddCryptedPasswordToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :crypted_password, :string
  end
end
