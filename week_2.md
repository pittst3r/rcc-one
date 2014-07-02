# Week 2

We can see our list now, so let's make it so we can add new ones.

# Add item feature

Make a new feature file, `user_adds_item.feature` with:

```gherkin
Feature: User adds item
  In order to be able to create a list
  As a user
  I want to add an item to my list

  @javascript
  Scenario: Success
    Given I visit "/"
    When I add a new item containing "do u even add items, bro?"
    Then I should see my new item
```

And add some new item step defs in `features/step_definitions/item_steps.rb`:

```ruby
```
