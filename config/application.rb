require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 8.0

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",  # SendGrid などに切り替え可能
      port: 587,
      domain: "your-app.onrender.com",
      user_name: ENV["SMTP_USERNAME"],
      password: ENV["SMTP_PASSWORD"],
      authentication: "plain",
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = { host: "your-app.onrender.com", protocol: "https" }

    config.autoload_lib(ignore: %w[assets tasks])
    config.eager_load_paths << Rails.root.join("test/mailers/previews")
    config.eager_load_paths << Rails.root.join("app/mailers")
  end
end
