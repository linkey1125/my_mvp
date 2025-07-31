require 'rails_helper'

RSpec.describe "投稿機能", type: :system do
  let!(:user) do
    User.create!(
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  before do
    driven_by(:rack_test) # rack_testならJSなしでも安定動作

    # ログイン処理
    visit login_path
    fill_in 'email', with: user.email          # ← id="email" に対応
    fill_in 'password', with: 'password'       # ← id="password" に対応
    click_button 'ログイン'
  end

  it "新規投稿ができる" do
    visit new_post_path

    # 投稿フォームへの入力（label一致で指定）
    fill_in 'タイトル', with: 'テスト投稿'
    fill_in '本文', with: '投稿の内容'
    select 'アパレル', from: 'カテゴリ'
    select '99.9%以上', from: 'UVカット率'
    select '3000-4999円', from: '金額'

    # 画像アップロード
    image_path = Rails.root.join("spec/fixtures/test_image.jpg")
    attach_file('画像', image_path)

    # 投稿ボタン
    click_button '投稿する'

    # 結果検証
    expect(page).to have_content('テスト投稿')
    expect(page).to have_content('投稿の内容')
  end
end
