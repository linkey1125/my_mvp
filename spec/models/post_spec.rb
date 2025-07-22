require 'rails_helper'

RSpec.describe Post, type: :model do
  # FactoryBotがあれば使うのがおすすめです。なければnewで代用。

  describe "バリデーション" do
    it "タイトルとコンテンツがあれば有効" do
      post = Post.new(title: "タイトル", content: "コンテンツ")
      expect(post).to be_valid
    end

    it "タイトルがなければ無効" do
      post = Post.new(title: nil, content: "コンテンツ")
      expect(post).not_to be_valid
      expect(post.errors[:title]).to include("can't be blank")
    end

    it "コンテンツがなければ無効" do
      post = Post.new(title: "タイトル", content: nil)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end
  end

  describe "アソシエーション" do
    it { should belong_to(:user) }
    it { should have_many(:favorites) }
  end
end
