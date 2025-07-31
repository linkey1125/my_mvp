require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "メール・パスワードがあれば有効である" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "メールがないと無効である" do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "パスワードが短すぎると無効である" do
      user = build(:user, password: "123")
      expect(user).not_to be_valid
    end

    it "重複したメールは登録できない" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new({
        provider: "google_oauth2",
        uid: "123456",
        info: {
          email: "google@example.com",
          name: "Google User"
        }
      })
    end

    it "新規ユーザーを作成できる" do
      expect {
        User.from_omniauth(auth)
      }.to change(User, :count).by(1)
    end

    it "既存ユーザーと紐づけられる" do
      user = create(:user, email: "google@example.com")
      expect {
        User.from_omniauth(auth)
      }.not_to change(User, :count)
      expect(user.reload.provider).to eq("google_oauth2")
    end
  end

  describe "#recommended_posts" do
  let(:user) { create(:user) }

  before do
    create(:post, title: "UVカットワンピース", content: "夏におすすめ", created_at: 1.day.ago)
    create(:post, title: "通気性抜群のシャツ", content: "汗をかいても快適", created_at: 2.days.ago)
    create(:search_history, user: user, keyword: "ワンピース")
  end

  it "検索履歴に基づいた投稿が返る" do
    results = user.recommended_posts
    expect(results.pluck(:title)).to include("UVカットワンピース")
    expect(results.pluck(:title)).not_to include("通気性抜群のシャツ")
  end

  it "履歴が空なら新着投稿が返る" do
    user.search_histories.destroy_all
    results = user.recommended_posts
    expect(results).not_to be_empty
    expect(results.first).to be_a(Post)
  end
end
end
