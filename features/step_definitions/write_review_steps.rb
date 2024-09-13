
When ("I click on a note") do
    visit '/notes/1'
end

When("I click the 'Leave a Review' button") do
    find('a', text: 'Leave a Review').click
    expect(page).to have_selector('#staticReview.modal.show', visible: true)  
end


When("I fill in the {string} field with {string}") do |field, content|
    fill_in field, with: content
end

When("I click on the {string} button") do |button|
    click_button button
end

Then("I expect to see an alert with the message {string}") do |message|
    expect(page).to have_content(message)
end

