require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  let(:user) { User.create(email: "test@example.com", password: "password") }

  before do
    driven_by(:rack_test)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: "password"
    click_button "ログイン"
  end

  it "新規投稿ができる" do
    visit new_post_path

    fill_in "タイトル", with: "テスト投稿"
    fill_in "本文", with: "投稿の内容"
    select "アパレル", from: "カテゴリ"
    select "99.9%以上", from: "UVカット率"
    select "3000-4999円", from: "金額"

    image_path = Rails.root.join("spec/fixtures/test_image.jpg")
    attach_file("画像", image_path)

    click_button "投稿する"

    expect(page).to have_content("テスト投稿")
    expect(page).to have_content("投稿の内容")
  end
end
