# Week 1

To browse the resultant code of this week, see the [`week_1` branch](https://github.com/sweatypitts/rcc-one/tree/week_1)

## Create app

Before proceeding, be sure to have your environment in the state you are brought to by the end of the README. This means you have already cloned this repo onto your computer and you are currently inside the repo's directory.

```shell
rails new ./ --skip-javascript --skip-test-unit
rake db:migrate
atom
```

The first command creates a Rails project in the current directory. We are using the options `--skip-javascript` and `--skip-test-unit` because otherwise files would be added that would conflict with the environment we will be building.

The second command will create our database since we don't have one yet. If we had migrations it would run the migrations too. You will learn briefly about migrations later.

The third command opens up the atom text editor. If you're using another editor like Vim, you can use that command instead. If your preferred editor doesn't have a command for the terminal, open up the project folder in your editor in whatever way you need to.

## Update Gemfile

Now that we are in our text editor, open up the `Gemfile` file. Delete everything in it and replace it with the following:

```ruby
source 'https://rubygems.org'

ruby '2.1.2'

gem 'rails', '4.1.4'

gem 'sqlite3'

gem 'coffee-rails'
gem 'haml-rails'
gem 'sass-rails'

gem 'therubyracer', platforms: :ruby

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'poltergeist'
  gem 'rspec-rails'
end
```

These are the gems we will need for our project. You will run into most of these during the course of the project. For now, it's not important that you know about them.

## Install RSpec

RSpec is the unit testing framework that we'll be using. Unit tests are frequently synonymous with model tests, as they are with Rails. Models are our interface to our database and manage our data for us; thus, it's important that we are confident they are working as expected. The following command sets up RSpec in our project. You'll notice that RSpec was a gem included in our Gemfile.

```shell
rails generate rspec:install
```

Now we'll want to add RSpec to our default rake task. Rake is a gem which is included in the Rails gem that runs jobs/tasks for us. The default rake task is run when we enter the `rake` command in our terminal without any subcommands. It is a Rails convention that the default rake task runs our entire test suite, which is why we're doing this. Create a new file in `lib/tasks/` called `test.rake` and make the contents of the file the following:

```ruby
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
```

Run `rake` in your terminal, observe lack of tests.

Open `spec/spec_helper.rb`.

Add the following requires at the top:

```ruby
require 'factory_girl'
require 'database_cleaner'
```

And make the `RSpec.config` block look like so:

```ruby
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.mock_with :rspec
  config.order = "random"

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation, pre_count: true)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
```

## Install Cucumber

Cucumber is another testing tool, but it is for features. It runs through our app like a human testing functionality we define in cucumber tests. This way, if we make a change in one place which inadvertently breaks something else, and we run our tests, we'll know about it (given we've written good tests).

```shell
rails generate cucumber:install
```

Cucumber adds itself to the default rake task, so we should now be able to run `rake` and run both cukes and specs. Give it a try:

```shell
rake
```

We also need to need to set up Cucumber to use `factory_girl` and tell it how to execute javascript when it runs tests in its headless browser, which it will not do by default. `factory_girl` is a tool we will use to create model instances and populate our database as needed for each test. In `features/support/env.rb` add the following requires to the top:

```ruby
require 'factory_girl'
require 'capybara/poltergeist'
```

And add the following to the bottom of the file:

```ruby
World(FactoryGirl::Syntax::Methods)
Capybara.javascript_driver = :poltergeist
```

## Write our first cuke

Add `features/user_views_items.feature` file, open it.

Now add this feature:

```gherkin
Feature: User views items
  In order to see the lists I've created
  As a user
  I want to see all of my lists and items

  @javascript
  Scenario: Success
    Given I have "3" items
    When I visit "/"
    Then I should see my items
```

Now `rake`. We should have a bunch of undefined steps now. Let's add them.

In `features/step_definitions/navigation_steps.rb`:

```ruby
When(/^I visit "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
```

In `features/step_definitions/item_steps.rb`:

```ruby
Given(/^I have "(.*?)" items?$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see my items?$/) do
  pending # express the regexp above with the code you wish you had
end
```

Now if you run `rake` again, you should see different output. The first step should come up as pending, and the rest skipped. Let's start defining the step definitions now. We'll do them in the order in which they're called. Make the first one look like so:

```ruby
When(/^I visit "(.*?)"$/) do |path|
  visit path
end
```

And `item_steps.rb` like this:

```ruby
Given(/^I have "(\d+)" items?$/) do |kount|
  @items = create_list :item, kount.to_i
end

Then(/^I should see my items?$/) do
  @items.each do |i|
    has_selector? "input[value='#{i}']"
  end
end
```

Now `rake`. It should fail with this message:

```
No route matches [GET] "/" (ActionController::RoutingError)
./features/step_definitions/navigation_steps.rb:2:in `/^I visit "(.*?)"$/'
features/user/item/create.feature:7:in `When I visit "/"'
```

This is telling is that it can't find the route we told it to go to. This is good, because we haven't made that route yet. Let's do that now.

In `config/routes.rb` delete all the commented garbage and replace it with:

```ruby
root 'items#index'
resources :items
```

`rake` again. It will still fail, as it should. You are now in the middle of the TDD pattern. You write a test defining the behavior you want, then write the code to make the test pass.

The current failure should be telling us we need the `ItemsController`. Let's add that now. Create the file `app/controllers/items_controller.rb` and make it look like this:

```ruby
class ItemsController < ApplicationController

  def index
    @items = Item.all
    respond_to do |format|
      format.html
      format.json { render json: { items: @items } }
    end
  end

end
```

`rake` again. Now our template is missing. It can find the action but it doesn't know what to render. Create the file `app/views/items/index.html.haml`. At this point I think we're smart enough to anticipate what the next failure will be, so lets speed things up by making the next step pass too. In order to do that, we need to add the appropriate content to the view we just made, along with defining the next step def.

Make the view look like this:

```haml
%ul
  - @items.each do |i|
    %li= i.description
```

Observe `Item.all` in the controller. The `Item` object does not exist yet. It should be a model, but we haven't made it. Because of this, we know the test will definitely fail. We need to add some more stuff to make our second step pass. In your terminal do the following:

```shell
rails g model item description:string
```

If you've set up Rails as described above, this should only generate two files: the model file and the migration file. Let's run the migration and create an item now.

```shell
rake db:migrate
rails runner "Item.create(description: 'asdf')"
```

Now we need to fill in the step def for entering text in the form field. We're going to boot up the development rails server to take a peek at the ids on the form and field we're trying to fill in. Run the following in your terminal:

```shell
rails server
```

Now go to `localhost:3000` in your browser. You should see your item.

Go back to your terminal and shut down the server by doing Ctl+C , then `rake`. Green!

We're not done yet though. We want this page to use ember.js to display and manage items.

## Set up Ember.js

In your terminal run `bower init` and go through the interactive prompt. You can use the defaults, except you want to opt to keep this package private—we're not publishing it, it's for our use only.

Make a new file in the root directory of the project named `.bowerrc` and make it look like this:

```json
{
  "directory": "vendor/assets/lib"
}
```

What this does is save packages managed by bower in the defined directory rather than `./bower_components`, the default.

Now run the following commands:

```shell
bower install jquery#2.1.0 --save
bower install ember#1.6.0-beta.5 --save
bower install ember-data#1.0.0-beta.8 --save
```

Create the directory `app/assets/javascripts/app` and create a file called `application.js` in it with the following contents:

```javascript
App = Ember.Application.create();

App.ApplicationStore = DS.Store.extend({
  adapter: DS.ActiveModelAdapter
});
```

This creates our Ember app and tells it what kind of data store adapter to use.

Create our Ember model in `app/assets/javascripts/app/models/item.js`:

```javascript
App.Item = DS.Model.extend({
  description: DS.attr('string')
});
```

This tells Ember what our model looks like.

And now our router in `app/assets/javascripts/app/router.js`:

```javascript
App.Router.map(function() {
  this.resource('items', { path: '/' });
});

App.ItemsRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('item');
  }
});
```

Observe the variations on the word 'item' throughout the above files. If we follow convention, Ember makes it all work automagically.

This won't work yet though if we don't include the scripts on our page.

Rename `app/assets/javascripts/application.js` to `app/assets/javascripts/main.js` and make it look like this:

```javascript
//= require jquery/dist/jquery
//= require handlebars/handlebars
//= require ember/ember
//= require ember-data/ember-data
//= require app
```

This is requiring our bower packages and one more file that we still need to create, `app/assets/javascripts/app.js`:

```javascript
//= require app/application
//= require_directory ./app/models
//= require app/router
```

We are using this file to require all the Ember files.

Because we've included these files in this way, we only need to require one file in our layout view. Rename `app/views/layouts/application.html.erb` to `app/views/layouts/application.html.haml` and make it look like this:

```haml
!!!
%html
  %head
    %title Richmond Computer Club
    = stylesheet_link_tag 'application', media: "all"
    = javascript_include_tag 'main'
    = csrf_meta_tags
  %body
    = yield
```

Notice how we're requiring the `main.js` file.

One last thing... our `app/views/items/index.html.haml` template needs to be modified to use with Ember:

```haml
%script{ type: 'text/x-handlebars', data: { template_name: 'items' } }
  %ul
    {{#each}}
    %li {{description}}
    {{/each}}
```

The script tag tells Ember what to render here. The double curly braces are a handlebars thing. If you look at it, the above is pretty self-explanatory.

If you fire up your server again, you should still see your item. Run `rake` again. Still green!
