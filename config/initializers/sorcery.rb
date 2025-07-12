Rails.application.config.sorcery.submodules = [:remember_me]

Rails.application.config.sorcery.configure do |config|
  config.user_class = 'User'   # ← ここは外側に

  config.user_config do |user|
    user.stretches = Rails.env.test? ? 1 : 12
    user.remember_me_for = 2.weeks
  end
end
