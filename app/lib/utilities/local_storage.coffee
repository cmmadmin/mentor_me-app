@MM.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->

  Utilities.LocalStorage =
    _store: window.localStorage
    setItem: (key, val) ->
      @_store.setItem('mentorme:' + key, val)
    getItem: (key) ->
      @_store.getItem('mentorme:' + key)
    removeItem: (key) ->
      @_store.removeItem('mentorme:' + key)
    clear: ->
      @_store.clear()
    storageSize: ->
      @_store.length