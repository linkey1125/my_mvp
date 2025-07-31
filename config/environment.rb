# config/environment.rb

# Load the Rails application.
require_relative "boot"                # ← まず boot.rb を読み込む
require "rails/all"
require "dotenv/load"

# Require the gems listed in Gemfile
Bundler.require(*Rails.groups)

require_relative "application"        # ← application.rb を読み込む

# Initialize the Rails application.
Rails.application.initialize!
