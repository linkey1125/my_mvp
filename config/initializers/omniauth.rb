# config/initializers/omniauth.rb
Rails.logger.info "🚀 OmniAuth initializer has loaded!"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV['GOOGLE_CLIENT_ID'],
           ENV['GOOGLE_CLIENT_SECRET'],
           {
             scope: 'email,profile',
             prompt: 'select_account'
           }
end
