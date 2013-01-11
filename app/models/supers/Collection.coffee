###
 * Base Class for all Backbone Collections
 * 
 * @langversion CoffeeScript
 * 
 * @author 
 * @since  
 ###

ApplicationConfig = require('config/ApplicationConfig')

module.exports = class Collection extends Backbone.Collection

  ###//--------------------------------------
  //+ PUBLIC PROPERTIES / CONSTANTS
  //--------------------------------------###

  ###//--------------------------------------
  //+ INHERITED / OVERRIDES
  //--------------------------------------###
  fetch: ->
    @trigger('fetch')
    super

  ###//--------------------------------------
  //+ PUBLIC METHODS / GETTERS / SETTERS
  //--------------------------------------###

  ###//--------------------------------------
  //+ EVENT HANDLERS
  //--------------------------------------###

  ###//--------------------------------------
  //+ PRIVATE AND PROTECTED METHODS
  //--------------------------------------###

  ###//--------------------------------------
  //+ STATIC METHODS
  //--------------------------------------###
  @serverUrl: (url) ->
    return ->
      return ApplicationConfig.SERVER_URL + url
      