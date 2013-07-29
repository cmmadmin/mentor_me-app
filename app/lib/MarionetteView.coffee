_.extend Marionette.View::,
  
    shallowOptions: (args...) ->
      for key, val of _.pick(@options, args...)
        @[key] = val