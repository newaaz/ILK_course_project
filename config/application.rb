require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ilk
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru

    config.time_zone = "Moscow"
    # config.eager_load_paths << Rails.root.join("extras")

    config.autoload_paths += [config.root.join('app')]

    config.active_storage.replace_on_assign_to_many = false

    config.generators do |g|
      g.test_framework :rspec,
                        controller_specs: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        request_specs: false
    end
  end
end
