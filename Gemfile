source 'http://rubygems.org'
# TODO:
# temporary disable http, until ruby upgrade with new openssl
# source 'https://rubygems.org'

gem 'rails', '4.2.11'

gem 'pg'
gem 'pghero'
gem 'thin'

gem 'slim'
gem 'cancan'
gem 'devise', '4.5.0'
gem 'devise-i18n', '~> 0.10.3'
gem 'rails-i18n'
gem 'simple_form'
gem 'activemerchant'
# TODO: switch to stable version
gem 'state_machine', github: "pluginaweek/state_machine"
gem 'kaminari'
# Temporary broken with rails 4.2
gem "active_model_serializers"#, github: 'rails-api/active_model_serializers', branch: '0-9-stable'

gem 'ransack', '1.5.1'

# TODO: switch to stable version
gem 'show_for', github: 'plataformatec/show_for'
gem "rails_config"
gem 'whenever', '0.9.0', require: false
gem 'carrierwave'
gem 'draper', '1.4.0'
gem 'russian_central_bank'
gem 'mechanize'
gem 'gibbon'

gem 'sinatra', require: false
gem 'sidekiq'

# TODO: make it optional via ENV flag
gem 'rollbar'
# TODO: make it optional via ENV flag
gem 'newrelic_rpm'

gem 'thread_safe', '0.3.6'
gem 'json', '~> 1.8'

group :assets do
  gem 'sass-rails',   '~> 5.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'jbuilder', '~> 1.0.1'
gem 'puma'
gem "ffi", ">= 1.9.24"

group :development do
  gem 'awesome_print'
  gem 'web-console', '~> 2.0'
  gem "better_errors"
  gem 'letter_opener'
  gem 'migration_opener'
  gem 'foreman'
  gem 'rubocop', require: false
  gem 'sandi_meter', require: false
end

group :test, :development do
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem "hirb"
  gem "vcr"
  gem "mocha", require: false
  gem 'capybara'
  gem 'database_cleaner', "1.0.0.RC1"
  # TODO: switch to stable version
  gem "shoulda-matchers", github: 'thoughtbot/shoulda-matchers'
  gem 'timecop'
  gem "rspec-rails"
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'pry-rails'
end

group :test do
  gem 'simplecov', require: false
  # TODO: switch to webmock since fakeweb is not supported anymore
  gem 'fakeweb', github: 'chrisk/fakeweb'
  gem 'zonebie'
  gem 'capybara-email'
end
