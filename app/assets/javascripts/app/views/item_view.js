App.ItemView = Ember.View.extend({
  didInsertElement: function() {
    var item = this;
    item.$().find('.item-control').mouseenter(function() {
      item.get('controller').set('isClosed', false);
    });
    item.$().find('.item-menu').mouseleave(function() {
      item.get('controller').set('isClosed', true);
    });
  }
});
