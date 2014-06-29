Feature: User adds item
  In order to have a place to keep lists
  As a user
  I want to add a new item

  Scenario: Success
    When I visit "/"
    And I enter "my sweet list item" in the new item field
    And I press "return"
    Then I should see "great success"
    And I should see "my sweet list item"
