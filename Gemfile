source 'http://rubygems.org'
# TODO:
# temporary disable http, until ruby upgrade with new openssl
# source 'https://rubygems.org'

ruby '2.5.3'

gem 'rails', '5.2.1'

gem 'pg'
gem 'pghero'
gem 'thin'

gem 'slim'
gem 'cancan'
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'activemerchant'
gem 'state_machine', github: "pluginaweek/state_machine"
gem 'kaminari'
# Temporary broken with rails 4.2
gem "active_model_serializers"#, github: 'rails-api/active_model_serializers', branch: '0-9-stable'

gem 'ransack'

gem 'show_for', github: 'plataformatec/show_for'
gem 'rails_config'
gem 'whenever', require: false
gem 'carrierwave'
gem 'draper'
gem 'russian_central_bank'
gem 'mechanize'
gem 'world-flags'
gem 'gibbon'

gem 'sinatra', require: false
gem 'sidekiq'
gem 'sidekiq-failures'

gem 'rollbar'
gem 'newrelic_rpm'

gem 'thread_safe'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'jbuilder'

gem 'knife-solo'

group :development do
  gem 'awesome_print'
  gem 'web-console'
  gem 'better_errors'
  gem 'letter_opener'
  gem 'migration_opener'
  gem 'forward'
  gem 'foreman'

  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-nc'

  gem 'rubocop', require: false
  gem 'sandi_meter', require: false
end

group :test, :development do
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem 'hirb'
  gem 'vcr'
  gem 'mocha', require: false
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers'
  gem 'timecop'
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'faker'
end

group :production do
  gem 'unicorn'
end

group :test do
  gem 'simplecov', require: false
  gem 'fakeweb'
  gem 'zonebie'
end
