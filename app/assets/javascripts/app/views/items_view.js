App.ItemsView = Ember.View.extend({
  tagName: 'ul',
  templateName: 'items',
  didInsertElement: function() {
    var elem = this;
    if (Ember.isEmpty(elem.get('controller').content)) {
      elem.get('controller').send('new');
    }
  }
});
