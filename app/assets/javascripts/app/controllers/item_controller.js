App.ItemController = Ember.ObjectController.extend({
  actions: {
    new: function() {
      var newItem = this.store.createRecord('item', {
        description: '',
        ordinal: (this.get('ordinal') + 1)
      });
      newItem.save();
    },
    delete: function() {
      var item = this.get('model'),
          orig = this;
      item.deleteRecord();
      item.save().then(function () {
        if (Ember.isEmpty(orig.get('parentController'))) {
          orig.store.createRecord('item', {
            description: '',
            ordinal: 0
          });
        }
      });
    },
    complete: function() {
      var item = this.get('model');
      item.set('completed', !item.get('completed'));
      item.save();
    },
    update: function() {
      if (Ember.isEmpty(this.get('description'))) {
        this.send('delete');
      } else {
        this.get('model').save();
      }
    }
  },
  isClosed: true,
  completeButtonText: function() {
    if (this.get('model.completed')) {
      return 'Uncomplete';
    } else {
      return 'Complete';
    }
  }.property('completed')
});
