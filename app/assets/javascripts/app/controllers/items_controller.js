App.ItemsController = Ember.ArrayController.extend({
  actions: {
    newItem: function() {
      var item = this.store.createRecord('item', {
        content: ''
      });
      item.save();
      item.$().focus();
    },
    createItem: function() {
      var content = this.get('newContent');
      if (!Ember.isEmpty(content)) {
        var item = this.store.createRecord('item', {
          content: content
        });
        this.set('newContent', '');
        item.save();
      }
    }
  }
});
