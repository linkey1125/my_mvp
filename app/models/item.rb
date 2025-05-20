class Item < ApplicationRecord
  belongs_to :post
  has_one_attached :image
  has_many :favorites
  has_many :favorited_users, through: :favorites, source: :user

  validates :uv_cut_rate, :category, :price_range, presence: true
  validate :image_presence

  def favorited_by?(user)
    favorited_users.include?(user)
  end

  private

  def image_presence
    errors.add(:image, "をアップロードしてください") unless image.attached?
  end
end
