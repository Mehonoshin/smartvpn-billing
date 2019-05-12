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

gem 'aasm'
gem 'active_model_serializers', github: 'rails-api/active_model_serializers', branch: '0-9-stable'
gem 'activemerchant', '~> 1.93'
gem 'bootstrap', '~> 4.3.1'
gem 'cancan'
gem 'clockwork'
gem 'devise', '4.6.2'
gem 'devise-i18n', '~> 1.8'
gem 'font-awesome-sass', '~> 5.8.1'
gem 'kaminari'
gem 'money'
gem 'offsite_payments'
gem 'rails-i18n'
gem 'simple_form'
gem 'slim'

gem 'ransack', '2.1.1'

# TODO: switch to stable version
gem 'carrierwave'
gem 'config'
gem 'draper', '3.1'
gem 'gibbon'
gem 'mechanize'
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

group :development do
  gem 'awesome_print'
  gem 'better_errors'
  gem 'foreman'
  gem 'letter_opener'
  gem 'migration_opener'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'sandi_meter', require: false
  gem 'web-console', '~> 3.7'
end

group :test, :development do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.7'
  gem 'dotenv-rails'
  gem 'hirb'
  gem 'mocha', require: false
  gem 'rb-fchange', require: false
  # TODO: switch to stable version
  gem 'factory_bot_rails', '~> 4.9'
  gem 'faker'
  gem 'i18n-tasks', '~> 0.9.29'
  gem 'pry-rails'
  gem 'rails-controller-testing'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 4.0.1'
  gem 'timecop'
  gem 'vcr'
end

group :test do
  gem 'simplecov', require: false
  # TODO: switch to webmock since fakeweb is not supported anymore
  gem 'capybara-email'
  gem 'clockwork-test'
  gem 'fakeweb', github: 'chrisk/fakeweb'
  gem 'zonebie'
end
