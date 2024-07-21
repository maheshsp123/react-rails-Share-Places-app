require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SharedPlaceRails6
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Middleware for handling Cross-Origin Resource Sharing (CORS),
    # making cross-origin AJAX possible.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3000' # Frontend origin
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true
      end
    end

    # Add services to the autoload paths if needed
    config.autoload_paths += %W(#{config.root}/app/services)
  end
end
