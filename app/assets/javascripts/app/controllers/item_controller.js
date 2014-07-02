App.ItemController = Ember.ObjectController.extend({
  actions: {
    deleteItem: function() {
      var item = this.get('model');
      item.deleteRecord();
      item.save();
    },
    editItem: function() {
      this.set('isEditing', true);
    },
    updateItem: function() {
      this.set('isEditing', false);

      if (Ember.isEmpty(this.get('model.content'))) {
        this.send('deleteItem');
      } else {
        this.get('model').save();
      }

      this.$().blur();
    }
  },
  isClosed: true
});
