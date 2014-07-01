App.Router.map(function() {
  this.resource('items', { path: '/' });
});

App.ItemsRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('item');
  }
});
