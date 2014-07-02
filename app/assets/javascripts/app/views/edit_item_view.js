App.EditItemView = Ember.TextField.extend({
  didInsertElement: function() {
    var elem = this;
    elem.$().keydown(function(evt) {
      if (evt.which == 27) {
        elem.sendAction('focus-out');
      }
    });
  },
  type: 'text'
});

Ember.Handlebars.helper('edit-item', App.EditItemView);
