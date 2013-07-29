###
 * Application Initializer
 * 
 * @langversion CoffeeScript
 * 
 * @author Paul Strong
 ###

$ ->

  MM = require('MentorMe')

  _.each(['routers/MenteeRouter', 'lib/MarionetteView', 'lib/Utilities'], (file) ->
    require(file)
  )

  MM.on "initialize:after", ->
    # Start Backbone router after bootstrap
    MM.execute "when:fetched", MM.collections, ->
      Backbone.history.start()

  # Initialize application
  MM.start();
