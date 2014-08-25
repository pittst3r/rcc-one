# Week 2

Before beginning, you will need to start up your vagrant instance again if you've suspended it, then ssh into it, and cd to the project file:

First, open up your terminal and cd into your project directory with the below command. If you've created your project directory in the same place that I have your command will look like this. If not, change the path as necessary.

```shell
cd ~/repos/rcc-one
```

Now, fire up vagrant:

```shell
vagrant up
```

Once it's done, ssh into it with the vagrant helper command for this:

```shell
vagrant ssh
```

Now cd to the project directory that's mirrored to the project directory on your computer. This path is the same for everybody and is a vagrant default:

```shell
cd /vagrant
```

Now we're ready to start!

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

We can see our list now, so let's make it so we can add new ones.

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
