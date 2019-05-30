require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

begin
  ENV.update YAML.safe_load(File.read('config/application.yml'))[Rails.env]
rescue StandardError
  {}
end

module TargetAPP
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.generators do |g|
      g.test_framework :rspec
    end
    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Origin' => '*'
    }
    config.action_cable.allowed_request_origins = [%r{http://*}, %r{https://*}]
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'

        resource '*',
                 headers: :any,
                 methods: %i[get post put patch delete options head],
                 expose: ['access-token', 'uid', 'client']
      end
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
