App.ItemsController = Ember.ArrayController.extend({
  needs: 'item',
  itemController: 'item',
  sortProperties: ['ordinal'],
  sortAscending: true,
  actions: {
    new: function() {
      var newItem = this.store.createRecord('item', {
        description: '',
        ordinal: 0
      });
    }
  }
});
