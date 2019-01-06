require 'simplecov'
SimpleCov.start

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'sidekiq/testing'
require 'capybara/rails'
require 'capybara/rspec'
require 'shoulda-matchers'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("app/helpers/**/*.rb")].each {|f| require f}
Dir[Rails.root.join("spec/shared_examples/*.rb")].each {|f| require f}

Capybara.javascript_driver = :selenium_chrome_headless
Zonebie.set_random_timezone
FakeWeb.allow_net_connect = false
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.mock_with :mocha

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.infer_spec_type_from_file_location!

  config.include ApplicationHelper, :type => :feature
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Requests::JsonHelpers, :type => :controller
  config.extend  Requests::ControllerMacros, :type => :controller

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do |example|
    if example.metadata[:disable_transaction]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.before(:each, type: :feature) do
    # Для капибарных тестов заполним редис курсами, чтобы не пытался стянуть их из инета
    redis = Redis.new
    redis.set("smartvpn:eur_usd", 10)
    redis.set("smartvpn:rub_usd", 10)

    FakeWeb.allow_net_connect = true
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
