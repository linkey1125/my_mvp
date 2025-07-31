require 'rails_helper'

RSpec.describe "Session管理", type: :request do
  let(:user) { create(:user, password: "password", password_confirmation: "password") }

  describe "ログイン処理" do
    it "正しい情報でログイン成功" do
      post login_path, params: {
        email: user.email,
        password: "password"
      }
      expect(response).to redirect_to(user_path(user))
      follow_redirect!
      expect(response.body).to include("ログインしました！")
    end

    it "間違った情報でログイン失敗" do
      post login_path, params: {
        email: user.email,
        password: "wrong"
      }
      expect(response.body).to include("メールアドレスまたはパスワードが間違っています")
    end
  end

  describe "ログアウト処理" do
    it "ログアウトしてルートにリダイレクト" do
      login_as(user)
      delete logout_path
      expect(response).to redirect_to(root_path)
    end
  end
end
