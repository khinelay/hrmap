require "capybara/rspec"
require 'rspec/example_steps'
require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require File.expand_path(File.dirname(__FILE__) + "/support/helpers")

include HelperMethods

include Warden::Test::Helpers
Warden.test_mode!

DatabaseCleaner.strategy = :truncation
Capybara.default_selector = :css
Capybara.save_and_open_page_path = File.expand_path(File.dirname(__FILE__) + "/../tmp/")
Capybara.default_wait_time = 35
Capybara.server_port = 8888 + ENV['TEST_ENV_NUMBER'].to_i

RSpec.configure do |config|
  config.include Capybara::DSL
  config.use_transactional_fixtures = false

  DatabaseCleaner.clean

  config.before(:each) do
    if example.options[:js]
      Capybara.current_driver = :selenium
      Capybara.current_session.driver.browser.manage.window.resize_to(1280, 720)
    end
  end

  config.after(:each) do
    Capybara.use_default_driver if example.options[:js]
    Warden.test_reset!
  end
end
