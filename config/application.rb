# frozen_string_literal: true

require File.expand_path('boot', __dir__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w[development test]))

module Smartvpn
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W[#{config.root}/app/models/connections]
    config.autoload_paths += %W[#{config.root}/app/models/traffic_reports]
    config.autoload_paths += %W[#{config.root}/app/models/dto]
    config.autoload_paths += %W[#{config.root}/app/models/promoters]
    config.autoload_paths += %W[#{config.root}/lib]
    config.autoload_paths += %W[#{config.root}/lib/exceptions]

    config.paths['app/views'].unshift(Rails.root.join('app/views/mailers'))

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :en
    I18n.enforce_available_locales = true

    config.assets.precompile += %w[admin.js admin.scss]
    # config.active_record.raise_in_transactional_callbacks = true
  end
end
