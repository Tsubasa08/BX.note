Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, 
    browser: :chrome,
    desired_capabilities: {
      "chromeOptions" => {
        "args" => %w{ window-size=1400,768 }
      }
    }
  )
end