window.App = Ember.Application.create();

App.ApplicationStore = DS.Store.extend({
  adapter: DS.ActiveModelAdapter
});

$(function() {
  var token = $('meta[name="csrf-token"]').attr('content');
  return $.ajaxPrefilter(function(options, originalOptions, xhr) {
    return xhr.setRequestHeader('X-CSRF-Token', token);
  });
});
