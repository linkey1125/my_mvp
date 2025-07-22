Rails.application.config.sorcery.submodules = [:remember_me, :external]

Rails.application.config.sorcery.configure do |config|
  config.user_class = 'User'  # ← 外側に正しく置かれていてOK

  # ✅ 外部プロバイダー設定
  config.external_providers = [:google]

  config.google.key = ENV['GOOGLE_CLIENT_ID']
  config.google.secret = ENV['GOOGLE_CLIENT_SECRET']
  config.google.callback_url = "http://localhost:3000/users/auth/google_oauth2/callback"
  config.google.user_info_mapping = { email: 'email', name: 'name' }
  config.google.scope = 'openid email profile'

  # ✅ ユーザー設定
  config.user_config do |user|
    user.stretches = Rails.env.test? ? 1 : 12
    user.remember_me_for = 2.weeks
  end
end
