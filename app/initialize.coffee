###
 * Application Initializer
 * 
 * @langversion CoffeeScript
 * 
 * @author Paul Strong
 ###

$ ->

  MM = require('MentorMe')

  MM.on "initialize:after", ->
    # Start Backbone router
    Backbone.history.start()

  # Initialize application
  MM.start();
