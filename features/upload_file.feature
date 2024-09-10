Feature: Upload file functionality
  As a logged-in user
  I want to upload a file from my local storage via the ShareYourNotes home page
  So that I can share ready-made files

   Scenario: User uploads a file 
    Given Login functionality - login.feature
    And I am on the home page
    When I click on the "Upload" link
    And I fill in the "Title" field with "Sistemi di calcolo 2"
    And I select the file "SC2.pdf" in the pdf field
    And I fill in the "Tag" field with "sdc"
    And I fill in the "Selezionare un corso" field with "Lettere"
    And I click on the "Create Note" button
    Then I should be redirected to the note show page
