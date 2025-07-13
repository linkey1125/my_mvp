class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 同じユーザーが同じ投稿に複数レビューできないようにする
  validates :user_id, uniqueness: { scope: :post_id, message: "は既にレビュー済みです" }

  # 評価は1〜5のみ許可
  validates :rating, inclusion: { in: 1..5, message: "は1〜5の範囲で入力してください" }

  # 任意: コメント必須にしたいならこれも追加
  # validates :comment, presence: true
end
