Feature: Login functionality
  As a guest
  I want to login into the website
  Because I want to be able to use my previously made account

  Scenario: Guest logs in with valid credentials
    Given I am on the login page
    When I fill in the login "Email" with "apa.1713337@studenti.uniroma1.it"
    And I fill in the login "Password" with "Admin@2"
    And I click the login "Log In" button
    Then I should be on the notes page

