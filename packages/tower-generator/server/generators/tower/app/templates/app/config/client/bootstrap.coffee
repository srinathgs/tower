# Tower.debug = Tower.env == 'development'

<%= app.namespace %>.bootstrap = (data) ->
  # Optimized rendering (force right at bottom of DOM, before DOM ready)
  Ember.Handlebars.bootstrap(Ember.$(document))

  Tower.NetConnection.transport = Tower.StoreTransportAjax
  if Tower.env == 'development'
    Tower.StoreTransportAjax.defaults.async = false
    
  <%= app.namespace %>.initialize()
  <%= app.namespace %>.listen()

  # Force rendering before dom ready (better UX with ember)
  Ember.run.autorun()
  Ember.run.currentRunLoop.flush('render')

if Tower.env == 'development'
  $ ->
    # This is a quick way to start watching for stylesheet updates (to be refactored).
    watch = =>
      # Needs to wait for the web socket connection.
      if Tower.connection
        App.watchers.watch()
        clearInterval(watchInterval)
    
    watchInterval = setInterval(watch, 500)