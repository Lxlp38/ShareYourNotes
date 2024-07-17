require 'rspec/expectations'


Given("I am on the login page") do
    visit new_user_session_path
    # Assicurati che `new_user_session_path` sia il percorso corretto per la pagina di login
end
When('I fill in {string} with {string}') do |field, value|
    fill_in field, with: value
  end
  
  When('I click the {string} button') do |button|
    click_button button
  end
  
  Then('I should see {string}') do |text|
    expect(page).to have_content(text)
  end
  