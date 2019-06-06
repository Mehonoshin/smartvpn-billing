# frozen_string_literal: true

source 'http://rubygems.org'
# TODO: temporary disable http, until ruby upgrade with new openssl
# source 'https://rubygems.org'

gem 'rails', '~> 5.2', '>= 5.2.3'
gem 'pg'
gem 'pghero'
gem 'thin'

gem 'chartkick'

gem 'aasm'
gem 'activemerchant', '~> 1.93'
gem 'money'
gem 'offsite_payments'
gem 'bootstrap', '~> 4.2.1'
gem 'cancan'
gem 'clockwork'
gem 'devise', '4.5.0'
gem 'devise-i18n', '~> 0.10.3'
gem 'font-awesome-sass', '~> 5.6.1'
gem 'kaminari'
gem 'rails-i18n'
gem 'simple_form'
gem 'slim'
# Temporary broken with rails 4.2
gem 'active_model_serializers' # , github: 'rails-api/active_model_serializers', branch: '0-9-stable'

gem 'ransack', '2.1.1'

# TODO: switch to stable version
gem 'carrierwave'
gem 'draper', '3.1'
gem 'gibbon'
gem 'mechanize'
gem 'config'
gem 'russian_central_bank'
gem 'show_for', github: 'plataformatec/show_for'
gem 'whenever', '0.9.0', require: false

gem 'sidekiq'
gem 'sinatra', require: false

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

gem 'ffi', '>= 1.9.24'
gem 'jbuilder', '~> 2.8'

group :development do
  gem 'better_errors'
  gem 'foreman'
  gem 'letter_opener'
  gem 'migration_opener'
  gem 'rubocop', require: false
  gem 'sandi_meter', require: false
  gem 'web-console', '~> 3.7'
end

group :test, :development do
  gem 'capybara'
  gem 'database_cleaner', '1.0.0.RC1'
  gem 'dotenv-rails'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
  gem 'i18n-tasks', '~> 0.9.28'
  gem 'pry-rails'
  gem 'rspec-its'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'vcr'
  # TODO: switch to stable version
  gem 'selenium-webdriver'
  gem 'timecop'
end

group :test do
  gem 'simplecov', require: false
  # TODO: switch to webmock since fakeweb is not supported anymore
  gem 'capybara-email'
  gem 'clockwork-test'
  gem 'fakeweb', github: 'chrisk/fakeweb'
  gem 'zonebie'
  gem 'rails-controller-testing'
end
