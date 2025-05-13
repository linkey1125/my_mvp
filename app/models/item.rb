class Item < ApplicationRecord
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorited_users.include?(user)
  end
end
