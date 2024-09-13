
Feature: Write a Review
  As a logged-in user
  I want to leave a review
  So that I can help other users choose notes.

  Background:
    Given I am on the login page
    When I fill in the login "Email" with "apa.1713337@studenti.uniroma1.it"
    And I fill in the login "Password" with "Admin@2"
    And I click the login "Log In" button
    Then I should be on the notes page

  Scenario: Write a review
    When I click on a note
    And I click the 'Leave a Review' button
    And I select the rating of 5 stars
    And I fill in the "Title" field with "Bellissima nota"
    And I fill in the "Text" field with "Nota motlo utile"
    And I click on the "Submit" button
    Then I expect to see an alert with the message "success"