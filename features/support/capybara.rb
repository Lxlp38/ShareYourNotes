require "capybara"
require "capybara/cucumber"
require "selenium-webdriver"

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :selenium
Capybara.javascript_driver = :selenium

Capybara::Selenium::Driver.class_eval do
    def quit
        if ENV['DEBUG'] == 'true'
            puts "Browser is still open"
        else
            super
        end
    end
end