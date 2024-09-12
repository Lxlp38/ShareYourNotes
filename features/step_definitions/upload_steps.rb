# features/step_definitions/upload_steps.rb

Given /^Login functionality - login\.feature$/ do

end

Given("I am on the home page") do
  visit '/'
end

When('I click on the {string} link') do |link_text|
  # Utilizzo di attesa esplicita per il link
  click_link(link_text)
end

When("I fill in the {string} field with {string}") do |field, value|
  fill_in field, with: value
end

When("I select the file {string} in the pdf field") do |file_name|
  desktop_path = File.join(Dir.home, 'Scrivania', file_name)
  attach_file('pdf_field', desktop_path)
  # Assicurati che 'pdf_field' corrisponda all'ID o al nome del campo del file nella tua pagina di upload
end

When("I click on the {string} button") do |button_text|
  click_button button_text
end
  Then("I should be redirected to the note show page") do
    expect(page).to have_current_path(note_path)
    # Sostituisci 'note_path' con il percorso effettivo della pagina show della nota
  end
  