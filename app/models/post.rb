class Post < ApplicationRecord
  belongs_to :user
  has_one :item, dependent: :destroy
  accepts_nested_attributes_for :item

  validates :title, presence: true
  validates :content, presence: true
end
