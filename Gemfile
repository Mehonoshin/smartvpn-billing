# frozen_string_literal: true

source 'http://rubygems.org'
# TODO:
# temporary disable http, until ruby upgrade with new openssl
# source 'https://rubygems.org'

gem 'rails', '5.2.3'

gem 'pg'
gem 'pghero'
gem 'thin'

gem 'chartkick'

gem 'activemerchant'
gem 'money'
gem 'offsite_payments'
gem 'bootstrap', '~> 4.3.1'
gem 'cancan'
gem 'devise', '4.6.2'
gem 'devise-i18n', '~> 1.8'
gem 'font-awesome-sass', '~> 5.8.1'
gem 'kaminari'
gem 'rails-i18n'
gem 'simple_form'
gem 'slim'
# TODO: switch to stable version
gem 'state_machine', github: 'pluginaweek/state_machine'
# Temporary broken with rails 4.2
gem 'active_model_serializers', '0.10.9'

gem 'ransack', '2.1.1'

# TODO: switch to stable version
gem 'carrierwave'
gem 'draper', '3.1'
gem 'gibbon'
gem 'mechanize'
gem 'config'
gem 'russian_central_bank'
gem 'show_for', github: 'plataformatec/show_for'
gem 'whenever', '0.11', require: false

gem 'sidekiq'
gem 'sinatra', require: false

# TODO: make it optional via ENV flag
gem 'rollbar'
# TODO: make it optional via ENV flag
gem 'newrelic_rpm'

gem 'json', '~> 2.2'
gem 'thread_safe', '0.3.6'

group :assets do
  gem 'coffee-rails', '~> 5.0'
  gem 'sass-rails'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'ffi', '>= 1.10'
gem 'jbuilder', '~> 2.8'
gem 'puma'

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'foreman'
  gem 'letter_opener'
  gem 'migration_opener'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'sandi_meter', require: false
  gem 'web-console', '~> 3.7'
end

group :test, :development do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.7'
  gem 'hirb'
  gem 'mocha', require: false
  gem 'rb-fchange', require: false
  gem 'vcr'
  # TODO: switch to stable version
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.9'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'timecop'
end

group :test do
  gem 'simplecov', require: false
  # TODO: switch to webmock since fakeweb is not supported anymore
  gem 'capybara-email'
  gem 'fakeweb', github: 'chrisk/fakeweb'
  gem 'zonebie'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'rails-controller-testing'
end
