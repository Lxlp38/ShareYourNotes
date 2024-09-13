require 'rspec/expectations'

Given("I am on the login page") do
  visit new_user_session_path 
end

When('I fill in the login {string} with {string}') do |field, value|
  fill_in field, with: value
end

And('I click the login {string} button') do |button|
  click_button button
end

Then('I should be on the notes page') do
  expect(current_path).to eq("/")
end
