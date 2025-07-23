require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "バリデーション" do
    it "タイトルと内容があれば有効" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "タイトルがないと無効" do
      post = build(:post, title: nil)
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("を入力してください")
    end

    it "内容がないと無効" do
      post = build(:post, content: nil)
      expect(post).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it "ユーザーと関連している" do
      user = create(:user)
      post = create(:post, user: user)
      expect(post.user).to eq(user)
    end
  end
end
