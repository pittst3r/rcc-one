Feature: User adds item
  In order to be able to create a list
  As a user
  I want to add an item to my list

  @javascript
  Scenario: Success
    Given I visit "/"
    When I add a new item containing "do u even add items, bro?"
    Then I should see my new item
