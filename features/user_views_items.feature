Feature: User views items
  In order to see the lists I've created
  As a user
  I want to see all of my lists and items

  @javascript
  Scenario: Success
    Given I have "3" items
    When I visit "/"
    Then I should see my items
