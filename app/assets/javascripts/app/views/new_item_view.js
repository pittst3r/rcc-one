App.NewItemView = Ember.TextField.extend({
  didInsertElement: function() {
    var elem = this;
    elem.$().keydown(function(evt) {
      if (evt.which == 27) {
        elem.$().blur();
      }
    });
  },
  type: 'text',
  placeholder: 'New item'
});

Ember.Handlebars.helper('new-item', App.NewItemView);
