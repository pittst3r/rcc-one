App.EditItemView = Ember.TextField.extend({
  type: 'text',
  didInsertElement: function() {
    if (Ember.isEmpty(this.get('value'))) {
      this.$().focus();
    }
  }
});

Ember.Handlebars.helper('edit-item', App.EditItemView);
