###
 * Application Initializer
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

application = require('Application')

$ ->



  rivets.configure
    adapter:
      subscribe: (obj, keypath, callback) ->
        callback.wrapped = (m, v) ->
          callback(v)
        obj.on('change:' + keypath, callback.wrapped)
      unsubscribe: (obj, keypath, callback) ->
        obj.off('change:' + keypath, callback.wrapped)
      read: (obj, keypath) ->
        return obj.get(keypath)
      publish: (obj, keypath, value) ->
        obj.set(keypath, value)
  
  # Initialize Application
  application.initialize()

  # Start Backbone router
  Backbone.history.start()
