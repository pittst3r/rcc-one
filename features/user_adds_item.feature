Feature: User adds item
  In order to be able to create a list
  As a user
  I want to add an item to my list

  @javascript
  Scenario: No items yet
    Given I visit "/"
    When I add a new item containing "do u even add items, bro?"
    Then I should see my new item

  @javascript
  Scenario: Existing items
    Given I have "3" items
    And I visit "/"
    When I add a new item containing "do u even add items, bro?"
    Then I should see my items
    And I should see my new item
