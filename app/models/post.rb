class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  
  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
  validates :price_range, presence: true
  validates :uv_cut_rate, presence: true
  validates :image, presence: true

  validate :image_presence

  private

  def image_presence
    errors.add(:image, "をアップロードしてください") unless image.attached?
  end
end
