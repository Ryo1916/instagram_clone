require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstagramClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Customize the generator command
    config.generators do |g|
      g.stylesheets false
      g.javascripts false
    end

    # Use secrets.yml for credentials
    config.read_encrypted_secrets = true

    # Embed auth token to remote form
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
