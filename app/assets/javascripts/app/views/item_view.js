App.ItemView = Ember.View.extend({
  tagName: 'li',
  templateName: 'item',
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
