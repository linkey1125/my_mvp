require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
    config.active_job.queue_adapter = :async
    config.autoload_lib(ignore: %w[assets tasks])
    config.eager_load_paths << Rails.root.join('test/mailers/previews')

  end
end
