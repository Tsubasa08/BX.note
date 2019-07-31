require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_chrome_headless
    Capybara.current_session.driver.browser.manage.window.resize_to(1300, 800)
  end
end