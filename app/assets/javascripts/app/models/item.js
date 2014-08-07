App.Item = DS.Model.extend({
  description: DS.attr('string'),
  ordinal: DS.attr('number'),
  completed: DS.attr('boolean')
});
